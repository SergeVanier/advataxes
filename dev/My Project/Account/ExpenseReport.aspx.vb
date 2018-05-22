Imports System.Data.SqlClient


Public Class Report1
    Inherits System.Web.UI.Page

    Dim rptID As Integer
    Dim i As Integer
    Dim AmtTotal As Decimal, AccPayableTotal As Decimal, ITCTotal As Decimal, ITRTotal As Decimal, RITCTotal As Decimal, debitTotal As Decimal, creditTotal As Decimal, NetTotal As Decimal, RITCTotalOnt As Decimal, RITCTotalBC As Decimal, RITCTotalPEI As Decimal
    Dim ITC As Decimal, ITR As Decimal, RITC As Decimal
    Dim exp As Expense
    Dim orgID As Integer
    Dim iPeriod As Integer
    Dim iYear As Integer
    Dim pPeriodStart As Period
    Dim pPeriodEnd As Period
    Dim dStartDate As Date
    Dim dEndDate As Date
    Dim Amt As Double
    Dim org As Org
    Dim rpt As Report
    Dim a As Array
    Dim s As String
    Dim items As Integer
    Dim linenum As Integer
    Dim sFinalized As String, sCategory As String, sAmount As String, sGSTHSTPaid As String, sQSTPaid As String, sAccNum As String, sDebit As String, sCredit As String, sPayableTo As String, sName As String, sEmployee As String, sReportName As String, sThirdParty As String, sAccount As String, sStatus As String, sSubmitted As String, sActive As String, sExpensed As String, sSupplier As String, sLinkedCat As String


    ''' <summary>
    ''' On any error, redirect to login.aspx
    ''' </summary>
    ''' <param name="sender"></param>
    ''' <param name="e"></param>
    ''' <remarks></remarks>
    Private Sub Report1_Error(sender As Object, e As System.EventArgs) Handles Me.Error
        If IsNothing(Session("error")) Then Session("error") = GetMessage(273) : Session("msgHeight") = 50
        Response.Redirect("../login.aspx")
    End Sub


    ''' <summary>
    ''' on page load, create the report that was requested by checking the querystring parameters and calling the appropriate routine
    ''' </summary>
    ''' <param name="sender"></param>
    ''' <param name="e"></param>
    ''' <remarks></remarks>
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        '#ebeaea
        Dim viewreport As Boolean = (Session("emp").isadmin Or Session("emp").isaccountant) And Not IsPostBack

        sFinalized = GetMessage(78)
        sCategory = GetMessage(60)
        sAmount = GetMessage(45)
        sGSTHSTPaid = GetMessage(50)
        sQSTPaid = GetMessage(66)
        sAccNum = GetMessage(245)
        sDebit = GetMessage(246)
        sCredit = GetMessage(247)
        sPayableTo = GetMessage(460)
        sName = GetMessage(317)
        sEmployee = GetMessage(73)
        sReportName = GetMessage(74)
        sThirdParty = GetMessage(421)
        sAccount = GetMessage(268)
        sStatus = GetMessage(70)
        sSubmitted = GetMessage(58)
        sActive = GetMessage(175)
        hdnRptName.Value = Request.QueryString("rptName")
        sExpensed = GetMessage(251)
        sSupplier = GetMessage(61)
        sLinkedCat = GetMessage(524)

        Try
            GetConnectionString()
            CheckLanguage()
            orgID = Request.QueryString("org")
            s = ""

            cmdTSV.Visible = Request.QueryString("type") = "21"
            cmdCSV.Visible = Request.QueryString("type") = "21"

            If Session("emp").organization.id = orgID Or Session("emp").organization.parent.id = orgID Or orgID = 0 Then
                org = New Org(orgID)

                Select Case Request.QueryString("type")
                    Case "2" : If viewreport Then SummaryReport()
                    Case "3" : If viewreport Then If Not IsNothing(Request.QueryString("id")) Then DetailedReport(CInt(Request.QueryString("id"))) Else DetailedReport()
                    Case "4" : If viewreport Then CategoryReport()
                    Case "5" : If viewreport Then DivisionReport()
                    Case "6" : If viewreport Then ThirdParty()
                    Case "7" : If viewreport Then ExpenseReportDetailed()
                    Case "8" : If viewreport Then GLReport()
                    Case "9" : If viewreport Then PayableToEmployees()
                    Case "10" : If viewreport Then Project()
                    Case "11" : If viewreport Then WorkOrder()
                    Case "12" : If viewreport Then CostCenter()
                    Case "13" : If viewreport Then DetailedITC()
                    Case "14" : If viewreport Then DetailedITR()
                    Case "15" : If viewreport Then DetailedRITC(2)
                    Case "16" : If viewreport Then DetailedRITC(4)
                    Case "17" : If viewreport Then DetailedByCategory()
                    Case "18" : If viewreport Then SummaryByCategory()
                    Case "20" : If viewreport Then If Request.QueryString("jur") = "99" Then SelectableRateReport() Else JurisdictionReport()
                    Case "21" : If viewreport Then SummaryDetailed()
                    Case "22" : If viewreport Then BySegment()
                    Case "23" : If viewreport Then GSTQST()
                    Case "24" : If viewreport Then ThirdPartyDetailed("TP")
                    Case "25" : If viewreport Then ThirdPartyDetailed("Advance")
                    Case "26" : If viewreport Then FactorMethodReport()
                    Case "27" : If viewreport Then DuplicateExpenses()
                    Case "X1" : If viewreport Then PendingReports()
                    Case "X2" : If viewreport Then ReportsByApprover()
                    Case "X3" : If viewreport Then ReportsByFinalizer()
                    Case "M1" : If viewreport Then ListOfProjects()
                    Case "M2" : If viewreport Then ListOfAccounts()
                    Case "M3" : If viewreport Then ListOfCategories()
                    Case "M4" : If viewreport Then ListOfEmployees()
                    Case Else : rpt = New Report(CInt(Request.QueryString("id"))) : s = ExpenseReport(rpt)
                End Select

                If s = "" Then
                    s = "<br><br><br><br><div class='labelText' style='font-size:1.0em'>" & GetMessage(459) & "</div>" 'selected criteria returned no results
                Else
                    s = "<div id='printableArea'><br><br><br><table id='dvData' width='100%' style='font-size:small;font-family:calibri;'><tr><td>" & s & "</td></tr></table></div>"
                End If

                Response.Write(s)

            Else
                s = "No authorization to view this data"
                Throw New Exception
            End If

        Catch ex As Exception
            Response.Write("<div id='printableArea' class='labelText' style='position:relative;top:70px;'>" & s & ex.Message & linenum & "</div>")

        Finally
            If Not IsPostBack Then org = Nothing
            rpt = Nothing
            pPeriodEnd = Nothing
            pPeriodStart = Nothing
        End Try
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


    ''' <summary>
    ''' Creates a standard report header that is present in most reports
    ''' </summary>
    ''' <param name="Title">Title of report</param>
    ''' <param name="tblWidth">width of the table that will be displaying the data in the report</param>
    ''' <param name="Col1Width">width of column 1 that contains the organization name</param>
    ''' <param name="showRange">boolean to show or hide the date range of the report</param>
    ''' <returns>returns a string formatted as a table containing report header informaiton</returns>
    ''' <remarks>Querystring("se") is to determine whether to "show employee". certain reports we want to show the employee name in the
    ''' header and some reports we don't want to show the employee </remarks>
    Private Function ReportHeader(Title As String, tblWidth As String, Optional Col1Width As String = "70%", Optional showRange As Boolean = True) As String
        Dim s As String
        'Dim r As Report

        s = "<table cellpadding='0' cellspacing='0' width='" & tblWidth & "' border=0 style='font-size:smaller;'>"
        s += "<tr><td></td><td></td><td></td><td></td><td></td><td></td></tr>"
        s += "<tr style='font-weight:bold;'><td colspan='6' width='" & Col1Width & "'>" & org.Name & IIf(org.Code <> "", " (" & org.Code & ")", "") & "</td></tr>"

        If Not IsNothing(Request.QueryString("se")) Then
            rpt = New Report(CInt(Request.QueryString("id")))
            s += "<tr style='font-weight:bold;'><td colspan='3'>" & rpt.Emp.LastName & ", " & rpt.Emp.FirstName & " - " & rpt.Emp.EmpNum & " Dept. " & rpt.Emp.DivCode & "</td>"
        End If

        s += "<tr style='font-weight:bold;'><td colspan='3'>" & Title & "</td>"

        If Not IsNothing(Request.QueryString("p")) Then s += "<td align='right' colspan='3'>" & GetMessage(237) & ": " & iYear & "</td>"
        s += "</tr>"

        s += "<tr valign='top' style='font-weight:bold;'><td colspan='3'>numberofitemstitle: numberofitems</td>"

        If Not IsNothing(Request.QueryString("p")) Then s += "<td align='right' colspan='3'>" & GetMessage(244) & ": " & iPeriod & "</td>"
        s += "</tr>"

        s += "<tr style='font-weight:bold;'><td colspan='3'>" & GetMessage(125) & ": " & Format(Now, "dd/MM/yyyy") & "</td>"

        If Left(Request.QueryString("type"), 1) = "X" Then
            s += "<td align='right' colspan='3'>" & GetMessage(514) & ": " & dStartDate & "</td></tr>"
        Else
            If showRange Then s += "<td align='right' colspan='3'>" & GetMessage(243) & ": " & dStartDate & " - " & dEndDate & "</td></tr>"
        End If

        s += "</table>"

        Return s
    End Function


    ''' <summary>
    ''' Report to display duplicate expenses. checks for expense amounts that are exactly the same that are found in expense reports </summary>
    ''' <param name="empID">employee ID</param>
    ''' <param name="finalizedOnly">only check finalized reports - true or false</param>
    ''' <remarks></remarks>
    Private Sub DuplicateExpenses(Optional empID As Integer = 0, Optional finalizedOnly As Boolean = True)
        Dim total As Double
        GetConnectionString()
        Dim sqlConn = New SqlConnection(connString.ConnectionString)
        sqlConn.Open()
        Dim rptNum As String
        Dim com As SqlCommand = New SqlCommand("GetDuplicateExpenses", sqlConn)
        Dim rs As SqlDataReader

        GetStartEndDates()

        s = ReportHeader(GetMessage(558), "98%", "60%")

        s += "<table cellpadding='0' cellspacing='0' width='98%' border='0' style='font-size:smaller;border-collapse:collapse;'>"
        s += "<tr style='font-weight:bold;border-bottom:thin solid silver;border-top:thin solid silver;'><td>Rpt</td><td></td><td>" & GetMessage(78) & "</td><td>" & GetMessage(251) & "</td><td>" & GetMessage(205) & "</td><td>" & GetMessage(73) & "</td><td>" & GetMessage(60) & "</td><td>" & GetMessage(42) & "</td><td>Jur</td><td align='right'>" & GetMessage(45) & "</td></tr>"
        s += "<tr style='height:5px;'><td colspan='15'></td></tr>"

        com.CommandType = CommandType.StoredProcedure
        com.Parameters.Add(New SqlParameter("@OrgID", SqlDbType.Int)).Value = orgID
        com.Parameters.Add(New SqlParameter("@empID", SqlDbType.Int)).Value = empID
        com.Parameters.Add(New SqlParameter("@finalizedOnly", SqlDbType.Bit)).Value = finalizedOnly
        com.Parameters.Add(New SqlParameter("@PeriodStart", SqlDbType.Date)).Value = dStartDate
        com.Parameters.Add(New SqlParameter("@PeriodEnd", SqlDbType.Date)).Value = dEndDate

        com.Connection = sqlConn
        rs = com.ExecuteReader

        i = 0
        While rs.Read
            i += 1
            If Not IsDBNull(rs("REPORT_NUM")) Then
                rptNum = "R" & IIf(rs("REPORT_NUM") < 10, "000", IIf(rs("REPORT_NUM") < 100, "00", IIf(rs("REPORT_NUM") < 1000, "0", ""))) & rs("REPORT_NUM")
            Else
                rptNum = ""
            End If

            s += "<tr style='border-bottom:thin solid silver;'>"
            s += "<td width='4%'>" & rptNum & "</td>"

            s += "<td width='1%' align='center'>"
            If Not IsDBNull(rs("RECEIPT_NAME")) Then s += IIf(rs("RECEIPT_NAME") <> "", "<a href='#' id='" & rs("EXPENSE_ID") & "' class='viewReceipt'><img src='../images/attachment2.png' width='15px' height='15px' border='0' /></a>", "")
            s += "</td>"

            s += "<td width='5%'>" & IIf(Not IsDBNull(rs("FINALIZED")), rs("FINALIZED"), "") & "</td>"
            s += "<td width='5%'>" & rs("EXP_DATE") & "</td>"
            s += "<td width='5%'>" & rs("EMP_NUM") & "</td>"
            s += "<td width='10%'>" & rs("LAST_NAME") & ", " & rs("FIRST_NAME") & "</td>"
            s += "<td width='15%'>" & IIf(Session("emp").defaultlanguage = "English", rs("CAT_NAME"), rs("CAT_NAME_FR")) & "</td>"
            s += "<td width='15%'>" & rs("SUPPLIER_NAME") & "</td>"
            s += "<td width='5%'>" & rs("JUR_NAME") & "</td>"
            s += "<td width='5%' align='right'>" & FormatNumber(rs("CDN_AMOUNT"), 2) & "</td>"
            s += "</tr>"
        End While

        s += "</table>"
        s = Replace(s, "numberofitemstitle", GetMessage(242))
        s = Replace(s, "numberofitems", i)
        If i = 0 Then s = ""

        rs = Nothing
        sqlConn.Close()
        sqlConn = Nothing
        com = Nothing

    End Sub


    ''' <summary>
    ''' List of employees in the organization. Accessed from the master data section
    ''' </summary>
    ''' <remarks></remarks>
    Private Sub ListOfEmployees()
        Dim emp As Employee, approver As Employee, finalizer As Employee



        org.GetEmployees()

        If Not IsNothing(org.Employees) Then
            s = ReportHeader(GetMessage(506), "70%", , False) 'List of employees
            s += "<br>"
            s += "<table border='0' cellspacing='0' cellpadding='0' width='70%' style='border-collapse:collapse;font-size:smaller'>"
            s += "<tr style='font-weight:bold;border-top:thin solid silver;border-bottom:thin solid silver;'>"
            s += "<td align='left'  width='15%'>" & GetCustomTag("D") & "</td>"
            s += "<td width='10%'>" & GetMessage(205) & "</td>"
            s += "<td width='25%'>" & GetMessage(73) & "</td>"
            s += "<td width='25%'>" & GetMessage(159) & "</td>"
            If org.Parent.ApprovalLevel = 2 Then s += "<td width='25%'>" & GetMessage(382) & "</td>"
            s += "<td align='right'>" & GetMessage(175) & "</td></tr>"

            For Each emp In org.Employees
                approver = New Employee(emp.Supervisor)
                If org.ApprovalLevel = 2 Then finalizer = New Employee(emp.Finalizer)
                s += "<tr style='border-bottom:thin solid silver;'>"
                s += "<td align='left'>" & emp.DivCode & "</td>"
                s += "<td align='left'>" & emp.EmpNum & "</td>"
                s += "<td align='left'>" & emp.LastName & ", " & emp.FirstName & "</td>"
                s += "<td align='left'>" & approver.LastName & ", " & approver.FirstName & "</td>"
                If org.ApprovalLevel = 2 Then s += "<td align='left'>" & finalizer.LastName & ", " & finalizer.FirstName & "</td>"
                s += "<td align='right'>" & IIf(emp.Active, GetMessage(279), GetMessage(280)) & "</td>"
                s += "</tr>"
            Next

            s = Replace(s, "numberofitemstitle", GetMessage(507))
            s = Replace(s, "numberofitems", org.Employees.Length)
            's += "<tr style='font-weight:bold;border-bottom:medium solid black;border-top:thin solid silver;'><td colspan='4'>Total</td><td align='right'>" & FormatNumber(total, 2) & "</td></tr>"
            s += "</table>"

            emp = Nothing
            approver = Nothing
            finalizer = Nothing
        End If

    End Sub

    ''' <summary>
    ''' List of projects. Accessed from the master data section
    ''' </summary>
    ''' <remarks></remarks>
    Private Sub ListOfProjects()
        Dim pwc As PWC

        org.GetProjects()

        If Not IsNothing(org.Projects) Then
            s = ReportHeader(GetMessage(500) & GetCustomTag("P"), "70%", , False) 'List of projects
            s += "<br>"
            s += "<table border='0' cellspacing='0' cellpadding='0' width='70%' style='border-collapse:collapse;font-size:smaller'>"
            s += "<tr style='font-weight:bold;border-top:thin solid silver;border-bottom:thin solid silver;'><td align='left'  width='5%'>" & GetCustomTag("P") & "</td><td width='25%'>Description</td><td align='right' width='10%'>" & sActive & "</td></tr>"

            For Each pwc In org.Projects
                s += "<tr style='border-bottom:thin solid silver;'>"
                s += "<td align='left'>" & pwc.PWCNumber & "</td>"
                s += "<td align='left'>" & pwc.PWCDescription & "</td>"
                s += "<td align='right'>" & IIf(pwc.Active, GetMessage(279), GetMessage(280)) & "</td>"
                s += "</tr>"
            Next

            s = Replace(s, "numberofitemstitle", GetMessage(508) & GetCustomTag("P") & "s")
            s = Replace(s, "numberofitems", org.Projects.Length)
            's += "<tr style='font-weight:bold;border-bottom:medium solid black;border-top:thin solid silver;'><td colspan='4'>Total</td><td align='right'>" & FormatNumber(total, 2) & "</td></tr>"
            s += "</table>"

        End If

    End Sub

    ''' <summary>
    ''' List of categories. Accessed from the master data section
    ''' </summary>
    ''' <remarks></remarks>
    Private Sub ListOfCategories()
        Dim c As OrgCat
        Dim emp As New Employee(Membership.GetUser.UserName)
        Dim acc As Account

        org.GetCategories()

        If Not IsNothing(org.Categories) Then
            s = ReportHeader(GetMessage(497), "70%", , False) 'List of categories
            s += "<br>"
            s += "<table border='0' cellspacing='0' cellpadding='0' width='70%' style='border-collapse:collapse;font-size:smaller'>"
            s += "<tr style='font-weight:bold;border-top:thin solid silver;border-bottom:thin solid silver;'><td align='left'  width='50%'>" & GetMessage(60) & "</td><td colspan='2'>" & sAccount & "</td><td align='right' width='5%'>" & sActive & "</td></tr>"

            For Each c In org.Categories
                acc = New Account(c.GLAccount, emp.OrgID)
                s += "<tr style='border-bottom:thin solid silver;'>"
                s += "<td align='left'>" & IIf(emp.DefaultLanguage = "English", c.Category.Name, c.Category.NameFR) & IIf(c.Note <> "", "--" & c.Note & "--", "") & "</td>"
                s += "<td align='left'>" & c.GLAccount & "</td>"
                s += "<td align='left' width='35%'>" & acc.Name & "</td>"
                s += "<td align='right'>" & IIf(c.Active, GetMessage(279), GetMessage(280)) & "</td>"
                s += "</tr>"
            Next

            s = Replace(s, "numberofitemstitle", GetMessage(498))
            s = Replace(s, "numberofitems", org.Categories.Length)
            's += "<tr style='font-weight:bold;border-bottom:medium solid black;border-top:thin solid silver;'><td colspan='4'>Total</td><td align='right'>" & FormatNumber(total, 2) & "</td></tr>"
            s += "</table>"

            emp = Nothing
            acc = Nothing
        End If
    End Sub

    ''' <summary>
    ''' List of accounts. Accessed from the master data section
    ''' </summary>
    ''' <remarks></remarks>
    Private Sub ListOfAccounts()
        Dim acc As Account

        org.GetAccounts()

        If Not IsNothing(org.Accounts) Then
            s = ReportHeader(GetMessage(499), "70%", , False) 'List of accounts
            s += "<br>"
            s += "<table border='0' cellspacing='0' cellpadding='0' width='70%' style='border-collapse:collapse;font-size:smaller'>"
            s += "<tr style='font-weight:bold;border-top:thin solid silver;border-bottom:thin solid silver;'><td align='left'  width='5%'>" & GetMessage(268) & "</td><td width='25%'>" & GetMessage(200) & "</td><td align='right' width='10%'>" & sActive & "</td></tr>"

            For Each acc In org.Accounts
                s += "<tr style='border-bottom:thin solid silver;'>"
                s += "<td align='left'>" & acc.Number & "</td>"
                s += "<td align='left'>" & acc.Name & "</td>"
                s += "<td align='right'>" & IIf(acc.Active, GetMessage(279), GetMessage(280)) & "</td>"
                s += "</tr>"
            Next

            s = Replace(s, "numberofitemstitle", GetMessage(508) & GetMessage(381))
            s = Replace(s, "numberofitems", org.Accounts.Length)
            's += "<tr style='font-weight:bold;border-bottom:medium solid black;border-top:thin solid silver;'><td colspan='4'>Total</td><td align='right'>" & FormatNumber(total, 2) & "</td></tr>"
            s += "</table>"
        End If
    End Sub


    ''' <summary>
    ''' List of reports that haven't been finalized. Accessed from the master data section
    ''' </summary>
    ''' <remarks></remarks>
    Private Sub PendingReports()
        Dim reportAmt As Double, total As Double, subTotalDiv As Double, subTotalStatus As Double
        Dim div As String, statusName As String, pwc As PWC
        Dim moreThanOneDiv As Boolean = False, moreThanOneStatus As Boolean = False
        Dim statusID As Integer

        GetStartEndDates()
        org.GetReports(dStartDate, dStartDate, 0)

        If Not IsNothing(org.Reports) Then
            s = ReportHeader(GetMessage(513), "98%") 'Pending reports
            s += "<br>"
            s += "<table border='0' cellspacing='0' cellpadding='0' width='98%' style='border-collapse:collapse;font-size:smaller'>"
            s += "<tr style='font-weight:bold;border-top:thin solid silver;border-bottom:thin solid silver;'><td align='left'  width='5%'>" & GetCustomTag("D") & "</td><td width='10%'>" & sSubmitted & "</td><td  align='left' width='25%'>" & sEmployee & "</td><td width='25%'>" & sReportName & "</td><td  align='right'  width='125px'>" & sAmount & "</td></tr>"

            For Each rpt In org.Reports
                'If statusID <> r.Status And statusID <> 0 And div = r.Emp.DivCode Then
                's += "<tr style='font-weight:bold;border-bottom:medium solid silver;border-top:thin solid silver;'><td></td><td colspan='4'>Sub-total: " & statusName & "</td><td align='right'>" & FormatNumber(subTotalStatus, 2) & "</td></tr>"
                'subTotalStatus = 0
                'moreThanOneStatus = True
                'End If

                If div <> rpt.Emp.DivCode And div <> "" Then
                    'If moreThanOneStatus Then s += "<tr style='font-weight:bold;border-bottom:medium solid silver;border-top:thin solid silver;'><td></td><td colspan='3'>Sub-total: " & statusName & "</td><td align='right'>" & FormatNumber(subTotalStatus, 2) & "</td></tr>"
                    s += "<tr style='font-weight:bold;border-bottom:thin solid black;border-top:thin solid silver;'><td colspan='4'>" & GetMessage(512) & ": " & div & "</td><td align='right'>" & FormatNumber(subTotalDiv, 2) & "</td></tr>"
                    subTotalDiv = 0
                    moreThanOneDiv = True
                    'moreThanOneStatus = False
                End If

                div = rpt.Emp.DivCode
                'pwc = New PWC(div, "D", r.Emp.Organization.ID)
                'statusID = r.Status
                'statusName = r.StatusName

                reportAmt = rpt.Amount(True)
                s += "<tr style='border-bottom:thin solid silver;'>"
                s += "<td align='left'>" & rpt.Emp.DivCode & "</td>"
                's += "<td align='left'>" & rpt.StatusName & "</td>"
                s += "<td align='left'>" & rpt.SubmittedDate & "</td>"
                s += "<td align='left'>" & rpt.Emp.LastName & ", " & rpt.Emp.FirstName & "</td>"
                s += "<td align='left'>" & rpt.Name & "</td>"
                s += "<td align='right'>" & FormatNumber(reportAmt, 2) & "</td>"
                s += "</tr>"

                'subTotalStatus += rpt.Amount
                subTotalDiv += reportAmt
                total += reportAmt
            Next

            s = Replace(s, "numberofitemstitle", GetMessage(508) & " " & GetMessage(71) & ": ")
            s = Replace(s, "numberofitems", org.Reports.Length)
            'If moreThanOneStatus Then s += "<tr style='font-weight:bold;border-bottom:medium solid silver;border-top:thin solid silver;'><td></td><td colspan='4'>Sub-total: " & statusName & "</td><td align='right'>" & FormatNumber(subTotalStatus, 2) & "</td></tr>"
            If moreThanOneDiv Then s += "<tr style='font-weight:bold;border-bottom:thin solid black;border-top:thin solid silver;'><td colspan='4'>" & GetMessage(512) & ": " & div & "</td><td align='right'>" & FormatNumber(subTotalDiv, 2) & "</td></tr>"
            s += "<tr style='font-weight:bold;border-bottom:medium solid black;border-top:thin solid silver;'><td colspan='4'>Total</td><td align='right'>" & FormatNumber(total, 2) & "</td></tr>"
            s += "</table>"

        End If

    End Sub

    ''' <summary>
    ''' List of reports that haven't been finalized, grouped by approver. Accessed from the master data section
    ''' </summary>
    ''' <remarks></remarks>
    Private Sub ReportsByApprover()
        Dim reportAmt As Double, total As Double, subTotalApprover As Double, subTotalStatus As Double
        Dim div As String, statusName As String, pwc As PWC
        Dim moreThanOneApprover As Boolean = False, moreThanOneStatus As Boolean = False
        Dim statusID As Integer
        Dim approver As Employee
        Dim i As Integer

        GetStartEndDates()
        org.GetReports(dStartDate, dStartDate, 0, "APPROVER")

        If Not IsNothing(org.Reports) Then
            s = ReportHeader(GetMessage(501), "98%") 'Pending reports
            s += "<br>"
            s += "<table border='0' cellspacing='0' cellpadding='0' width='98%' style='border-collapse:collapse;font-size:smaller'>"
            s += "<tr style='font-weight:bold;border-top:thin solid silver;border-bottom:thin solid silver;'><td>" & GetMessage(159) & "</td><td align='left'  width='5%'>" & GetCustomTag("D") & "</td><td width='10%'>" & sSubmitted & "</td><td  align='left' width='25%'>" & sEmployee & "</td><td width='25%'>" & sReportName & "</td><td  align='right'  width='125px'>" & sAmount & "</td></tr>"

            For Each rpt In org.Reports
                i += 1
                'If statusID <> rpt.Status And statusID <> 0 And div = rpt.Emp.DivCode Then
                's += "<tr style='font-weight:bold;border-bottom:medium solid silver;border-top:thin solid silver;'><td></td><td colspan='4'>Sub-total: " & statusName & "</td><td align='right'>" & FormatNumber(subTotalStatus, 2) & "</td></tr>"
                'subTotalStatus = 0
                'moreThanOneStatus = True
                'End If
                If IsNothing(approver) Then approver = New Employee(rpt.Emp.Supervisor)

                If approver.ID <> rpt.Emp.Supervisor Or i = 1 Then
                    If i <> 1 Then s += "<tr style='font-weight:bold;border-bottom:thin solid black;border-top:thin solid silver;'><td colspan='5'>" & GetMessage(512) & ": " & approver.LastName & ", " & approver.FirstName & "</td><td align='right'>" & FormatNumber(subTotalApprover, 2) & "</td></tr>"
                    approver = New Employee(rpt.Emp.Supervisor)
                    s += "<tr style='font-weight:bold;border-bottom:thin solid silver;border-top:thin solid silver;'><td colspan='6'>" & approver.LastName & ", " & approver.FirstName & "</td></tr>"
                    subTotalApprover = 0
                    If i > 1 Then moreThanOneApprover = True
                End If

                div = rpt.Emp.DivCode
                'pwc = New PWC(div, "D", rpt.Emp.Organization.ID)
                'statusID = rpt.Status
                'statusName = rpt.StatusName
                reportAmt = rpt.Amount(True)
                s += "<tr style='border-bottom:thin solid silver;'><td></td>"
                s += "<td align='left'>" & rpt.Emp.DivCode & "</td>"
                's += "<td align='left'>" & rpt.StatusName & "</td>"
                s += "<td align='left'>" & rpt.SubmittedDate & "</td>"
                s += "<td align='left'>" & rpt.Emp.LastName & ", " & rpt.Emp.FirstName & "</td>"
                s += "<td align='left'>" & rpt.Name & "</td>"
                s += "<td align='right'>" & FormatNumber(reportAmt, 2) & "</td>"
                s += "</tr>"

                'subTotalStatus += rpt.Amount
                subTotalApprover += reportAmt
                total += reportAmt
            Next

            s = Replace(s, "numberofitemstitle", GetMessage(508) & " " & GetMessage(71) & ": ")
            s = Replace(s, "numberofitems", org.Reports.Length)
            'If moreThanOneStatus Then s += "<tr style='font-weight:bold;border-bottom:medium solid silver;border-top:thin solid silver;'><td></td><td colspan='4'>Sub-total: " & statusName & "</td><td align='right'>" & FormatNumber(subTotalStatus, 2) & "</td></tr>"
            If moreThanOneApprover Then s += "<tr style='font-weight:bold;border-bottom:thin solid black;border-top:thin solid silver;'><td colspan='5'>" & GetMessage(512) & ": " & approver.LastName & ", " & approver.FirstName & "</td><td align='right'>" & FormatNumber(subTotalApprover, 2) & "</td></tr>"
            s += "<tr style='font-weight:bold;border-bottom:medium solid black;border-top:thin solid silver;'><td colspan='5'>Total</td><td align='right'>" & FormatNumber(total, 2) & "</td></tr>"
            s += "</table>"
            approver = Nothing
        End If

    End Sub

    ''' <summary>
    ''' List of reports that haven't been finalized, grouped by finalizer. Accessed from the master data section
    ''' </summary>
    ''' <remarks></remarks>
    Private Sub ReportsByFinalizer()
        Dim reportAmt As Double, total As Double, subTotalFinalizer As Double, subTotalStatus As Double
        Dim div As String, statusName As String, pwc As PWC
        Dim moreThanOneFinalizer As Boolean = False, moreThanOneStatus As Boolean = False
        Dim statusID As Integer
        Dim finalizer As Employee
        Dim approver As Employee
        Dim i As Integer

        GetStartEndDates()
        org.GetReports(dStartDate, dStartDate, 0, "FINALIZER")

        If Not IsNothing(org.Reports) Then
            s = ReportHeader(GetMessage(502), "98%") 'Pending reports
            s += "<br>"
            s += "<table border='0' cellspacing='0' cellpadding='0' width='98%' style='border-collapse:collapse;font-size:smaller'>"
            s += "<tr style='font-weight:bold;border-top:thin solid silver;border-bottom:thin solid silver;'><td>" & GetMessage(382) & "</td><td align='left'  width='5%'>" & GetCustomTag("D") & "</td><td width='10%'>" & sSubmitted & "</td><td width='15%'>" & GetMessage(159) & "</td><td  align='left' width='15%'>" & sEmployee & "</td><td width='25%'>" & sReportName & "</td><td  align='right'  width='125px'>" & sAmount & "</td></tr>"

            For Each rpt In org.Reports
                i += 1
                approver = New Employee(rpt.Emp.Supervisor)
                'If statusID <> rpt.Status And statusID <> 0 And div = rpt.Emp.DivCode Then
                's += "<tr style='font-weight:bold;border-bottom:medium solid silver;border-top:thin solid silver;'><td></td><td colspan='4'>Sub-total: " & statusName & "</td><td align='right'>" & FormatNumber(subTotalStatus, 2) & "</td></tr>"
                'subTotalStatus = 0
                'moreThanOneStatus = True
                'End If
                If IsNothing(finalizer) Then finalizer = New Employee(rpt.Emp.Finalizer)

                If finalizer.ID <> rpt.Emp.Finalizer Or i = 1 Then
                    If i <> 1 Then s += "<tr style='font-weight:bold;border-bottom:thin solid black;border-top:thin solid silver;'><td colspan='6'>" & GetMessage(512) & ": " & finalizer.LastName & ", " & finalizer.FirstName & "</td><td align='right'>" & FormatNumber(subTotalFinalizer, 2) & "</td></tr>"
                    finalizer = New Employee(rpt.Emp.Finalizer)
                    s += "<tr style='font-weight:bold;border-bottom:thin solid silver;border-top:thin solid silver;'><td colspan='7'>" & finalizer.LastName & ", " & finalizer.FirstName & "</td></tr>"
                    subTotalFinalizer = 0
                    moreThanOneFinalizer = i > 1
                End If

                div = rpt.Emp.DivCode
                'pwc = New PWC(div, "D", rpt.Emp.Organization.ID)
                'statusID = rpt.Status
                'statusName = rpt.StatusName

                reportAmt = rpt.Amount(True)
                s += "<tr style='border-bottom:thin solid silver;'><td></td>"
                s += "<td align='left'>" & rpt.Emp.DivCode & "</td>"
                's += "<td align='left'>" & rpt.StatusName & "</td>"
                s += "<td align='left'>" & rpt.SubmittedDate & "</td>"
                s += "<td align='left'>" & approver.LastName & ", " & approver.FirstName & "</td>"
                s += "<td align='left'>" & rpt.Emp.LastName & ", " & rpt.Emp.FirstName & "</td>"
                s += "<td align='left'>" & rpt.Name & "</td>"
                s += "<td align='right'>" & FormatNumber(reportAmt, 2) & "</td>"
                s += "</tr>"

                'subTotalStatus += rpt.Amount
                subTotalFinalizer += reportAmt
                total += reportAmt
            Next

            s = Replace(s, "numberofitemstitle", GetMessage(508) & " " & GetMessage(71) & ": ")
            s = Replace(s, "numberofitems", org.Reports.Length)
            'If moreThanOneStatus Then s += "<tr style='font-weight:bold;border-bottom:medium solid silver;border-top:thin solid silver;'><td></td><td colspan='4'>Sub-total: " & statusName & "</td><td align='right'>" & FormatNumber(subTotalStatus, 2) & "</td></tr>"
            If moreThanOneFinalizer Then s += "<tr style='font-weight:bold;border-bottom:thin solid black;border-top:thin solid silver;'><td colspan='6'>" & GetMessage(512) & ": " & finalizer.LastName & ", " & finalizer.FirstName & "</td><td align='right'>" & FormatNumber(subTotalFinalizer, 2) & "</td></tr>"
            s += "<tr style='font-weight:bold;border-bottom:medium solid black;border-top:thin solid silver;'><td colspan='6'>Total</td><td align='right'>" & FormatNumber(total, 2) & "</td></tr>"
            s += "</table>"
            finalizer = Nothing
        End If

    End Sub

    ''' <summary>
    ''' Report to display all the GST/HST and QST that has been paid on expenses.
    ''' </summary>
    ''' <remarks></remarks>
    Private Sub GSTQST()
        Dim gstTotal As Decimal, qstTotal As Decimal

        GetStartEndDates()
        org.GetExpenses(dStartDate, dEndDate)

        s = ReportHeader(GetMessage(443), "98%") 'GST/HST/QST Paid

        s += "<table cellpadding='0' cellspacing='0' width='98%' border=0 style='font-size:smaller;border-collapse:collapse;'>"
        s += "<tr style='font-weight:bold;border-bottom:thin solid silver;border-top:thin solid silver;'><td align='left'>Rpt</td><td align='left'>" & sFinalized & "</td><td align='left'>" & sCategory & "</td><td align='left'>" & sEmployee & "</td><td align='center'>Jur</td><td align='right'>" & sAmount & "</td><td align='right'>" & sGSTHSTPaid & "</td><td align='right'>" & sQSTPaid & "</td></tr>"

        AmtTotal = 0
        i = 0
        If Not IsNothing(org.Expenses) Then
            For Each exp In org.Expenses
                If exp.GSTPaid > 0 Or exp.QSTPaid > 0 Then
                    i += 1
                    s += "<tr style='border-bottom:thin solid silver;background-color:" & IIf(i Mod 2 = 0, "white", "white") & ";'>"
                    s += "<td align='left' width='5%'>R" & exp.Rpt.ReportNumberFormatted & "</td>"
                    s += "<td align='left' width='8%'>" & exp.Rpt.FinalizedDate & "</td>"
                    s += "<td align='left' width='20%'>" & IIf(Session("emp").defaultlanguage = "English", exp.OrgCategory.Category.Name, exp.OrgCategory.Category.NameFR) & IIf(exp.OrgCategory.Note <> "", exp.OrgCategory.Note, "") & "</td>"
                    s += "<td align='left' width='10%'>" & exp.Rpt.Emp.LastName & ", " & exp.Rpt.Emp.FirstName & "</td>"
                    s += "<td align='center' width='5%'>" & exp.Jurisdiction.Abbreviation & "</td>"
                    s += "<td align='right' width='8%'>" & FormatNumber(exp.AmountCDN, 2) & "</td>"
                    s += "<td align='right' width='8%'>" & FormatNumber(exp.GSTPaid) & "</td>"
                    s += "<td align='right' width='8%'>" & FormatNumber(exp.QSTPaid) & "</td>"
                    s += "</tr>"

                    gstTotal += exp.GSTPaid
                    qstTotal += exp.QSTPaid
                    AmtTotal += exp.AmountCDN
                End If
            Next
        End If

        s += "<tr style='font-weight:bold;border-bottom:thin solid silver;border-top:thin solid silver;'><td>Total</td><td></td><td></td><td></td><td></td><td align='right'>" & FormatNumber(AmtTotal, 2) & "</td><td align='right'>" & FormatNumber(gstTotal, 2) & "</td><td align='right'>" & FormatNumber(qstTotal, 2) & "</td></tr>"
        s += "</table>"

        s = Replace(s, "numberofitemstitle", GetMessage(261))
        s = Replace(s, "numberofitems", i)

        If i = 0 Then s = ""

        exp = Nothing
        org = Nothing
    End Sub


    ''' <summary>
    ''' List of expenses that are payable to the employee
    ''' </summary>
    ''' <remarks></remarks>
    Private Sub PayableToEmployees()
        Dim total As Double
        GetConnectionString()
        Dim sqlConn = New SqlConnection(connString.ConnectionString)
        sqlConn.Open()

        Dim com As SqlCommand = New SqlCommand("GetListOfReports", sqlConn)
        Dim rs As SqlDataReader

        GetStartEndDates()

        s = ReportHeader(GetMessage(339), "98%", "60%")

        s += "<table cellpadding='0' cellspacing='0' width='100%' border=0 style='font-size:smaller;border-collapse:collapse;'>"
        s += "<tr style='font-weight:bold;border-bottom:thin solid silver;border-top:thin solid silver;'><td>Rpt</td><td>" & GetMessage(78) & "</td><td>Emp</td><td>" & GetMessage(73) & "</td><td>" & GetMessage(74) & "</td><td align='right'>" & GetMessage(247) & "</td><td align='right'>" & GetMessage(267) & "</td></tr>"
        s += "<tr style='height:5px;'><td colspan='15'></td></tr>"

        com.CommandType = CommandType.StoredProcedure
        com.Parameters.Add(New SqlParameter("@OrgID", SqlDbType.Int)).Value = orgID
        com.Parameters.Add(New SqlParameter("@PeriodStart", SqlDbType.Date)).Value = dStartDate
        com.Parameters.Add(New SqlParameter("@PeriodEnd", SqlDbType.Date)).Value = dEndDate

        com.Connection = sqlConn
        rs = com.ExecuteReader

        i = 0
        While rs.Read
            rpt = New Report(rs("report_id"))
            i += 1
            s += "<tr style='border-bottom:thin solid silver;'>"
            s += "<td width='4%'>R" & rpt.ReportNumberFormatted & "</td>"
            s += "<td width='8%'>" & rs("FINALIZED") & "</td>"
            s += "<td width='5%'>" & rs("EMP_NUM") & "</td>"
            s += "<td width='20%'>" & rs("LAST_NAME") & "," & rs("FIRST_NAME") & "</td>"
            s += "<td width='25%'>" & rs("REPORT_NAME") & "</td>"

            total += rpt.Amount

            s += "<td width='30%' align='right'>" & FormatNumber(rpt.Amount, 2) & "</td>"
            s += "<td width='30%' align='right'>" & FormatNumber(total, 2) & "</td>"
            s += "</tr>"

            rpt = Nothing
        End While

        s += "</table>"
        s = Replace(s, "numberofitemstitle", GetMessage(242))
        s = Replace(s, "numberofitems", i)
        If i = 0 Then s = ""

        rs = Nothing
        sqlConn.Close()
        sqlConn = Nothing
        com = Nothing

    End Sub


    ''' <summary>
    ''' A detailed summary by gl account
    ''' </summary>
    ''' <remarks></remarks>
    Private Sub SummaryDetailed()
        Dim oc As New OrgCat
        Dim tableHeader As String

        AmtTotal = 0 : ITCTotal = 0 : ITRTotal = 0 : RITCTotal = 0 : debitTotal = 0 : RITCTotalOnt = 0 : RITCTotalBC = 0 : RITCTotalPEI = 0
        i = 0
        items = 0

        tableHeader = "<table border='0' cellspacing='0' cellpadding='0' width='95%' style='border-collapse:collapse;font-size:smaller'>"
        tableHeader += "<tr style='font-weight:bold;border-top:thin solid silver;border-bottom:thin solid silver;'><td align='left'  width='5%'>Rpt</td><td width='10%'>" & sFinalized & "</td><td colspan='4' width='25%'>" & sAccNum & "</td><td  align='left' width='25%'>" & GetMessage(383) & "</td><td>Emp/CC</td><td  align='right'  width='125px'>" & sDebit & "</td><td align='right' width='125px'>" & sCredit & "</td></tr>"

        If Not IsNothing(Request.QueryString("id")) Then
            rpt = New Report(CInt(Request.QueryString("id")))
            s = ReportHeader(GetMessage(361), "95%", , False)
            s += tableHeader
            org = rpt.Emp.Organization
            s += SummaryDetailed2(rpt)
        Else
            GetStartEndDates()
            s = ReportHeader(GetMessage(361), "95%")
            s += tableHeader
            org.GetReports(dStartDate, dEndDate, , "REPORT_NUM")

            If Not IsNothing(org.Reports) Then
                For Each rpt In org.Reports
                    s += SummaryDetailed2(rpt)
                Next
            End If

        End If

        s = Replace(s, "numberofitemstitle", GetMessage(261))
        s = Replace(s, "numberofitems", items)

        s += "<tr style='font-weight:bold;border-top:thin solid silver;border-bottom:thin solid silver;'>"
        s += "<td colspan='2'>Total</td>"
        s += "<td  align='right'></td>"
        s += "<td  align='right'></td>"
        s += "<td  align='right'></td>"
        s += "<td  align='right'></td>"
        s += "<td  align='right'></td>"
        s += "<td  align='right'></td>"
        s += "<td  align='right'>" & FormatNumber(AmtTotal, 2) & "</td>"
        s += "<td align='right'>" & FormatNumber(AmtTotal, 2) & "</td></tr>"
        s += "</table>"

        rpt = Nothing
    End Sub

    ''' <summary>
    ''' Detailed summary by GL account, CSV or TSV format
    ''' </summary>
    ''' <param name="TSV"></param>
    ''' <remarks></remarks>
    Private Sub SummaryDetailedCSV(Optional TSV As Boolean = False)
        Dim rpt As Report
        Dim oc As New OrgCat
        Dim i As Integer
        Dim s As String = ""
        Dim buffer() As Byte
        Dim memoryStream = New System.IO.MemoryStream


        AmtTotal = 0 : ITCTotal = 0 : ITRTotal = 0 : RITCTotal = 0 : debitTotal = 0 : RITCTotalOnt = 0 : RITCTotalBC = 0 : RITCTotalPEI = 0
        i = 0
        items = 0
        If s = "" Then s = """Rpt"",""" & sFinalized & """,""" & sAccNum & """,""Emp/CC"",""Type"",""" & sAmount & """" & vbCrLf

        'New code
        'ss += ",""" & sAccSegment & """,""" & rpt.Emp.EmpNum & """,""D"",""" & Replace(FormatNumber(exp.AmountCDN - exp.ITC - exp.ITR + exp.RITC, 2).ToString().Replace(",", String.Empty), ",", "") & """" & vbCrLf








        If Not IsNothing(Request.QueryString("id")) Then
            rpt = New Report(CInt(Request.QueryString("id")))
            org = rpt.Emp.Organization
            s += SummaryDetailedCSV2(rpt)
            rpt.Downloaded = True
            rpt.Update()
        Else
            GetStartEndDates()
            org.GetReports(dStartDate, dEndDate)
            Dim result = org.Reports.OrderBy(Function(tt) tt.ReportNumber)
            If Not IsNothing(org.Reports) Then
                For Each rpt In result
                    s += SummaryDetailedCSV2(rpt)
                    rpt.Downloaded = True
                    rpt.Update()
                Next
            End If
        End If

        'If s = "" Then s = "All data for this period has already been downloaded or there is no data for this period. If you would like to download data that has already been downloaded, go to the Download Manager and uncheck the checkboxes and re-run the download."
        If TSV Then s = Replace(s, """,""", vbTab) : s = Replace(s, """", "")

        buffer = Encoding.Default.GetBytes(s)
        memoryStream.Write(buffer, 0, buffer.Length)
        Response.Clear()

        Response.AddHeader("Content-Disposition", "attachment; filename=" & Request.QueryString("rptName") & "." & IIf(TSV, "tsv", "csv"))
        Response.AddHeader("Content-Length", memoryStream.Length.ToString())
        Response.ContentType = "text/plain"
        memoryStream.WriteTo(Response.OutputStream)
        Response.End()

        rpt = Nothing
    End Sub

    ''' <summary>
    ''' Expense reports for a selected period/custom range
    ''' </summary>
    ''' <remarks></remarks>
    Private Sub ExpenseReportDetailed()
        Dim rpt As Report

        GetStartEndDates()
        org.GetReports(dStartDate, dEndDate, , "")

        If Not IsNothing(org.Reports) Then
            For Each rpt In org.Reports
                s += ExpenseReport(rpt)
            Next
        End If

        rpt = Nothing
    End Sub


    ''' <summary>
    ''' Expense report for a given report ID
    ''' </summary>
    ''' <param name="rpt">report object</param>
    ''' <returns>A string containing a table holding all information for the report that was passed</returns>
    ''' <remarks></remarks>
    Private Function ExpenseReport(rpt As Report) As String
        Dim p As New Period
        Dim ss As String = ""
        Dim DontReimburseAmt As Double
        Dim tp As New SortedDictionary(Of String, Double)
        Dim i As Integer
        Dim displayPayableTypeCol As Boolean
        Dim footerCurrencyString As String
        footerCurrencyString = ""

        Amt = 0 : AmtTotal = 0 : AmtTotal = 0 : ITCTotal = 0 : ITRTotal = 0 : RITCTotal = 0 : NetTotal = 0 : RITCTotalOnt = 0 : RITCTotalBC = 0 : RITCTotalPEI = 0

        If rpt.Status = 4 Then p = New Period(rpt.Emp.Organization.ID, rpt.FinalizedDate.Month)

        If rpt.EmpID = Session("emp").ID Or (rpt.Emp.Supervisor = Session("emp").id) Or rpt.Emp.Finalizer = Session("emp").id Or Session("emp").isadmin Then
            Dim statusDate As String = "", statusDesc As String = ""
            linenum = 1
            org = New Org(rpt.Emp.OrgID)

            ss = "<table border='0' cellspacing='0' cellpadding='0' width='100%'  style='font-size:smaller;border-collapse:collapse;'>"

            If org.ID = 1305 Then
                ss += "<tr><td width='50%' style=' font-weight:bold;'></td></tr>"
                ss += "<tr style='font-weight:bold;'><td colspan='3'>" & org.Name & IIf(org.Code <> "", " (" & org.Code & ")", "") & "</td><td align='right' colspan='2'>" & GetMessage(112) & ":</td><td align='right' colspan='2'>University</td></tr>"
                ss += "<tr style='font-weight:bold;'><td colspan='3'>" & rpt.Emp.LastName & ",  " & rpt.Emp.FirstName & IIf(rpt.Emp.EmpNum <> "", " - " & rpt.Emp.EmpNum, "") & IIf(rpt.Emp.DivCode <> "", " " & GetCustomTag("D") & " " & rpt.Emp.DivCode, "") & "</td><td align='right' colspan='2'>" & GetMessage(113) & ":</td><td align='right' colspan='2'>University</td></tr>"
            Else
                ss += "<tr><td width='50%' style=' font-weight:bold;'></td></tr>"
                ss += "<tr style='font-weight:bold;'><td colspan='3'>" & org.Name & IIf(org.Code <> "", " (" & org.Code & ")", "") & "</td><td align='right' colspan='2'>" & GetMessage(112) & ":</td><td align='right' colspan='2'>" & IIf(org.GSTReg, IIf(org.OrgSizeGST = 1, GetMessage(116), GetMessage(117)), GetMessage(252)) & "</td></tr>"
                ss += "<tr style='font-weight:bold;'><td colspan='3'>" & rpt.Emp.LastName & ",  " & rpt.Emp.FirstName & IIf(rpt.Emp.EmpNum <> "", " - " & rpt.Emp.EmpNum, "") & IIf(rpt.Emp.DivCode <> "", " " & GetCustomTag("D") & " " & rpt.Emp.DivCode, "") & "</td><td align='right' colspan='2'>" & GetMessage(113) & ":</td><td align='right' colspan='2'>" & IIf(org.QSTReg, IIf(org.OrgSizeQST = 1, GetMessage(116), GetMessage(117)), GetMessage(252)) & "</td></tr>"
            End If

            ss += "<tr style='font-weight:bold;'><td colspan='3'>" & IIf(rpt.Status = 4, "Rpt " & rpt.ReportNumberFormatted & " - ", "") & rpt.Name & "</td><td align='right' colspan='2'>" & IIf(org.GSTReg, GetMessage(114) & ":</td><td align='right' colspan='2'>" & org.GetCRAactualRatio("GST", rpt.CreatedDate, org.GetCRA("GST", rpt.CreatedDate)) * 100 & "%", "") & "</td></tr>"
            ss += "<tr style='font-weight:bold;'><td colspan='3'>" & GetMessage(77) & ": " & rpt.CreatedDate & "</td><td align='right' colspan='2'>" & IIf(org.QSTReg, GetMessage(115) & ":</td><td align='right' colspan='2'>" & org.GetCRAactualRatio("QST", rpt.CreatedDate, org.GetCRA("QST", rpt.CreatedDate)) * 100 & "%", "") & "</td></tr>"

            linenum = 2
            Select Case rpt.Status
                Case 1 : statusDate = "" : statusDesc = GetMessage(105)
                Case 2 : statusDate = rpt.SubmittedDate : statusDesc = GetMessage(106)
                Case 3 : statusDate = rpt.ApprovedDate : statusDesc = GetMessage(253)
                Case 4 : statusDate = rpt.FinalizedDate : statusDesc = GetMessage(78)
            End Select

            If rpt.Status = 4 Then
                Dim finalizedBy As New Employee(rpt.FinalizedBy)
                ss += "<tr style='font-weight:bold;'><td colspan='3'>" & GetMessage(70) & ": " & statusDesc & " " & GetMessage(255) & " " & rpt.FinalizedDate & " " & GetMessage(254) & " " & finalizedBy.FirstName & " " & finalizedBy.LastName & "</td><td align='right' colspan='2'>" & GetMessage(237) & ": " & rpt.FinalizedDate.Year + p.SubtractYear & "</td><td align='right' colspan='2'> " & GetMessage(244) & ": " & p.PeriodNum & "</td></tr>"
                finalizedBy = Nothing
            Else
                ss += "<tr style='font-weight:bold;'><td colspan='10'>" & GetMessage(111) & ": " & statusDesc & " " & statusDate & "</td></tr>"
            End If
            org = Session("emp").Organization
            If org.QSTReg = False Then
                ss += "<tr style='height:10px;'><td colspan='15'></td></tr>"
                ss += "</table>"

                ss += "<table border='0' cellspacing='0' cellpadding='0' width='100%'  style='font-size:smaller;border-collapse:collapse;'>"
                ss += "<tr style='font-weight:bold;border-bottom:thin solid silver;border-top:thin solid silver;'>"
                ss += "<td width='5px' align='left'>" & GetMessage(251) & "</td>"
                ss += "<td width='5px' align='center'>Jur</td>"
                ss += "<td align='left'>" & GetMessage(60) & "</td>"
                ss += "<td align='left' " & IIf(org.Parent.DisplayProject, "", "style='display:none;'") & ">" & GetCustomTag("P") & "</td>"
                ss += "<td align='left' " & IIf(org.Parent.DisplayCostCenter, "", "style='display:none;'") & ">" & GetCustomTag("C") & "</td><td align='left' " & IIf(org.Parent.DisplayWorkOrder, "", "style='display:none;'") & ">" & GetCustomTag("W") & "</td>"
                ss += "<td align='left'>" & GetMessage(61) & "</td>"
                ss += "<td align='center'>" & GetMessage(63) & "</td>"
                ss += "<td align='center' (display)>Type</td>"
                ss += "<td style='width:50px;' align='right'>Total</td>"
                ss += "<td align='right'>" & GetMessage(118) & "</td><td align='right'>"
                ss += "<td align='right' " & IIf(org.OrgSizeGST <> 2, "style='display:none;'", "") & ">" & GetMessage(120) & "</td>"
                ss += "<td style='width:50px;' align='right'>Net</td><td align='right' " & IIf(org.OrgSizeGST <> 2, "colspan='3'", "") & ">" & GetMessage(48) & "</td>"
                ss += "</tr>"
            Else
                ss += "<tr style='height:10px;'><td colspan='15'></td></tr>"
                ss += "</table>"

                ss += "<table border='0' cellspacing='0' cellpadding='0' width='100%'  style='font-size:smaller;border-collapse:collapse;'>"
                ss += "<tr style='font-weight:bold;border-bottom:thin solid silver;border-top:thin solid silver;'>"
                ss += "<td width='5px' align='left'>" & GetMessage(251) & "</td>"
                ss += "<td width='5px' align='center'>Jur</td>"
                ss += "<td align='left'>" & GetMessage(60) & "</td>"
                ss += "<td align='left' " & IIf(org.Parent.DisplayProject, "", "style='display:none;'") & ">" & GetCustomTag("P") & "</td>"
                ss += "<td align='left' " & IIf(org.Parent.DisplayCostCenter, "", "style='display:none;'") & ">" & GetCustomTag("C") & "</td><td align='left' " & IIf(org.Parent.DisplayWorkOrder, "", "style='display:none;'") & ">" & GetCustomTag("W") & "</td>"
                ss += "<td align='left'>" & GetMessage(61) & "</td>"
                ss += "<td align='center'>" & GetMessage(63) & "</td>"
                ss += "<td align='center' (display)>Type</td>"
                ss += "<td style='width:50px;' align='right'>Total</td>"
                ss += "<td align='right'>" & GetMessage(118) & "</td><td align='right'>" & GetMessage(119) & "</td>"
                ss += "<td align='right' " & IIf(org.OrgSizeGST <> 2, "style='display:none;'", "") & ">" & GetMessage(120) & "</td>"
                ss += "<td style='width:50px;' align='right'>Net</td><td align='right' " & IIf(org.OrgSizeGST <> 2, "colspan='3'", "") & ">" & GetMessage(48) & "</td>"
                ss += "</tr>"
            End If


            linenum = 3

            i = 0
            If Not IsNothing(rpt.Expenses) Then
                For Each exp In rpt.Expenses
                    i += 1

                    If exp.CurrID <> 25 Then
                        Dim currency As Currency
                        currency = New Currency(exp.CurrID)
                        footerCurrencyString += exp.Amount & " " & currency.Symbol & ", "
                        currency = Nothing
                    End If
                    Dim str As String
                    ITC = exp.ITC
                    ITR = exp.ITR
                    RITC = exp.RITC
                    Amt = exp.AmountCDN
                    str = Convert.ToString(Amt)
                    str = str.Replace(",", String.Empty)
                    Amt = Convert.ToDouble(str)
                    linenum = 4
                    If exp.Reimburse = False Then displayPayableTypeCol = True
                    If org.QSTReg = False Then
                        ss += "<tr style='border-bottom:thin solid silver;background-color:" & IIf(i Mod 2 = 0, "white", "white") & ";'>"
                        ss += "<td align='left' width='5px'>" & exp.DateOfExpense & "&nbsp;</td>"
                        ss += "<td align='center' width='50px'>" & exp.Jurisdiction.Abbreviation & "</td>"
                        ss += "<td align='left' style='" & IIf(org.OrgSizeGST <> 2, "width:200px;", "") & "'>" & IIf(exp.ReceiptName <> "", "<img src='../images/attachment1.png' width='10px' height='10px' />", "") & IIf(Session("emp").defaultlanguage = "English", exp.OrgCategory.Category.Name, exp.OrgCategory.Category.NameFR) & IIf(exp.OrgCategory.Note <> "", " -- ", "") & exp.OrgCategory.Note & IIf(exp.OrgCategory.Note <> "", " -- ", "") & "</td>"
                        ss += "<td align='left' style='" & IIf(org.Parent.DisplayProject, "", "display:none;") & "'>" & exp.Project & "</td>"
                        ss += "<td align='left' style='" & IIf(org.Parent.DisplayCostCenter, "", "display:none;") & "'>" & exp.CostCenter & "</td>"
                        ss += "<td align='left' style='" & IIf(org.Parent.DisplayWorkOrder, "", "display:none;") & "'>" & exp.WorkOrder & "</td>"
                        ss += "<td align='left' style='" & IIf(org.OrgSizeGST <> 2, "width:150px;", "") & "'>" & Server.HtmlEncode(exp.SupplierName) & "</td>"
                        ss += "<td align='center' width='75px'>" & IIf(exp.OrgCategory.Category.AllowKM, FormatNumber(exp.Amount / exp.Rate, 0) & " x " & FormatNumber(exp.Rate, 2), IIf(exp.OrgCategory.Category.AllowGratuity And exp.Gratuities > 0, FormatNumber(exp.Gratuities, 2), "")) & "</td>"
                        ss += "<td align='center' width='50px' (display)>" & IIf(Not exp.Reimburse, IIf(exp.Account.Type = "Advance", "A", "C"), "") & "</td>"
                        ss += "<td align='right' width='50px'>" & FormatNumber(Amt, 2) & "</td>"
                        ss += "<td align='right' width='50px'>" & FormatNumber(ITC, 2) & "</td><td>"
                        ss += "<td align='right' width='50px' style='" & IIf(org.OrgSizeGST <> 2, "display:none;", "") & "'>" & FormatNumber(RITC, 2) & "</td>"
                        ss += "<td align='right' width='50px'>" & FormatNumber(Amt - ITC - ITR + RITC, 2) & "</td>"
                        ss += "<td align='right' " & IIf(org.OrgSizeGST <> 2, "colspan='3'", "") & ">" & Server.HtmlEncode(exp.Attendees) & "<BR>" & Server.HtmlEncode(exp.Comment) & "&nbsp;</td>"
                        ss += "</tr>"
                    Else
                        ss += "<tr style='border-bottom:thin solid silver;background-color:" & IIf(i Mod 2 = 0, "white", "white") & ";'>"
                        ss += "<td align='left' width='5px'>" & exp.DateOfExpense & "&nbsp;</td>"
                        ss += "<td align='center' width='50px'>" & exp.Jurisdiction.Abbreviation & "</td>"
                        ss += "<td align='left' style='" & IIf(org.OrgSizeGST <> 2, "width:200px;", "") & "'>" & IIf(exp.ReceiptName <> "", "<img src='../images/attachment1.png' width='10px' height='10px' />", "") & IIf(Session("emp").defaultlanguage = "English", exp.OrgCategory.Category.Name, exp.OrgCategory.Category.NameFR) & IIf(exp.OrgCategory.Note <> "", " -- ", "") & exp.OrgCategory.Note & IIf(exp.OrgCategory.Note <> "", " -- ", "") & "</td>"
                        ss += "<td align='left' style='" & IIf(org.Parent.DisplayProject, "", "display:none;") & "'>" & exp.Project & "</td>"
                        ss += "<td align='left' style='" & IIf(org.Parent.DisplayCostCenter, "", "display:none;") & "'>" & exp.CostCenter & "</td>"
                        ss += "<td align='left' style='" & IIf(org.Parent.DisplayWorkOrder, "", "display:none;") & "'>" & exp.WorkOrder & "</td>"
                        ss += "<td align='left' style='" & IIf(org.OrgSizeGST <> 2, "width:150px;", "") & "'>" & Server.HtmlEncode(exp.SupplierName) & "</td>"
                        ss += "<td align='center' width='75px'>" & IIf(exp.OrgCategory.Category.AllowKM, FormatNumber(exp.Amount / exp.Rate, 0) & " x " & FormatNumber(exp.Rate, 2), IIf(exp.OrgCategory.Category.AllowGratuity And exp.Gratuities > 0, FormatNumber(exp.Gratuities, 2), "")) & "</td>"
                        ss += "<td align='center' width='50px' (display)>" & IIf(Not exp.Reimburse, IIf(exp.Account.Type = "Advance", "A", "C"), "") & "</td>"
                        ss += "<td align='right' width='50px'>" & FormatNumber(Amt, 2) & "</td>"
                        ss += "<td align='right' width='50px'>" & FormatNumber(ITC, 2) & "</td>"
                        ss += "<td align='right' width='50px'>" & FormatNumber(ITR, 2) & "</td>"
                        ss += "<td align='right' width='50px' style='" & IIf(org.OrgSizeGST <> 2, "display:none;", "") & "'>" & FormatNumber(RITC, 2) & "</td>"
                        ss += "<td align='right' width='50px'>" & FormatNumber(Amt - ITC - ITR + RITC, 2) & "</td>"
                        ss += "<td align='right' " & IIf(org.OrgSizeGST <> 2, "colspan='3'", "") & ">" & Server.HtmlEncode(exp.Attendees) & "<BR>" & Server.HtmlEncode(exp.Comment) & "&nbsp;</td>"
                        ss += "</tr>"
                    End If
                    DontReimburseAmt += IIf(Not exp.Reimburse, Amt, 0)

                    If Not exp.Reimburse Then
                        If Not tp.ContainsKey(exp.TPName) Then
                            tp.Add(exp.TPName, Amt)
                        Else
                            tp(exp.TPName) += Amt
                        End If
                    End If


                    AmtTotal += Amt
                    ITCTotal += ITC
                    ITRTotal += ITR
                    RITCTotal += RITC
                    NetTotal += Amt - ITC - ITR + RITC

                    Select Case exp.Jurisdiction.ID
                        Case 2 : RITCTotalOnt += RITC
                        Case 10 : RITCTotalBC += RITC
                        Case 4 : RITCTotalPEI += RITC
                    End Select

                Next
                If org.QSTReg = False Then
                    ss += "<tr style='font-weight:bold;border-top:thin solid silver;'><td>Total</td><td></td><td></td><td " & IIf(org.Parent.DisplayProject, "", "style='display:none;'") & "></td><td " & IIf(org.Parent.DisplayWorkOrder, "", "style='display:none;'") & "></td><td " & IIf(org.Parent.DisplayCostCenter, "", "style='display:none;'") & "></td><td></td><td></td><td (display)></td><td align='right'>" & FormatNumber(AmtTotal, 2) & "</td><td align='right'>" & FormatNumber(ITCTotal, 2) & "</td><td align='right'>" & "</td></td><td align='right' " & IIf(org.OrgSizeGST <> 2, "style='display:none;'", "") & ">" & FormatNumber(RITCTotal, 2) & "</td><td align='right'>" & FormatNumber(NetTotal, 2) & "</td><td></td></tr>"
                Else
                    ss += "<tr style='font-weight:bold;border-top:thin solid silver;'><td>Total</td><td></td><td></td><td " & IIf(org.Parent.DisplayProject, "", "style='display:none;'") & "></td><td " & IIf(org.Parent.DisplayWorkOrder, "", "style='display:none;'") & "></td><td " & IIf(org.Parent.DisplayCostCenter, "", "style='display:none;'") & "></td><td></td><td></td><td (display)></td><td align='right'>" & FormatNumber(AmtTotal, 2) & "</td><td align='right'>" & FormatNumber(ITCTotal, 2) & "</td><td align='right'>" & FormatNumber(ITRTotal, 2) & "</td><td align='right' " & IIf(org.OrgSizeGST <> 2, "style='display:none;'", "") & ">" & FormatNumber(RITCTotal, 2) & "</td><td align='right'>" & FormatNumber(NetTotal, 2) & "</td><td></td></tr>"
                End If
                'If DontReimburseAmt > 0 Then
                '    ss += "<tr><td style='height:10px;'></td></tr>"
                '    ss += "<tr  style=' font-weight:bold;'><td colspan='3'>" & GetMessage(256) & " *</td><td " & IIf(org.Parent.DisplayProject, "", "style='display:none;'") & "></td><td " & IIf(org.Parent.DisplayWorkOrder, "", "style='display:none;'") & "></td><td " & IIf(org.Parent.DisplayCostCenter, "", "style='display:none;'") & "></td><td></td><td></td><td>&nbsp;&nbsp;$</td><td align='right'>" & FormatNumber(DontReimburseAmt, 2) & "</td><td></td><td align='right'></td><td></td><td align='right'></td><td></td><td align='right'></td><td></td><td align='right'></td></tr>"
                'End If

                ss += "<tr><td style='height:10px;'></td></tr>"

                For i = 0 To tp.Count - 1
                    ss += "<tr style=' font-weight:bold;'><td  colspan='3'>" & GetMessage(544) & " " & tp.ElementAt(i).Key & "</td><td " & IIf(org.Parent.DisplayProject, "", "style='display:none;'") & "></td><td " & IIf(org.Parent.DisplayWorkOrder, "", "style='display:none;'") & "></td><td " & IIf(org.Parent.DisplayCostCenter, "", "style='display:none;'") & "></td><td></td><td></td><td (display)></td><td align='right'>" & FormatNumber(tp.ElementAt(i).Value, 2) & "</td><td></td><td align='right'></td><td></td><td></td></tr>"
                Next

                ss += "<tr style=' font-weight:bold;'><td  colspan='3'>" & GetMessage(257) & "</td><td " & IIf(org.Parent.DisplayProject, "", "style='display:none;'") & "></td><td " & IIf(org.Parent.DisplayWorkOrder, "", "style='display:none;'") & "></td><td " & IIf(org.Parent.DisplayCostCenter, "", "style='display:none;'") & "></td><td></td><td></td><td (display)></td><td align='right'>" & FormatNumber(AmtTotal - DontReimburseAmt, 2) & "</td><td></td><td></td><td></td><td></td></tr>"

                If RITCTotalOnt > 0 Then ss += "<tr height='30px' valign='bottom' style='font-weight:bold;'><td>" & GetMessage(258) & "</td><td " & IIf(org.Parent.DisplayProject, "", "style='display:none;'") & "></td><td " & IIf(org.Parent.DisplayWorkOrder, "", "style='display:none;'") & "></td><td " & IIf(org.Parent.DisplayCostCenter, "", "style='display:none;'") & "></td><td></td><td></td><td (display)></td><td></td><td></td><td colspan='3' align='right'></td><td align='right'>" & FormatNumber(RITCTotalOnt, 2) & "</td><td></td><td></td><td></td><td></td></tr>"
                If RITCTotalBC > 0 Then ss += "<tr style='font-weight:bold;'><td>" & GetMessage(259) & "</td><td " & IIf(org.Parent.DisplayProject, "", "style='display:none;'") & "></td><td " & IIf(org.Parent.DisplayWorkOrder, "", "style='display:none;'") & "></td><td " & IIf(org.Parent.DisplayCostCenter, "", "style='display:none;'") & "></td><td></td><td></td><td (display)></td><td></td><td></td><td colspan='3' align='right'></td><td align='right'>" & FormatNumber(RITCTotalBC, 2) & "</td><td></td><td></td><td></td><td></td></tr>"
                If RITCTotalPEI > 0 Then ss += "<tr style='font-weight:bold;'><td>" & GetMessage(260) & "</td><td " & IIf(org.Parent.DisplayProject, "", "style='display:none;'") & "></td><td " & IIf(org.Parent.DisplayWorkOrder, "", "style='display:none;'") & "></td><td " & IIf(org.Parent.DisplayCostCenter, "", "style='display:none;'") & "></td><td></td><td></td><td (display)></td><td></td><td></td><td colspan='3' align='right'></td><td align='right'>" & FormatNumber(RITCTotalPEI, 2) & "</td><td></td><td></td><td></td><td></td></tr>"
                ss += "<tr style='height:10px;'><td></td></tr>"

                If Not String.IsNullOrEmpty(footerCurrencyString) Then
                    footerCurrencyString = footerCurrencyString.Remove(footerCurrencyString.Length - 2)
                End If
                ss += "<tr style='border-top:thin solid silver;border-bottom:thin solid red;'><td colspan='8' style='font-style:italic;'>" & GetMessage(124) & ": " & footerCurrencyString & "</td>"

                ss += "<td " & IIf(org.Parent.DisplayProject, "", "style='display:none;'") & "></td><td " & IIf(org.Parent.DisplayWorkOrder, "", "style='display:none;'") & "></td><td " & IIf(org.Parent.DisplayCostCenter, "", "style='display:none;'") & "></td><td (display)></td><td align='right' colspan='3' style='border-top:thin solid silver;border-bottom:thin solid red;'>" & GetMessage(125) & ": " & Format(Now, "dd/MM/yyyy") & "</td></tr>"
                ss += "</table>"
                ss += "<br><br>"

                p = Nothing
            Else
                ss = GetMessage(132) 'no expenses to display
            End If

        Else
            '  ss = ""
            ss = "No authorization to view this data"
        End If

        ss = Replace(ss, "(display)", IIf(displayPayableTypeCol, "", " style='display:none;'"))

        Return ss
    End Function


    ''' <summary>
    ''' Detailed summary for a given report ID
    ''' </summary>
    ''' <param name="rpt">report object</param>
    ''' <returns>A string containing a table with all the information for the report that was passed</returns>
    ''' <remarks></remarks>
    Private Function SummaryDetailed2(rpt As Report) As String
        Dim credit As Double
        Dim ii As Integer
        Dim ss As String = ""
        Dim sAccSegment As String = ""
        Dim sOtherAccPayable As String = "", sAccPayable As String = ""
        Dim oc As New OrgCat
        Dim acc As Account
        Dim TP As New SortedDictionary(Of String, Double)

        If rpt.EmpID = Session("emp").ID Or (rpt.Emp.Supervisor = Session("emp").id) Or (rpt.Emp.Finalizer = Session("emp").id) Or Session("emp").isadmin Then
            ss += "<accPayable>"
            ss += "<otherAccPayables>"

            ITCTotal = 0 : ITRTotal = 0 : RITCTotalBC = 0 : RITCTotalOnt = 0 : RITCTotalPEI = 0 : ITC = 0 : ITR = 0 : RITC = 0

            For Each exp In rpt.Expenses
                items += 1

                ITC += exp.ITC
                ITR += exp.ITR

                ss += "<tr style='border-bottom:thin solid silver;'>"
                ss += "<td align='left'>R" & rpt.ReportNumberFormatted & "</td>"
                ss += "<td align='left'>" & rpt.FinalizedDate & "</td>"

                If org.Parent.AccSegment.IndexOf("D") = 0 Then ss += "<td width='5%'>" & rpt.Emp.DivCode & "</td>"
                If org.Parent.AccSegment.IndexOf("A") = 0 Then ss += "<td width='5%'>" & exp.OrgCategory.GLAccount & "</td>"

                If org.Parent.AccSegment.IndexOf("D") = 1 Then ss += "<td width='5%'>" & rpt.Emp.DivCode & "</td>"
                If org.Parent.AccSegment.IndexOf("A") = 1 Then ss += "<td width='5%'>" & exp.OrgCategory.GLAccount & "</td>"
                If org.Parent.AccSegment.IndexOf("P") = 1 Then ss += "<td width='5%'>" & exp.Project & "</td>"
                If org.Parent.AccSegment.IndexOf("C") = 1 Then ss += "<td width='5%'>" & exp.CostCenter & "</td>"

                If org.Parent.AccSegment.IndexOf("P") = 2 Then ss += "<td width='5%'>" & exp.Project & "</td>"
                If org.Parent.AccSegment.IndexOf("C") = 2 Then ss += "<td width='5%'>" & exp.CostCenter & "</td>"

                If org.Parent.AccSegment.IndexOf("P") = 3 Then ss += "<td width='5%'>" & exp.Project & "</td>"
                If org.Parent.AccSegment.IndexOf("C") = 3 Then ss += "<td width='5%'>" & exp.CostCenter & "</td>"
                If org.Parent.AccSegment.IndexOf("NNN") > 0 Then ss += "<td></td>"
                If org.Parent.AccSegment.IndexOf("NN") > 0 Then ss += "<td></td>"
                If org.Parent.AccSegment.IndexOf("N") > 0 Then ss += "<td></td>"

                acc = New Account(exp.OrgCategory.GLAccount, exp.OrgCategory.OrgID)
                ss += "<td align='left'>" & acc.Name & "</td>"
                acc = Nothing
                ss += "<td align='left'>" & rpt.Emp.EmpNum & "</td>"
                ss += "<td align='right'>" & FormatNumber(exp.AmountCDN - exp.ITC - exp.ITR + exp.RITC, 2) & "</td>"
                ss += "<td align='right'></td>"
                ss += "</tr>"

                If exp.Reimburse Then
                    credit += CDec(exp.AmountCDN)
                Else
                    If TP.ContainsKey(exp.TPNum) Then
                        TP(exp.TPNum) += exp.AmountCDN
                    Else
                        TP.Add(exp.TPNum, exp.AmountCDN)
                    End If
                End If

                RITCTotalBC = oc.GetRITCTotals(rpt.ID, 10)
                RITCTotalOnt = oc.GetRITCTotals(rpt.ID, 2)
                RITCTotalPEI = oc.GetRITCTotals(rpt.ID, 4)
                AmtTotal += CDec(exp.AmountCDN) + exp.RITC
            Next

            For ii = 0 To TP.Count - 1
                sOtherAccPayable += TPPayableLine(TP.ElementAt(ii).Key, TP.ElementAt(ii).Value, rpt, "credit")
            Next

            If credit > 0 Then sAccPayable += CreditDebitLine(org.Parent.AccountPayable, credit, rpt, "credit")

            ss = Replace(ss, "<accPayable>", sAccPayable)
            ss = Replace(ss, "<otherAccPayables>", sOtherAccPayable)

            If ITC > 0 Then ss += CreditDebitLine(org.Parent.ITCAccount, ITC, rpt, "Debit")
            If ITR > 0 Then ss += CreditDebitLine(org.Parent.ITRAccount, ITR, rpt, "Debit")
            If RITCTotalOnt > 0 Then ss += CreditDebitLine(org.Parent.ritcONAccount, RITCTotalOnt, rpt, "credit")
            If RITCTotalBC > 0 Then CreditDebitLine(org.Parent.ritcBCAccount, RITCTotalBC, rpt, "credit")
            If RITCTotalPEI > 0 Then ss += CreditDebitLine(org.Parent.ritcPEIAccount, RITCTotalPEI, rpt, "credit")

        Else
            ss = ""
            'ss = "No authorization to view this data"
        End If

        oc = Nothing
        Return ss
    End Function

    ''' <summary>
    ''' Gets the creditcard (thirdparty) information to display on a line of a report
    ''' </summary>
    ''' <param name="tpNum">third party number</param>
    ''' <param name="Total">amount of the expense</param>
    ''' <param name="rpt">report object</param>
    ''' <param name="Type">type - advance or TP (thirdparty)</param>
    ''' <returns>A string containing the row of information to display on the report</returns>
    ''' <remarks></remarks>
    Private Function TPPayableLine(tpNum As String, Total As Double, rpt As Report, Type As String) As String
        Dim s As String
        Dim acc As New Account(rpt.Emp.Organization.ID, tpNum)

        i += 1
        s += "<tr style='border-bottom:thin solid silver;'>"
        s += "<td align='left'>R" & rpt.ReportNumberFormatted & "</td>"
        s += "<td align='left'>" & rpt.FinalizedDate & "</td>"

        s += IIf(rpt.Emp.Organization.Parent.AccSegment.IndexOf("A") = 0, "<td width='5%'>" & acc.Number & "</td><td></td>", "<td width='5%'></td><td>" & acc.Number & "</td>")
        s += "<td></td>"
        s += "<td></td>"

        s += "<td>" & IIf(acc.Type = "TP", GetMessage(236), "") & " " & acc.Name & "</td>"
        s += "<td align='left'>" & IIf(acc.Type = "Advance", rpt.Emp.EmpNum, tpNum) & "</td>"

        s += IIf(Type = "credit", "<td></td>", "")
        s += "<td align='right'>" & FormatNumber(Total, 2) & "</td>"
        s += IIf(Type = "credit", "", "<td>&nbsp;</td>")
        s += "</tr>"

        acc = Nothing

        Return s
    End Function


    ''' <summary>
    ''' Gets the accounts payable row data or taxes row data to display on a report
    ''' </summary>
    ''' <param name="accountNum">account number</param>
    ''' <param name="Total">total amount</param>
    ''' <param name="rpt">report object</param>
    ''' <param name="Type">credit or debit</param>
    ''' <returns>A string containing the row of data to display on the report</returns>
    ''' <remarks></remarks>
    Private Function CreditDebitLine(accountNum As String, Total As Double, rpt As Report, Type As String) As String
        Dim s As String
        Dim acc As Account

        i += 1
        s += "<tr style='border-bottom:thin solid silver;'>"
        s += "<td align='left'>R" & rpt.ReportNumberFormatted & "</td>"
        s += "<td align='left'>" & rpt.FinalizedDate & "</td>"

        s += IIf(rpt.Emp.Organization.Parent.AccSegment.IndexOf("A") = 0, "<td width='5%'>" & accountNum & "</td><td></td>", "<td width='5%'></td><td>" & accountNum & "</td>")
        s += "<td></td>"
        s += "<td></td>"

        acc = New Account(accountNum, org.ID)
        s += "<td>" & acc.Name & "</td>"

        s += "<td align='left'>" & rpt.Emp.EmpNum & "</td>"
        s += IIf(Type = "credit", "<td>&nbsp;</td>", "")
        s += "<td align='right'>" & FormatNumber(Total, 2) & "</td>"
        s += IIf(Type = "credit", "", "<td>&nbsp;</td>")
        s += "</tr>"

        acc = Nothing

        Return s
    End Function

    ''' <summary>
    ''' Detailed summary to export to CSV
    ''' </summary>
    ''' <param name="rpt">report object</param>
    ''' <returns>A string in a CSV format</returns>
    ''' <remarks></remarks>
    Private Function SummaryDetailedCSV2(rpt As Report) As String
        Dim buffer() As Byte
        Dim memoryStream = New System.IO.MemoryStream
        Dim credit As Double
        Dim ii As Integer
        Dim ss As String = ""
        Dim sAccSegment As String = ""
        Dim sOtherAccPayable As String = "", sAccPayable As String = ""
        Dim oc As New OrgCat
        Dim str As String


        If rpt.EmpID = Session("emp").ID Or (rpt.Emp.Supervisor = Session("emp").id) Or (rpt.Emp.Finalizer = Session("emp").id) Or Session("emp").isadmin Then
            i += 1
            ss += "<accPayable>"
            ss += "<otherAccPayables>"

            ITCTotal = 0 : ITRTotal = 0 : RITCTotalBC = 0 : RITCTotalOnt = 0 : RITCTotalPEI = 0 : ITC = 0 : ITR = 0 : RITC = 0









            For Each exp In rpt.Expenses
                                         i += 1
                                         items += 1

                                         ITC += exp.ITC
                                         ITR += exp.ITR

                                         ss += """" & "R" & rpt.ReportNumberFormatted & """"
                                         ss += ",""" & Format(rpt.FinalizedDate, "yyyyMMdd") & """"
                                         'ss += ",""" & rpt.Emp.EmpNum & """"

                                         If org.Parent.AccSegment.IndexOf("D") = 0 Then sAccSegment = rpt.Emp.DivCode
                                         If org.Parent.AccSegment.IndexOf("A") = 0 Then sAccSegment = exp.OrgCategory.GLAccount
                                         If org.Parent.AccSegment.IndexOf("D") = 1 Then sAccSegment += " " & rpt.Emp.DivCode
                                         If org.Parent.AccSegment.IndexOf("A") = 1 Then sAccSegment += " " & exp.OrgCategory.GLAccount
                                         If org.Parent.AccSegment.IndexOf("P") = 1 Then sAccSegment += " " & exp.Project
                                         If org.Parent.AccSegment.IndexOf("C") = 1 Then sAccSegment += " " & exp.CostCenter

                                         If org.Parent.AccSegment.IndexOf("P") = 2 Then sAccSegment += " " & exp.Project
                                         If org.Parent.AccSegment.IndexOf("C") = 2 Then sAccSegment += " " & exp.CostCenter

                                         If org.Parent.AccSegment.IndexOf("P") = 3 Then sAccSegment += " " & exp.Project
                                         If org.Parent.AccSegment.IndexOf("C") = 3 Then sAccSegment += " " & exp.CostCenter

                                         'old code
                                         'ss += ",""" & sAccSegment & """,""" & rpt.Emp.EmpNum & """,""D"",""" & Replace(FormatNumber(exp.AmountCDN - exp.ITC - exp.ITR + exp.RITC, 2).ToString, ",", "") & """" & vbCrLf

                                         'New code
                                         ss += ",""" & sAccSegment & """,""" & rpt.Emp.EmpNum & """,""D"",""" & Replace(FormatNumber(exp.AmountCDN - exp.ITC - exp.ITR + exp.RITC, 2).ToString().Replace(",", String.Empty), ",", "") & """" & vbCrLf



                                         If Not exp.Reimburse Then
                                             sOtherAccPayable += """" & "R" & rpt.ReportNumberFormatted & """"
                                             sOtherAccPayable += ",""" & Format(rpt.FinalizedDate, "yyyyMMdd") & """"
                                             sOtherAccPayable += ",""" & org.Parent.AccountPayable & """"
                                             sOtherAccPayable += ",""" & exp.TPNum & """"
                                             sOtherAccPayable += ",""C"""
                                             sOtherAccPayable += ",""" & FormatNumber(exp.AmountCDN(), 2).Replace(",", String.Empty) & """" & vbCrLf
                                         Else
                                             credit += CDec(exp.AmountCDN)
                                         End If

                                         RITCTotalBC = oc.GetRITCTotals(rpt.ID, 10)
                                         RITCTotalOnt = oc.GetRITCTotals(rpt.ID, 2)
                                         RITCTotalPEI = oc.GetRITCTotals(rpt.ID, 4)
                                         AmtTotal += CDec(exp.AmountCDN) + exp.RITC
                                     Next

                                     If credit > 0 Then
                                         sAccPayable += """" & "R" & rpt.ReportNumberFormatted & """"
                                         sAccPayable += ",""" & Format(rpt.FinalizedDate, "yyyyMMdd") & """"
                                         sAccPayable += ",""" & org.Parent.AccountPayable & """"
                                         sAccPayable += ",""" & rpt.Emp.EmpNum & """"
                                         sAccPayable += ",""C"""
                                         sAccPayable += ",""" & FormatNumber(credit, 2).Replace(",", String.Empty) & """" & vbCrLf

                                     End If

                                     ss = Replace(ss, "<accPayable>", sAccPayable)
                                     ss = Replace(ss, "<otherAccPayables>", sOtherAccPayable)

                                     If ITC > 0 Then
                                         i += 1
                                         ss += """" & "R" & rpt.ReportNumberFormatted & """"
                                         ss += ",""" & Format(rpt.FinalizedDate, "yyyyMMdd") & """"
                                         ss += ",""" & org.Parent.ITCAccount & """"
                                         ss += ",""" & rpt.Emp.EmpNum & """"
                                         ss += ",""D"""
                                         ss += ",""" & FormatNumber(ITC, 2) & """" & vbCrLf

                                     End If

                                     If ITR > 0 Then
                                         i += 1
                                         ss += """" & "R" & rpt.ReportNumberFormatted & """"
                                         ss += ",""" & Format(rpt.FinalizedDate, "yyyyMMdd") & """"
                                         ss += ",""" & org.Parent.ITRAccount & """"
                                         ss += ",""" & rpt.Emp.EmpNum & """"
                                         ss += ",""D"""
                                         ss += ",""" & FormatNumber(ITR, 2) & """" & vbCrLf

                                     End If

                                     If RITCTotalOnt > 0 Then
                                         i += 1
                                         ss += """" & "R" & rpt.ReportNumberFormatted & """"
                                         ss += ",""" & Format(rpt.FinalizedDate, "yyyyMMdd") & """"
                                         ss += ",""" & org.Parent.ritcONAccount & """"
                                         ss += ",""" & rpt.Emp.EmpNum & """"
                                         ss += ",""C"""
                                         ss += ",""" & FormatNumber(RITCTotalOnt, 2) & """" & vbCrLf

                                     End If

                                     If RITCTotalBC > 0 Then
                                         i += 1
                                         ss += """" & "R" & rpt.ReportNumberFormatted & """"
                                         ss += ",""" & Format(rpt.FinalizedDate, "yyyyMMdd") & """"
                                         ss += ",""" & org.Parent.ritcBCAccount & """"
                                         ss += ",""" & rpt.Emp.EmpNum & """"
                                         ss += ",""C"""
                                         ss += ",""" & FormatNumber(RITCTotalBC, 2) & """" & vbCrLf

                                     End If

                                     If RITCTotalPEI > 0 Then
                                         i += 1
                                         ss += """" & "R" & rpt.ReportNumberFormatted & """"
                                         ss += ",""" & Format(rpt.FinalizedDate, "yyyyMMdd") & """"
                                         ss += ",""" & org.Parent.ritcPEIAccount & """"
                                         ss += ",""" & rpt.Emp.EmpNum & """"
                                         ss += ",""C"""
                                         ss += ",""" & FormatNumber(RITCTotalPEI, 2) & """" & vbCrLf
                                     End If

        Else
            ss = ""
            'ss = "No authorization to view this data"
        End If

        oc = Nothing
        Return ss
    End Function

    ''' <summary>
    ''' Summary report by gl account
    ''' </summary>
    ''' <remarks></remarks>

    Private Sub SummaryReport()
        Dim oc As New OrgCat()
        Dim saccsegment As String = ""
        Dim tp As New SortedDictionary(Of String, Double)
        Dim i As Integer
        Dim sOtherAccPayable As String
        Dim acc As Account


        If Request.QueryString("rpt") = "" Then
            GetStartEndDates()
            org.GetReports(dStartDate, dEndDate)

            If Not IsNothing(org.Reports) Then
                s = ReportHeader(GetMessage(216), "615px", "50%")
                s = Replace(s, "numberofitemstitle", GetMessage(242))
                s = Replace(s, "numberofitems", org.Reports.Count)

                a = oc.GetGLAccountTotals(orgID, dStartDate, dEndDate, org.Parent.AccSegment)
                s += "<table border=0 cellspacing='0' width='615px' style='font-size:smaller;border-collapse:collapse;'>"
                s += "<tr style='font-weight:bold;border-top:thin solid silver;border-bottom:thin solid silver;'><td colspan='2'>" & GetMessage(268) & "</td><td></td><td></td><td width='150px' style='text-align:right;'>" & GetMessage(246) & "</td><td width='150px' style='text-align:right;'>" & GetMessage(247) & "</td></tr>"
                s += "<tr style='border-bottom:thin solid silver;'>" & IIf(org.Parent.AccSegment.IndexOf("A") = 0, "<td>" & org.Parent.AccountPayable & "</td><td></td>", "<td width='5%'></td><td>" & org.Parent.AccountPayable & "</td>") & "<td></td><td></td><td></td><td width='150px' style='text-align:right;'>AccountPayableAmount</td></tr>"
                s += "<OtherAccPayable>"

                If Not IsNothing(a) Then
                    For i = 0 To a.GetUpperBound(1)
                        s += "<tr style='border-bottom:thin solid silver;'>"
                        If org.Parent.AccSegment.IndexOf("D") = 0 Then s += "<td width='5%'>" & a(5, i) & "</td>"
                        If org.Parent.AccSegment.IndexOf("A") = 0 Then s += "<td width='5%'>" & a(0, i) & "</td>"

                        If org.Parent.AccSegment.IndexOf("D") = 1 Then s += "<td width='5%'>" & a(5, i) & "</td>"
                        If org.Parent.AccSegment.IndexOf("A") = 1 Then s += "<td width='5%'>" & a(0, i) & "</td>"
                        If org.Parent.AccSegment.IndexOf("P") = 1 Then s += "<td width='5%'>" & a(6, i) & "</td>"
                        If org.Parent.AccSegment.IndexOf("C") = 1 Then s += "<td width='5%'>" & a(7, i) & "</td>"

                        If org.Parent.AccSegment.IndexOf("P") = 2 Then s += "<td width='5%'>" & a(6, i) & "</td>"
                        If org.Parent.AccSegment.IndexOf("C") = 2 Then s += "<td width='5%'>" & a(7, i) & "</td>"

                        If org.Parent.AccSegment.IndexOf("P") = 3 Then s += "<td width='5%'>" & a(6, i) & "</td>"
                        If org.Parent.AccSegment.IndexOf("C") = 3 Then s += "<td width='5%'>" & a(7, i) & "</td>"
                        If org.Parent.AccSegment.IndexOf("NNN") > 0 Then s += "<td></td>"
                        If org.Parent.AccSegment.IndexOf("NN") > 0 Then s += "<td></td>"
                        If org.Parent.AccSegment.IndexOf("N") > 0 Then s += "<td></td>"

                        s += "<td width='150px' style='text-align:right;'>"
                        s += FormatNumber(CDec(a(1, i)) - CDec(a(2, i)) - CDec(a(3, i)) + CDec(a(4, i)), 2)
                        s += "</td><td></td></tr>"

                        AmtTotal += CDec(CDec(a(1, i)) - CDec(a(2, i)) - CDec(a(3, i)) + CDec(a(4, i)))
                        AccPayableTotal += CDec(CDec(a(1, i)) - CDec(a(2, i)) - CDec(a(3, i)) + CDec(a(4, i)))
                        ITC += CDec(a(2, i))
                        ITR += CDec(a(3, i))
                    Next

                    RITCTotalBC = oc.GetRITCTotals(orgID, 10, dStartDate, dEndDate)
                    RITCTotalOnt = oc.GetRITCTotals(orgID, 2, dStartDate, dEndDate)
                    RITCTotalPEI = oc.GetRITCTotals(orgID, 4, dStartDate, dEndDate)

                    For Each rpt In org.Reports
                        For Each exp In rpt.Expenses
                            If Not exp.Reimburse Then
                                If tp.ContainsKey(exp.TPNum) Then
                                    tp(exp.TPNum) += exp.AmountCDN
                                Else
                                    tp.Add(exp.TPNum, exp.AmountCDN)
                                End If
                            End If
                        Next
                    Next

                    For i = 0 To tp.Count - 1
                        acc = New Account(org.ID, tp.ElementAt(i).Key)
                        sOtherAccPayable += "<tr style='border-bottom:thin solid silver;'>" & IIf(org.Parent.AccSegment.IndexOf("A") = 0, "<td>" & acc.Number & "</td><td></td>", "<td width='5%'></td><td>" & acc.Number & "</td>") & "<td></td><td></td><td></td><td width='150px' style='text-align:right;'>" & FormatNumber(tp.ElementAt(i).Value, 2) & "</td></tr>"
                        AccPayableTotal -= tp.ElementAt(i).Value
                    Next

                End If

                SummaryFooter()
                s = Replace(s, "<OtherAccPayable>", sOtherAccPayable)
            End If
        Else
            SummaryByEmp()
        End If

        rpt = Nothing
        exp = Nothing
        org = Nothing
        tp = Nothing
        oc = Nothing
        acc = Nothing
    End Sub

    ''' <summary>
    ''' Footer to display on the summary report. contains the ITC, ITR, RITCs account information
    ''' </summary>
    ''' <remarks></remarks>
    Private Sub SummaryFooter()

        If ITC > 0 Then
            s += "<tr  style='border-bottom:thin solid silver;'>" & IIf(org.Parent.AccSegment.IndexOf("A") = 0, "<td>" & org.Parent.ITCAccount & "</td><td></td>", "<td></td><td>" & org.Parent.ITCAccount & "</td>") & "<td></td><td></td><td width='150px' style='text-align:right;'>"
            s += FormatNumber(ITC, 2)
            s += "</td><td></td></tr>"
        End If

        If ITR > 0 Then
            s += "<tr  style='border-bottom:thin solid silver;'>" & IIf(org.Parent.AccSegment.IndexOf("A") = 0, "<td>" & org.Parent.ITRAccount & "</td><td></td>", "<td></td><td>" & org.Parent.ITRAccount & "</td>") & "<td></td><td></td><td width='150px'  style='text-align:right;'>"
            s += FormatNumber(ITR, 2)
            s += "</td><td></td></tr>"
        End If

        If RITCTotalOnt > 0 Then
            s += "<tr  style='border-bottom:thin solid silver;'>" & IIf(org.Parent.AccSegment.IndexOf("A") = 0, "<td>" & org.Parent.ritcONAccount & "</td><td></td>", "<td></td><td>" & org.Parent.ritcONAccount & "</td>") & "<td></td><td></td><td></td><td width='150px'  style='text-align:right;'>"
            s += FormatNumber(RITCTotalOnt, 2)
            s += "</td></tr>"
        End If

        If RITCTotalBC > 0 Then
            s += "<tr  style='border-bottom:thin solid silver;'>" & IIf(org.Parent.AccSegment.IndexOf("A") = 0, "<td>" & org.Parent.ritcBCAccount & "</td><td></td>", "<td></td><td>" & org.Parent.ritcBCAccount & "</td>") & "<td></td><td></td><td></td><td width='150px'  style='text-align:right;'>"
            s += FormatNumber(RITCTotalBC, 2)
            s += "</td></tr>"
        End If

        If RITCTotalPEI > 0 Then
            s += "<tr  style='border-bottom:thin solid silver;'>" & IIf(org.Parent.AccSegment.IndexOf("A") = 0, "<td>" & org.Parent.ritcPEIAccount & "</td><td></td>", "<td></td><td>" & org.Parent.ritcPEIAccount & "</td>") & "<td></td><td></td><td></td><td width='150px'  style='text-align:right;'>"
            s += FormatNumber(RITCTotalPEI, 2)
            s += "</td></tr>"
        End If

        s += "<tr style='font-weight:bold;border-top:thin solid silver;border-bottom:thin solid #cd1e1e;'><td>Total</td><td></td><td></td><td></td><td style='text-align:right;'>" & FormatNumber(AmtTotal + ITC + ITR, 2) & "</td><td width='150px' align='right'>CreditTotal</td></tr>"
        s += "</table>"

        s = Replace(s, "AccountPayableAmount", FormatNumber(AccPayableTotal + ITC + ITR - RITCTotalBC - RITCTotalOnt - RITCTotalPEI, 2))
        s = Replace(s, "CreditTotal", FormatNumber(AmtTotal + ITC + ITR, 2))

        s += "<br><br>"

    End Sub


    Private Sub SummaryByEmp()
        Dim oc As New OrgCat()
        Dim emp As New Employee(CInt(Request.QueryString("empID")))
        Dim aR(0) As Report
        Dim p As Period

        If Request.QueryString("rpt") = 0 Then
            emp.GetReports()
            ReDim aR(emp.Reports.Count)
            aR = emp.Reports
        Else
            aR(0) = New Report(CInt(Request.QueryString("rpt")))
        End If

        s = ""
        For Each rpt In aR
            AmtTotal = 0 : ITC = 0 : ITR = 0 : RITCTotalBC = 0 : RITCTotalOnt = 0 : RITCTotalPEI = 0

            If rpt.Status = 4 Then
                p = New Period(orgID, rpt.FinalizedDate.Month)

                s += "<table width='615px'  style='font-size:smaller;'>"
                s += "<tr><td width='200px' style='font-weight:bold;'>" & emp.Organization.Name & IIf(emp.Organization.Code <> "", " (" & emp.Organization.Code & ")", "") & "</td></tr>"
                s += "<tr style='font-weight:bold;'><td>" & GetMessage(241) & ": " & rpt.Name & "</td><td align='right' style='color:#cd1e1e; '>Rpt " & rpt.ReportNumberFormatted & "</td></tr>"
                s += "<tr><td style=' font-weight:bold;'>" & emp.LastName & ", " & emp.FirstName & IIf(emp.EmpNum <> "", " (" & emp.EmpNum & ")", "") & IIf(emp.DivCode <> "", " " & GetCustomTag("D") & " " & emp.DivCode, "") & "</td></tr>"
                s += "<tr><td style=' font-weight:bold;'>" & GetMessage(125) & ": " & Format(Now, "dd/MM/yyyy") & "</td></tr>"
                s += "<tr style='font-weight:bold;'><td>" & GetMessage(78) & ": " & Format(rpt.FinalizedDate, "dd/MM/yyyy") & "</td><td align='right'>" & GetMessage(237) & ": " & rpt.FinalizedDate.Year + p.SubtractYear & " " & GetMessage(244) & ": " & p.PeriodNum & "</td></tr>"
                s += "<tr style='height:10px;'><td colspan='15'></td></tr>"
                s += "</table>"

                s += "<table border=0 width='615px'  style='font-size:smaller;'>"
                s += "<tr><td colspan='3' style='border-bottom:thin solid silver;'></td></tr>"
                s += "<tr style='font-weight:bold;'><td width='200px'>" & GetMessage(268) & "</td><td width='150px' style='text-align:right;'>" & GetMessage(246) & "</td><td width='150px' style='text-align:right;'>" & GetMessage(247) & "</td></tr>"
                s += "<tr><td colspan='3' style='border-bottom:thin solid silver;'></td></tr>"
                s += "<tr><td>" & emp.Organization.Parent.AccountPayable & "</td>"
                s += "<td style='text-align:right;'></td>"
                s += "<td  width='150px' style='text-align:right;'>AccountPayableAmount</td></tr>"

                a = oc.GetGLAccountTotals(rpt.ID)

                If Not IsNothing(a) Then
                    For i = 0 To a.GetUpperBound(1)
                        s += "<tr><td>" & a(0, i) & "&nbsp;</td>"
                        s += "<td  width='150px' style='text-align:right;'>"
                        s += FormatNumber(a(1, i) - a(2, i) - a(3, i) + a(4, i), 2)
                        s += "</td></tr>"

                        AmtTotal = AmtTotal + CDec(a(1, i) - a(2, i) - a(3, i) + a(4, i))
                        ITC = ITC + a(2, i)
                        ITR = ITR + a(3, i)
                    Next

                    RITCTotalBC = oc.GetRITCTotals(rpt.ID, 10)
                    RITCTotalOnt = oc.GetRITCTotals(rpt.ID, 2)
                    RITCTotalPEI = oc.GetRITCTotals(rpt.ID, 4)
                End If

                SummaryFooter()

                p = Nothing
            End If
        Next

        emp = Nothing
        p = Nothing

    End Sub

    ''' <summary>
    ''' Totals by category
    ''' </summary>
    ''' <remarks></remarks>
    Private Sub SummaryByCategory()
        Dim oc As New OrgCat()

        RITCTotalBC = 0 : RITCTotalOnt = 0 : RITCTotalPEI = 0 : AmtTotal = 0 : ITC = 0 : ITR = 0

        If Request.QueryString("rpt") = "" Then
            GetStartEndDates()
            org.GetReports(dStartDate, dEndDate)

            If Not IsNothing(org.Reports) Then
                s = ReportHeader(GetMessage(345), "615px", "50%")
                s = Replace(s, "numberofitemstitle", GetMessage(242))
                s = Replace(s, "numberofitems", org.Reports.Count)

                a = oc.GetCategoryTotals(orgID, dStartDate, dEndDate)

                s += "<table width='615px' border='0'  style='font-size:smaller;border-collapse:collapse;'>"
                s += "<tr><td colspan='2' style='border-bottom:thin solid silver;'></td></tr>"
                s += "<tr><td width='200px' style='font-weight:bold;'>" & GetMessage(60) & "</td><td width='150px' style='font-weight:bold;text-align:right;'>" & GetMessage(246) & "</td></tr>"
                s += "<tr><td colspan='2' style='border-top:thin solid silver;'></td></tr>"
                's += "<tr style='border-bottom:thin solid silver;'><td>" & GetMessage(236) & "</td>"
                's += "<td style='text-align:right;'></td>"
                's += "<td width='150px'  style='text-align:right;'>AccountPayableAmount</td></tr>"

                For i = 0 To a.GetUpperBound(1)
                    s += "<tr style='border-bottom:thin solid silver; background-color:" & IIf(i Mod 2 = 0, "white", "white") & ";'><td>"
                    s += If(Session("emp").defaultlanguage = "English", a(0, i), a(5, i))
                    s += "</td>"

                    s += "<td width='150px'  style='text-align:right;'>"
                    s += FormatNumber(CDec(a(1, i)) - CDec(a(2, i)) - CDec(a(3, i)) + CDec(a(4, i)), 2)
                    s += "</td></tr>"

                    AmtTotal += CDec(CDec(a(1, i)) - CDec(a(2, i)) - CDec(a(3, i)) + CDec(a(4, i)))
                    'ITC += CDec(a(2, i))
                    'ITR += CDec(a(3, i))
                Next
            End If
        Else

            rpt = New Report(CInt(Request.QueryString("rpt")))
            Dim emp As New Employee(rpt.EmpID)
            Dim p As Period

            p = New Period(orgID, rpt.FinalizedDate.Month)

            s = "<table width='615px'  style='font-size:smaller;'>"
            s += "<tr><td style=' font-weight:bold;'>" & emp.Organization.Name & IIf(emp.Organization.Code <> "", " (" & emp.Organization.Code & ")", "") & "</td></tr>"
            s += "<tr><td style=' font-weight:bold;'>" & GetMessage(241) & " - " & rpt.Name & "</td></tr>"
            s += "<tr><td style=' font-weight:bold;'>" & emp.LastName & ", " & emp.FirstName & IIf(emp.EmpNum <> "", " - " & emp.EmpNum, "") & IIf(emp.DivCode <> "", GetCustomTag("D") & " " & emp.DivCode, "") & ")</td></tr>"
            s += "<tr><td style=' font-weight:bold;'>" & GetMessage(125) & ": " & Format(Now, "MMMM dd, yyyy") & "</td></tr>"
            s += "<tr><td style=' font-weight:bold;'><table cellpadding=0 cellspacing=0 width='100%'><tr style='font-weight:bold;'><td width='50%'>" & GetMessage(78) & ": " & Format(rpt.FinalizedDate, "MMMM dd, yyyy") & "</td><td align='right'>" & GetMessage(237) & ": " & rpt.FinalizedDate.Year + p.SubtractYear & "" & GetMessage(244) & ": " & p.PeriodNum & "</td></tr></table></td></tr>"
            s += "</table>"

            s += "<table border=0 width='615px'  style='font-size:smaller;border-collapse:collapse;'>"
            s += "<tr><td colspan='3' style='border-bottom:thin solid silver;'></td></tr>"
            s += "<tr><td width='200px' style='font-weight:bold;'>" & GetMessage(268) & "</td><td width='150px' style='font-weight:bold;text-align:right;'>" & GetMessage(246) & "</td><td width='150px' style='font-weight:bold;text-align:right;'>" & GetMessage(247) & "</td></tr>"
            s += "<tr><td colspan='3' style='border-top:thin solid silver;'></td></tr>"
            's += "<tr style='border-bottom:thin solid silver;'><td>" & emp.Organization.Parent.AccountPayable & "</td>"
            s += "<td style='text-align:right;'></td>"

            a = oc.GetCategoryTotals(rpt.ID)

            s += "<br><br>"
            s += "<table width='615px'>"
            s += "<tr><td colspan='3' style='border-bottom:thin solid silver;'></td></tr>"
            s += "<tr><td width='200px' style='font-weight:bold;'>" & GetMessage(60) & "</td><td width='150px' style='font-weight:bold;text-align:right;'>" & GetMessage(246) & "</td><td width='150px' style='font-weight:bold;text-align:right;'>" & GetMessage(247) & "</td></tr>"
            s += "<tr><td colspan='3' style='border-top:thin solid silver;'></td></tr>"
            s += "<tr><td>" & GetMessage(236) & "</td>"
            s += "<td style='text-align:right;'></td>"

            For i = 0 To a.GetUpperBound(1)
                s += "<tr><td>"
                s += IIf(Session("emp").defaultlanguage = "English", a(0, i), a(5, i))
                s += "</td>"

                s += "<td width='150px'  style='text-align:right;'>"
                s += FormatNumber(a(1, i) - a(2, i) - a(3, i) + a(4, i), 2)
                s += "</td></tr>"

                AmtTotal += CDec(CDec(a(1, i)) - CDec(a(2, i)) - CDec(a(3, i)) + CDec(a(4, i)))
                'ITC += CDec(a(2, i))
                'ITR += CDec(a(3, i))
            Next

        End If
        s += "<tr style='border-bottom:solid thin red;font-weight:bold;'><td>Total</td><td align='right'>" & FormatNumber(AmtTotal, 2) & "</td></tr>"
        s += "</table>"

        'If AmtTotal > 0 Then
        '    RITCTotalBC = oc.GetRITCTotals(orgID, 10, dStartDate, dEndDate)
        '    RITCTotalOnt = oc.GetRITCTotals(orgID, 2, dStartDate, dEndDate)
        '    RITCTotalPEI = oc.GetRITCTotals(orgID, 4, dStartDate, dEndDate)

        '    SummaryByCategoryFooter(i)
        'End If

        org = Nothing
    End Sub


    ''' <summary>
    ''' Footer for the summary by category report. contains the ITC, ITR, RITC information
    ''' </summary>
    ''' <param name="i"></param>
    ''' <remarks></remarks>
    Private Sub SummaryByCategoryFooter(i As Integer)

        If ITC > 0 Then
            s += "<tr style='border-bottom:thin solid silver; background-color:" & IIf(i Mod 2 = 0, "white", "white") & ";'><td>"
            s += GetMessage(118) & "</td><td width='150px' style=' text-align:right;'>"
            s += FormatNumber(ITC, 2)
            s += "</td><td></td></tr>"
            i += 1
        End If

        If ITR > 0 Then
            s += "<tr style='border-bottom:thin solid silver; background-color:" & IIf(i Mod 2 = 0, "white", "white") & ";'><td>"
            s += GetMessage(119) & "</td><td width='150px'  style=' text-align:right;'>"
            s += FormatNumber(ITR, 2)
            s += "</td><td></td></tr>"
            i += 1
        End If

        If RITCTotalOnt > 0 Then
            s += "<tr style='border-bottom:thin solid silver; background-color:" & IIf(i Mod 2 = 0, "white", "white") & ";'><td>"
            s += GetMessage(250) & "</td><td></td><td width='150px'  style=' text-align:right;'>"
            s += FormatNumber(RITCTotalOnt, 2)
            s += "</td></tr>"
            i += 1
        End If

        If RITCTotalBC > 0 Then
            s += "<tr style='border-bottom:thin solid silver; background-color:" & IIf(i Mod 2 = 0, "white", "white") & ";'><td>"
            s += GetMessage(249) & "</td><td></td><td width='150px'  style=' text-align:right;'>"
            s += FormatNumber(RITCTotalBC, 2)
            s += "</td></tr>"
            i += 1
        End If

        If RITCTotalPEI > 0 Then
            s += "<tr style='border-bottom:thin solid silver; background-color:" & IIf(i Mod 2 = 0, "white", "white") & ";'><td>"
            s += GetMessage(248) & "</td><td></td><td width='150px'  style=' text-align:right;'>"
            s += FormatNumber(RITCTotalPEI, 2)
            s += "</td></tr>"
            i += 1
        End If

        s += "<tr><td colspan='3'></td></tr>"
        s += "<tr  style='font-weight:bold;'><td>Total</td><td width='150px'  style='text-align:right; '>" & FormatNumber(AmtTotal + ITC + ITR, 2) & "</td><td width='150px'  align='right'>CreditTotal</td></tr>"
        s += "<tr><td colspan=3 style='border-top:thin solid red;'></td></tr>"
        s += "</table>"

        If AccPayableTotal > 0 Then
            s = Replace(s, "<AccPayable>", "<tr style='border-bottom:thin solid silver;'><td>" & GetMessage(236) & "</td><td style=' text-align:right;'></td><td width='150px'  style=' text-align:right;'>" & FormatNumber(AccPayableTotal + ITC + ITR - RITCTotalBC - RITCTotalOnt - RITCTotalPEI, 2) & "</td></tr>")
        Else
            s = Replace(s, "<AccPayable>", "")
        End If

        s = Replace(s, "AccountPayableAmount", FormatNumber(AmtTotal + ITC + ITR - RITCTotalBC - RITCTotalOnt - RITCTotalPEI, 2))

        s = Replace(s, "CreditTotal", FormatNumber(AmtTotal + ITC + ITR, 2))

        s += "<br><br>"
    End Sub

    ''' <summary>
    ''' Detailed report by gl account for a given date range or period
    ''' </summary>
    ''' <remarks></remarks>
    Private Sub DetailedReport()
        Dim oc As New OrgCat()
        Dim p As Period
        Dim finalizedBy As Employee
        Dim sAccSegment As String = ""
        Dim sOtherAccPayable As String = "", sAccPayable As String = ""
        Dim acc As Account
        Dim tp As New SortedDictionary(Of String, Double)
        Dim i As Integer

        GetStartEndDates()
        org.GetReports(dStartDate, dEndDate, , "")

        If Not IsNothing(org.Reports) Then
            s = ""
            For Each rpt In org.Reports
                finalizedBy = New Employee(rpt.FinalizedBy)

                AmtTotal = 0 : ITC = 0 : ITR = 0 : RITCTotalBC = 0 : RITCTotalOnt = 0 : RITCTotalPEI = 0 : creditTotal = 0
                tp.Clear()
                sOtherAccPayable = ""
                sAccPayable = ""

                p = New Period(orgID, rpt.FinalizedDate.Month)

                If CInt(Request.QueryString("emp")) = 0 Or CInt(Request.QueryString("emp")) = rpt.Emp.ID Then
                    s += "<table width='615px'  style='font-size:smaller;'>"
                    s += "<tr><td width='60%' style=' font-weight:bold;'>" & rpt.Emp.Organization.Name & IIf(rpt.Emp.Organization.Code <> "", " (" & rpt.Emp.Organization.Code & ")", "") & "</td><td width='150px' align='center' style='font-weight:bold; '></td></tr>"
                    s += "<tr style='font-weight:bold;'><td>" & GetMessage(217) & " - " & rpt.Name & "</td><td align='right' style='color:#cd1e1e;'>Rpt " & rpt.ReportNumberFormatted & "</td></tr>"
                    s += "<tr style='font-weight:bold;'><td>" & rpt.Emp.LastName & ", " & rpt.Emp.FirstName & IIf(rpt.Emp.EmpNum <> "", " - " & rpt.Emp.EmpNum, "") & IIf(rpt.Emp.DivCode <> "", " " & GetCustomTag("D") & " " & rpt.Emp.DivCode, "") & "</td>"
                    s += "<td align='right'>" & GetMessage(237) & ": " & rpt.FinalizedDate.Year + p.SubtractYear & "</td></tr>"
                    s += "<tr style='font-weight:bold;'><td>" & GetMessage(78) & " " & GetMessage(255) & " " & Format(rpt.FinalizedDate, "dd/MM/yyyy") & " " & GetMessage(254) & " " & finalizedBy.FirstName & " " & finalizedBy.LastName & "</td>"
                    s += "<td  align='right'>" & GetMessage(244) & ": " & p.PeriodNum & "</td></tr>"
                    s += "<tr style='font-weight:bold;'><td>" & GetMessage(125) & ": " & Format(Now, "dd/MM/yyyy") & "</td>"
                    s += "<td align='right'>" & GetMessage(243) & ": " & dStartDate & " - " & dEndDate & "</td></tr>"
                    s += "<tr><td colspan='7'></td></tr>"
                    s += "</table>"

                    s += "<table border=0  width='615px' style='font-size:smaller;border-collapse:collapse;'>"
                    s += "<tr style='border-bottom:thin solid silver;border-top:thin solid silver;'><td colspan='2' style='font-weight:bold;'>" & GetMessage(245) & "</td><td></td><td></td><td style='font-weight:bold;'>" & GetMessage(268) & "</td><td width='100px' style=' font-weight:bold;text-align:right;'>" & sDebit & "</td><td width='100px' align='right' style=' font-weight:bold;text-align:right;'>" & sCredit & "</td></tr>"
                    s += "<accPayable>"
                    s += "<otherAccPayables>"

                    If Not IsNothing(rpt.Expenses) Then
                        For Each exp In rpt.Expenses
                            s += "<tr style='border-bottom:thin solid silver;'>"
                            ' If org.Parent.AccSegment.IndexOf("D") = 0 Then s += "<td width='5%'>" & rpt.Emp.DivCode & "</td>"
                            If org.Parent.AccSegment.IndexOf("A") = 0 Then s += "<td width='5%' >" & exp.OrgCategory.GLAccount & "</td>"

                            If org.Parent.AccSegment.IndexOf("D") = 1 Then s += "<td width='5%'>" & rpt.Emp.DivCode & "</td>"
                            If org.Parent.AccSegment.IndexOf("A") = 1 Then s += "<td width='5%'>" & exp.OrgCategory.GLAccount & "</td>"
                            If org.Parent.AccSegment.IndexOf("P") = 1 Then s += "<td width='5%'>" & exp.Project & "</td>"
                            If org.Parent.AccSegment.IndexOf("C") = 1 Then s += "<td width='5%'>" & exp.CostCenter & "</td>"

                            If org.Parent.AccSegment.IndexOf("P") = 2 Then s += "<td><td " & IIf(Right(org.Parent.AccSegment, 1) <> "P", "width='5%'", "") & ">" & exp.Project & "</td>"
                            If org.Parent.AccSegment.IndexOf("C") = 2 Then s += "<td " & IIf(Right(org.Parent.AccSegment, 1) <> "C", "width='5%'", "") & ">" & exp.CostCenter & "</td>"

                            If org.Parent.AccSegment.IndexOf("P") = 3 Then s += "<td width='5%'>" & exp.Project & "</td>"
                            If org.Parent.AccSegment.IndexOf("C") = 3 Then s += "<td><td width='5%'>" & exp.CostCenter & "</td>"
                            If org.Parent.AccSegment.IndexOf("NNN") > 0 Then s += "<td></td><td></td><td></td><td></td>"
                            If org.Parent.AccSegment.IndexOf("NN") > 0 Then s += "<td width='5%'></td>"
                            If org.Parent.AccSegment.IndexOf("N") > 0 Then s += "<td></td>"

                            If Not exp.Reimburse Then
                                If Not tp.ContainsKey(exp.TPNum) Then
                                    tp.Add(exp.TPNum, exp.AmountCDN)
                                Else
                                    tp(exp.TPNum) += exp.AmountCDN
                                End If
                            Else
                                creditTotal += exp.AmountCDN
                            End If

                            acc = New Account(exp.OrgCategory.GLAccount, org.ID)
                            s += "<td style='text-align:left;'>" & acc.Name & "</td>"
                            s += "<td style=' text-align:right;'>"
                            s += FormatNumber(exp.AmountCDN - exp.ITC - exp.ITR + exp.RITC, 2)
                            s += "</td><td></td></tr>"

                            AmtTotal += exp.AmountCDN - exp.ITC - exp.ITR + exp.RITC
                            ITC += exp.ITC
                            ITR += exp.ITR
                            acc = Nothing
                        Next

                        For i = 0 To tp.Count - 1
                            acc = New Account(org.ID, tp.ElementAt(i).Key)
                            sOtherAccPayable += "<tr  style='border-bottom:thin solid silver;'>" & IIf(org.Parent.AccSegment.IndexOf("A") = 0, "<td>" & acc.Number & "</td><td></td>", "<td>&nbsp;</td><td>" & acc.Number & "</td>")
                            sOtherAccPayable += "<td></td>"
                            sOtherAccPayable += "<td></td>"
                            sOtherAccPayable += "<td style='text-align:left;'>" & GetMessage(236) & " " & acc.Name & "</td>"
                            sOtherAccPayable += "<td style='text-align:right;'></td>"
                            sOtherAccPayable += "<td style=' text-align:right;'>" & FormatNumber(tp.ElementAt(i).Value, 2) & "</td></tr>"
                            acc = Nothing
                        Next

                        If creditTotal > 0 Then
                            acc = New Account(org.Parent.AccountPayable, org.ID)
                            sAccPayable += "<tr  style='border-bottom:thin solid silver;'>" & IIf(org.Parent.AccSegment.IndexOf("A") = 0, "<td>" & org.Parent.AccountPayable & "</td><td>&nbsp;</td>", "</td><td>" & org.Parent.AccountPayable & "</td>")
                            sAccPayable += "<td></td>"
                            sAccPayable += "<td></td>"
                            sAccPayable += "<td><td style='text-align:left;'>" & acc.Name & "</td>"
                            sAccPayable += "<td style='text-align:right;'></td>"
                            sAccPayable += "<td style=' text-align:right;'>" & FormatNumber(creditTotal, 2) & "</td></tr>"
                            acc = Nothing
                        End If

                        s = Replace(s, "<accPayable>", sAccPayable)
                        s = Replace(s, "<otherAccPayables>", sOtherAccPayable)

                        If AmtTotal > 0 Then
                            RITCTotalBC = oc.GetRITCTotals(rpt.ID, 10)
                            RITCTotalOnt = oc.GetRITCTotals(rpt.ID, 2)
                            RITCTotalPEI = oc.GetRITCTotals(rpt.ID, 4)

                            If ITC > 0 Then
                                acc = New Account(org.Parent.ITCAccount, org.ID)
                                s += "<tr style='border-bottom:thin solid silver;'>" & IIf(org.Parent.AccSegment.IndexOf("A") = 0, "<td>" & org.Parent.ITCAccount & "</td><td></td>", "<td>" & org.Parent.ITCAccount & "</td>") & "<td></td><td><td></td><td style='text-align:left;'>" & acc.Name & "</td><td style='text-align:right;'>"
                                s += FormatNumber(ITC, 2)
                                s += "</td><td></td></tr></td></tr>"
                                acc = Nothing
                            End If

                            If ITR > 0 Then
                                acc = New Account(org.Parent.ITRAccount, org.ID)
                                s += "<tr style='border-bottom:thin solid silver;'>" & IIf(org.Parent.AccSegment.IndexOf("A") = 0, "<td>" & org.Parent.ITRAccount & "</td><td></td>", "<td>" & org.Parent.ITRAccount & "</td>") & "<td></td><td></td><td></td><td style='text-align:left;'>" & acc.Name & "</td><td style='text-align:right;'>"
                                s += FormatNumber(ITR, 2)
                                s += "</td><td></td></tr>"
                                acc = Nothing
                            End If

                            If RITCTotalOnt > 0 Then
                                acc = New Account(org.Parent.ritcONAccount, org.ID)
                                s += "<tr style='border-bottom:thin solid silver;'>" & IIf(org.Parent.AccSegment.IndexOf("A") = 0, "<td>" & org.Parent.ritcONAccount & "</td><td></td>", "<td>" & org.Parent.ritcONAccount & "</td>") & "<td></td><td></td><td></td><td style='text-align:left;'>" & acc.Name & "</td><td></td><td style='text-align:right;'>"
                                s += FormatNumber(RITCTotalOnt, 2)
                                s += "</td></tr>"
                                acc = Nothing
                            End If

                            If RITCTotalBC > 0 Then
                                acc = New Account(org.Parent.ritcBCAccount, org.ID)
                                s += "<tr style='border-bottom:thin solid silver;'>" & IIf(org.Parent.AccSegment.IndexOf("A") = 0, "<td>" & org.Parent.ritcONAccount & "</td><td></td>", "<td></td><td>" & org.Parent.ritcBCAccount & "</td>") & "<td></td><td></td><td style='text-align:left;'>" & acc.Name & "</td><td></td><td  style='text-align:right;'>"
                                s += FormatNumber(RITCTotalBC, 2)
                                s += "</td></tr>"
                                acc = Nothing
                            End If

                            If RITCTotalPEI > 0 Then
                                acc = New Account(org.Parent.ritcPEIAccount, org.ID)
                                s += "<tr style='border-bottom:thin solid silver;'>" & IIf(org.Parent.AccSegment.IndexOf("A") = 0, "<td>" & org.Parent.ritcONAccount & "</td><td></td>", "<td></td><td>" & org.Parent.ritcPEIAccount & "</td>") & "<td></td><td></td><td style='text-align:left;'>" & acc.Name & "</td><td></td><td style='text-align:right;'>"
                                s += FormatNumber(RITCTotalPEI, 2)
                                s += "</td></tr>"
                                acc = Nothing
                            End If

                            s += "<tr style='font-weight:bold;border-top:thin solid silver;border-bottom:thin solid #cd1e1e;'><td>Total</td><td></td><td></td><td></td><td></td><td style='text-align:right;'>" & FormatNumber(AmtTotal + ITC + ITR, 2) & "</td><td align='right'>CreditTotal</td></tr>"
                            s += "</table>"

                            s = Replace(s, "AccountPayableAmount", FormatNumber(AmtTotal + ITC + ITR - RITCTotalBC - RITCTotalOnt - RITCTotalPEI, 2))
                            s = Replace(s, "CreditTotal", FormatNumber(AmtTotal + ITC + ITR, 2))

                            s += "<br><br>"
                        End If

                    End If

                    p = Nothing
                    finalizedBy = Nothing
                End If
                'emp = Nothing
            Next
        End If

        org = Nothing
        rpt = Nothing
        oc = Nothing
    End Sub


    ''' <summary>
    ''' Detailed report for a specific report
    ''' </summary>
    ''' <param name="rptID"></param>
    ''' <remarks></remarks>
    Private Sub DetailedReport(rptID As Integer)
        Dim oc As New OrgCat()
        Dim p As Period
        Dim finalizedBy As Employee
        Dim sAccSegment As String = ""
        Dim sOtherAccPayable As String = "", sAccPayable As String = ""

        rpt = New Report(rptID)

        s = ""
        finalizedBy = New Employee(rpt.FinalizedBy)

        AmtTotal = 0 : ITC = 0 : ITR = 0 : RITCTotalBC = 0 : RITCTotalOnt = 0 : RITCTotalPEI = 0 : creditTotal = 0
        sOtherAccPayable = ""
        sAccPayable = ""

        p = New Period(rpt.Emp.Organization.ID, rpt.FinalizedDate.Month)
        GetStartEndDates(p, Year(rpt.FinalizedDate))

        s += "<table width='615px'  style='font-size:smaller;'>"
        s += "<tr><td width='60%' style=' font-weight:bold;'>" & rpt.Emp.Organization.Name & IIf(rpt.Emp.Organization.Code <> "", " (" & rpt.Emp.Organization.Code & ")", "") & "</td><td width='150px' align='center' style='font-weight:bold; '></td></tr>"
        s += "<tr style='font-weight:bold;'><td>Detailed Posting - " & rpt.Name & "</td><td align='right' style='color:#cd1e1e;'>Rpt " & rpt.ReportNumberFormatted & "</td></tr>"
        s += "<tr style='font-weight:bold;'><td>" & rpt.Emp.LastName & ", " & rpt.Emp.FirstName & IIf(rpt.Emp.EmpNum <> "", " - " & rpt.Emp.EmpNum, "") & IIf(rpt.Emp.DivCode <> "", " " & GetCustomTag("D") & " " & rpt.Emp.DivCode, "") & "</td>"
        s += "<td align='right'>" & GetMessage(237) & ": " & rpt.FinalizedDate.Year + p.SubtractYear & "</td></tr>"
        s += "<tr style='font-weight:bold;'><td>" & GetMessage(78) & " " & GetMessage(255) & " " & Format(rpt.FinalizedDate, "dd/MM/yyyy") & " " & GetMessage(254) & " " & finalizedBy.FirstName & " " & finalizedBy.LastName & "</td>"
        s += "<td  align='right'>" & GetMessage(244) & ": " & p.PeriodNum & "</td></tr>"
        s += "<tr style='font-weight:bold;'><td>" & GetMessage(125) & ": " & Format(Now, "dd/MM/yyyy") & "</td>"
        s += "<td align='right'>" & GetMessage(243) & ": " & dStartDate & " - " & dEndDate & "</td></tr>"
        s += "<tr><td colspan='15'></td></tr>"
        s += "</table>"

        s += "<table border=0  width='615px' style='font-size:smaller;border-collapse:collapse;'>"
        s += "<tr style='border-bottom:thin solid silver;border-top:thin solid silver;'><td colspan='2' style='font-weight:bold;'>" & GetMessage(268) & "</td><td></td><td></td><td></td><td width='150px' style=' font-weight:bold;text-align:right;'>" & sDebit & "</td><td width='150px' align='right' style=' font-weight:bold;text-align:right;'>" & sCredit & "</td></tr>"
        s += "<accPayable>"
        s += "<otherAccPayables>"

        If Not IsNothing(rpt.Expenses) Then
            For Each Me.exp In rpt.Expenses
                s += "<tr>"
                If rpt.Emp.Organization.Parent.AccSegment.IndexOf("D") = 0 Then s += "<td width='5%'>" & rpt.Emp.DivCode & "</td>"
                If rpt.Emp.Organization.Parent.AccSegment.IndexOf("A") = 0 Then s += "<td width='5%'>" & exp.OrgCategory.GLAccount & "</td>"

                If rpt.Emp.Organization.Parent.AccSegment.IndexOf("D") = 1 Then s += "<td width='5%'>" & rpt.Emp.DivCode & "</td>"
                If rpt.Emp.Organization.Parent.AccSegment.IndexOf("A") = 1 Then s += "<td width='5%'>" & exp.OrgCategory.GLAccount & "</td>"
                If rpt.Emp.Organization.Parent.AccSegment.IndexOf("P") = 1 Then s += "<td width='5%'>" & exp.Project & "</td>"
                If rpt.Emp.Organization.Parent.AccSegment.IndexOf("C") = 1 Then s += "<td width='5%'>" & exp.CostCenter & "</td>"

                If rpt.Emp.Organization.Parent.AccSegment.IndexOf("P") = 2 Then s += "<td " & IIf(Right(rpt.Emp.Organization.Parent.AccSegment, 1) <> "P", "width='5%'", "") & ">" & exp.Project & "</td>"
                If rpt.Emp.Organization.Parent.AccSegment.IndexOf("C") = 2 Then s += "<td " & IIf(Right(rpt.Emp.Organization.Parent.AccSegment, 1) <> "C", "width='5%'", "") & ">" & exp.CostCenter & "</td>"

                If rpt.Emp.Organization.Parent.AccSegment.IndexOf("P") = 3 Then s += "<td width='5%'>" & exp.Project & "</td>"
                If rpt.Emp.Organization.Parent.AccSegment.IndexOf("C") = 3 Then s += "<td width='5%'>" & exp.CostCenter & "</td>"
                If rpt.Emp.Organization.Parent.AccSegment.IndexOf("NNN") > 0 Then s += "<td></td>"
                If rpt.Emp.Organization.Parent.AccSegment.IndexOf("NN") > 0 Then s += "<td width='5%'></td>"
                If rpt.Emp.Organization.Parent.AccSegment.IndexOf("N") > 0 Then s += "<td></td>"

                If Not exp.Reimburse Then
                    sOtherAccPayable += "<tr>" & IIf(rpt.Emp.Organization.Parent.AccSegment.IndexOf("A") = 0, "<td>" & rpt.Emp.Organization.Parent.AccountPayable & "</td><td></td>", "<td>&nbsp;</td><td>" & rpt.Emp.Organization.Parent.AccountPayable & "</td>")
                    sOtherAccPayable += "<td></td>"
                    sOtherAccPayable += "<td></td>"
                    sOtherAccPayable += "<td style='text-align:right;'>" & exp.TPNum & "</td>"
                    sOtherAccPayable += "<td style='text-align:right;'></td>"
                    sOtherAccPayable += "<td width='150px' style=' text-align:right;'>" & FormatNumber(exp.AmountCDN, 2) & "</td></tr>"
                Else
                    creditTotal += exp.AmountCDN
                End If

                s += "<td style='text-align:right;'>" & rpt.Emp.EmpNum & "</td>"
                s += "<td width='150px' style=' text-align:right;'>"
                s += FormatNumber(exp.AmountCDN - exp.ITC - exp.ITR + exp.RITC, 2)
                s += "</td></tr>"

                AmtTotal += exp.AmountCDN - exp.ITC - exp.ITR + exp.RITC
                ITC += exp.ITC
                ITR += exp.ITR
            Next

            If creditTotal > 0 Then
                sAccPayable += "<tr>" & IIf(rpt.Emp.Organization.Parent.AccSegment.IndexOf("A") = 0, "<td>" & rpt.Emp.Organization.Parent.AccountPayable & "</td><td>&nbsp;</td>", "<td>&nbsp;</td><td>" & rpt.Emp.Organization.Parent.AccountPayable & "</td>")
                sAccPayable += "<td></td>"
                sAccPayable += "<td></td>"
                sAccPayable += "<td style='text-align:right;'>" & rpt.Emp.EmpNum & "</td>"
                sAccPayable += "<td style='text-align:right;'></td>"
                sAccPayable += "<td width='150px' style=' text-align:right;'>" & FormatNumber(creditTotal, 2) & "</td></tr>"
            End If

            s = Replace(s, "<accPayable>", sAccPayable)
            s = Replace(s, "<otherAccPayables>", sOtherAccPayable)

            If AmtTotal > 0 Then
                RITCTotalBC = oc.GetRITCTotals(rpt.ID, 10)
                RITCTotalOnt = oc.GetRITCTotals(rpt.ID, 2)
                RITCTotalPEI = oc.GetRITCTotals(rpt.ID, 4)

                If ITC > 0 Then
                    s += "<tr>" & IIf(rpt.Emp.Organization.Parent.AccSegment.IndexOf("A") = 0, "<td>" & rpt.Emp.Organization.Parent.ITCAccount & "</td><td></td>", "<td></td><td>" & rpt.Emp.Organization.Parent.ITCAccount & "</td>") & "<td></td><td></td><td style='text-align:right;'>" & rpt.Emp.EmpNum & "</td><td width='150px' style='text-align:right;'>"
                    s += FormatNumber(ITC, 2)
                    s += "</td></tr>"
                End If

                If ITR > 0 Then
                    s += "<tr>" & IIf(rpt.Emp.Organization.Parent.AccSegment.IndexOf("A") = 0, "<td>" & rpt.Emp.Organization.Parent.ITRAccount & "</td><td></td>", "<td></td><td>" & rpt.Emp.Organization.Parent.ITRAccount & "</td>") & "<td></td><td></td><td style='text-align:right;'>" & rpt.Emp.EmpNum & "</td><td width='150px' style='text-align:right;'>"
                    s += FormatNumber(ITR, 2)
                    s += "</td></tr>"
                End If

                If RITCTotalOnt > 0 Then
                    s += "<tr>" & IIf(rpt.Emp.Organization.Parent.AccSegment.IndexOf("A") = 0, "<td>" & rpt.Emp.Organization.Parent.ritcONAccount & "</td><td></td>", "<td></td><td>" & rpt.Emp.Organization.Parent.ritcONAccount & "</td>") & "<td></td><td></td><td style='text-align:right;'>" & rpt.Emp.EmpNum & "</td><td></td><td width='150px'  style='text-align:right;'>"
                    s += FormatNumber(RITCTotalOnt, 2)
                    s += "</td></tr>"
                End If

                If RITCTotalBC > 0 Then
                    s += "<tr>" & IIf(rpt.Emp.Organization.Parent.AccSegment.IndexOf("A") = 0, "<td>" & rpt.Emp.Organization.Parent.ritcONAccount & "</td><td></td>", "<td></td><td>" & rpt.Emp.Organization.Parent.ritcBCAccount & "</td>") & "<td></td><td></td><td style='text-align:right;'>" & rpt.Emp.EmpNum & "</td><td></td><td width='150px'  style='text-align:right;'>"
                    s += FormatNumber(RITCTotalBC, 2)
                    s += "</td></tr>"
                End If

                If RITCTotalPEI > 0 Then
                    s += "<tr>" & IIf(rpt.Emp.Organization.Parent.AccSegment.IndexOf("A") = 0, "<td>" & rpt.Emp.Organization.Parent.ritcONAccount & "</td><td></td>", "<td></td><td>" & rpt.Emp.Organization.Parent.ritcPEIAccount & "</td>") & "<td></td><td></td><td style='text-align:right;'>" & rpt.Emp.EmpNum & "</td><td></td><td width='150px'  style='text-align:right;'>"
                    s += FormatNumber(RITCTotalPEI, 2)
                    s += "</td></tr>"
                End If

                s += "<tr style='font-weight:bold;border-top:thin solid silver;border-bottom:thin solid #cd1e1e;'><td>Total</td><td></td><td></td><td></td><td></td><td width='150px' style='text-align:right;'>" & FormatNumber(AmtTotal + ITC + ITR, 2) & "</td><td width='150px' align='right'>CreditTotal</td></tr>"
                s += "</table>"

                s = Replace(s, "AccountPayableAmount", FormatNumber(AmtTotal + ITC + ITR - RITCTotalBC - RITCTotalOnt - RITCTotalPEI, 2))
                s = Replace(s, "CreditTotal", FormatNumber(AmtTotal + ITC + ITR, 2))

                s += "<br><br>"
            End If

        End If

        p = Nothing
        finalizedBy = Nothing

        org = Nothing
        rpt = Nothing
        oc = Nothing
    End Sub


    Private Sub DetailedByCategory()
        Dim oc As New OrgCat
        Dim p As Period
        Dim finalizedBy As Employee
        Dim tp As New SortedDictionary(Of String, Double)
        Dim acc As Account
        Dim i As Integer
        Dim sOtherAccPayables As String = ""

        GetStartEndDates()
        org.GetReports(dStartDate, dEndDate, , "REPORT_NUM")

        If Not IsNothing(org.Reports) Then
            s = ""

            For Each rpt In org.Reports

                AmtTotal = 0 : ITC = 0 : ITR = 0 : RITCTotalBC = 0 : RITCTotalOnt = 0 : RITCTotalPEI = 0 : AccPayableTotal = 0
                tp.Clear()
                sOtherAccPayables = ""
                finalizedBy = New Employee(rpt.FinalizedBy)
                p = New Period(orgID, rpt.FinalizedDate.Month)

                s += "<table border=0 width='615px'  style='font-size:smaller;' >"
                s += "<tr><td width='60%' style=' font-weight:bold;'>" & rpt.Emp.Organization.Name & IIf(rpt.Emp.Organization.Code <> "", " (" & rpt.Emp.Organization.Code & ")", "") & "</td><td width='150px' align='center' style='font-weight:bold; '></td></tr>"
                s += "<tr style='font-weight:bold;'><td>" & GetMessage(270) & " - " & rpt.Name & "</td><td align='right' style='color:red;'>" & GetMessage(227) & " R" & rpt.ReportNumberFormatted & "</td></tr>"
                s += "<tr style='font-weight:bold;'><td>" & rpt.Emp.LastName & ", " & rpt.Emp.FirstName & IIf(rpt.Emp.EmpNum <> "", " - " & rpt.Emp.EmpNum, "") & IIf(rpt.Emp.DivCode <> "", " " & GetCustomTag("D") & " " & rpt.Emp.DivCode, "") & "</td>"
                s += "<td align='right'>" & GetMessage(237) & ": " & rpt.FinalizedDate.Year + p.SubtractYear & "</td></tr>"
                s += "<tr style='font-weight:bold;'><td>" & GetMessage(78) & " " & GetMessage(255) & " " & Format(rpt.FinalizedDate, "dd/MM/yyyy") & " " & GetMessage(254) & " " & finalizedBy.FirstName & " " & finalizedBy.LastName & "</td>"
                s += "<td  align='right'>" & GetMessage(244) & ": " & p.PeriodNum & "</td></tr>"
                s += "<tr style='font-weight:bold;'><td>" & GetMessage(125) & ": " & Format(Now, "dd/MM/yyyy") & "</td>"
                s += "<td  align='right'>" & GetMessage(243) & ": " & dStartDate & " - " & dEndDate & "</td></tr>"
                s += "</table>"

                a = oc.GetCategoryTotals(rpt.ID)

                s += "<table  width='615px'  style='font-size:smaller;border-collapse:collapse;'>"
                s += "<tr style='font-weight:bold;border-top:thin solid silver;border-bottom:thin solid silver;'><td width='60%'>" & GetMessage(60) & "</td><td width='150px' style=' text-align:right;'>" & sDebit & "</td><td width='150px' style=' text-align:right;'>" & sCredit & "</td></tr>"
                s += "<AccPayable>"
                s += "<OtherAccPayables>"

                For i = 0 To a.GetUpperBound(1)
                    s += "<tr style='border-bottom:thin solid silver;'><td width='200px'>"
                    s += IIf(Session("emp").defaultlanguage = "English", a(0, i), a(5, i))
                    s += "</td>"
                    s += "<td width='150px' style=' text-align:right;'>"
                    s += FormatNumber(a(1, i) - a(2, i) - a(3, i) + a(4, i), 2)
                    s += "</td><td></td></tr>"

                    AmtTotal += CDec(a(1, i) - a(2, i) - a(3, i) + a(4, i))
                    AccPayableTotal += CDec(a(1, i) - a(2, i) - a(3, i) + a(4, i))
                    ITC += a(2, i)
                    ITR += a(3, i)
                Next

                For Each exp In rpt.Expenses
                    If Not exp.Reimburse Then
                        If tp.ContainsKey(exp.TPNum) Then
                            tp(exp.TPNum) += exp.AmountCDN
                        Else
                            tp.Add(exp.TPNum, exp.AmountCDN)
                        End If
                    End If
                Next

                For i = 0 To tp.Count - 1
                    acc = New Account(org.ID, tp.ElementAt(i).Key)
                    sOtherAccPayables += "<tr style='border-bottom:thin solid silver;'><td>" & GetMessage(236) & " " & acc.Name & "</td>"
                    sOtherAccPayables += "<td style=' text-align:right;'></td>"
                    sOtherAccPayables += "<td width='150px'  style=' text-align:right;'>" & FormatNumber(tp.ElementAt(i).Value, 2) & "</td></tr>"
                    acc = Nothing
                    AccPayableTotal -= tp.ElementAt(i).Value
                Next

                s = Replace(s, "<OtherAccPayables>", sOtherAccPayables)

                If AmtTotal > 0 Then
                    RITCTotalBC = oc.GetRITCTotals(rpt.ID, 10)
                    RITCTotalOnt = oc.GetRITCTotals(rpt.ID, 2)
                    RITCTotalPEI = oc.GetRITCTotals(rpt.ID, 4)

                    SummaryByCategoryFooter(i)
                End If

                p = Nothing

                finalizedBy = Nothing
                rpt = Nothing
            Next

            tp = Nothing
        End If
    End Sub



    Private Sub APReport()
        'Dim emp As Employee
        Dim p As New Period
        Dim pob As Boolean

        AmtTotal = 0 : Amt = 0 : RITCTotalBC = 0 : RITCTotalOnt = 0 : RITCTotalPEI = 0
        GetStartEndDates()
        org.GetExpenses(dStartDate, dEndDate)

        s = ReportHeader(GetMessage(236) & " - " & org.Parent.AccountPayable, "100%", "65%")

        s += "<table cellpadding='0' cellspacing='0' width='100%' border=0  style='font-size:smaller;border-collapse:collapse;'>"
        s += "<tr style=' height:2px;'><td colspan='9' style='border-bottom:thin solid silver;'></td></tr>"
        s += "<tr style=' font-weight:bold;'><td>Rpt</td><td>" & GetMessage(78) & "</td><td align='center'>" & GetMessage(244) & "</td><td align='center' >" & GetMessage(161) & "</td><td align='left' colspan='2'>" & sPayableTo & "</td><td >" & GetMessage(74) & "</td><td align='right' >" & GetMessage(247) & "</td><td align='right' >" & GetMessage(267) & "</td></tr>"
        s += "<tr style='height:2px;'><td colspan='9' style='border-top:thin solid silver;'></td></tr>"
        s += "<tr style='height:5px;'><td colspan='15'></td></tr>"

        If Not IsNothing(org.Expenses) Then
            For Each Me.exp In org.Expenses
                'If IsNothing(r) Then rpt = New Report(exp.ReportID, False)

                'If rpt.ID <> exp.ReportID Then
                ' rpt = New Report(exp.ReportID, False)

                If (Request.QueryString("proj") = exp.Project Or Request.QueryString("proj") = 0) And (Request.QueryString("cc") = exp.CostCenter Or Request.QueryString("cc") = 0) And (Request.QueryString("div") = exp.Rpt.Emp.DivCode Or Request.QueryString("div") = 0) Then
                    p = New Period(org.ID, Month(exp.Rpt.FinalizedDate))
                    'End If

                    i += 1

                    pob = Not exp.Reimburse
                    AmtTotal += exp.AmountCDN

                    s += "<tr style='border-bottom:thin solid silver; background-color:" & IIf(i Mod 2 = 0, "white", "white") & ";'>"
                    s += "<td width='3%' align='left'>R" & exp.Rpt.ReportNumberFormatted & "</td>"
                    s += "<td width='3%'>" & Format(exp.Rpt.FinalizedDate, "dd/MM/yyyy") & "</td>"
                    s += "<td align='center' width='3%'>" & p.PeriodNum & "</td>"
                    s += "<td align='center' width='6%'>" & Year(exp.Rpt.FinalizedDate) - p.SubtractYear & "</td>"
                    s += "<td align='left' width='5%'>" & IIf(exp.Reimburse, exp.Rpt.Emp.EmpNum, exp.TPNum) & "</td>"
                    s += "<td align='left' width='20%'>" & IIf(exp.Reimburse, exp.Rpt.Emp.LastName & ", " & exp.Rpt.Emp.FirstName, exp.TPName) & "</td>"
                    s += "<td align='left' width='30%'>" & exp.Rpt.Name & "</td>"
                    s += "<td align='right' width='8%'>" & FormatNumber(exp.AmountCDN, 2) & "</td>"
                    s += "<td align='right' width='8%'>" & FormatNumber(AmtTotal, 2) & "</td>"
                    s += "</tr>"

                    pob = False

                End If
            Next
        End If
        s += "<tr><td colspan='9' style='border-top:thin solid silver;'></td></tr>"
        s += "</table>"
        s = Replace(s, "numberofitemstitle", GetMessage(261))
        s = Replace(s, "numberofitems", i)
        If i = 0 Then s = ""

        p = Nothing
        exp = Nothing
        org = Nothing
    End Sub


    Private Sub CategoryReport()
        Dim orgCatID As Integer

        AmtTotal = 0 : Amt = 0 : RITCTotalBC = 0 : RITCTotalOnt = 0 : RITCTotalPEI = 0
        orgCatID = CInt(Request.QueryString("orgCatID"))

        GetStartEndDates()

        Dim oc As New OrgCat(orgCatID)
        org.GetExpenses(dStartDate, dEndDate, , "CAT_NAME")

        s = ReportHeader(GetMessage(263) & " " & IIf(orgCatID = 0, " " & GetMessage(265) & "", "") & IIf(Session("emp").defaultlanguage = "English", oc.Category.Name, oc.Category.NameFR) & IIf(oc.Note <> "", " -- " & oc.Note & " --", ""), "100%", "65%")
        s = Replace(s, "numberofitemstitle", GetMessage(261))

        s += "<table cellpadding='0' cellspacing='0' width='100%' border='0' style='border-collapse: collapse;font-size:smaller;'>"
        's += "<tr style='font-weight:bold;border-bottom:thin solid silver;border-top:thin solid silver;'><td>Rpt</td><td></td><td>" & GetMessage(78) & "</td><td>" & GetMessage(251) & "</td>" & IIf(orgCatID = 0, "<td>" & GetMessage(60) & "</td>", "") & "<td align='left' >" & sName & "</td><td>Jur</td><td align='right' >" & GetMessage(40) & "</td><td align='right' >" & GetMessage(45) & "</td><td align='right' >" & GetMessage(118) & "</td><td align='right' >" & GetMessage(119) & "</td>" & IIf(org.GSTReg And org.OrgSizeGST = 2, "<td align='right' >" & GetMessage(120) & "</td>", "") & "<td align='right' >Net</td><td align='right' >" & GetMessage(48) & "</td></tr>"
        s += "<tr style='font-weight:bold;border-bottom:thin solid silver;border-top:thin solid silver;'><td>Rpt</td><td></td><td>" & GetMessage(78) & "</td><td>" & GetMessage(251) & "</td><td>" & GetMessage(60) & "<td align='left' >" & sName & "</td><td>Jur</td><td align='right' >" & GetMessage(40) & "</td><td align='right' >" & GetMessage(45) & "</td><td align='right' >" & GetMessage(118) & "</td><td align='right' >" & GetMessage(119) & "</td>" & IIf(org.GSTReg And org.OrgSizeGST = 2, "<td align='right' >" & GetMessage(120) & "</td>", "") & "<td align='right' >Net</td><td align='right' >" & GetMessage(48) & "</td></tr>"
        s += "<tr style='height:5px;'><td colspan='13'></td></tr>"

        If Not IsNothing(org.Expenses) Then
            For Each exp In org.Expenses
                'If IsNothing(r) Then rpt = New Report(exp.ReportID, False)
                'If rpt.ID <> exp.ReportID Then rpt = New Report(exp.ReportID, False)

                If exp.OrgCategory.ID = orgCatID Or orgCatID = 0 Then
                    i += 1

                    ITC = exp.ITC
                    ITR = exp.ITR

                    Select Case exp.Jurisdiction.ID
                        Case 2 : RITCTotalOnt += exp.RITC
                        Case 10 : RITCTotalBC += exp.RITC
                        Case 4 : RITCTotalPEI += exp.RITC
                    End Select
                    Diagnostics.Debug.WriteLine(exp.OrgCategory.Category.ID)
                    Amt = exp.AmountCDN
                    If (exp.OrgCategory.Category.ID = 4) Then
                        s += "<tr style='border-bottom:thin solid silver;background-color:" & IIf(i Mod 2 = 0, "white", "white") & ";'>"
                        s += "<td width='3%' align='left'>R" & exp.Rpt.ReportNumberFormatted & "</td>"
                        s += "<td width='1%'>" & IIf(exp.ReceiptName <> "", "<a href='#' id='" & exp.ID & "' class='viewReceipt'><img src='../images/attachment2.png' width='15px' height='15px' border='0' /></a>", "") & "</td>"
                        s += "<td width='8%'>" & exp.Rpt.FinalizedDate & "</td>"
                        s += "<td width='8%' align='left'>" & exp.DateOfExpense & "</td>"
                        ' s += "<td width='15%' " & IIf(orgCatID <> 0, "style='display:none;'", "") & ">" & IIf(Session("emp").defaultlanguage = "English", exp.OrgCategory.Category.Name, exp.OrgCategory.Category.NameFR) & IIf(exp.OrgCategory.Note <> "", " -- " & exp.OrgCategory.Note & " -- ", "") & "</td>"
                        s += "<td width='15%' " & ">" & IIf(Session("emp").defaultlanguage = "English", exp.OrgCategory.Category.Name, exp.OrgCategory.Category.NameFR) & IIf(exp.OrgCategory.Note <> "", " -- " & exp.OrgCategory.Note & " -- ", "") & "</td>"
                        s += "<td align='left' width='15%'>" & exp.Rpt.Emp.LastName & ", " & exp.Rpt.Emp.FirstName & "</td>"
                        s += "<td align='right' width='2%'>" & exp.Jurisdiction.Abbreviation & "</td>"
                        s += "<td align='right' width='2%'>" & FormatNumber(exp.Rate, 2) & "</td>"
                        s += "<td align='right' width='8%'>" & FormatNumber(Amt, 2) & "</td>"
                        s += "<td align='right' width='8%'>" & FormatNumber(ITC, 2) & "</td>"
                        s += "<td align='right' width='8%'>" & FormatNumber(ITR, 2) & "</td>"
                        s += "<td align='right' width='8%' " & IIf(org.OrgSizeGST = 2 And org.GSTReg, "", "style='display:none;'") & ">" & FormatNumber(exp.RITC, 2) & "</td>"
                        s += "<td align='right' width='8%'>" & FormatNumber(Amt - ITC - ITR + exp.RITC, 2) & "</td>"
                        s += "<td align='right' width='10%'>" & exp.Comment & "</td>"
                        s += "</tr>"
                    Else
                        s += "<tr style='border-bottom:thin solid silver;background-color:" & IIf(i Mod 2 = 0, "white", "white") & ";'>"
                        s += "<td width='3%' align='left'>R" & exp.Rpt.ReportNumberFormatted & "</td>"
                        s += "<td width='1%'>" & IIf(exp.ReceiptName <> "", "<a href='#' id='" & exp.ID & "' class='viewReceipt'><img src='../images/attachment2.png' width='15px' height='15px' border='0' /></a>", "") & "</td>"
                        s += "<td width='8%'>" & exp.Rpt.FinalizedDate & "</td>"
                        s += "<td width='8%' align='left'>" & exp.DateOfExpense & "</td>"
                        '   s += "<td width='15%' " & IIf(orgCatID <> 0, "style='display:none;'", "") & ">" & IIf(Session("emp").defaultlanguage = "English", exp.OrgCategory.Category.Name, exp.OrgCategory.Category.NameFR) & IIf(exp.OrgCategory.Note <> "", " -- " & exp.OrgCategory.Note & " -- ", "") & "</td>"
                        s += "<td width='15%' " & ">" & IIf(Session("emp").defaultlanguage = "English", exp.OrgCategory.Category.Name, exp.OrgCategory.Category.NameFR) & IIf(exp.OrgCategory.Note <> "", " -- " & exp.OrgCategory.Note & " -- ", "") & "</td>"
                        s += "<td align='left' width='15%'>" & exp.Rpt.Emp.LastName & ", " & exp.Rpt.Emp.FirstName & "</td>"
                        s += "<td align='right' width='2%'>" & exp.Jurisdiction.Abbreviation & "</td>"
                        s += "<td align='right' width='8%'>" & FormatNumber(Amt, 2) & "</td>"
                        s += "<td align='right' width='8%'>" & FormatNumber(ITC, 2) & "</td>"
                        s += "<td align='right' width='8%'>" & FormatNumber(ITR, 2) & "</td>"
                        s += "<td align='right' width='8%' " & IIf(org.OrgSizeGST = 2 And org.GSTReg, "", "style='display:none;'") & ">" & FormatNumber(exp.RITC, 2) & "</td>"
                        s += "<td align='right' width='8%'>" & FormatNumber(Amt - ITC - ITR + exp.RITC, 2) & "</td>"
                        s += "<td align='right' width='10%'>" & exp.Comment & "</td>"
                        s += "</tr>"
                    End If
                    AmtTotal += Amt
                    ITCTotal += ITC
                    ITRTotal += ITR
                    RITCTotal += exp.RITC
                    NetTotal += Amt - ITC - ITR + exp.RITC

                End If
            Next
        End If

        If (orgCatID = 0) Then
            s += "<tr style='font-weight:bold;border-bottom:thin solid silver;border-top:thin solid silver;'><td colspan='3'>Total</td></td><td></td><td><td></td><td " & IIf(orgCatID <> 0, "style='display:none;'", "") & "></td><td></td><td align='right' >" & FormatNumber(AmtTotal, 2) & "</td><td align='right' >" & FormatNumber(ITCTotal, 2) & "</td><td align='right' >" & FormatNumber(ITRTotal, 2) & "</td><td align='right' " & IIf(org.GSTReg And org.OrgSizeGST = 2, "", "style='display:none;'") & " >" & FormatNumber(RITCTotal, 2) & "</td><td align='right' >" & FormatNumber(NetTotal, 2) & "</td><td></td></tr>"
        Else
            s += "<tr style='font-weight:bold;border-bottom:thin solid silver;border-top:thin solid silver;'><td colspan='3'>Total</td></td><td></td><td><td></td><td " & "></td><td></td><td align='right' >" & FormatNumber(AmtTotal, 2) & "</td><td align='right' >" & FormatNumber(ITCTotal, 2) & "</td><td align='right' >" & FormatNumber(ITRTotal, 2) & "</td><td align='right' " & IIf(org.GSTReg And org.OrgSizeGST = 2, "", "style='display:none;'") & " >" & FormatNumber(RITCTotal, 2) & "</td><td align='right' >" & FormatNumber(NetTotal, 2) & "</td><td></td></tr>"
        End If

        If (orgCatID = 0) Then
            If RITCTotalOnt > 0 Then s += "<tr style='font-weight:bold;'><td colspan='3' >Total " & GetMessage(250) & "</td><td></td><td " & IIf(orgCatID <> 0, "style='display:none;'", "") & "></td><td></td><td></td><td></td><td></td><td></td><td></td><td align='right' >" & FormatNumber(RITCTotalOnt, 2) & "</td><td></td><td></td></tr>"
            If RITCTotalBC > 0 Then s += "<tr style='font-weight:bold;'><td colspan='3'>Total " & GetMessage(249) & "</td><td></td><td " & IIf(orgCatID <> 0, "style='display:none;'", "") & "></td><td></td><td></td><td></td><td></td><td></td><td align='right' >" & FormatNumber(RITCTotalBC, 2) & "</td><td></td><td></td></tr>"
            If RITCTotalPEI > 0 Then s += "<tr style='font-weight:bold;'><td colspan='3'>Total " & GetMessage(248) & "</td><td></td><td " & IIf(orgCatID <> 0, "style='display:none;'", "") & "></td><td></td><td></td><td></td><td></td><td></td><td></td><td align='right' >" & FormatNumber(RITCTotalPEI, 2) & "</td><td></td><td></td></tr>"
            s += "</table>"
        Else
            If RITCTotalOnt > 0 Then s += "<tr style='font-weight:bold;'><td colspan='3' >Total " & GetMessage(250) & "</td><td></td><td " & "></td><td></td><td></td><td></td><td></td><td></td><td></td><td align='right' >" & FormatNumber(RITCTotalOnt, 2) & "</td><td></td><td></td></tr>"
            If RITCTotalBC > 0 Then s += "<tr style='font-weight:bold;'><td colspan='3'>Total " & GetMessage(249) & "</td><td></td><td " & IIf(orgCatID <> 0, "style='display:none;'", "") & "></td><td></td><td></td><td></td><td></td><td align='right' >" & FormatNumber(RITCTotalBC, 2) & "</td><td></td><td></td></tr>"
            If RITCTotalPEI > 0 Then s += "<tr style='font-weight:bold;'><td colspan='3'>Total " & GetMessage(248) & "</td><td></td><td " & IIf(orgCatID <> 0, "style='display:none;'", "") & "></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td align='right' >" & FormatNumber(RITCTotalPEI, 2) & "</td><td></td><td></td></tr>"
            s += "</table>"
        End If

        s = Replace(s, "numberofitems", i)
        If i = 0 Then s = ""

        exp = Nothing
        org = Nothing
    End Sub

    Private Sub FactorMethodReport()
        Dim orgCatID As Integer
        Dim fmRate As Decimal
        Dim factorItems As Boolean

        AmtTotal = 0 : Amt = 0 : RITCTotalBC = 0 : RITCTotalOnt = 0 : RITCTotalPEI = 0
        orgCatID = CInt(Request.QueryString("orgCatID"))

        GetStartEndDates()

        Dim oc As New OrgCat(orgCatID)
        org.GetExpenses(dStartDate, dEndDate, , "CAT_NAME")

        s = ReportHeader(GetMessage(554), "100%", "65%")
        s = Replace(s, "numberofitemstitle", GetMessage(261))

        s += "<table cellpadding='0' cellspacing='0' width='100%' border='0' style='border-collapse: collapse;font-size:smaller;'>"
        s += "<tr style='font-weight:bold;border-bottom:thin solid silver;border-top:thin solid silver;'><td>Rpt</td><td></td><td>" & GetMessage(78) & "</td><td>" & GetMessage(251) & "</td>" & IIf(orgCatID = 0, "<td>" & GetMessage(60) & "</td>", "") & "<td align='left' >" & sName & "</td><td align='center'>Jur</td><td align='center'>" & GetMessage(557) & "</td><td align='right' >" & GetMessage(45) & "</td><td align='right' >" & GetMessage(118) & "</td><td align='right' >" & GetMessage(119) & "</td>" & IIf(org.GSTReg And org.OrgSizeGST = 2, "<td align='right' >" & GetMessage(120) & "</td>", "") & "<td align='right' >Net</td></tr>"
        s += "<tr style='height:5px;'><td colspan='13'></td></tr>"

        If Not IsNothing(org.Expenses) Then
            For Each exp In org.Expenses

                i += 1
                'check to see if at least one factor method item exists in the report. if not, display a message saying there are no factor method items
                factorItems = IIf(Not factorItems, exp.OrgCategory.FactorMethod Or exp.DateOfExpense.Year < 2014, factorItems)
                fmRate = IIf(exp.OrgCategory.FactorMethod, exp.OrgCategory.Category.GetFM("CAN", exp.Jurisdiction.ID, 0, exp.Rpt.FinalizedDate), 1)
                ITC = IIf(exp.OrgCategory.FactorMethod, fmRate * exp.AmountCDN * org.GetCRAactualRatio("GST", exp.Rpt.FinalizedDate, org.GetCRA("GST", exp.Rpt.FinalizedDate)), exp.ITC)
                fmRate = IIf(exp.OrgCategory.FactorMethod Or exp.DateOfExpense.Year < 2014, exp.OrgCategory.Category.GetFM("QST", exp.Jurisdiction.ID, org.OrgSizeQST, exp.DateOfExpense), 1)
                ITR = IIf(exp.OrgCategory.FactorMethod Or exp.DateOfExpense.Year < 2014, fmRate * exp.AmountCDN * org.GetCRAactualRatio("QST", exp.DateOfExpense, org.GetCRA("QST", exp.DateOfExpense)), exp.ITR)

                Select Case exp.Jurisdiction.ID
                    Case 2 : RITCTotalOnt += exp.RITC
                    Case 10 : RITCTotalBC += exp.RITC
                    Case 4 : RITCTotalPEI += exp.RITC
                End Select

                Amt = exp.AmountCDN

                s += "<tr style='border-bottom:thin solid silver;background-color:" & IIf(i Mod 2 = 0, "white", "white") & ";'>"
                s += "<td width='3%' align='left'>R" & exp.Rpt.ReportNumberFormatted & "</td>"
                s += "<td width='1%'>" & IIf(exp.ReceiptName <> "", "<a href='#' id='" & exp.ID & "' class='viewReceipt'><img src='../images/attachment2.png' width='15px' height='15px' border='0' /></a>", "") & "</td>"
                s += "<td width='8%'>" & exp.Rpt.FinalizedDate & "</td>"
                s += "<td width='8%' align='left'>" & exp.DateOfExpense & "</td>"
                s += "<td width='15%' " & IIf(orgCatID <> 0, "style='display:none;'", "") & ">" & IIf(Session("emp").defaultlanguage = "English", exp.OrgCategory.Category.Name, exp.OrgCategory.Category.NameFR) & IIf(exp.OrgCategory.Note <> "", " -- " & exp.OrgCategory.Note & " -- ", "") & "</td>"
                s += "<td align='left' width='15%'>" & exp.Rpt.Emp.LastName & ", " & exp.Rpt.Emp.FirstName & "</td>"
                s += "<td align='center' width='4%'>" & exp.Jurisdiction.Abbreviation & "</td>"
                s += "<td align='center' width='2%' style='font-weight:bold;'>" & IIf(exp.OrgCategory.FactorMethod, "X", "") & "</td>"
                s += "<td align='right' width='8%'>" & FormatNumber(Amt, 2) & "</td>"
                s += "<td align='right' width='8%'>" & FormatNumber(ITC, 2) & "</td>"
                s += "<td align='right' width='8%'>" & FormatNumber(ITR, 2) & "</td>"
                s += "<td align='right' width='8%' " & IIf(org.OrgSizeGST = 2 And org.GSTReg, "", "style='display:none;'") & ">" & FormatNumber(exp.RITC, 2) & "</td>"
                s += "<td align='right' width='8%'>" & FormatNumber(Amt - ITC - ITR + exp.RITC, 2) & "</td>"
                's += "<td align='right' width='10%'>" & exp.Comment & "</td>"
                s += "</tr>"

                AmtTotal += Amt
                ITCTotal += ITC
                ITRTotal += ITR
                RITCTotal += exp.RITC
                NetTotal += Amt - ITC - ITR + exp.RITC

            Next
        End If

        s += "<tr style='font-weight:bold;border-bottom:thin solid silver;border-top:thin solid silver;'><td colspan='3'>Total</td><td></td><td></td><td " & IIf(orgCatID <> 0, "style='display:none;'", "") & "></td><td></td><td></td><td align='right' >" & FormatNumber(AmtTotal, 2) & "</td><td align='right' >" & FormatNumber(ITCTotal, 2) & "</td><td align='right' >" & FormatNumber(ITRTotal, 2) & "</td><td align='right' " & IIf(org.GSTReg And org.OrgSizeGST = 2, "", "style='display:none;'") & " >" & FormatNumber(RITCTotal, 2) & "</td><td align='right' >" & FormatNumber(NetTotal, 2) & "</td></tr>"

        If RITCTotalOnt > 0 Then s += "<tr style='font-weight:bold;'><td colspan='3' >Total " & GetMessage(250) & "</td><td></td><td " & IIf(orgCatID <> 0, "style='display:none;'", "") & "></td><td></td><td></td><td></td><td></td><td></td><td></td><td align='right' >" & FormatNumber(RITCTotalOnt, 2) & "</td><td></td></tr>"
        If RITCTotalBC > 0 Then s += "<tr style='font-weight:bold;'><td colspan='3'>Total " & GetMessage(249) & "</td><td></td><td " & IIf(orgCatID <> 0, "style='display:none;'", "") & "></td><td></td><td></td><td></td><td></td><td></td><td></td><td align='right' >" & FormatNumber(RITCTotalBC, 2) & "</td><td></td></tr>"
        If RITCTotalPEI > 0 Then s += "<tr style='font-weight:bold;'><td colspan='3'>Total " & GetMessage(248) & "</td><td></td><td " & IIf(orgCatID <> 0, "style='display:none;'", "") & "></td><td></td><td></td><td></td><td></td><td></td><td></td><td align='right' >" & FormatNumber(RITCTotalPEI, 2) & "</td><td></td></tr>"
        s += "</table>"

        s = Replace(s, "numberofitems", i)
        If Not factorItems Then s = "<p class='labelText' style='font-size:1.4em;'>There are no expenses related to the factors method for this period</p>"
        If i = 0 Then s = ""

        exp = Nothing
        org = Nothing
    End Sub



    Private Sub JurisdictionReport()
        AmtTotal = 0 : Amt = 0 : RITCTotalBC = 0 : RITCTotalOnt = 0 : RITCTotalPEI = 0
        'Dim emp As Employee
        Dim jurID As Integer = CInt(Request.QueryString("jur"))
        Dim jur As Jurisdiction
        Dim title As String

        If jurID > 0 Then jur = New Jurisdiction(jurID)

        GetStartEndDates()
        org.GetExpenses(dStartDate, dEndDate, , "JUR_NAME")

        If jurID = 0 Then
            title = GetMessage(263) & " " & GetMessage(351)
        Else
            title = GetMessage(263) & " " & If(Session("emp").defaultlanguage = "English", jur.Name, jur.NameFR)
        End If

        s = ReportHeader(title, "100%", "65%")
        s = Replace(s, "numberofitemstitle", GetMessage(261))

        s += "<table border='0' cellpadding='0' cellspacing='0' width='100%' style='border-collapse: collapse;font-size:smaller;'>"
        s += "<tr style='font-weight:bold;border-bottom:thin solid silver;border-top:thin solid silver;'><td>Rpt</td><td></td><td>" & GetMessage(78) & "</td><td>" & GetMessage(251) & "</td><td>" & GetMessage(60) & "</td><td align='left'>" & sName & "</td><td align='center' " & IIf(jurID > 0, "style='display:none;'", "") & ">Jur</td><td align='right'>" & GetMessage(45) & "</td><td align='right'>" & GetMessage(118) & "</td><td align='right'>" & GetMessage(119) & "</td>" & IIf(org.GSTReg And org.OrgSizeGST = 2, "<td align='right'>" & GetMessage(120) & "</td>", "") & "<td align='right'>Net</td><td align='right'>" & GetMessage(48) & "</td></tr>"
        s += "<tr style='height:5px;'><td colspan='13'></td></tr>"

        If Not IsNothing(org.Expenses) Then
            For Each exp In org.Expenses
                'rpt = New Report(exp.ReportID, False)
                'emp = New Employee(rpt.EmpID)

                If exp.Jurisdiction.ID = jurID Or jurID = 0 Then
                    i += 1

                    ITC = exp.ITC
                    ITR = exp.ITR
                    Amt = exp.AmountCDN

                    Select Case exp.Jurisdiction.ID
                        Case 2 : RITCTotalOnt += exp.RITC
                        Case 10 : RITCTotalBC += exp.RITC
                        Case 4 : RITCTotalPEI += exp.RITC
                    End Select

                    s += "<tr style='border-bottom:thin solid silver;background-color:" & IIf(i Mod 2 = 0, "white", "white") & ";'>"
                    s += "<td width='3%' align='left'>R" & exp.Rpt.ReportNumberFormatted & "</td>"
                    s += "<td width='1%'>" & IIf(exp.ReceiptName <> "", "<a href='#' id='" & exp.ID & "' class='viewReceipt'><img src='../images/attachment2.png' width='15px' height='15px' border='0' /></a>", "") & "</td>"
                    s += "<td width='8%'>" & exp.Rpt.FinalizedDate & "</td>"
                    s += "<td width='8%' align='left'>" & exp.DateOfExpense & "</td>"
                    s += "<td width='15%'>" & IIf(Session("emp").defaultlanguage = "English", exp.OrgCategory.Category.Name, exp.OrgCategory.Category.NameFR) & IIf(exp.OrgCategory.Note <> "", " -- " & exp.OrgCategory.Note & " -- ", "") & "</td>"
                    s += "<td align='left' width='15%'>" & exp.Rpt.Emp.LastName & ", " & exp.Rpt.Emp.FirstName & "</td>"
                    s += "<td width='2%' align='center' " & IIf(jurID > 0, "style='display:none;'", "") & ">" & IIf(exp.OrgCategory.Category.ID = 5, "ZZ", exp.Jurisdiction.Abbreviation) & "</td>"
                    s += "<td align='right' width='8%'>" & FormatNumber(Amt, 2) & "</td>"
                    s += "<td align='right' width='8%'>" & FormatNumber(ITC, 2) & "</td>"
                    s += "<td align='right' width='8%'>" & FormatNumber(ITR, 2) & "</td>"
                    s += "<td align='right' width='8%' " & IIf(org.OrgSizeGST = 2 And org.GSTReg, "", "style='display:none;'") & ">" & FormatNumber(exp.RITC, 2) & "</td>"
                    s += "<td align='right' width='8%'>" & FormatNumber(Amt - ITC - ITR + exp.RITC, 2) & "</td>"
                    s += "<td align='right' width='10%'>" & exp.Comment & "</td>"
                    s += "</tr>"

                    AmtTotal += Amt
                    ITCTotal += ITC
                    ITRTotal += ITR
                    RITCTotal += exp.RITC
                    NetTotal += Amt - ITC - ITR + exp.RITC

                End If

            Next
        End If
        s += "<tr style='font-weight:bold;border-bottom:thin solid silver;border-top:thin solid silver;'><td colspan='3'>Total</td><td></td><td " & IIf(jurID > 0, "style='display:none;'", "") & "></td><td></td><td></td><td align='right' >" & FormatNumber(AmtTotal, 2) & "</td><td align='right' >" & FormatNumber(ITCTotal, 2) & "</td><td align='right' >" & FormatNumber(ITRTotal, 2) & "</td><td align='right' " & IIf(org.GSTReg And org.OrgSizeGST = 2, "", "style='display:none;'") & " >" & FormatNumber(RITCTotal, 2) & "</td><td align='right' >" & FormatNumber(NetTotal, 2) & "</td><td></td></tr>"

        If jurID = 0 Then If RITCTotalOnt > 0 Then s += "<tr style='font-weight:bold;'><td colspan='3' >Total " & GetMessage(250) & "</td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td align='right' >" & FormatNumber(RITCTotalOnt, 2) & "</td><td></td><td></td></tr>"
        If jurID = 0 Then If RITCTotalBC > 0 Then s += "<tr style='font-weight:bold;'><td colspan='3'>Total " & GetMessage(249) & "</td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td align='right' >" & FormatNumber(RITCTotalBC, 2) & "</td><td></td><td></td></tr>"
        If jurID = 0 Then If RITCTotalPEI > 0 Then s += "<tr style='font-weight:bold;'><td colspan='3'>Total " & GetMessage(248) & "</td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td align='right' >" & FormatNumber(RITCTotalPEI, 2) & "</td><td></td><td></td></tr>"

        s += "</table>"

        s = Replace(s, "numberofitems", i)
        If i = 0 Then s = ""

        rpt = Nothing
        exp = Nothing
        org = Nothing
    End Sub

    Private Sub SelectableRateReport()
        AmtTotal = 0 : Amt = 0 : RITCTotalBC = 0 : RITCTotalOnt = 0 : RITCTotalPEI = 0
        'Dim emp As Employee
        Dim title As String

        GetStartEndDates()
        org.GetReports(dStartDate, dEndDate)

        title = GetMessage(263) & " " & GetMessage(360)

        s = ReportHeader(title, "100%", "65%")
        s = Replace(s, "numberofitemstitle", GetMessage(261))

        s += "<table border='0' cellpadding='0' cellspacing='0' width='100%' style='border-collapse: collapse;font-size:smaller;'>"
        s += "<tr style=' font-weight:bold;border-bottom:thin solid silver;border-top:thin solid silver;'><td>Rpt</td><td></td><td>" & GetMessage(78) & "</td><td>" & GetMessage(251) & "</td><td>" & GetMessage(60) & "</td><td align='left'>" & sName & "</td><td align='center'>" & GetMessage(40) & "</td><td align='right'>" & GetMessage(45) & "</td><td align='right'>" & GetMessage(118) & "</td><td align='right'>" & GetMessage(119) & "</td>" & IIf(org.GSTReg And org.OrgSizeGST = 2, "<td align='right'>" & GetMessage(120) & "</td>", "") & "<td align='right'>Net</td><td align='right'>" & GetMessage(48) & "</td></tr>"
        s += "<tr style='height:5px;'><td colspan='13'></td></tr>"

        If Not IsNothing(org.Reports) Then
            For Each rpt In org.Reports
                'emp = New Employee(rpt.EmpID)

                For Each exp In rpt.Expenses
                    If exp.OrgCategory.Category.ID = 5 Then
                        i += 1

                        ITC = exp.ITC
                        ITR = exp.ITR
                        Amt = exp.AmountCDN

                        Select Case exp.Jurisdiction.ID
                            Case 2 : RITCTotalOnt += exp.RITC
                            Case 10 : RITCTotalBC += exp.RITC
                            Case 4 : RITCTotalPEI += exp.RITC
                        End Select

                        s += "<tr style='border-bottom:thin solid silver; background-color:" & IIf(i Mod 2 = 0, "white", "white") & ";'>"
                        s += "<td width='3%' align='left'>R" & rpt.ReportNumberFormatted & "</td>"
                        s += "<td width='1%'>" & IIf(exp.ReceiptName <> "", "<a href='#' id='" & exp.ID & "' class='viewReceipt'><img src='../images/attachment2.png' width='15px' height='15px' border='0' /></a>", "") & "</td>"
                        s += "<td width='9%'>" & rpt.FinalizedDate & "</td>"
                        s += "<td width='9%' align='left'>" & exp.DateOfExpense & "</td>"
                        s += "<td width='15%'>" & IIf(Session("emp").defaultlanguage = "English", exp.OrgCategory.Category.Name, exp.OrgCategory.Category.NameFR) & IIf(exp.OrgCategory.Note <> "", " -- " & exp.OrgCategory.Note & " -- ", "") & "</td>"
                        s += "<td align='left' width='15%'>" & rpt.Emp.LastName & ", " & rpt.Emp.FirstName & "</td>"
                        s += "<td width='2%' align='center'>" & IIf(exp.Jurisdiction.ID = 1, GetMessage(359), IIf(exp.Jurisdiction.ID = 14, GetMessage(358), IIf(Session("emp").defaultlanguage = "English", exp.Jurisdiction.Abbreviation, exp.Jurisdiction.AbbreviationFR))) & "</td>"
                        s += "<td align='right' width='6%'>" & FormatNumber(Amt, 2) & "</td>"
                        s += "<td align='right' width='6%'>" & FormatNumber(ITC, 2) & "</td>"
                        s += "<td align='right' width='6%'>" & FormatNumber(ITR, 2) & "</td>"
                        s += "<td align='right' width='6%' " & IIf(org.OrgSizeGST = 2 And org.GSTReg, "", "style='display:none;'") & ">" & FormatNumber(exp.RITC, 2) & "</td>"
                        s += "<td align='right' width='6%'>" & FormatNumber(Amt - ITC - ITR + exp.RITC, 2) & "</td>"
                        s += "<td align='right' width='10%'>" & exp.Comment & "</td>"
                        s += "</tr>"

                        AmtTotal += Amt
                        ITCTotal += ITC
                        ITRTotal += ITR
                        RITCTotal += exp.RITC
                        NetTotal += Amt - ITC - ITR + exp.RITC

                    End If
                Next
                'emp = Nothing
            Next
        End If
        s += "<tr style=' font-weight:bold;border-bottom:thin solid silver;border-top:thin solid silver;'><td colspan='3'>Total</td><td></td><td></td><td></td><td></td><td align='right' >" & FormatNumber(AmtTotal, 2) & "</td><td align='right' >" & FormatNumber(ITCTotal, 2) & "</td><td align='right' >" & FormatNumber(ITRTotal, 2) & "</td><td align='right' " & IIf(org.GSTReg And org.OrgSizeGST = 2, "", "style='display:none;'") & " >" & FormatNumber(RITCTotal, 2) & "</td><td align='right' >" & FormatNumber(NetTotal, 2) & "</td><td></td></tr>"
        s += "</table>"

        s = Replace(s, "numberofitems", i)
        If i = 0 Then s = ""

        rpt = Nothing
        exp = Nothing
        org = Nothing
    End Sub


    Private Sub CheckDebitCredit(GL As String)
        Dim balance As Double, totalDT As Double, totalCR As Double
        Dim credit As Boolean
        Dim rptNum As Integer = -1
        Dim org2 As Org


        GetConnectionString()
        GetStartEndDates()

        Dim sqlConn = New SqlConnection(connString.ConnectionString)
        sqlConn.Open()

        Dim com As SqlCommand = New SqlCommand("GetDebitCredit", sqlConn)
        Dim rs As SqlDataReader

        com.CommandType = CommandType.StoredProcedure
        com.Parameters.Add(New SqlParameter("@OrgID", SqlDbType.Int)).Value = orgID
        com.Parameters.Add(New SqlParameter("@GLAccount", SqlDbType.NVarChar)).Value = GL
        com.Parameters.Add(New SqlParameter("@PeriodStart", SqlDbType.Date)).Value = dStartDate
        com.Parameters.Add(New SqlParameter("@PeriodEnd", SqlDbType.Date)).Value = dEndDate

        com.Connection = sqlConn
        rs = com.ExecuteReader

        org2 = New Org(orgID)

        s = "<table cellpadding='0' cellspacing='0' width='98%' border=0  style='font-size:smaller;'>"
        s += "<tr><td width='60%' style=' font-weight:bold;'>" & org2.Name & IIf(org2.Code <> "", " (" & org2.Code & ")", "") & "</td><td></td></tr>"
        s += "<tr><td width='60%'  style=' font-weight:bold;'>" & GetMessage(268) & " " & GL & "</td><td></td><td align='right'></td></tr>"
        s += "<tr valign='top'><td style=' font-weight:bold;'>" & GetMessage(242) & ": numberofreports</td><td></td><td align='right'></td></tr>"
        s += "<tr><td width='60%'  style=' font-weight:bold;'>" & GetMessage(243) & ": " & dStartDate & " - " & dEndDate & "</td><td></td><td align='right'></td></tr>"

        If Not IsNothing(Request.QueryString("p")) Then s += "<tr><td width='60%'  style=' font-weight:bold;'>" & GetMessage(237) & ": " & iYear & " - " & GetMessage(244) & ":" & iPeriod & "</td><td></td><td align='right'></td></tr>"

        s += "<tr style='height:10px;'><td colspan='7'></td></tr>"
        s += "</table>"

        s += "<table cellpadding='0' cellspacing='0' width='100%' border=0  style='font-size:smaller;border-collapse:collapse;'>"
        s += "<tr style='height:2px;'><td colspan='7' style='border-bottom:thin solid silver;'></td></tr>"
        s += "<tr style='font-weight:bold;'><td>Rpt</td><td>" & GetMessage(78) & "</td><td>" & sReportName & "</td><td>" & sEmployee & "</td><td width='5%' align='right' >" & sDebit & "</td><td align='right'>" & sCredit & "</td><td align='right'>Balance</td></tr>"
        s += "<tr style='height:2px;'><td colspan='7' style='border-top:thin solid silver;'></td></tr>"
        s += "<tr style='height:5px;'><td colspan='7'></td></tr>"

        i = 0
        While rs.Read
            s += "<tr style='border-bottom:thin solid silver;background-color:" & IIf(i Mod 2 = 0, "white", "white") & ";'>"
            s += "<td>R" & IIf(rs("REPORT_NUM") < 10, "000", IIf(rs("REPORT_NUM") < 100, "00", IIf(rs("REPORT_NUM") < 1000, "0", ""))) & rs("REPORT_NUM") & "</td>"
            s += "<td>" & rs("FINALIZED") & "</td>"
            s += "<td>" & rs("REPORT_NAME") & "</td>"
            s += "<td>" & rs("LAST_NAME") & "," & rs("FIRST_NAME") & "</td>"
            If rs("DC_TYPE") = "DT" Then s += "<td align='right'>" & FormatNumber(rs("AMOUNT"), 2) & "</td><td></td>"
            If rs("DC_TYPE") = "CR" Then s += "<td></td><td align='right'>" & FormatNumber(rs("AMOUNT"), 2) & "</td>"

            If rs("DC_TYPE") = "DT" Then
                balance += rs("AMOUNT")
                totalDT += rs("AMOUNT")
            Else
                balance -= rs("AMOUNT")
                totalCR += rs("AMOUNT")
            End If

            If balance < 0 Then credit = True
            s += "<td  align='right'>" & FormatNumber(Math.Abs(balance), 2) & IIf(credit, " CR", " DT") & "</td>"
            s += "</tr>"

            If rs("REPORT_NUM") <> rptNum Or i = 0 Then i += 1
            rptNum = rs("REPORT_NUM")

        End While

        s += "<tr><td colspan='7' style='border-top:thin solid silver;'></td></tr>"

        s += "</table>"
        s = Replace(s, "numberofreports", i)
        If i = 0 Then s = ""

        org2 = Nothing
        rs = Nothing
        sqlConn.Close()
        sqlConn = Nothing
        com = Nothing

    End Sub


    Private Sub GLReport()
        Dim GL As String
        Dim sAccSegment As String
        Dim proj As String = "0", cc As String = "0", div As String = "0"
        Dim acc As Account

        GL = Request.QueryString("GL")

        If GL <> "0" And GL = org.Parent.AccountPayable Then
            APReport()
        Else

            'If GL <> "0" And GL = org.Parent.ITCAccount Or GL = org.Parent.ITRAccount Or GL = org.Parent.ritcONAccount Or GL = org.Parent.ritcPEIAccount Or GL = org.Parent.ritcBCAccount Then
            'CheckDebitCredit(GL)
            'Else
            AmtTotal = 0 : Amt = 0 : RITCTotalBC = 0 : RITCTotalOnt = 0 : RITCTotalPEI = 0

            GetStartEndDates()
            If GL <> "0" Then
                org.GetExpenses(dStartDate, dEndDate, GL)
            Else
                org.GetExpenses(dStartDate, dEndDate)
            End If

            s = ReportHeader(GetMessage(268) & ": " & IIf(GL = "0", GetMessage(104), ""), "100%", "65%")
            sAccSegment = ""

            s += "<table cellpadding='0' cellspacing='0' width='100%' border=0  style='font-size:smaller;border-collapse:collapse;'>"
            s += "<tr style='height:2px;'><td colspan='10' style='border-bottom:thin solid silver;'></td></tr>"
            s += "<tr style=' font-weight:bold;'><td>Rpt</td><td></td><td width='2%'>" & GetMessage(78) & "</td><td>" & GetMessage(251) & "</td><td>" & GetMessage(245) & "</td><td>" & GetMessage(268) & "</td><td>" & GetMessage(60) & "</td><td align='center' >Jur</td><td align='left' >" & sName & "</td><td align='right' >" & sDebit & "</td></tr>"
            s += "<tr style='height:2px;'><td colspan='10' style='border-top:thin solid silver;'></td></tr>"
            s += "<tr style='height:5px;'><td colspan='10'></td></tr>"

            If Not IsNothing(org.Expenses) Then
                For Each exp In org.Expenses
                    i += 1
                    ITC = exp.ITC
                    ITR = exp.ITR

                    Select Case exp.Jurisdiction.ID
                        Case 2 : RITCTotalOnt += exp.RITC
                        Case 10 : RITCTotalBC += exp.RITC
                        Case 4 : RITCTotalPEI += exp.RITC
                    End Select

                    Amt = exp.AmountCDN

                    s += "<tr style='border-bottom:thin solid silver; background-color:" & IIf(i Mod 2 = 0, "white", "white") & ";'>"
                    s += "<td width='1%' align='left'>R" & exp.Rpt.ReportNumberFormatted & "</td>"
                    s += "<td width='1%'>" & IIf(exp.ReceiptName <> "", "<a href='#' id='" & exp.ID & "' class='viewReceipt'><img src='../images/attachment2.png' width='15px' height='15px' border='0' /></a>", "") & "</td>"
                    s += "<td width='3%'>" & exp.Rpt.FinalizedDate & "</td>"
                    s += "<td width='3%'>" & exp.DateOfExpense & "</td>"

                    sAccSegment = "<table border=0 width='50%' cellspacing='0' cellpadding='0' style='font-size:0.9em;'><tr>"
                    If org.Parent.AccSegment.IndexOf("D") = 0 Then sAccSegment += "<td width='15%'>" & exp.Rpt.Emp.DivCode & "&nbsp;</td>"
                    If org.Parent.AccSegment.IndexOf("A") = 0 Then sAccSegment += "<td width='20%'>" & exp.OrgCategory.GLAccount & "&nbsp;</td>"

                    If org.Parent.AccSegment.IndexOf("D") = 1 Then sAccSegment += "<td width='15%'>" & exp.Rpt.Emp.DivCode & "&nbsp;</td>"
                    If org.Parent.AccSegment.IndexOf("A") = 1 Then sAccSegment += "<td width='20%'>" & exp.OrgCategory.GLAccount & "&nbsp;</td>"
                    If org.Parent.AccSegment.IndexOf("P") = 1 Then sAccSegment += "<td width='20%'>" & exp.Project & "&nbsp;</td>"
                    If org.Parent.AccSegment.IndexOf("C") = 1 Then sAccSegment += "<td width='20%'>" & exp.CostCenter & "&nbsp;</td>"

                    If org.Parent.AccSegment.IndexOf("P") = 2 Then sAccSegment += "<td width='20%'>" & exp.Project & "&nbsp;</td>"
                    If org.Parent.AccSegment.IndexOf("C") = 2 Then sAccSegment += "<td width='20%'>" & exp.CostCenter & "&nbsp;</td>"

                    If org.Parent.AccSegment.IndexOf("P") = 3 Then sAccSegment += "<td width='20%'>" & exp.Project & "&nbsp;</td>"
                    If org.Parent.AccSegment.IndexOf("C") = 3 Then sAccSegment += "<td width='20%'>" & exp.CostCenter & "&nbsp;</td>"
                    If org.Parent.AccSegment.IndexOf("NNN") > 0 Then sAccSegment += "<td></td>"
                    If org.Parent.AccSegment.IndexOf("NN") > 0 Then sAccSegment += "<td></td>"
                    If org.Parent.AccSegment.IndexOf("N") > 0 Then sAccSegment += "<td></td>"

                    sAccSegment += "</tr></table>"

                    s += "<td width='3%' align='left'>" & sAccSegment & "</td>"
                    acc = New Account(exp.OrgCategory.GLAccount, org.ID)
                    s += "<td width='3%' align='left'>" & acc.Name & "</td>"
                    s += "<td width='10%'>" & IIf(Session("emp").defaultlanguage = "English", exp.OrgCategory.Category.Name, exp.OrgCategory.Category.NameFR) & IIf(exp.OrgCategory.Note <> "", " -- " & exp.OrgCategory.Note & " -- ", "") & "</td>"
                    s += "<td align='center' width='2%'>" & exp.Jurisdiction.Abbreviation & "</td>"
                    s += "<td align='left' width='7%'>" & exp.Rpt.Emp.LastName & ", " & exp.Rpt.Emp.FirstName & "</td>"
                    s += "<td align='right' width='5%'>" & FormatNumber(Amt - ITC - ITR + exp.RITC, 2) & "</td>"
                    s += "</tr>"

                    acc = Nothing
                    AmtTotal += Amt
                    ITCTotal += ITC
                    ITRTotal += ITR
                    RITCTotal += exp.RITC
                    NetTotal += Amt - ITC - ITR + exp.RITC
                Next
            End If
            s += "<tr style=' font-weight:bold;border-bottom:thin solid silver;border-top:thin solid silver;'><td colspan='4'>Total</td><td></td><td></td><td></td><td></td><td></td><td align='right' >" & FormatNumber(NetTotal, 2) & "</td></tr>"
            s += "</table>"

            s = Replace(s, "numberofitemstitle", GetMessage(261))
            s = Replace(s, "numberofitems", i)
            If i = 0 Then s = ""
        End If

        exp = Nothing
        org = Nothing
    End Sub

    Private Sub ReimburseReport()
        Dim total As Double
        'Dim emp As Employee

        GetStartEndDates()
        org.GetReports(dStartDate, dEndDate)

        s = "<table cellpadding='0' cellspacing='0' width='100%' border=0  style='font-size:smaller;'>"
        s += "<tr><td width='60%' style=' font-weight:bold;'>" & org.Name & IIf(org.Code <> "", " (" & org.Code & ")", "") & "</td></tr>"
        s += "<tr><td width='60%'  style=' font-weight:bold;'>" & GetMessage(365) & "</td>"

        If Not IsNothing(Request.QueryString("p")) Then s += "<td align='right' style=' font-weight:bold;'>" & GetMessage(237) & ":</td><td align='right' style=' font-weight:bold;'>" & iYear & "</td>"
        s += "</tr>"
        s += "<tr valign='top'><td style=' font-weight:bold;'>" & GetMessage(261) & ": numberofexpenses</td>"

        If Not IsNothing(Request.QueryString("p")) Then s += "<td align='right' style=' font-weight:bold;'>" & GetMessage(244) & ":</td><td align='right' style=' font-weight:bold;'>" & iPeriod & "</td>"
        s += "</tr>"

        s += "<tr><td width='70%' style=' font-weight:bold;'>" & GetMessage(125) & ": " & Format(Now, "dd/MM/yyyy") & "</td>"
        s += "<td align='right' style=' font-weight:bold;'>" & GetMessage(243) & ":</td><td align='right' style=' font-weight:bold;'>" & dStartDate & " - " & dEndDate & "</td></tr>"
        s += "<tr style='height:10px;'><td colspan='15'></td></tr>"
        s += "</table>"

        s += "<table cellpadding='0' cellspacing='0' width='100%' border=0  style='font-size:smaller;border-collapse:collapse;'>"
        s += "<tr style='height:2px;'><td colspan='6' style='border-bottom:thin solid silver;'></td></tr>"
        s += "<tr style='font-weight:bold;'><td>Rpt</td><td>" & GetMessage(78) & "</td><td>" & sEmployee & "</td><td align='left' >" & GetMessage(60) & "</td><td align='right' >" & GetMessage(247) & "</td><td align='right' >" & GetMessage(267) & "</td></tr>"
        s += "<tr style='height:2px;'><td colspan='6' style='border-top:thin solid silver;'></td></tr>"
        s += "<tr style='height:5px;'><td colspan='6'></td></tr>"

        If Not IsNothing(org.Reports) Then
            For Each rpt In org.Reports
                'emp = New Employee(rpt.EmpID)

                For Each Me.exp In rpt.Expenses
                    If Not Me.exp.Reimburse Then
                        i += 1
                        s += "<tr style='border-bottom:thin solid silver;background-color:" & IIf(i Mod 2 = 0, "white", "white") & ";'>"
                        s += "<td width='4%'>R" & rpt.ReportNumberFormatted & "</td>"
                        s += "<td width='8%'>" & rpt.FinalizedDate & "</td>"
                        s += "<td align='left' width='15%'>" & rpt.Emp.LastName & ", " & rpt.Emp.FirstName & "</td>"
                        s += "<td width='20%'>" & IIf(Session("emp").defaultlanguage = "English", exp.OrgCategory.Category.Name, exp.OrgCategory.Category.NameFR) & IIf(exp.OrgCategory.Note <> "", " -- " & exp.OrgCategory.Note & " -- ", "") & "</td>"
                        s += "<td align='right' width='8%'>" & FormatNumber(exp.AmountCDN, 2) & "</td>"
                        total += exp.AmountCDN
                        s += "<td align='right' width='8%'>" & FormatNumber(total, 2) & "</td>"
                        s += "</tr>"
                    End If
                Next

                'emp = Nothing
            Next
        End If
        s += "<tr style='height:2px;'><td colspan='6' style='border-top:thin solid silver;'></td></tr>"
        s += "</table>"
        s = Replace(s, "numberofexpenses", i)
        If i = 0 Then s = ""

        rpt = Nothing
        exp = Nothing
        org = Nothing
    End Sub

    Private Sub ThirdParty()
        GetConnectionString()
        Dim i As Integer
        Dim sqlConn = New SqlConnection(connString.ConnectionString)
        sqlConn.Open()
        Dim com As SqlCommand = New SqlCommand("GetTPTotals", sqlConn)
        Dim rs As SqlDataReader
        Dim exp As Expense
        Dim balance As Double

        GetStartEndDates()
        s += "<table cellpadding='0' cellspacing='0' width='100%'  style='font-size:smaller;'>"
        s += "<tr><td width='60%' style=' font-weight:bold;'></td></tr>"
        s += "<tr><td width='60%' style=' font-weight:bold;'>" & org.Name & IIf(org.Code <> "", " (" & org.Code & ")", "") & "</td></tr>"
        s += "<tr><td width='60%' style=' font-weight:bold;'>" & GetMessage(365) & "</td>"

        If Not IsNothing(Request.QueryString("p")) Then s += "<td align='right' style=' font-weight:bold;'>" & GetMessage(237) & ":</td><td align='right' style=' font-weight:bold;'>" & iYear & "</td>"
        s += "</tr>"

        s += "<tr valign='top'><td style=' font-weight:bold;'>" & GetMessage(476) & ": numberofitems</td>"

        If Not IsNothing(Request.QueryString("p")) Then s += "<td align='right' style=' font-weight:bold;'>" & GetMessage(244) & ":</td><td align='right' style=' font-weight:bold;'>" & iPeriod & "</td>"
        s += "</tr>"

        s += "<tr><td width='70%' style=' font-weight:bold;'>" & GetMessage(125) & ": " & Format(Now, "dd/MM/yyyy") & "</td>"
        s += "<td align='right' style=' font-weight:bold;'>" & GetMessage(243) & ":</td><td align='right' style=' font-weight:bold;'>" & dStartDate & " - " & dEndDate & "</td></tr>"

        s += "<tr style='height:10px;'><td colspan='15'></td></tr>"
        s += "</table>"

        com.CommandType = CommandType.StoredProcedure
        com.Parameters.Add(New SqlParameter("@OrgID", SqlDbType.Int)).Value = org.ID
        com.Parameters.Add(New SqlParameter("@StartDate", SqlDbType.Date)).Value = dStartDate
        com.Parameters.Add(New SqlParameter("@EndDate", SqlDbType.Date)).Value = dEndDate

        com.Connection = sqlConn
        rs = com.ExecuteReader

        s += "<table cellpadding='0' cellspacing='0' width='100%' border=0  style='font-size:smaller;border-collapse:collapse;'>"
        s += "<tr style='font-weight:bold;border-bottom:thin solid silver;border-top:thin solid silver;'><td>TP</td><td>" & sThirdParty & "</td><td>" & GetMessage(236) & "</td><td align='right'>" & sCredit.ToString & "</td><td align='right'>Balance</td></tr>"

        While rs.Read
            i += 1

            balance += rs("AMT")
            s += "<tr style='border-bottom:thin solid silver;background-color:" & IIf(i Mod 2 = 0, "white", "white") & ";'>"
            s += "<td>" & rs("THIRD_PARTY") & "</td>"
            s += "<td>" & rs("ACC_NAME") & "</td>"
            s += "<td>" & rs("ACC_NUMBER") & "</td>"
            s += "<td align='right'>" & FormatNumber(rs("AMT"), 2) & "</td>"
            s += "<td align='right'>" & FormatNumber(balance, 2) & "</td>"
            s += "</tr>"
        End While

        s += "</table>"

        s = Replace(s, "numberofitems", i)
        If i = 0 Then s = ""

        rs.Close()
        com.Dispose()
        sqlConn.Close()
        exp = Nothing
        sqlConn = Nothing
        com = Nothing
        rs = Nothing

    End Sub


    Private Sub ThirdPartyDetailed()
        Dim total As Double, net As Double
        'Dim emp As Employee
        Dim i As Integer

        GetStartEndDates()
        org.GetExpenses(dStartDate, dEndDate, 1, "TP")

        s = "<table cellpadding='0' cellspacing='0' width='100%' border=0  style='font-size:smaller;'>"
        s += "<tr><td width='60%' style=' font-weight:bold;'>" & org.Name & IIf(org.Code <> "", " (" & org.Code & ")", "") & "</td></tr>"
        s += "<tr><td width='60%'  style=' font-weight:bold;'>" & GetMessage(550) & "</td>"

        If Not IsNothing(Request.QueryString("p")) Then s += "<td align='right' style=' font-weight:bold;'>" & GetMessage(237) & ":</td><td align='right' style=' font-weight:bold;'>" & iYear & "</td>"
        s += "</tr>"

        s += "<tr valign='top'><td style=' font-weight:bold;'>" & GetMessage(261) & ": numberofexpenses</td>"

        If Not IsNothing(Request.QueryString("p")) Then s += "<td align='right' style=' font-weight:bold;'>" & GetMessage(244) & ":</td><td align='right' style=' font-weight:bold;'>" & iPeriod & "</td>"
        s += "</tr>"

        s += "<tr><td width='70%' style=' font-weight:bold;'>" & GetMessage(125) & ": " & Format(Now, "dd/MM/yyyy") & "</td>"
        s += "<td align='right' style=' font-weight:bold;'>" & GetMessage(243) & ":</td><td align='right' style=' font-weight:bold;'>" & dStartDate & " - " & dEndDate & "</td></tr>"
        s += "<tr style='height:10px;'><td colspan='15'></td></tr>"
        s += "</table>"

        s += "<table cellpadding='0' cellspacing='0' width='100%' border=0  style='font-size:smaller;border-collapse:collapse;'>"
        s += "<tr style='font-weight:bold;border-bottom:thin solid silver;border-top:thin solid silver;'><td>Rpt</td><td>" & sFinalized & "</td><td>" & sExpensed & "</td><td>Emp</td><td>" & sEmployee & "</td><td>" & GetMessage(236) & "</td><td colspan='2'>" & sThirdParty & "</td><td>" & sSupplier & "</td><td>" & sLinkedCat & "</td><td align='right'>Jur</td><td align='right'>" & sCredit & "</td><td align='right'>Balance</td></tr>"
        s += "<tr style='height:5px;'><td colspan='8'></td></tr>"

        If Not IsNothing(org.Expenses) Then
            For Each exp In org.Expenses
                'rpt = New Report(exp.ReportID)
                'emp = New Employee(rpt.EmpID)
                i += 1
                'net = exp.AmountCDN - exp.ITC - exp.ITR + exp.RITC
                total += exp.AmountCDN
                s += "<tr style='border-bottom:thin solid silver;background-color:" & IIf(i Mod 2 = 0, "white", "white") & ";'>"
                s += "<td width='4%'>R" & exp.Rpt.ReportNumberFormatted & "</td>"
                s += "<td width='8%'>" & exp.Rpt.FinalizedDate & "</td>"
                s += "<td width='8%'>" & exp.DateOfExpense & "</td>"
                s += "<td width='5%'>" & exp.Rpt.Emp.EmpNum & "</td>"
                s += "<td width='12%'>" & exp.Rpt.Emp.LastName & ", " & exp.Rpt.Emp.FirstName & "</td>"
                s += "<td width='8%'>" & exp.AccountNumber & "</td>"
                s += "<td width='5%'>" & exp.TPNum & "</td>"
                s += "<td width='10%'>" & exp.TPName & "</td>"
                s += "<td width='10%'>" & exp.SupplierName & "</td>"
                s += "<td width='12%'>" & IIf(Session("emp").defaultlanguage = "English", exp.OrgCategory.Category.Name, exp.OrgCategory.Category.NameFR) & IIf(exp.OrgCategory.Note <> "", "--" & exp.OrgCategory.Note & "--", "") & "</td>"
                s += "<td width='3%' align='right'>" & exp.Jurisdiction.Abbreviation & "</td>"
                s += "<td width='8%' align='right'>" & FormatNumber(exp.AmountCDN, 2) & "</td>"
                s += "<td  width='8%' align='right'>" & FormatNumber(total, 2) & "</td>"
                s += "</tr>"
            Next
        End If
        s += "<tr style='height:2px;'><td colspan='10' style='border-top:thin solid silver;'></td></tr>"
        s += "</table>"
        s = Replace(s, "numberofexpenses", i)


        If i = 0 Then s = ""

        exp = Nothing
        org = Nothing
    End Sub


    Private Sub ThirdPartyDetailed(AccType As String)
        Dim total As Double, net As Double
        'Dim emp As Employee
        Dim i As Integer

        GetStartEndDates()
        org.GetExpenses(dStartDate, dEndDate, 1, "TP")

        s = "<table cellpadding='0' cellspacing='0' width='100%' border=0  style='font-size:smaller;'>"
        s += "<tr><td width='60%' style=' font-weight:bold;'>" & org.Name & IIf(org.Code <> "", " (" & org.Code & ")", "") & "</td></tr>"
        s += "<tr><td width='60%'  style=' font-weight:bold;'>" & GetMessage(IIf(AccType = "Advance", 551, 547)) & "</td>"

        If Not IsNothing(Request.QueryString("p")) Then s += "<td align='right' style=' font-weight:bold;'>" & GetMessage(237) & ":</td><td align='right' style=' font-weight:bold;'>" & iYear & "</td>"
        s += "</tr>"

        s += "<tr valign='top'><td style=' font-weight:bold;'>" & GetMessage(261) & ": numberofexpenses</td>"

        If Not IsNothing(Request.QueryString("p")) Then s += "<td align='right' style=' font-weight:bold;'>" & GetMessage(244) & ":</td><td align='right' style=' font-weight:bold;'>" & iPeriod & "</td>"
        s += "</tr>"

        s += "<tr><td width='70%' style=' font-weight:bold;'>" & GetMessage(125) & ": " & Format(Now, "dd/MM/yyyy") & "</td>"
        s += "<td align='right' style=' font-weight:bold;'>" & GetMessage(243) & ":</td><td align='right' style=' font-weight:bold;'>" & dStartDate & " - " & dEndDate & "</td></tr>"
        s += "<tr style='height:10px;'><td colspan='15'></td></tr>"
        s += "</table>"

        s += "<table cellpadding='0' cellspacing='0' width='100%' border=0  style='font-size:smaller;border-collapse:collapse;'>"
        s += "<tr style='font-weight:bold;border-bottom:thin solid silver;border-top:thin solid silver;'><td>Rpt</td><td>" & sFinalized & "</td><td>" & sExpensed & "</td><td width='8%'>" & GetMessage(205) & "</td><td>" & sEmployee & "</td><td>" & IIf(AccType = "TP", "CC no.", GetMessage(245)) & "</td><td>" & GetMessage(268) & "</td>" & If(AccType = "TP", "<td>" & GetMessage(200) & "</td>", "") & "<td>" & sSupplier & "</td><td>" & sLinkedCat & "</td><td align='right'>Jur</td><td align='right'>" & sCredit & "</td><td align='right'>Balance</td></tr>"
        s += "<tr style='height:5px;'><td colspan='8'></td></tr>"

        If Not IsNothing(org.Expenses) Then
            For Each exp In org.Expenses
                'rpt = New Report(exp.ReportID)
                'emp = New Employee(rpt.EmpID)
                If exp.Account.Type = AccType Then
                    i += 1
                    'net = exp.AmountCDN - exp.ITC - exp.ITR + exp.RITC
                    total += exp.AmountCDN
                    s += "<tr style='border-bottom:thin solid silver;background-color:" & IIf(i Mod 2 = 0, "white", "white") & ";'>"
                    s += "<td width='4%'>R" & exp.Rpt.ReportNumberFormatted & "</td>"
                    s += "<td width='8%'>" & exp.Rpt.FinalizedDate & "</td>"
                    s += "<td width='8%'>" & exp.DateOfExpense & "</td>"
                    s += "<td width='6%'>" & exp.Rpt.Emp.EmpNum & "</td>"
                    s += "<td width='12%'>" & exp.Rpt.Emp.LastName & ", " & exp.Rpt.Emp.FirstName & "</td>"
                    If AccType = "TP" Then s += "<td width='5%'>" & exp.TPNum & "</td>"
                    s += "<td width='8%'>" & exp.Account.Number & "</td>"
                    s += "<td width='10%'>" & exp.TPName & "</td>"

                    s += "<td width='10%'>" & exp.SupplierName & "</td>"
                    s += "<td width='12%'>" & IIf(Session("emp").defaultlanguage = "English", exp.OrgCategory.Category.Name, exp.OrgCategory.Category.NameFR) & IIf(exp.OrgCategory.Note <> "", "--" & exp.OrgCategory.Note & "--", "") & "</td>"
                    s += "<td width='3%' align='right'>" & exp.Jurisdiction.Abbreviation & "</td>"
                    s += "<td width='8%' align='right'>" & FormatNumber(exp.AmountCDN, 2) & "</td>"
                    s += "<td  width='8%' align='right'>" & FormatNumber(total, 2) & "</td>"
                    s += "</tr>"
                End If

            Next
        End If
        s += "<tr style='height:2px;'><td colspan='" & IIf(AccType = "TP", 10, 8) & "' style='border-top:thin solid silver;'></td></tr>"
        s += "</table>"
        s = Replace(s, "numberofexpenses", i)


        If i = 0 Then s = ""

        exp = Nothing
        org = Nothing
    End Sub

    Private Sub DivisionReport()
        'Dim emp As Employee
        Dim i As Integer
        Dim div As String = ""

        If Not IsNothing(Request.QueryString("div")) Then div = Request.QueryString("div")

        AmtTotal = 0 : Amt = 0 : RITCTotalBC = 0 : RITCTotalOnt = 0 : RITCTotalPEI = 0

        GetStartEndDates()
        org.GetReports(dStartDate, dEndDate)

        s = ReportHeader(GetMessage(263) & " " & IIf(div = "", " all " & GetCustomTag("D") & "s", GetCustomTag("D") & " " & Request.QueryString("div")), "100%")

        s += "<table cellpadding='0' cellspacing='0' width='100%' border=0  style='font-size:smaller;border-collapse:collapse;'>"
        s += "<tr style='height:2px;'><td colspan='13' style='border-bottom:thin solid silver;'></td></tr>"
        s += "<tr style=' font-weight:bold;border-top:thin solid silver;border-bottom:thin solid silver;'><td>Rpt</td><td></td><td>" & GetMessage(78) & "</td><td>" & GetMessage(251) & "</td><td " & IIf(div = "", "", "style='display:none;'") & ">Division</td><td>" & GetMessage(60) & "</td><td align='left'>" & sName & "</td><td>Jur</td><td align='right'>" & GetMessage(45) & "</td><td align='right'>" & GetMessage(118) & "</td><td align='right'>" & GetMessage(119) & "</td>" & IIf(org.GSTReg And org.OrgSizeGST = 2, "<td align='right'>" & GetMessage(120) & "</td>", "") & "<td align='right'>Net</td><td align='right'>" & GetMessage(48) & "</td></tr>"

        If Not IsNothing(org.Reports) Then
            For Each rpt In org.Reports
                'emp = New Employee(rpt.EmpID)

                If rpt.Emp.DivCode = div Or div = "" Then
                    For Each Me.exp In rpt.Expenses
                        i += 1

                        ITC = exp.ITC
                        ITR = exp.ITR

                        Select Case exp.Jurisdiction.ID
                            Case 2 : RITCTotalOnt += exp.RITC
                            Case 10 : RITCTotalBC += exp.RITC
                            Case 4 : RITCTotalPEI += exp.RITC
                        End Select

                        Amt = exp.AmountCDN

                        s += "<tr style='border-bottom:thin solid silver;background-color:" & IIf(i Mod 2 = 0, "white", "white") & ";'>"
                        s += "<td width='4%'>R" & rpt.ReportNumberFormatted & "</td>"
                        s += "<td width='2%'>" & IIf(exp.ReceiptName <> "", "<a href='#' id='" & exp.ID & "' class='viewReceipt'><img src='../images/attachment2.png' width='20px' height='20px' border='0' /></a>", "") & "</td>"
                        s += "<td width='8%'>" & rpt.FinalizedDate & "</td>"
                        s += "<td width='8%'>" & exp.DateOfExpense & "</td>"
                        s += "<td width='8%' " & IIf(div = "", "", "style='display:none;'") & ">" & rpt.Emp.DivCode & "</td>"
                        s += "<td width='20%'>" & IIf(Session("emp").defaultlanguage = "English", exp.OrgCategory.Category.Name, exp.OrgCategory.Category.NameFR) & IIf(exp.OrgCategory.Note <> "", " -- " & exp.OrgCategory.Note & " -- ", "") & "</td>"
                        s += "<td align='left' width='15%'>" & rpt.Emp.LastName & ", " & rpt.Emp.FirstName & "</td>"
                        s += "<td align='right' width='2%'>" & exp.Jurisdiction.Abbreviation & "</td>"
                        s += "<td align='right' width='8%'>" & FormatNumber(Amt, 2) & "</td>"
                        s += "<td align='right' width='5%'>" & FormatNumber(ITC, 2) & "</td>"
                        s += "<td align='right' width='5%'>" & FormatNumber(ITR, 2) & "</td>"

                        If org.OrgSizeGST = 2 And org.GSTReg Then s += "<td align='right' width='5%'>" & FormatNumber(exp.RITC, 2) & "</td>"

                        s += "<td align='right' width='8%'>" & FormatNumber(Amt - ITC - ITR + exp.RITC, 2) & "</td>"
                        s += "<td align='right' width='20%'>" & exp.Comment & "</td>"
                        s += "</tr>"

                        AmtTotal += Amt
                        ITCTotal += ITC
                        ITRTotal += ITR
                        RITCTotal += exp.RITC
                        NetTotal += Amt - ITC - ITR + exp.RITC
                    Next
                End If

            Next
        End If

        s += "<tr style='font-weight:bold;border-top:thin solid silver;border-bottom:thin solid silver;'><td>Total</td><td " & IIf(div = "", "", "style='display:none;'") & "></td><td></td><td></td><td></td><td></td><td></td><td></td><td align='right' >" & FormatNumber(AmtTotal, 2) & "</td><td align='right' >" & FormatNumber(ITCTotal, 2) & "</td><td align='right' >" & FormatNumber(ITRTotal, 2) & "</td>" & IIf(org.GSTReg And org.OrgSizeGST = 2, "<td align='right' >" & FormatNumber(RITCTotal, 2) & "</td>", "") & "<td align='right' >" & FormatNumber(NetTotal, 2) & "</td><td></td></tr>"

        If RITCTotalOnt > 0 Then s += "<tr style='font-weight:bold;'><td colspan='3' >Total " & GetMessage(250) & "</td><td " & IIf(div = "", "", "style='display:none;'") & "></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td align='right'>" & FormatNumber(RITCTotalOnt, 2) & "</td><td></td><td></td></tr>"
        If RITCTotalBC > 0 Then s += "<tr style='font-weight:bold;'><td colspan='3'>Total " & GetMessage(249) & "</td><td " & IIf(div = "", "", "style='display:none;'") & "></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td align='right' >" & FormatNumber(RITCTotalBC, 2) & "</td><td></td><td></td></tr>"
        If RITCTotalPEI > 0 Then s += "<tr style='font-weight:bold;'><td colspan='3'>Total " & GetMessage(248) & "</td><td " & IIf(div = "", "", "style='display:none;'") & "></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td align='right' >" & FormatNumber(RITCTotalPEI, 2) & "</td><td></td><td></td></tr>"
        s += "</table>"
        s = Replace(s, "numberofitemstitle", GetMessage(261))
        s = Replace(s, "numberofitems", i)
        If i = 0 Then s = ""

        rpt = Nothing
        exp = Nothing
        org = Nothing
    End Sub



    Private Sub Project()
        Dim project As String = Request.QueryString("proj")
        Dim title As String

        AmtTotal = 0 : Amt = 0 : RITCTotalBC = 0 : RITCTotalOnt = 0 : RITCTotalPEI = 0

        GetStartEndDates()
        org.GetReports(dStartDate, dEndDate)

        title = GetMessage(263) & " " & IIf(project = "0", GetMessage(352), GetCustomTag("P") & " " & project)

        s = ReportHeader(title, "100%", "65%")

        s += "<table cellpadding='0' cellspacing='0' width='100%' border='0' style='border-collapse:collapse;font-size:smaller;'>"
        s += "<tr style='font-weight:bold;border-bottom:thin solid silver;border-top:thin solid silver;'><td>Rpt</td><td></td><td>" & GetMessage(78) & "</td><td>" & GetMessage(251) & "</td><td " & IIf(project = "0", "", "style='display:none;'") & ">" & GetCustomTag("P") & "</td><td>" & GetMessage(60) & "</td><td align='left' >" & sName & "</td><td width='2%' align='center' >Jur</td><td align='right' >" & sDebit & "</td></tr>"
        s += "<tr style='height:5px;'><td colspan='8'></td></tr>"

        If Not IsNothing(org.Reports) Then
            For Each rpt In org.Reports
                'emp = New Employee(rpt.EmpID)

                For Each exp In rpt.Expenses
                    If exp.Project = project Or (project = "0") Then
                        If Not IsDBNull(exp.Project) Then
                            If exp.Project <> "" Then
                                i += 1

                                ITC = exp.ITC
                                ITR = exp.ITR

                                Select Case exp.Jurisdiction.ID
                                    Case 2 : RITCTotalOnt += exp.RITC
                                    Case 10 : RITCTotalBC += exp.RITC
                                    Case 4 : RITCTotalPEI += exp.RITC
                                End Select

                                Amt = exp.AmountCDN

                                s += "<tr style='border-bottom:thin solid silver;background-color:" & IIf(i Mod 2 = 0, "white", "white") & ";'>"
                                s += "<td width='3%' align='left'>R" & rpt.ReportNumberFormatted & "</td>"
                                s += "<td width='1%'>" & IIf(exp.ReceiptName <> "", "<a href='#' id='" & exp.ID & "' class='viewReceipt'><img src='../images/attachment2.png' width='20px' height='20px' border='0' /></a>", "") & "</td>"
                                s += "<td width='5%'>" & rpt.FinalizedDate & "</td>"
                                s += "<td width='5%'>" & exp.DateOfExpense & "</td>"
                                s += "<td align='left' width='5%' " & IIf(project = "0", "", "style='display:none;'") & ">" & exp.Project & "</td>"
                                s += "<td width='15%'>" & IIf(Session("emp").defaultlanguage = "English", exp.OrgCategory.Category.Name, exp.OrgCategory.Category.NameFR) & IIf(exp.OrgCategory.Note <> "", " -- " & exp.OrgCategory.Note & " -- ", "") & "</td>"
                                s += "<td align='left' width='15%'>" & rpt.Emp.LastName & ", " & rpt.Emp.FirstName & "</td>"
                                s += "<td align='center' width='10px'>" & IIf(Session("emp").defaultlanguage = "English", exp.Jurisdiction.Abbreviation, exp.Jurisdiction.AbbreviationFR) & "</td>"
                                s += "<td align='right' width='8%'>" & FormatNumber(Amt - ITC - ITR + exp.RITC, 2) & "</td>"
                                s += "</tr>"

                                AmtTotal += Amt
                                ITCTotal += ITC
                                ITRTotal += ITR
                                RITCTotal += exp.RITC
                                NetTotal += Amt - ITC - ITR + exp.RITC
                            End If
                        End If
                    End If
                Next

            Next
        End If

        s += "<tr style='font-weight:bold;border-bottom:thin solid silver;border-top:thin solid silver;'><td colspan='3'>Total</td><td></td><td></td><td " & IIf(project = "0", "", "style='display:none;'") & "></td><td></td><td></td><td align='right' >" & FormatNumber(NetTotal, 2) & "</td></tr>"
        s += "</table>"

        s = Replace(s, "numberofitemstitle", GetMessage(261))
        s = Replace(s, "numberofitems", i)
        If i = 0 Then s = ""

        rpt = Nothing
        exp = Nothing
        org = Nothing
    End Sub


    Private Sub BySegment()
        Dim project As String = Request.QueryString("proj")
        Dim div As String = Request.QueryString("div")
        Dim cc As String = Request.QueryString("cc")
        Dim sAccSegment As String
        Dim title As String

        AmtTotal = 0 : Amt = 0 : RITCTotalBC = 0 : RITCTotalOnt = 0 : RITCTotalPEI = 0

        GetStartEndDates()
        org.GetReports(dStartDate, dEndDate)
        title = GetMessage(263) & " "
        title += IIf(org.Parent.AccSegment.Contains("P"), IIf(project = 0, GetMessage(352), GetCustomTag("P") & " " & project), "") & " "
        title += IIf(org.Parent.AccSegment.Contains("D"), IIf(div = 0, GetMessage(362), GetCustomTag("D") & " " & div), "") & " "
        title += IIf(org.Parent.AccSegment.Contains("C"), IIf(cc = 0, GetMessage(354), GetCustomTag("C") & " " & cc), "") & " "

        s = ReportHeader(title, "100%", "65%")

        s += "<table cellpadding='0' cellspacing='0' width='100%' border='0' style='border-collapse:collapse;font-size:smaller;'>"
        s += "<tr style='font-weight:bold;border-bottom:thin solid silver;border-top:thin solid silver;'><td>Rpt</td><td></td><td>" & GetMessage(78) & "</td><td>" & GetMessage(251) & "</td><td>" & sAccount & "</td><td>" & GetMessage(60) & "</td><td align='left' >" & sName & "</td><td width='2%' align='center' >Jur</td><td align='right' >" & sDebit & "</td></tr>"
        s += "<tr style='height:5px;'><td colspan='8'></td></tr>"

        If Not IsNothing(org.Reports) Then
            For Each rpt In org.Reports
                'emp = New Employee(rpt.EmpID)

                For Each exp In rpt.Expenses
                    If (exp.Project = project Or (project = 0)) And (rpt.Emp.DivCode = div Or (div = 0)) And (exp.CostCenter = cc Or (cc = 0)) Then
                        i += 1

                        ITC = exp.ITC
                        ITR = exp.ITR

                        Select Case exp.Jurisdiction.ID
                            Case 2 : RITCTotalOnt += exp.RITC
                            Case 10 : RITCTotalBC += exp.RITC
                            Case 4 : RITCTotalPEI += exp.RITC
                        End Select

                        Amt = exp.AmountCDN

                        s += "<tr style='border-bottom:thin solid silver;background-color:" & IIf(i Mod 2 = 0, "white", "white") & ";'>"
                        s += "<td width='3%' align='left'>R" & rpt.ReportNumberFormatted & "</td>"
                        s += "<td width='1%'>" & IIf(exp.ReceiptName <> "", "<a href='#' id='" & exp.ID & "' class='viewReceipt'><img src='../images/attachment2.png' width='20px' height='20px' border='0' /></a>", "") & "</td>"
                        s += "<td width='5%'>" & rpt.FinalizedDate & "</td>"
                        s += "<td width='5%'>" & exp.DateOfExpense & "</td>"

                        If org.Parent.AccSegment.IndexOf("D") = 0 Then sAccSegment = rpt.Emp.DivCode
                        If org.Parent.AccSegment.IndexOf("A") = 0 Then sAccSegment = exp.OrgCategory.GLAccount

                        If org.Parent.AccSegment.IndexOf("D") = 1 Then sAccSegment += " " & rpt.Emp.DivCode
                        If org.Parent.AccSegment.IndexOf("A") = 1 Then sAccSegment += " " & exp.OrgCategory.GLAccount
                        If org.Parent.AccSegment.IndexOf("P") = 1 Then sAccSegment += " " & exp.Project
                        If org.Parent.AccSegment.IndexOf("C") = 1 Then sAccSegment += " " & exp.CostCenter

                        If org.Parent.AccSegment.IndexOf("P") = 2 Then sAccSegment += " " & exp.Project
                        If org.Parent.AccSegment.IndexOf("C") = 2 Then sAccSegment += " " & exp.CostCenter

                        If org.Parent.AccSegment.IndexOf("P") = 3 Then sAccSegment += " " & exp.Project
                        If org.Parent.AccSegment.IndexOf("C") = 3 Then sAccSegment += " " & exp.CostCenter


                        s += "<td align='left' width='5%'>" & sAccSegment & "</td>"
                        s += "<td width='15%'>" & IIf(Session("emp").defaultlanguage = "English", exp.OrgCategory.Category.Name, exp.OrgCategory.Category.NameFR) & IIf(exp.OrgCategory.Note <> "", " -- " & exp.OrgCategory.Note & " -- ", "") & "</td>"
                        s += "<td align='left' width='15%'>" & rpt.Emp.LastName & ", " & rpt.Emp.FirstName & "</td>"
                        s += "<td align='center' width='10px'>" & IIf(Session("emp").defaultlanguage = "English", exp.Jurisdiction.Abbreviation, exp.Jurisdiction.AbbreviationFR) & "</td>"
                        s += "<td align='right' width='8%'>" & FormatNumber(Amt - ITC - ITR + exp.RITC, 2) & "</td>"
                        s += "</tr>"

                        AmtTotal += Amt
                        ITCTotal += ITC
                        ITRTotal += ITR
                        RITCTotal += exp.RITC
                        NetTotal += Amt - ITC - ITR + exp.RITC
                    End If
                Next
            Next
        End If

        s += "<tr style='font-weight:bold;border-bottom:thin solid silver;border-top:thin solid silver;'><td colspan='3'>Total</td><td></td><td></td><td></td><td></td><td></td><td align='right' >" & FormatNumber(NetTotal, 2) & "</td></tr>"
        s += "</table>"

        s = Replace(s, "numberofitemstitle", GetMessage(261))
        s = Replace(s, "numberofitems", i)
        If i = 0 Then s = ""

        rpt = Nothing
        exp = Nothing
        org = Nothing
    End Sub

    Private Sub CostCenter()
        Dim cc As String = Request.QueryString("cc")
        Dim title As String

        AmtTotal = 0 : Amt = 0 : RITCTotalBC = 0 : RITCTotalOnt = 0 : RITCTotalPEI = 0

        GetStartEndDates()
        org.GetReports(dStartDate, dEndDate)

        title = GetMessage(263) & " " & IIf(cc = "0", GetMessage(354), GetCustomTag("C") & " " & cc)

        s = ReportHeader(title, "100%", "65%")

        s += "<table cellpadding='0' cellspacing='0' width='100%' style='border-collapse:collapse;font-size:smaller;'>"
        s += "<tr style='font-weight:bold;border-bottom:thin solid silver;border-top:thin solid silver;'><td>Rpt</td><td></td><td>" & GetMessage(78) & "</td><td>" & GetMessage(251) & "</td><td " & IIf(cc <> "0", "style='display:none;'", "") & ">" & GetCustomTag("C") & "</td><td>" & GetMessage(60) & "</td><td align='left' >" & sName & "</td><td width='5%' align='center' >Jur</td><td align='right' >" & sDebit & "</td></tr>"
        s += "<tr style='height:5px;'><td colspan='9'></td></tr>"

        If Not IsNothing(org.Reports) Then
            For Each rpt In org.Reports
                'emp = New Employee(rpt.EmpID)

                For Each exp In rpt.Expenses
                    If exp.CostCenter = cc Or (cc = "0" And exp.CostCenter <> "") Then
                        i += 1

                        ITC = exp.ITC
                        ITR = exp.ITR

                        Select Case exp.Jurisdiction.ID
                            Case 2 : RITCTotalOnt += exp.RITC
                            Case 10 : RITCTotalBC += exp.RITC
                            Case 4 : RITCTotalPEI += exp.RITC
                        End Select

                        Amt = exp.AmountCDN

                        s += "<tr style='border-bottom:thin solid silver;background-color:" & IIf(i Mod 2 = 0, "white", "white") & ";'>"
                        s += "<td width='3%' align='left'>R" & rpt.ReportNumberFormatted & "</td>"
                        s += "<td width='1%'>" & IIf(exp.ReceiptName <> "", "<a href='#' id='" & exp.ID & "' class='viewReceipt'><img src='../images/attachment2.png' width='20px' height='20px' border='0' /></a>", "") & "</td>"
                        s += "<td width='7%'>" & rpt.FinalizedDate & "</td>"
                        s += "<td width='8%'>" & exp.DateOfExpense & "</td>"
                        s += "<td width='8%' " & IIf(cc <> "0", "style='display:none;'", "") & ">" & exp.CostCenter & "</td>"
                        s += "<td width='15%'>" & IIf(Session("emp").defaultlanguage = "English", exp.OrgCategory.Category.Name, exp.OrgCategory.Category.NameFR) & IIf(exp.OrgCategory.Note <> "", " -- " & exp.OrgCategory.Note & " -- ", "") & "</td>"
                        s += "<td align='left' width='15%'>" & rpt.Emp.LastName & ", " & rpt.Emp.FirstName & "</td>"
                        s += "<td align='center' width='2%'>" & IIf(Session("emp").defaultlanguage = "English", exp.Jurisdiction.Abbreviation, exp.Jurisdiction.AbbreviationFR) & "</td>"
                        s += "<td align='right' width='8%'>" & FormatNumber(Amt - ITC - ITR + exp.RITC, 2) & "</td>"
                        s += "</tr>"

                        AmtTotal += Amt
                        ITCTotal += ITC
                        ITRTotal += ITR
                        RITCTotal += exp.RITC
                        NetTotal += Amt - ITC - ITR + exp.RITC
                    End If
                Next
            Next
        End If
        s += "<tr style='font-weight:bold;border-bottom:thin solid silver;border-top:thin solid silver;'><td colspan='7'>Total</td><td " & IIf(cc <> "0", "style='display:none;'", "") & "></td><td align='right' >" & FormatNumber(NetTotal, 2) & "</td></tr>"
        s += "</table>"

        s = Replace(s, "numberofitemstitle", GetMessage(261))
        s = Replace(s, "numberofitems", i)
        If i = 0 Then s = ""

        rpt = Nothing
        exp = Nothing
        org = Nothing

    End Sub


    Private Sub WorkOrder()
        'Dim emp As Employee
        Dim wo As String = Request.QueryString("wo")
        Dim title As String

        AmtTotal = 0 : Amt = 0 : RITCTotalBC = 0 : RITCTotalOnt = 0 : RITCTotalPEI = 0

        GetStartEndDates()
        org.GetReports(dStartDate, dEndDate)

        If wo = "0" Then
            title = GetMessage(263) & " " & GetMessage(353)
        Else
            title = GetMessage(263) & " " & GetCustomTag("W") & " " & wo
        End If

        s = ReportHeader(title, "100%", "65%")

        s += "<table border=0 cellpadding='0' cellspacing='0' width='100%' style='border-collapse:collapse;font-size:smaller;'>"
        s += "<tr style='font-weight:bold;border-bottom:thin solid silver;border-top:thin solid silver;'><td>Rpt</td><td></td><td>" & GetMessage(78) & "</td><td>" & GetMessage(251) & "</td><td width='5%'>" & sAccount & "</td><td width='5%'></td><td width='5%'></td><td width='5%'></td><td " & IIf(wo <> "0", "style='display:none;'", "") & ">" & GetCustomTag("W") & "</td><td>" & GetMessage(60) & "</td><td>Emp</td><td align='left' >" & sName & "</td><td width='5%' align='center' >Jur</td><td align='right' >" & sDebit & "</td></tr>"
        s += "<tr style='height:5px;'><td colspan='9'></td></tr>"

        If Not IsNothing(org.Reports) Then
            For Each rpt In org.Reports
                'emp = New Employee(rpt.EmpID)

                For Each exp In rpt.Expenses
                    If exp.WorkOrder = wo Or (wo = "0" And exp.WorkOrder <> "") Then
                        i += 1

                        ITC = exp.ITC
                        ITR = exp.ITR

                        Select Case exp.Jurisdiction.ID
                            Case 2 : RITCTotalOnt = RITCTotalOnt + exp.RITC
                            Case 10 : RITCTotalBC = RITCTotalBC + exp.RITC
                            Case 4 : RITCTotalPEI = RITCTotalPEI + exp.RITC
                        End Select

                        Amt = exp.AmountCDN

                        s += "<tr style='border-bottom:thin solid silver;background-color:" & IIf(i Mod 2 = 0, "white", "white") & ";'>"
                        s += "<td width='3%' align='left'>R" & rpt.ReportNumberFormatted & "</td>"
                        s += "<td width='1%'>" & IIf(exp.ReceiptName <> "", "<a href='#' id='" & exp.ID & "' class='viewReceipt'><img src='../images/attachment2.png' width='20px' height='20px' border='0' /></a>", "") & "</td>"
                        s += "<td width='7%'>" & rpt.FinalizedDate & "</td>"
                        s += "<td width='7%'>" & exp.DateOfExpense & "</td>"


                        If org.Parent.AccSegment.IndexOf("D") = 0 Then s += "<td>" & rpt.Emp.DivCode & "</td>"
                        If org.Parent.AccSegment.IndexOf("A") = 0 Then s += "<td>" & exp.OrgCategory.GLAccount & "</td>"

                        If org.Parent.AccSegment.IndexOf("D") = 1 Then s += "<td>" & rpt.Emp.DivCode & "</td>"
                        If org.Parent.AccSegment.IndexOf("A") = 1 Then s += "<td>" & exp.OrgCategory.GLAccount & "</td>"
                        If org.Parent.AccSegment.IndexOf("P") = 1 Then s += "<td align='left' " & IIf(exp.Project = "", "width='5%'", "") & ">" & exp.Project & "</td>"
                        If org.Parent.AccSegment.IndexOf("C") = 1 Then s += "<td align='left' " & IIf(exp.CostCenter = "", "width='5%'", "") & ">" & exp.CostCenter & "</td>"

                        If org.Parent.AccSegment.IndexOf("P") = 2 Then s += "<td align='left' " & IIf(Right(org.Parent.AccSegment, 1) <> "P", "width='5%'", "") & ">" & exp.Project & "</td>"
                        If org.Parent.AccSegment.IndexOf("C") = 2 Then s += "<td align='left' " & IIf(Right(org.Parent.AccSegment, 1) <> "C", "width='5%'", "") & ">" & exp.CostCenter & "</td>"

                        If org.Parent.AccSegment.IndexOf("P") = 3 Then s += "<td align='left' " & IIf(exp.Project = "", "width='5%'", "") & ">" & exp.Project & "</td>"
                        If org.Parent.AccSegment.IndexOf("C") = 3 Then s += "<td align='left' " & IIf(exp.CostCenter = "", "width='5%'", "") & ">" & exp.CostCenter & "</td>"

                        If org.Parent.AccSegment.IndexOf("NNN") > 0 Then
                            s += "<td></td><td></td><td></td>"
                        ElseIf org.Parent.AccSegment.IndexOf("NN") > 0 Then
                            s += "<td></td><td></td>"
                        ElseIf org.Parent.AccSegment.IndexOf("N") > 0 Then
                            s += "<td></td>"
                        End If


                        s += "<td width='8%' " & IIf(wo <> "0", "style='display:none;'", "") & ">" & exp.WorkOrder & "</td>"
                        s += "<td width='20%'>" & IIf(Session("emp").defaultlanguage = "English", exp.OrgCategory.Category.Name, exp.OrgCategory.Category.NameFR) & IIf(exp.OrgCategory.Note <> "", " -- " & exp.OrgCategory.Note & " -- ", "") & "</td>"
                        s += "<td align='left' width='5%'>" & rpt.Emp.EmpNum & "</td>"
                        s += "<td align='left' width='15%'>" & rpt.Emp.LastName & ", " & rpt.Emp.FirstName & "</td>"
                        s += "<td align='center' width='2%'>" & IIf(Session("emp").defaultlanguage = "English", exp.Jurisdiction.Abbreviation, exp.Jurisdiction.AbbreviationFR) & "</td>"
                        s += "<td align='right' width='8%'>" & FormatNumber(Amt - ITC - ITR + exp.RITC, 2) & "</td>"
                        s += "</tr>"

                        AmtTotal += Amt
                        ITCTotal += ITC
                        ITRTotal += ITR
                        RITCTotal += exp.RITC
                        NetTotal += Amt - ITC - ITR + exp.RITC

                    End If
                Next
            Next
        End If

        s += "<tr style='font-weight:bold;border-bottom:thin solid silver;border-top:thin solid silver;'><td colspan='9'>Total</td><td " & IIf(wo <> "0", "style='display:none;'", "") & "></td><td></td><td></td><td></td><td align='right' >" & FormatNumber(NetTotal, 2) & "</td></tr>"
        s += "</table>"

        s = Replace(s, "numberofitemstitle", GetMessage(261))
        s = Replace(s, "numberofitems", i)
        If i = 0 Then s = ""

        rpt = Nothing
        exp = Nothing
        org = Nothing

    End Sub


    Private Sub GetStartEndDates()
        If Not IsNothing(Request.QueryString("p")) Then
            iPeriod = CInt(Request.QueryString("p"))
            iYear = CInt(Request.QueryString("yr"))
            pPeriodStart = New Period(org.Parent.ID, iPeriod, "Start")
            pPeriodEnd = New Period(org.Parent.ID, iPeriod, "End")
            dStartDate = New Date(iYear - pPeriodStart.SubtractYear, pPeriodStart.PeriodMonth, 1)
            dEndDate = New Date(iYear - pPeriodEnd.SubtractYear, pPeriodEnd.PeriodMonth, System.DateTime.DaysInMonth(iYear - pPeriodEnd.SubtractYear, pPeriodEnd.PeriodMonth))

        Else
            Dim yr As Integer = CInt(Right(Request.QueryString("start"), 4))
            Dim day As Integer = CInt(Left(Request.QueryString("start"), 2))
            Dim mo As Integer = CInt(Mid(Request.QueryString("start"), 4, 2))

            dStartDate = New Date(yr, mo, day)

            If Not IsNothing(Request.QueryString("end")) Then
                yr = CInt(Right(Request.QueryString("end"), 4))
                day = CInt(Left(Request.QueryString("end"), 2))
                mo = CInt(Mid(Request.QueryString("end"), 4, 2))

                dEndDate = New Date(yr, mo, day)
            End If
        End If
    End Sub

    Private Sub GetStartEndDates(p As Period, year As Integer)
        iYear = year
        pPeriodStart = New Period(p.OrgID, p.PeriodNum, "Start")
        pPeriodEnd = New Period(p.OrgID, p.PeriodNum, "End")
        dStartDate = New Date(iYear - pPeriodStart.SubtractYear, pPeriodStart.PeriodMonth, 1)
        dEndDate = New Date(iYear - pPeriodEnd.SubtractYear, pPeriodEnd.PeriodMonth, System.DateTime.DaysInMonth(iYear - pPeriodEnd.SubtractYear, pPeriodEnd.PeriodMonth))
    End Sub

    Private Sub SummaryCSV()
        Dim i As Integer
        Dim s As String
        Dim buffer() As Byte
        Dim memoryStream = New System.IO.MemoryStream
        Dim sAccSegment As String

        ITC = 0 : ITR = 0 : AmtTotal = 0 : RITCTotalBC = 0 : RITCTotalOnt = 0 : RITCTotalPEI = 0

        If Request.QueryString("rpt") = "" Then
            Dim oc As New OrgCat()
            org = New Org(orgID)

            GetStartEndDates()
            rpt = New Report
            org.GetReports(dStartDate, dEndDate)

            If Not IsNothing(org.Reports) Then
                a = oc.GetGLAccountTotals(orgID, dStartDate, dEndDate, org.Parent.AccSegment)
                s = "<accountspayable>" & vbCrLf
                If Not IsNothing(a) Then
                    For i = 0 To a.GetUpperBound(1)
                        If a(0, i) <> "" Then
                            If org.Parent.AccSegment.IndexOf("D") = 0 Then sAccSegment = a(5, i)
                            If org.Parent.AccSegment.IndexOf("A") = 0 Then sAccSegment = a(0, i)

                            If org.Parent.AccSegment.IndexOf("D") = 1 Then sAccSegment += " " & a(5, i)
                            If org.Parent.AccSegment.IndexOf("A") = 1 Then sAccSegment += " " & a(0, i)
                            If org.Parent.AccSegment.IndexOf("P") = 1 Then sAccSegment += " " & a(6, i)
                            If org.Parent.AccSegment.IndexOf("C") = 1 Then sAccSegment += " " & a(7, i)

                            If org.Parent.AccSegment.IndexOf("P") = 2 Then sAccSegment += " " & a(6, i)
                            If org.Parent.AccSegment.IndexOf("C") = 2 Then sAccSegment += " " & a(7, i)

                            If org.Parent.AccSegment.IndexOf("P") = 3 Then sAccSegment += " " & a(6, i)
                            If org.Parent.AccSegment.IndexOf("C") = 3 Then sAccSegment += " " & a(7, i)

                            s += """" & Request.QueryString("p") & """,""" & Format(dEndDate, "yyyyMMdd") & """"
                            s += ",""" & sAccSegment & """,""D"",""" & Replace(FormatNumber(CDec(a(1, i)) - CDec(a(2, i)) - CDec(a(3, i)) + CDec(a(4, i)), 2).ToString, ",", "") & """"
                            AmtTotal = AmtTotal + CDec(CDec(a(1, i)) - CDec(a(2, i)) - CDec(a(3, i)) + CDec(a(4, i)))
                            ITC = ITC + CDec(a(2, i))
                            ITR = ITR + CDec(a(3, i))
                        End If
                        s += vbCrLf
                    Next
                End If

                RITCTotalBC = oc.GetRITCTotals(orgID, 10, dStartDate, dEndDate)
                RITCTotalOnt = oc.GetRITCTotals(orgID, 2, dStartDate, dEndDate)
                RITCTotalPEI = oc.GetRITCTotals(orgID, 4, dStartDate, dEndDate)

                If ITC > 0 Then s += """" & Request.QueryString("p") & """,""" & Format(dEndDate, "yyyyMMdd") & """" & ",""" & org.Parent.ITCAccount & """,""D"",""" & FormatNumber(ITC, 2) & """" & vbCrLf
                If ITR > 0 Then s += """" & Request.QueryString("p") & """,""" & Format(dEndDate, "yyyyMMdd") & """" & ",""" & org.Parent.ITRAccount & """,""D"",""" & FormatNumber(ITR, 2) & """" & vbCrLf
                If RITCTotalOnt > 0 Then s += """" & Request.QueryString("p") & """,""" & Format(dEndDate, "yyyyMMdd") & """" & ",""" & org.Parent.ritcONAccount & """,""C"",""" & FormatNumber(RITCTotalOnt, 2) & """" & vbCrLf
                If RITCTotalBC > 0 Then s += """" & Request.QueryString("p") & """,""" & Format(dEndDate, "yyyyMMdd") & """" & ",""" & org.Parent.ritcBCAccount & """,""C"",""" & FormatNumber(RITCTotalBC, 2) & """" & vbCrLf
                If RITCTotalPEI > 0 Then s += """" & Request.QueryString("p") & """,""" & Format(dEndDate, "yyyyMMdd") & """" & ",""" & org.Parent.ritcPEIAccount & """,""C"",""" & FormatNumber(RITCTotalPEI, 2) & """" & vbCrLf

                s = Replace(s, "<accountspayable>", """" & Request.QueryString("p") & """,""" & Format(dEndDate, "yyyyMMdd") & """" & ",""" & org.Parent.AccountPayable & """,""C"",""" & Replace(FormatNumber(AmtTotal + ITC + ITR - RITCTotalBC - RITCTotalOnt - RITCTotalPEI, 2).ToString, ",", "") & """")
            End If

        Else
            '    Dim oc As New OrgCat()
            '    rpt = New Report(CInt(Request.QueryString("rpt")))
            '    Dim emp As New Employee(rpt.EmpID)
            '    Dim p As Period
            '    p = New Period(orgID, rpt.FinalizedDate.Month)

            '    s.Add(emp.Organization.Name & IIf(emp.Organization.Code <> "", " (" & emp.Organization.Code & ")", ""))
            '    s.Add(GetMessage(241 ) & " - " & rpt.Name)
            '    s.Add(emp.LastName & ", " & emp.FirstName & IIf(emp.EmpNum <> "", " - " & emp.EmpNum, "") & IIf(emp.DivCode <> "", " " & GetMessage(208 ) & " - " & emp.DivCode, ""))
            '    s.Add(GetMessage(125 ) & ": " & Format(Now, "MMMM dd, yyyy"))
            '    s.Add(GetMessage(78 ) & ": " & Format(rpt.FinalizedDate, "MMMM dd, yyyy"))
            '    s.Add(GetMessage(237 ) & ": " & rpt.FinalizedDate.Year + p.SubtractYear & " " & GetMessage(244 ) & ": " & p.PeriodNum)
            '    s.Add("")
            '    xls.Header = s

            '    table.Columns.Add(GetMessage(245 ))
            '    table.Columns.Add(GetMessage(246 ))
            '    table.Columns.Add(GetMessage(247 ))
            '    'table.Columns.Add( emp.Organization.AccountPayable

            '    a = oc.GetGLAccountTotals(rpt.ID)

            '    If Not IsNothing(a) Then
            '        For i = 0 To a.GetUpperBound(1)
            '            table.Rows.Add(a(0, i), FormatNumber(a(1, i) - a(2, i) - a(3, i) + a(4, i), 2))

            '            AmtTotal = AmtTotal + CDec(a(1, i) - a(2, i) - a(3, i) + a(4, i))
            '            ITC = ITC + a(2, i)
            '            ITR = ITR + a(3, i)
            '        Next
            '    End If

            '    RITCTotalBC = oc.GetRITCTotals(rpt.ID, 10)
            '    RITCTotalOnt = oc.GetRITCTotals(rpt.ID, 2)
            '    RITCTotalPEI = oc.GetRITCTotals(rpt.ID, 4)

            '    i += 9

            '    If ITC > 0 Then
            '        table.Rows.Add(o.ITCAccount, FormatNumber(ITC, 2))
            '        i += 1
            '    End If

            '    If ITR > 0 Then
            '        table.Rows.Add(o.ITRAccount, FormatNumber(ITR, 2))
            '        i += 1
            '    End If

            '    If RITCTotalOnt > 0 Then
            '        table.Rows.Add(o.ritcONAccount, "", FormatNumber(RITCTotalOnt, 2))
            '        i += 1
            '    End If

            '    If RITCTotalBC > 0 Then
            '        table.Rows.Add(o.ritcBCAccount, "", FormatNumber(RITCTotalBC, 2))
            '        i += 1
            '    End If

            '    If RITCTotalPEI > 0 Then
            '        table.Rows.Add(o.ritcPEIAccount, "", FormatNumber(RITCTotalPEI, 2))
            '        i += 1
            '    End If

            '    table.Rows.Add("Total", FormatNumber(AmtTotal + ITC + ITR, 2))
            '    iCreditTotal1 = i


            '    '////////////////////////////////////////////////////////////////////////////////////////////////////////////
            '    a = oc.GetCategoryTotals(rpt.ID)

            '    i += 2
            '    table.Rows.Add(GetMessage(60 ), GetMessage(246 ), GetMessage(247 ))

            '    i += 1
            '    table.Rows.Add(GetMessage(236 ), "", FormatNumber(AmtTotal + ITC + ITR - RITCTotalBC - RITCTotalOnt - RITCTotalPEI, 2))

            '    ii = i + 1
            '    For i = 0 To a.GetUpperBound(1)
            '        table.Rows.Add(a(0, i), FormatNumber(a(1, i) - a(2, i) - a(3, i) + a(4, i), 2))
            '    Next

            '    pPeriodEnd = Nothing
            '    pPeriodStart = Nothing
            '    i = i + ii

            'End If

            ''i += 1

            'If AmtTotal > 0 Then
            '    If ITC > 0 Then
            '        table.Rows.Add(GetMessage(118 ), FormatNumber(ITC, 2))
            '        i += 1
            '    End If

            '    If ITR > 0 Then
            '        table.Rows.Add(GetMessage(119 ), FormatNumber(ITR, 2))
            '        i += 1
            '    End If

            '    If RITCTotalOnt > 0 Then
            '        table.Rows.Add(GetMessage(250 ), "", FormatNumber(RITCTotalOnt, 2))
            '        i += 1
            '    End If

            '    If RITCTotalBC > 0 Then
            '        table.Rows.Add(GetMessage(249 ), "", FormatNumber(RITCTotalBC, 2))
            '        i += 1
            '    End If

            '    If RITCTotalPEI > 0 Then
            '        table.Rows.Add(GetMessage(248 ), "", FormatNumber(RITCTotalPEI, 2))
            '        i += 1
            '    End If

            '    'ii += 1
            '    table.Rows.Add("Total", FormatNumber(AmtTotal + ITC + ITR, 2), FormatNumber(AmtTotal + ITC + ITR, 2))
            '    'oSheet.Range("C" & iCreditTotal1).Value = FormatNumber(AmtTotal + ITC + ITR, 2)

            '    buffer = Encoding.Default.GetBytes(s)
            '    memoryStream.Write(buffer, 0, buffer.Length)
            '    Response.Clear()
            '    Response.AddHeader("Content-Disposition", "attachment; filename=test.csv")
            '    Response.AddHeader("Content-Length", memoryStream.Length.ToString())
            '    Response.ContentType = "text/plain"
            '    memoryStream.WriteTo(Response.OutputStream)
            '    Response.End()

        End If

        buffer = Encoding.Default.GetBytes(s)
        memoryStream.Write(buffer, 0, buffer.Length)
        Response.Clear()
        Response.AddHeader("Content-Disposition", "attachment; filename=" & Request.QueryString("rptName") & ".csv")
        Response.AddHeader("Content-Length", memoryStream.Length.ToString())
        Response.ContentType = "text/plain"
        memoryStream.WriteTo(Response.OutputStream)
        Response.End()
    End Sub

    Private Sub DetailedITC()
        'Dim emp As Employee
        Dim balance As Double, totalDT As Double
        Dim credit As Boolean

        AmtTotal = 0 : Amt = 0 : RITCTotalBC = 0 : RITCTotalOnt = 0 : RITCTotalPEI = 0

        GetStartEndDates()
        org.GetReports(dStartDate, dEndDate, , "")

        s = ReportHeader(GetMessage(341) & " - " & org.Parent.ITCAccount, "100%")

        s += "<table width='100%' cellspacing='0'  style='font-size:smaller;border-collapse:collapse;' >"
        s += "<tr style='font-weight:bold;'><td width='5%'style='border-bottom:thin solid silver;border-top:thin solid silver;'>Rpt</td><td width='8%' style='border-bottom:thin solid silver;border-top:thin solid silver;'>" & GetMessage(78) & "</td><td width='15%' style='border-bottom:thin solid silver;border-top:thin solid silver;'>" & sEmployee & "</td><td width='30%' style='border-bottom:thin solid silver;border-top:thin solid silver;'>" & sCategory & "</td><td width='5%' style='border-bottom:thin solid silver;border-top:thin solid silver;'>Jur</td><td width='10%' align='right' style='border-bottom:thin solid silver;border-top:thin solid silver;'>" & sDebit & "</td><td align='right' width='10%' style='border-bottom:thin solid silver;border-top:thin solid silver;'>Balance</td></tr>"
        s += "<tr style='height:2px;'><td colspan='7' style='border-top:thin solid silver;'></td></tr>"
        s += "<tr style='height:5px;'><td colspan='7'></td></tr>"

        i = 0
        If Not IsNothing(org.Reports) Then
            For Each rpt In org.Reports
                'emp = New Employee(rpt.EmpID)

                For Each exp In rpt.Expenses
                    If exp.ITC > 0 Then
                        s += "<tr style='border-bottom:thin solid silver;background-color:" & IIf(i Mod 2 = 0, "white", "white") & ";'>"
                        s += "<td>R" & rpt.ReportNumberFormatted & "</td>"
                        s += "<td>" & rpt.FinalizedDate & "</td>"
                        s += "<td width='20%'>" & rpt.Emp.LastName & ", " & rpt.Emp.FirstName & "</td>"
                        s += "<td width='30%'>" & IIf(Session("emp").defaultlanguage = "English", exp.OrgCategory.Category.Name, exp.OrgCategory.Category.NameFR) & IIf(exp.OrgCategory.Note <> "", "--" & exp.OrgCategory.Note & "--", "") & "</td>"
                        s += "<td>" & exp.Jurisdiction.Abbreviation & "</td>"
                        s += "<td align='right'>" & FormatNumber(exp.ITC, 2) & "</td>"

                        balance += exp.ITC
                        totalDT += exp.ITC

                        credit = False
                        s += "<td  align='right'>" & FormatNumber(Math.Abs(balance), 2) & IIf(credit, " CR", " DT") & "</td>"
                        s += "</tr>"
                        i += 1
                    End If
                Next
            Next
        End If

        s += "<tr><td colspan='7' style='border-top:thin solid silver;'>&nbsp;</td></tr>"
        s += "</table>"

        s = Replace(s, "numberofitemstitle", GetMessage(261))
        s = Replace(s, "numberofitems", i)

        If i = 0 Then s = ""
        rpt = Nothing
    End Sub

    Private Sub DetailedITR()
        'Dim emp As Employee
        Dim balance As Double, totalDT As Double
        Dim credit As Boolean


        AmtTotal = 0 : Amt = 0 : RITCTotalBC = 0 : RITCTotalOnt = 0 : RITCTotalPEI = 0
        GetStartEndDates()
        org.GetReports(dStartDate, dEndDate, , "")

        s = ReportHeader(GetMessage(342) & " " & org.Parent.ITRAccount, "100%")

        s += "<table cellpadding='0' cellspacing='0' width='100%' border=0  style='font-size:smaller;border-collapse:collapse;'>"
        s += "<tr style='font-weight:bold;'><td width='5%' style='border-bottom:thin solid silver;border-top:thin solid silver;'>Rpt</td><td width='8%' style='border-bottom:thin solid silver;border-top:thin solid silver;'>" & GetMessage(78) & "</td><td width='15%' style='border-bottom:thin solid silver;border-top:thin solid silver;'>" & sEmployee & "</td><td width='30%' style='border-bottom:thin solid silver;border-top:thin solid silver;'>" & sCategory & "</td><td width='5%' style='border-bottom:thin solid silver;border-top:thin solid silver;'>Jur</td><td width='10%' align='right' style='border-bottom:thin solid silver;border-top:thin solid silver;'>" & sDebit & "</td><td align='right' width='10%' style='border-bottom:thin solid silver;border-top:thin solid silver;'>Balance</td></tr>"
        s += "<tr style='height:5px;'><td colspan='7'></td></tr>"

        i = 0
        If Not IsNothing(org.Reports) Then

            For Each rpt In org.Reports
                'emp = New Employee(rpt.EmpID)

                For Each exp In rpt.Expenses
                    If exp.ITR > 0 Then
                        s += "<tr style='border-bottom:thin solid silver;background-color:" & IIf(i Mod 2 = 0, "white", "white") & ";'>"
                        s += "<td>R" & rpt.ReportNumberFormatted & "</td>"
                        s += "<td>" & rpt.FinalizedDate & "</td>"
                        s += "<td>" & rpt.Emp.LastName & ", " & rpt.Emp.FirstName & "</td>"
                        s += "<td width='30%'>" & IIf(Session("emp").defaultlanguage = "English", exp.OrgCategory.Category.Name, exp.OrgCategory.Category.NameFR) & IIf(exp.OrgCategory.Note <> "", "--" & exp.OrgCategory.Note & "--", "") & "</td>"
                        s += "<td>" & exp.Jurisdiction.Abbreviation & "</td>"
                        s += "<td align='right'>" & FormatNumber(exp.ITR, 2) & "</td>"
                        balance += exp.ITR
                        totalDT += exp.ITR

                        credit = False
                        s += "<td  align='right'>" & FormatNumber(Math.Abs(balance), 2) & IIf(credit, " CR", " DT") & "</td>"
                        s += "</tr>"

                        i += 1
                    End If
                Next
            Next
        End If

        s += "<tr><td colspan='7' style='border-top:thin solid silver;'>&nbsp;</td></tr>"
        s += "</table>"

        s = Replace(s, "numberofitemstitle", GetMessage(261))
        s = Replace(s, "numberofitems", i)
        If i = 0 Then s = ""

    End Sub

    Private Sub DetailedRITC(jurID As Integer)
        'Dim emp As Employee
        Dim balance As Double, totalDT As Double
        Dim credit As Boolean


        AmtTotal = 0 : Amt = 0 : RITCTotalBC = 0 : RITCTotalOnt = 0 : RITCTotalPEI = 0
        GetStartEndDates()

        org.GetReports(dStartDate, dEndDate, , "")

        s = ReportHeader(GetMessage(IIf(jurID = 2, 343, 344)) & " " & IIf(jurID = 2, org.Parent.ritcONAccount, RITCTotalPEI), "100%")
        s += "<table cellpadding='0' cellspacing='0' width='100%' border=0  style='font-size:smaller;border-collapse:collapse;'>"
        s += "<tr style='font-weight:bold;'><td width='5%' style='border-top:thin solid silver;border-bottom:thin solid silver;'>Rpt</td><td width='8%' style='border-top:thin solid silver;border-bottom:thin solid silver;'>" & GetMessage(78) & "</td><td width='15%' style='border-top:thin solid silver;border-bottom:thin solid silver;'>" & sEmployee & "</td><td width='30%' style='border-top:thin solid silver;border-bottom:thin solid silver;'>" & sCategory & "</td><td width='5%' style='border-top:thin solid silver;border-bottom:thin solid silver;'>Jur</td><td align='right'  width='10%' style='border-top:thin solid silver;border-bottom:thin solid silver;'>" & sCredit & "</td><td align='right'  width='10%' style='border-top:thin solid silver;border-bottom:thin solid silver;'>Balance</td></tr>"

        i = 0
        If Not IsNothing(org.Reports) Then
            For Each rpt In org.Reports
                'emp = New Employee(rpt.EmpID)

                For Each exp In rpt.Expenses
                    If exp.RITC > 0 And exp.Jurisdiction.ID = jurID Then
                        s += "<tr style='border-bottom:thin solid silver;background-color:" & IIf(i Mod 2 = 0, "white", "white") & ";'>"
                        s += "<td>R" & rpt.ReportNumberFormatted & "</td>"
                        s += "<td>" & rpt.FinalizedDate & "</td>"
                        s += "<td>" & rpt.Emp.LastName & ", " & rpt.Emp.FirstName & "</td>"
                        s += "<td width='30%'>" & IIf(Session("emp").defaultlanguage = "English", exp.OrgCategory.Category.Name, exp.OrgCategory.Category.NameFR) & "</td>"
                        s += "<td>" & exp.Jurisdiction.Abbreviation & "</td>"
                        s += "<td align='right'>" & FormatNumber(exp.RITC, 2) & "</td>"
                        balance += exp.RITC
                        totalDT += exp.RITC

                        credit = True
                        s += "<td  align='right'>" & FormatNumber(Math.Abs(balance), 2) & IIf(credit, " CR", " DT") & "</td>"
                        s += "</tr>"

                        i += 1
                    End If
                Next
            Next
        End If

        s += "<tr><td colspan='7' style='border-top:thin solid silver;'>&nbsp;</td></tr>"
        s += "</table>"

        s = Replace(s, "numberofitemstitle", GetMessage(261))
        s = Replace(s, "numberofitems", i)
        If i = 0 Then s = ""
    End Sub

    Protected Overrides Sub Finalize()
        MyBase.Finalize()
    End Sub

    Private Sub cmdCSV_Click(sender As Object, e As System.Web.UI.ImageClickEventArgs) Handles cmdCSV.Click
        Select Case Request.QueryString("type")
            Case 2 : SummaryCSV()
            Case 21 : SummaryDetailedCSV()

        End Select

    End Sub

    Private Sub cmdTSV_Click(sender As Object, e As System.Web.UI.ImageClickEventArgs) Handles cmdTSV.Click
        Select Case Request.QueryString("type")
            Case 2 : SummaryCSV()
            Case 21 : SummaryDetailedCSV(True)
        End Select

    End Sub
End Class