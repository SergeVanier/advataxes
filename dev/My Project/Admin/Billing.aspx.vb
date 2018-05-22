Public Class Billing
    Inherits System.Web.UI.Page

    Private Sub Billing_Error(sender As Object, e As System.EventArgs) Handles Me.Error
        If IsNothing(Session("error")) Then Session("error") = GetMessage(273, Session("language")) : Session("msgHeight") = 50
        Response.Redirect("../login.aspx")
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load        
        hdnPUK.Value = Membership.GetUser.ProviderUserKey.ToString

        txtFrom.Text = Now.AddMonths(-3).ToShortDateString
        txtTo.Text = Now.ToShortDateString
        hdnParentOrg.Value = Session("emp").organization.parent.id        
        cboOrg.SelectedValue = Session("emp").organization.id
        Translate()
    End Sub


    <System.Web.Services.WebMethod()>
    Public Shared Function GetDates(orgID As Integer, puk As String, selectedRange As Integer) As Array        
        Dim range(1) As String
        Dim yr As Integer = Now.Year
        Dim day As Integer = 1
        Dim mo As Integer = 1
        Dim dStartDate As New Date(yr, mo, day)
        Dim dBeginningDate As New Date(2012, 1, 1)
        Const iLAST_6_MONTHS = 6
        Const iTHIS_YEAR = 98
        Const iALL_TIME = 99

        Select Case selectedRange
            'Case 1 : range(0) = Now.ToShortDateString : range(1) = Now.ToShortDateString
            'Case 2 : range(0) = Now.AddMonths(-1).ToShortDateString : range(1) = Now.AddMonths(-1).ToShortDateString
            'Case 3 : range(0) = Now.AddMonths(-3).ToShortDateString : range(1) = Now.ToShortDateString
            Case iLAST_6_MONTHS : range(0) = Now.AddMonths(-6).ToShortDateString : range(1) = Now.ToShortDateString
            Case iTHIS_YEAR : range(0) = dStartDate.ToShortDateString : range(1) = Now.ToShortDateString
            Case iALL_TIME : range(0) = dBeginningDate.ToShortDateString : range(1) = Now.ToShortDateString
        End Select

        Return range
    End Function


    <System.Web.Services.WebMethod()>
    Public Shared Function GetBillingData(orgID As Integer, puk As String, fromDate As String, toDate As String) As String
        Dim sPath As String
        Dim organization As New Org(orgID)
        Dim report As Report
        Dim stringBuilder As New StringBuilder
        Dim dStartDate As Date
        Dim dEndDate As Date
        Dim month As Integer
        Dim total As Double, grandTotal As Double
        Dim loggedInUser As New Employee(Membership.GetUser.UserName)

        Dim yr As Integer = CInt(Left(fromDate, 4))
        Dim day As Integer = 1 'CInt(Left(fromDate, 2))
        Dim mo As Integer = CInt(Mid(fromDate, 5, 2))
        Dim sDateTitle As String

        dStartDate = New Date(yr, mo, day)

        yr = CInt(Left(toDate, 4))
        mo = CInt(Mid(toDate, 5, 2))
        day = Date.DaysInMonth(yr, mo)  'CInt(Left(toDate, 2))
        dEndDate = New Date(yr, mo, day)

        organization.GetReports(dStartDate, dEndDate)

        stringBuilder.Append("<div id='BillingData' style='overflow:scroll;height:850px;'>")
        stringBuilder.Append("<table width='100%' border=1 style='border-collapse:collapse;border-bottom:solid thin silver;border-top:solid thin silver;border-left:solid thin silver;border-right:solid thin silver;'>")

        If Not IsNothing(organization.Reports) Then
            For Each report In organization.Reports
                If report.FinalizedDate.Month <> month Then
                    If loggedInUser.DefaultLanguage = "English" Then
                        sDateTitle = GetMessageTitle(600 + report.FinalizedDate.Month) & " 1 - " & Date.DaysInMonth(report.FinalizedDate.Year, report.FinalizedDate.Month) & ", " & report.FinalizedDate.Year
                    Else
                        sDateTitle = "1 " & GetMessageTitle(600 + report.FinalizedDate.Month) & " " & Date.DaysInMonth(report.FinalizedDate.Year, report.FinalizedDate.Month) & " " & GetMessageTitle(600 + report.FinalizedDate.Month) & " " & report.FinalizedDate.Year
                    End If
                    stringBuilder.Replace("(total)", FormatNumber(total, 2))
                    sPath = "invoice.aspx?id=" & IIf(orgID < 10, "000", IIf(orgID < 100, "00", IIf(orgID < 1000, "0", ""))) & organization.ID & Format(report.FinalizedDate, "yy") & "-" & Format(report.FinalizedDate, "MM")
                    stringBuilder.Append("<tr style='border-bottom:solid thin silver;border-left:solid thin silver;border-right:solid thin silver;background-color:#EAF2FA;height:30px;'><td align='left' width='30%' colspan='3' style='border-right-style:hidden;'><span style='font-weight:bold;'>" & sDateTitle & "</span>&nbsp;&nbsp;" & IIf((report.FinalizedDate.Month < Now.Month And report.FinalizedDate.Year = Now.Year) Or report.FinalizedDate.Year < Now.Year, "<a href=""javascript:popup('" & sPath & "')"" style='color:blue;'>" & GetMessage(526) & "</a>", "") & "</td><td align='right' style='font-weight:bold;'>$ (total)</td></tr>")
                    month = report.FinalizedDate.Month
                    total = 0
                End If
                stringBuilder.Append("<tr style='border-bottom:solid thin silver;border-left:solid thin silver;border-right:solid thin silver;height:30px'><td align='center' width='15%'>" & report.FinalizedDate & "</td><td  width='30%'>" & report.Emp.LastName & ", " & report.Emp.FirstName & "</td><td width='60%' colspan='2'>" & report.Name & "</td></tr>")

                If organization.CreatedDate <= report.FinalizedDate Then
                    total += 2
                    grandTotal += 2
                End If
            Next

            stringBuilder.Append("<tr style='height:40px;font-weight:bold;background-color:#EAF2FA;'><td colspan='3' style='border-right-style:hidden;'>Grand Total</td><td align='right'>$ " & FormatNumber(grandTotal, 2) & "</td></tr>")
            stringBuilder.Replace("(total)", FormatNumber(total, 2))
        Else
            stringBuilder.Append("<tr class='labelText' style='border-bottom:solid thin silver;border-left:solid thin silver;border-right:solid thin silver;height:30px'><td align='center' colspan='4'>There is no data for this period</td></tr>")
        End If

        stringBuilder.Append("</table>")
        stringBuilder.Append("</div>")

        Return stringBuilder.ToString

        organization = Nothing
        report = Nothing
        loggedInUser = Nothing
    End Function

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

                                ElseIf childccc.id Like "CT*" Then
                                    childccc.text = GetCustomTag(Right(childccc.id, 1))
                                End If

                            ElseIf TypeOf childccc Is Panel Then
                                For Each childcccc In childccc.controls
                                    If TypeOf childcccc Is Label Then

                                        If childcccc.id Like "lbl*" Then
                                            id = Replace(childcccc.id, "_", "")
                                            childcccc.text = d.GetDescription(CInt(Replace(id, "lbl", "")), Left(Session("emp").defaultlanguage, 1))

                                        ElseIf childcccc.id Like "CT*" Then
                                            childcccc.text = GetCustomTag(Right(childcccc.id, 1))
                                        End If

                                    ElseIf TypeOf childcccc Is Button Then
                                        id = Replace(childcccc.text, "_", "")
                                        childcccc.text = d.GetDescription(CInt(Replace(id, "lbl", "")), Left(Session("emp").defaultlanguage, 1))
                                    End If
                                Next

                            ElseIf TypeOf childccc Is GridView Then
                                For Each col In childccc.columns
                                    If col.headertext Like "CT*" Then
                                        col.headertext = GetCustomTag(Right(col.headertext, 1))
                                    Else
                                        col.headertext = d.GetDescription(CInt(col.headertext), Left(Session("emp").defaultlanguage, 1))
                                    End If

                                Next
                            End If
                        Next
                    End If
                Next
            Next
        Next

    End Sub

    
    
End Class