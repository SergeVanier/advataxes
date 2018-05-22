Public Class BulletinBoard
    Inherits System.Web.UI.Page

    ''' <summary>
    ''' On any error, redirect to the login page
    ''' </summary>
    ''' <param name="sender"></param>
    ''' <param name="e"></param>
    ''' <remarks></remarks>
    Private Sub BulletinBoard_Error(sender As Object, e As System.EventArgs) Handles Me.Error
        If IsNothing(Session("error")) Then Session("error") = GetMessage(273) : Session("msgHeight") = 50
        Response.Redirect("../login.aspx")
    End Sub

    ''' <summary>
    ''' On page load, check if there are any querystring values for any messages to display. set values of hidden fields to handle translations
    ''' for jquery functionality
    ''' </summary>
    ''' <param name="sender"></param>
    ''' <param name="e"></param>
    ''' <remarks></remarks>
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim organization As Org

        Session("currentpage") = "BulletinBoard.aspx"

        CheckLanguage()
        Translate()

        'gvBB.Columns(0).HeaderText = GetMessage(370, )

        Select Case Request.QueryString("action")
            Case "filedeleted" : Session("msg") = GetMessage(487)
            Case "addedMsg" : Session("msg") = GetMessage(489)
            Case "deletedMsg" : Session("msg") = GetMessage(488)
        End Select

        If Not IsNothing(Request.QueryString("action")) Then Response.Redirect(Request.Path)

        hdnOrgID.Value = IIf(IsPostBack, cboOrg.SelectedValue, Session("emp").organization.id)
        If Not IsPostBack Then cboOrg.SelectedValue = Session("emp").organization.id
        hdnEmpOrgID.Value = Session("emp").organization.id
        hdnEmpID.Value = Session("emp").id
        hdnPUK.Value = Membership.GetUser(Session("emp").username.ToString).ProviderUserKey.ToString
        hdnCancel.Value = GetMessage(142)
        hdnAdd.Value = GetMessage(278)
        hdnDelete.Value = GetMessageTitle(128)
        hdnDeleteDoc.Value = GetMessage(484)
        hdnViewDoc.Value = GetMessage(483)
        hdnAttachDoc.Value = GetMessage(485)
        hdnDelMsg.Value = GetMessage(490)

        gvBB.Columns(3).Visible = Session("emp").isadmin
        cboOrg.Visible = Session("emp").isadmin
        lbl238.Visible = Session("emp").isadmin  'lblOrg

        If hdnOrgID.Value <> "" Then
            organization = New Org(CInt(hdnOrgID.Value))
            hdnOrgName.Value = organization.Name
            organization = Nothing
        End If

    End Sub


    ''' <summary>
    ''' Called when a user clicks on the save button in the panel pnlAttachFile. 
    ''' Attaches a file from the user's computer to a bulletin board message
    ''' </summary>
    ''' <param name="sender"></param>
    ''' <param name="e"></param>
    ''' <remarks></remarks>
    Private Sub cmdAttachFile_Click(sender As Object, e As System.EventArgs) Handles cmdAttachFile.Click
        Dim i As String, ii As Integer
        Dim bulletin As New Bulletin

        bulletin.GetMessagesByBBCode(hdnBBCODE.Value)

        For ii = 0 To bulletin.Messages.GetUpperBound(1)
            i = UploadBBFile(FileUpload1, CInt(bulletin.Messages(0, ii)))
        Next

        Select Case i
            Case 0 : Session("alert") = GetMessage(434)
            Case 1 : GetMessage(138)
            Case 2 : Session("alert") = GetMessage(435)
        End Select

        gvBB.DataBind()
        Session("msg") = GetMessage(491)
    End Sub

    ''' <summary>
    ''' Called when an administrator clicks the delete link on the bulletin board.
    ''' Deletes the file from the bulletin board message
    ''' </summary>
    ''' <param name="bbCode"></param>
    ''' <remarks></remarks>
    <System.Web.Services.WebMethod()>
    Public Shared Sub DeleteFile(bbCode As String)
        Dim bulletin As New Bulletin

        bulletin.DeleteFile(bbCode)

        bulletin = Nothing
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



    <System.Web.Services.WebMethod()>
    Public Shared Function GetBB(orgID As Integer, empID As Integer) As String
        Dim stringBuilder As New StringBuilder
        Dim i As Integer
        Dim bulletin As New Bulletin(orgID)
        Dim employee As Employee
        Dim loggedInEmp As New Employee(empID)
        Dim organization As Org

        Try
            If loggedInEmp.Organization.ID = orgID Or loggedInEmp.Organization.Parent.ID = orgID Then
                stringBuilder.Append("<div id='BulletinBoard' style='overflow:scroll;height:700px; width:98%;'><br /><table width='100%'>")

                For i = 0 To bulletin.Messages.GetUpperBound(1)
                    employee = New Employee(CInt(bulletin.Messages(4, i)))
                    organization = New Org(CInt(bulletin.Messages(6, i)))

                    stringBuilder.Append("<tr style='background-color:#efefef;color:#cd1e1e;font-weight:bold;'><td>")
                    stringBuilder.Append(bulletin.Messages(2, i) + " - " + bulletin.Messages(5, i))
                    stringBuilder.Append("</td></tr>")
                    stringBuilder.Append("<tr><td>")
                    stringBuilder.Append(bulletin.Messages(3, i))
                    stringBuilder.Append("</td></tr>")
                    stringBuilder.Append("<tr><td style='color:blue;font-style:italic;'>")
                    stringBuilder.Append("Posted by " & organization.Name & " - " & employee.FirstName & " " & employee.LastName)
                    stringBuilder.Append("</td></tr>")
                    stringBuilder.Append("<tr style='height:20px;'><td></td></tr>")

                    employee = Nothing
                    organization = Nothing
                Next

            Else
                stringBuilder.Append("<div id='BulletinBoard' style='overflow:scroll;height:700px; width:98%;'><br /><table width='100%'><tr><td>You are not authorized to view this data</td></tr>")
            End If

            stringBuilder.Append("</table></div>")

        Catch ex As Exception
            Throw New Exception

        Finally
            bulletin = Nothing
            employee = Nothing
            loggedInEmp = Nothing
        End Try

        GetBB = stringBuilder.ToString
    End Function


    ''' <summary>
    ''' Called from jquery when an administrator clicks on the garbage can in the gridview gvBB to delete a message
    ''' </summary>
    ''' <param name="bbCode">bulletin board code</param>
    ''' <param name="puk">provider user key - unique key to identify a login</param>
    ''' <remarks>an administrator can delete a message if they are an employee of the same company the message was created for</remarks>
    <System.Web.Services.WebMethod()>
    Public Shared Sub DeleteMessage(bbCode As String, puk As String)
        Dim bulletin As New Bulletin
        Dim employee As Employee

        Try
            If puk = Membership.GetUser.ProviderUserKey.ToString Then
                employee = New Employee(Membership.GetUser.UserName)

                If employee.Organization.ID = Left(bbCode, Len(employee.Organization.ID.ToString)) Then
                    bulletin.Delete(bbCode)
                Else
                    Throw New Exception
                End If
            Else
                Throw New Exception
            End If

        Catch ex As Exception
            Throw ex

        Finally
            bulletin = Nothing
            employee = Nothing
        End Try

    End Sub

    ''' <summary>
    ''' Called from jquery when an administrator clicks on the Create New Message button.
    ''' </summary>
    ''' <param name="msg">The body of the message</param>
    ''' <param name="title">Message Title</param>
    ''' <param name="postAll">post to all organizations - true/false</param>
    ''' <param name="orgID">organization ID</param>
    ''' <param name="puk">provider user key - unique key to identify a login</param>
    ''' <remarks>every message is created with a unique ID so the bbcode is used to assign to all messages in case it is posted to all 
    ''' organizations. a message being posted to all organizations will have the same bbcode. this way, if ever a message is deleted, 
    ''' it will be deleted from all organizations using that bbcode. </remarks>
    <System.Web.Services.WebMethod()>
    Public Shared Sub CreateMessage(msg As String, title As String, postAll As String, orgID As Integer, puk As String)
        Dim bulletin As New Bulletin
        Dim loggedInUser As Employee
        Dim code As String

        Try

            If puk = Membership.GetUser.ProviderUserKey.ToString Then
                loggedInUser = New Employee(Membership.GetUser.UserName)

                code = loggedInUser.Organization.ID & loggedInUser.ID & Format(Now, "MMddyyyhhmmss")
                bulletin.OrgID = orgID
                bulletin.Message = msg
                bulletin.Title = title
                bulletin.PostedByEmp = loggedInUser.ID
                bulletin.PostedByOrg = loggedInUser.Organization.ID
                bulletin.BBDate = Now
                bulletin.Code = code
                bulletin.Create()

                If postAll = "checked" And orgID <> 0 Then
                    Dim parentOrganization As New Org(loggedInUser.Organization.Parent.ID)
                    Dim organization As Org

                    parentOrganization.GetChildOrgs()

                    If Not IsNothing(parentOrganization.ChildOrgs) Then
                        For Each organization In parentOrganization.ChildOrgs
                            If organization.ID <> loggedInUser.Organization.ID Then
                                bulletin.OrgID = organization.ID
                                bulletin.Create()
                            End If
                        Next

                        organization = Nothing
                    End If
                End If
            Else
                Throw New Exception
            End If

        Catch ex As Exception
            Throw ex

        Finally
            bulletin = Nothing
            loggedInUser = Nothing
        End Try
    End Sub

    ''' <summary>
    ''' Cycles through all the controls and translates any controls that are found with a prefix of lbl that has an integer following the prefix
    ''' </summary>
    ''' <remarks></remarks>
    Public Sub Translate()
        On Error Resume Next
        Dim d As New Description
        Dim c As Object
        Dim col As Object
        Dim childc As Object, childcc As Object, childccc As Object, childcccc As Object
        Dim id As String


        For Each c In Page.Controls
            For Each childc In c.controls
                For Each childcc In childc.controls
                    If TypeOf childcc Is ContentPlaceHolder Then
                        For Each childccc In childcc.controls
                            If TypeOf childccc Is Label Then
                                If childccc.id Like "lbl*" Then
                                    id = Replace(childccc.id, "_", "")
                                    childccc.text = d.GetDescription(CInt(Replace(id, "lbl", "")), Left(Session("emp").defaultlanguage, 1))
                                End If

                            ElseIf TypeOf childccc Is Panel Then
                                For Each childcccc In childccc.controls
                                    If TypeOf childcccc Is Label Then

                                        If childcccc.id Like "lbl*" Then
                                            id = Replace(childcccc.id, "_", "")
                                            childcccc.text = d.GetDescription(CInt(Replace(id, "lbl", "")), Left(Session("emp").defaultlanguage, 1))
                                        End If

                                    ElseIf TypeOf childcccc Is Button Then
                                        id = Replace(childcccc.text, "_", "")
                                        childcccc.text = d.GetDescription(CInt(Replace(id, "lbl", "")), Left(Session("emp").defaultlanguage, 1))
                                    End If
                                Next

                            ElseIf TypeOf childccc Is GridView Then
                                For Each col In childccc.columns
                                    col.headertext = d.GetDescription(CInt(col.headertext), Left(Session("emp").defaultlanguage, 1))
                                Next
                            End If
                        Next
                    End If
                Next
            Next
        Next

    End Sub

    ''' <summary>
    ''' Called when the save button on the pnlCreateMsg is clicked
    ''' </summary>
    ''' <param name="sender"></param>
    ''' <param name="e"></param>
    ''' <remarks>bbcode is still being generated but not used anymore. this was used for when there was a functionality to
    ''' post to all organizations but this was removed for now. bbcode is created with the organization ID, employee ID and the date and time
    ''' the message is being created</remarks>
    Private Sub cmdSave_Click(sender As Object, e As System.EventArgs) Handles cmdSave.Click
        Dim bulletin As New Bulletin
        Dim loggedInUser As Employee
        Dim code As String

        Try
            loggedInUser = New Employee(Membership.GetUser.UserName)

            code = loggedInUser.Organization.ID & loggedInUser.ID & Format(Now, "MMddyyyhhmmss")
            bulletin.OrgID = cboOrg.SelectedValue
            bulletin.Message = txtMsg.Text
            bulletin.Title = txtTitle.Text
            bulletin.PostedByEmp = loggedInUser.ID
            bulletin.PostedByOrg = loggedInUser.Organization.ID
            bulletin.BBDate = Now
            bulletin.Code = code
            bulletin.Create()
            gvBB.DataBind()

        Catch ex As Exception
            Throw ex

        Finally
            bulletin = Nothing
            loggedInUser = Nothing
        End Try
    End Sub
End Class