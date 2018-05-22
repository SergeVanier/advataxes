Imports System.Data.SqlClient
Imports System.IO
Imports System.Drawing

Public Class MyReceipts
    Inherits System.Web.UI.Page

    Private Sub MyReceipts_Error(sender As Object, e As System.EventArgs) Handles Me.Error
        If IsNothing(Session("error")) Then Session("error") = GetMessage(273) & " - " : Session("msgHeight") = 50
        Response.Redirect("/login.aspx")
    End Sub

    ''' <summary>
    ''' on page load, get uploaded receipts from tblUploadedReceipts and display them in the grid 
    ''' </summary>
    ''' <param name="sender"></param>
    ''' <param name="e"></param>
    ''' <remarks></remarks>

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        hdnPUK.Value = Membership.GetUser(Session("emp").username.ToString).ProviderUserKey.ToString
        hdnEmpID.Value = Session("emp").id
        Session("selectedEmp") = New Employee(CInt(Session("emp").id))
        Session("currentpage") = "myreceipts.aspx"

        If Request.QueryString("ImageID") IsNot Nothing Then
            Dim imageID As Int16
            imageID = Request.QueryString("ImageID")

            GetConnectionString()
            Dim con As New SqlConnection(connString.ConnectionString)
            con.Open()
            Dim cmd As SqlCommand = New SqlCommand("GetReceipt", con)
            cmd.Parameters.Add(New SqlParameter("@ID", SqlDbType.Int)).Value = Convert.ToInt32(imageID)
            cmd.Parameters.Add(New SqlParameter("@EMP_ID", SqlDbType.Int)).Value = Convert.ToInt32(hdnEmpID.Value)
            Dim dataAdapter As New SqlDataAdapter
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Connection = con
            Dim dataTable As New DataTable

            Try
                dataAdapter.SelectCommand = cmd
                dataAdapter.Fill(dataTable)

            Catch ex As Exception
                dataTable = Nothing

            Finally
                con.Close()
                dataAdapter.Dispose()
                con.Dispose()
            End Try

            If dataTable IsNot Nothing Then
                Dim bytes() As Byte = CType(dataTable.Rows(0)("RECEIPT"), Byte())

                If Request.QueryString("resized") IsNot Nothing Then
                    bytes = resizeArrayImage(bytes)
                End If

                Response.Buffer = True
                Response.Charset = ""
                Response.Cache.SetCacheability(HttpCacheability.NoCache)
                Response.ContentType = dataTable.Rows(0)("RECEIPT_TYPE").ToString()
                Dim fileExtension As String = dataTable.Rows(0)("RECEIPT_TYPE").ToString()
                fileExtension = "." & fileExtension.Substring(fileExtension.IndexOf("/") + 1)
                Response.AddHeader("content-disposition", "inline;filename=" & dataTable.Rows(0)("ID").ToString() & fileExtension)
                Response.BinaryWrite(bytes)
                Response.Flush()
                Response.End()
            End If
        End If

        CheckLanguage()
        hdnCreateExpense.Value = GetMessage(376)
        hdnDelete.Value = GetMessageTitle(137)
        gridViewReceipts.EmptyDataText = GetMessage(419)
        Translate()
        GetGuidelines()
    End Sub


    Private Sub GetGuidelines()
        Dim Guidelines As String = "var _guidelinesSteps; $(document).ready(function() {"
        Dim d As New Description

        Guidelines += d.GetDescription(677, Left(Session("language"), 1))
        Guidelines += "});"
        Page.ClientScript.RegisterClientScriptBlock(Me.GetType(), "Guidelines", Guidelines, True)
    End Sub


    <System.Web.Services.WebMethod()>
    Public Shared Sub DeleteReceipt(rID As Integer, puk As String)
        Dim receipt As New UploadedReceipt(rID)
        Dim loggedInUser As Employee
        Dim receiptOwner As New Employee(receipt.Owner.ID)

        Try
            'check if guid passed is the same as the guid of the logged in user
            If puk = Membership.GetUser.ProviderUserKey.ToString Then
                loggedInUser = New Employee(Membership.GetUser.UserName)

                'check if employee who is deleting is the same employee who created the expense or 
                'if the employee deleting is the supervisor of the employee who created expense
                If loggedInUser.ID = receiptOwner.ID Then
                    receipt.Delete()
                Else
                    Throw New Exception
                End If

            Else
                Throw New Exception
            End If

        Catch ex As Exception
            Throw ex

        Finally
            loggedInUser = Nothing
            receiptOwner = Nothing
            receipt = Nothing

        End Try
    End Sub


    ''' <summary>
    ''' Checks to see if an open report exists for the selected employee. If there is no open report, a message will be displayed saying 
    ''' an open report must exist before creating an expense
    ''' </summary>
    ''' <param name="sender"></param>
    ''' <param name="e"></param>
    ''' <remarks></remarks>
    Private Sub cboCreateFor_DataBound(sender As Object, e As System.EventArgs) Handles cboCreateFor.DataBound
        Dim report As New Report

        report.GetOpenReport(Session("emp").id)
        hdnOpenReport.Value = report.Status = 1

        If report.Status = 1 Then
            cboCreateFor.Items.Insert(0, GetMessage(228))
            cboCreateFor.Items(0).Value = Session("emp").id
        End If

        report = Nothing

    End Sub


    ''' <summary>
    ''' Dropdown list that appears for a delegate so they can view receipts that were uploaded by either them or someone else they are
    ''' delegated to
    ''' </summary>
    ''' <param name="sender"></param>
    ''' <param name="e"></param>
    ''' <remarks>Adds the option Me to the dropdown</remarks>
    Private Sub cboViewFor_DataBound(sender As Object, e As System.EventArgs) Handles cboViewFor.DataBound
        cboViewFor.Items.Insert(0, GetMessage(228))
        cboViewFor.Items(0).Value = Session("emp").id
    End Sub


    ''' <summary>
    ''' Dropdown list that appears for a delegate so they can view receipts that were uploaded by either them or someone else they are
    ''' delegated to
    ''' </summary>
    ''' <param name="sender"></param>
    ''' <param name="e"></param>
    ''' <remarks>Synchronizes the ViewFor and CreateFor dropdowns</remarks>
    Private Sub cboViewFor_SelectedIndexChanged(sender As Object, e As System.EventArgs) Handles cboViewFor.SelectedIndexChanged
        If cboViewFor.Items.Count = cboCreateFor.Items.Count Then
            cboCreateFor.SelectedValue = cboViewFor.SelectedValue

        ElseIf cboViewFor.SelectedValue <> Session("emp").id Then
            cboCreateFor.SelectedValue = cboViewFor.SelectedValue
        End If

    End Sub


    ''' <summary>
    ''' Dropdown list that appears when a person is a delegate so they can select which employee to create an expense 
    ''' for using an uploaded receipt
    ''' </summary>
    ''' <param name="sender"></param>
    ''' <param name="e"></param>
    ''' <remarks></remarks>
    Private Sub cboCreateFor_SelectedIndexChanged(sender As Object, e As System.EventArgs) Handles cboCreateFor.SelectedIndexChanged
        Session("selectedEmp") = New Employee(cboCreateFor.SelectedValue)
    End Sub


    ''' <summary>
    ''' Cycle through controls and translate the page
    ''' </summary>
    ''' <remarks></remarks>
    Public Sub Translate()
        On Error Resume Next

        Dim description As New Description
        Dim control As Object
        Dim column As Object
        Dim childControl As Object, childControlTwoLevels As Object, childControlThreeLevels As Object, childControlFourLevels As Object
        Dim id As String

        For Each control In Page.Controls
            For Each childControl In control.controls
                For Each childControlTwoLevels In childControl.controls
                    If TypeOf childControlTwoLevels Is ContentPlaceHolder Then
                        For Each childControlThreeLevels In childControlTwoLevels.controls
                            If TypeOf childControlThreeLevels Is Label Then
                                id = Replace(childControlThreeLevels.id, "_", "")
                                If id Like "lbl*" Then
                                    childControlThreeLevels.text = description.GetDescription(CInt(Replace(id, "lbl", "")), Left(Session("language"), 1))
                                Else
                                    If childControlThreeLevels.id Like "lbl*" Then childControlThreeLevels.text = description.GetDescription(CInt(Replace(childControlThreeLevels.id, "lbl", "")), Left(Session("language"), 1))
                                End If

                            ElseIf TypeOf childControlThreeLevels Is Panel Then
                                For Each childControlFourLevels In childControlThreeLevels.controls
                                    If TypeOf childControlFourLevels Is Label Then
                                        id = Replace(childControlFourLevels.id, "_", "")
                                        If id Like "lbl*" Then
                                            childControlFourLevels.text = description.GetDescription(CInt(Replace(id, "lbl", "")), Left(Session("language"), 1))
                                        End If
                                    End If
                                Next

                            ElseIf TypeOf childControlThreeLevels Is GridView Then
                                For Each column In childControlThreeLevels.columns
                                    column.headertext = description.GetDescription(CInt(column.headertext), Left(Session("language"), 1))
                                Next
                            End If
                        Next
                    End If
                Next
            Next
        Next

    End Sub


    Private Sub CheckLanguage()
        Try
            If IsNothing(Session("language")) Then
                Session("language") = Session("emp").defaultlanguage
            Else
                If Session("language") = "" Then Session("language") = Session("emp").defaultlanguage
            End If

            If Not IsNothing(Request.QueryString("lang")) Then
                If Request.QueryString("lang") = "f" Then
                    Session("language") = "French"
                Else
                    Session("language") = "English"
                End If
            End If

        Catch ex As Exception
            Session("language") = "French"
        End Try

    End Sub


    Private Function resizeArrayImage(arrayImage As Byte())
        Dim stream As New MemoryStream(arrayImage)
        Dim bmp As New Bitmap(stream)
        stream.Close()

        Dim imgByteArray() As Byte

        'start resizing the retrieved image. First the current dimensions are checked.
        Dim Width As Integer = bmp.Width
        Dim Height As Integer = bmp.Height
        'next we declare the maximum size of the resized image. 
        'In this case, all resized images need to be constrained to a 173x173 square.
        Dim Heightmax As Integer = 350
        Dim Widthmax As Integer = 350
        'declare the minimum value af the resizing factor before proceeding. 
        'All images with a lower factor than this will actually be resized
        Dim Factorlimit As Decimal = 1
        'determine if it is a portrait or landscape image
        Dim Relative As Decimal = Height / Width
        Dim Factor As Decimal
        'if the image is a portrait image, calculate the resizing factor based on its height. 
        'else the image is a landscape image, 
        'and we calculate the resizing factor based on its width.
        If Relative > 1 Then
            If Height < (Heightmax + 1) Then
                Factor = 1
            Else
                Factor = Heightmax / Height
            End If
            '
        Else
            If Width < (Widthmax + 1) Then
                Factor = 1
            Else
                Factor = Widthmax / Width
            End If
        End If

        'if the resizing factor is lower than the set limit, start processing the image
        If Factor < Factorlimit Then
            'draw a new image with the dimensions that result from the resizing
            Dim bmpnew As New Bitmap(bmp.Width * Factor, bmp.Height * Factor, Imaging.PixelFormat.Format24bppRgb)
            Dim g As Graphics = Graphics.FromImage(bmpnew)
            g.InterpolationMode = Drawing.Drawing2D.InterpolationMode.HighQualityBicubic
            'and paste the resized image into it
            g.DrawImage(bmp, 0, 0, bmpnew.Width, bmpnew.Height)

            Dim streamstore As New MemoryStream
            bmpnew.Save(streamstore, Imaging.ImageFormat.Jpeg)
            imgByteArray = streamstore.ToArray()
            streamstore.Close()
        End If

        Return imgByteArray
    End Function

End Class