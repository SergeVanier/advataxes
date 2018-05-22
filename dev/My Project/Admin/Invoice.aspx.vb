Imports System.Data.SqlClient


Public Class Invoice
    Inherits System.Web.UI.Page

    Dim iPeriod As Integer
    Dim iYear As Integer

    

    Private Sub Report1_Error(sender As Object, e As System.EventArgs) Handles Me.Error
        If IsNothing(Session("error")) Then Session("error") = GetMessage(273) : Session("msgHeight") = 50
        Response.Redirect("../login.aspx")
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim invoiceNum = Request.QueryString("id")
        Dim organization As New Org(CInt(Left(Request.QueryString("id"), 4)))
        Dim yr As Integer = CInt("20" + Mid(invoiceNum, Len(invoiceNum) - 4, 2))
        Dim day As Integer = 1
        Dim mo As Integer = CInt(Right(invoiceNum, 2))
        Dim dDate = New Date(yr, mo, day)
        Dim loggedInUser As New Employee(Membership.GetUser.UserName)

        Try
            Me.Title = GetMessage(533) & " (#" & Request.QueryString("id") & ")"
            Translate()
        
            If Session("emp").DefaultLanguage = "English" Then
                lblInvoiceDateRange.Text = GetMessageTitle(600 + dDate.Month) & " 1 - " & Date.DaysInMonth(dDate.Year, dDate.Month) & ", " & dDate.Year
                lblInvoiceDate.Text += GetMessageTitle(600 + dDate.Month) & " " & Date.DaysInMonth(dDate.Year, dDate.Month) & ", " & dDate.Year
            Else
                lblInvoiceDateRange.Text = "1 " & GetMessageTitle(600 + dDate.Month) & " " & Date.DaysInMonth(dDate.Year, dDate.Month) & " " & GetMessageTitle(600 + dDate.Month) & " " & dDate.Year
                lblInvoiceDate.Text += Date.DaysInMonth(dDate.Year, dDate.Month) & " " & GetMessageTitle(600 + dDate.Month) & " " & dDate.Year
            End If

            If (loggedInUser.Organization.ID = organization.ID Or loggedInUser.Organization.ID = organization.Parent.ID) And loggedInUser.IsAdmin Then
                lblCompanyName.Text = organization.Parent.Name
                lblOrg.Text = organization.Name
                lblAddress.Text = organization.Parent.Address1 & IIf(organization.Parent.Address2 <> "", vbCrLf & organization.Parent.Address2, "")
                lblCity.Text = organization.Parent.City & "(" & organization.Parent.Jur.Abbreviation & "), " & organization.Parent.CountryName
                lblPostal.Text = organization.Parent.Postal
            End If

            hdnPUK.Value = Membership.GetUser.ProviderUserKey.ToString

        Catch ex As Exception
            Throw ex

        Finally
            organization = Nothing
        End Try

    End Sub

    <System.Web.Services.WebMethod()>
    Public Shared Function GetInvoiceData(id As String) As String
        Dim stringBuilder As New StringBuilder
        Dim organization As New Org(CInt(Left(id, 4)))
        Dim report As Report
        Dim dStartDate As Date
        Dim dEndDate As Date
        Dim category As New Category
        Dim total As Double, gst As Double, qst As Double, hst As Double
        Dim loggedInUser As New Employee(Membership.GetUser.UserName)

        Try
            GetConnectionString()

            If loggedInUser.IsAdvalorem Or ((loggedInUser.Organization.ID = organization.ID Or loggedInUser.Organization.ID = organization.Parent.ID) And loggedInUser.IsAdmin) Then
                Dim yr As Integer = CInt("20" + Mid(id, Len(id) - 4, 2))
                Dim day As Integer = 1
                Dim mo As Integer = CInt(Right(id, 2))

                dStartDate = New Date(yr, mo, day)

                If (dStartDate.Month < Now.Month And dStartDate.Year = Now.Year) Or dStartDate.Year < Now.Year Then

                    day = Date.DaysInMonth(yr, mo)

                    dEndDate = New Date(yr, mo, day)

                    organization.GetReports(dStartDate, dEndDate)
                    stringBuilder.Append("<table width='100%' cellspacing='0' style='font-size:0.7em;border-collapse:collapse;border:solid thin silver;border-left:hidden;border-right:hidden;'>")
                    stringBuilder.Append("<tr style='font-weight:bold;border-bottom:solid thin silver'><td>" & GetMessage(78) & "</td><td>" & GetMessage(73) & "</td><td>" & GetMessage(74) & "</td><td align='right'>" & GetMessage(45) & "</td></tr>")

                    For Each report In organization.Reports
                        stringBuilder.Append("<tr style='font-size:0.9em;border-bottom:solid thin silver;'><td>" & report.FinalizedDate & "</td><td>" & report.Emp.LastName & ", " & report.Emp.FirstName & "</td><td>" & report.Name & "</td><td align='right'>" & IIf(report.FinalizedDate > organization.CreatedDate, " 2.00", " 0.00") & "</td></tr>")
                    Next

                    stringBuilder.Append("</table>")
                    stringBuilder.Append("<br>")
                    stringBuilder.Append("<table width='100%' cellspacing='0' style='border-collapse:collapse;font-size:0.7em;'>")

                    If report.FinalizedDate > organization.CreatedDate Then total = FormatNumber(organization.Reports.Count * 2, 2)

                    gst = total * category.GetGST(organization.Jur.ID, 29, dEndDate.ToShortDateString)
                    If gst = "0" Then hst = total * category.GetHST(organization.Jur.ID, 29, dEndDate.ToShortDateString)
                    qst = total * category.GetQST(organization.Jur.ID, 29, dEndDate.ToShortDateString)

                    stringBuilder.Append("<tr style='font-weight:bold;font-size:1em;'><td colspan='3'>Total</td><td align='right'><u>$ " & FormatNumber(total, 2) & "</u></td></tr>")

                    If hst > 0 Then stringBuilder.Append("<tr style='font-weight:bold;font-size:1em;'><td colspan='3'>" & GetMessage(357) & " " & category.GetHST(organization.Jur.ID, 29, dEndDate.ToShortDateString) * 100 & "%</td><td align='right'>$ " & FormatNumber(hst, 2) & "</td></tr>")
                    If gst > 0 Then stringBuilder.Append("<tr style='font-weight:bold;font-size:1em;'><td colspan='3'>" & GetMessage(355) & " " & category.GetGST(organization.Jur.ID, 29, dEndDate.ToShortDateString) * 100 & "% #843430406</td><td align='right'>$ " & FormatNumber(gst, 2) & "</td></tr>")
                    If qst > 0 Then stringBuilder.Append("<tr style='font-weight:bold;font-size:1em;'><td colspan='3'>" & GetMessage(356) & " " & FormatNumber(category.GetQST(organization.Jur.ID, 29, dEndDate.ToShortDateString) * 100, 3) & "% #1216909778</td><td align='right'>$ " & FormatNumber(qst, 2) & "</td></tr>")
                    stringBuilder.Append("<tr style='height:10px;'><td colspan='4'></td></tr>")
                    stringBuilder.Append("<tr style='font-weight:bold;font-size:1em;'><td colspan='3'>" & GetMessage(534) & "</td><td align='right'><u style='border-bottom:thin groove black;'>$ " & FormatNumber(total + gst + qst + hst, 2) & "</u><br><br></td></tr>")
                    stringBuilder.Append("<tr style='border-top:solid thin #cd1e1e;font-style:italic;'><td colspan='4'>" & GetMessage(124) & "</td></tr>")
                    stringBuilder.Append("</table>")
                Else
                    stringBuilder.Append("<div>Invoice is not available at this time</div>")
                End If

            Else
                stringBuilder.Append("<div>You are not authorized to view this data</div>")
            End If


        Catch ex As Exception
            'Response.Write("<div id='printableArea' class='labelText' style='position:relative;top:70px;'>" & sb.ToString & ex.Message & "</div>")

        Finally
            organization = Nothing
            category = Nothing
            loggedInUser = Nothing
        End Try

        Return stringBuilder.ToString
    End Function

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

    Private Sub CheckSession()

        If IsNothing(Session("emp")) And Not IsNothing(Membership.GetUser) Then Session("emp") = New Employee(Membership.GetUser.UserName)

        If IsNothing(Session("emp")) Then
            Session.Abandon()
            FormsAuthentication.SignOut()
            Response.Redirect("../login.aspx")

        ElseIf Not Session("emp").Activated Then
            Session("emp") = Nothing
            Session.Abandon()
            Session("msg") = "Your account hasn't been activated yet.<br><br>To activate your account, please click the link that was sent to the email address you used to create your account."
            FormsAuthentication.SignOut()
            Response.Redirect("../error.aspx")

        ElseIf Not Session("emp").active Then
            Session("emp") = Nothing
            Session.Abandon()
            Session("msg") = "<table border='0'><tr rowspan='2'><td><table><tr style='height:40px;'><td class='labelText' style='font-size:1.6em;'>Your account has been suspended.</td></tr><tr><td class='labelText' valign='top' style='height:50px;'>Contact your administrator to have your account reactivated.</td></tr></table></td></tr></table>"
            FormsAuthentication.SignOut()
            Response.Redirect("../error.aspx")

        ElseIf Session("emp").organization.parent.accountstatus = 1 Then
            If DateAdd(DateInterval.Day, 30, Session("emp").organization.createdDate) < Now Then
                Session("emp") = Nothing
                Session.Abandon()
                Session("msg") = "<table border='0'><tr rowspan='2'><td><table><tr style='height:40px;'><td class='labelText' style='font-size:1.6em;'>Your 30 day trial has expired.</td></tr><tr><td class='labelText' valign='top' style='height:50px;'>   </td></tr></table></td></tr></table>"
                FormsAuthentication.SignOut()
                Response.Redirect("../error.aspx")
            End If
        End If


    End Sub


    Public Sub Translate()
        On Error Resume Next
        Dim d As New Description
        Dim c As Object
        Dim col As Object
        Dim childc As Object, childcc As Object, childccc As Object, childcccc As Object
        Dim id As String


        For Each c In Page.Controls
            For Each childc In c.controls
                If TypeOf childc Is Label Then
                    If childc.id Like "lbl*" Then
                        id = Replace(childc.id, "_", "")
                        childc.text = d.GetDescription(CInt(Replace(id, "lbl", "")), Left(Session("emp").defaultlanguage, 1))

                    ElseIf childc.id Like "CT*" Then
                        childc.text = GetCustomTag(Right(childc.id, 1))
                    End If

                ElseIf TypeOf childc Is Panel Then
                    For Each childcc In childc.controls
                        If TypeOf childcc Is Label Then

                            If childcc.id Like "lbl*" Then
                                id = Replace(childcc.id, "_", "")
                                childcc.text = d.GetDescription(CInt(Replace(id, "lbl", "")), Left(Session("emp").defaultlanguage, 1))

                            ElseIf childcc.id Like "CT*" Then
                                childcc.text = GetCustomTag(Right(childcc.id, 1))
                            End If

                        ElseIf TypeOf childcc Is Button Then
                            id = Replace(childcc.text, "_", "")
                            childcc.text = d.GetDescription(CInt(Replace(id, "lbl", "")), Left(Session("emp").defaultlanguage, 1))
                        End If
                    Next

                ElseIf TypeOf childc Is GridView Then
                    For Each col In childc.columns
                        If col.headertext Like "CT*" Then
                            col.headertext = GetCustomTag(Right(col.headertext, 1))
                        Else
                            col.headertext = d.GetDescription(CInt(col.headertext), Left(Session("emp").defaultlanguage, 1))
                        End If

                    Next
                End If
            Next
        Next

    End Sub

End Class