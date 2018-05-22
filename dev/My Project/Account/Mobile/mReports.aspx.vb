Imports System.Data
Imports System.Data.SqlClient
Imports System.Configuration
Imports System.IO
Imports System.Net




Partial Public Class mReports
    Inherits System.Web.UI.Page

    Dim blnSubmit As Boolean
    Dim ExpenseID As Integer
    Dim linenum As Integer
    Public isSubmitted As Boolean = False


    Private Sub mReports_Error(sender As Object, e As System.EventArgs) Handles Me.Error
        'If IsNothing(Session("error")) Then Session("error") = GetMessage(273) & " - " & linenum : Session("msgHeight") = 50
        'Response.Redirect("../../mobile/mlogin.aspx")
    End Sub


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim rpt As New Report
        Dim i As Single
        Dim d As New Description

        If IsNothing(Session("emp")) Then Response.Redirect("../../mobile/mlogin.aspx")

        If Not IsNothing(Request.QueryString("action")) Then
            If Request.QueryString("action") = "receitdeleted" Then
                Session("msg") = "Receipt was deleted"
                Response.Redirect(Request.Path)
            End If
        End If

        Try
            GetConnectionString()
            CheckLanguage()

            Session("selectedEmp") = Session("emp").id.ToString
            Session("currentpage") = "mReports.aspx"

            hdnOrgID.Value = Session("emp").OrgID
            txtEmpID.Text = Session("emp").id
            txtSuperID.Text = Session("emp").ID
            hdnLoggedInEmpID.Value = Session("emp").ID
            hdnPUK.Value = Membership.GetUser(Session("emp").username.ToString).ProviderUserKey.ToString

            If Not IsPostBack Then
                gvReports.SelectedIndex = 0
                hdnReportID.Value = rpt.ID
                labelReportName.Text = IIf(rpt.ID <> 0, " - ", "") & rpt.Name
            End If
            gvReports.DataSourceID = "sqlReportsByEmpID"
            gvReports.DataBind()
            InitializeReportGrid()
            gvExpenses.DataBind()
            Dim parameter As New System.Web.UI.WebControls.Parameter("EmpID", Data.DbType.Int32)
            parameter.DefaultValue = txtEmpID.Text
            sqlReportsByEmpID.SelectParameters.Add(parameter)
            

            Translate()
            Translate2()
            
        Catch ex As Exception
            'Session("Error") = IIf(Session("emp").isadvalorem, ex.Message, GetMessage(273 ))

        Finally
            If Not IsNothing(Session("error")) Then Response.Redirect("/error.aspx")

            rpt = Nothing
            d = Nothing
        End Try
        Response.Cache.SetCacheability(HttpCacheability.NoCache)
        Response.Cache.SetExpires(DateTime.UtcNow.AddHours(-1))
        Response.Cache.SetNoStore()
        Response.Cache.SetNoServerCaching()


    End Sub




    Private Sub gvReports_PageIndexChanged(sender As Object, e As System.EventArgs) Handles gvReports.PageIndexChanged
        gvReports.SelectedIndex = -1
        gvExpenses.SelectedIndex = -1
    End Sub

    Private Sub gvreports_RowDataBound(sender As Object, e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles gvReports.RowDataBound
        e.Row.Cells(0).Attributes.Add("title", "Select")
    End Sub

    Protected Sub gvreports_SelectedIndexChanged(ByVal sender As Object, ByVal e As EventArgs) Handles gvReports.SelectedIndexChanged
        Dim rpt As New Report(gvReports.SelectedDataKey.Value)

        txtStatusID.Text = rpt.Status
        labelReportName.Text = " - " & rpt.Name
        hdnReportID.Value = gvReports.SelectedDataKey.Value

        rpt = Nothing

        gvExpenses.SelectedIndex = -1
    End Sub


    <System.Web.Services.WebMethod()>
    Public Shared Function DeleteExpense(expID As Integer, puk As String) As Integer
        Dim exp As New Expense(expID)
        Return exp.Delete(puk)
        exp = Nothing
    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Sub DeleteReport(rptID As Integer, puk As String)
        Dim rpt As New Report(rptID)

        rpt.Delete(puk)

        rpt = Nothing
    End Sub


    Private Sub gvExpenses_SelectedIndexChanged(sender As Object, e As System.EventArgs) Handles gvExpenses.SelectedIndexChanged
        ExpenseID = gvExpenses.SelectedValue
    End Sub


    <System.Web.Services.WebMethod()>
    Public Shared Function GetOtherExpenseDetails(expID As Integer) As String
        Dim exp As New Expense(expID)
        Dim resp As String
        Dim s As String

        resp = "<tr><td colspan='20'>"

        If Not IsDBNull(exp.Attendees) And exp.Attendees <> "" Then
            s = Replace(exp.Attendees, "<", "")
            s = Replace(s, ">", "")

            If resp <> "<tr><td colspan='20'>" Then resp = resp & "<br />"
            resp = resp & "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Attendees: " & s

        End If

        If Not IsDBNull(exp.Comment) And exp.Comment <> "" Then
            s = Replace(exp.Comment, "<", "")
            s = Replace(s, ">", "")

            If resp <> "<tr><td colspan='20'>" Then resp = resp & "<br />"
            resp = resp & "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Comment: " & s

        End If

        resp = resp & "</td></tr>"
        exp = Nothing


        Return resp
    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function GetReportTotalsEmp() As Array
        Dim r As New Report()
        Dim e As New Employee(Membership.GetUser().UserName)

        GetReportTotalsEmp = r.GetReportTotalsEmp(e.ID)

        r = Nothing
    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function ApproveReport(rptID As Integer, puk As String) As String
        Dim r As New Report(rptID)

        Return r.Approve(puk)

        r = Nothing
    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function FinalizeReport(rptID As Integer, puk As String) As String
        Dim r As New Report(rptID)

        Return r.FinalizeReport(puk)

        r = Nothing
    End Function


    <System.Web.Services.WebMethod()>
    Public Shared Function RejectReport(rptID As Integer, reason As String, puk As String) As String
        Dim r As New Report(rptID)

        r.ReasonRejected = reason
        Return r.Reject(puk)

        r = Nothing
    End Function


    <System.Web.Services.WebMethod()>
    Public Shared Function SubmitReport(rptID As Integer, puk As String) As Dictionary(Of String, String)
        Dim r As New Report(rptID)

        Return r.Submit(puk)

        r = Nothing
    End Function


    <System.Web.Services.WebMethod()>
    Public Shared Function GetDates(rptID As Integer, puk As String) As String
        Dim r As New Report(rptID)
        Dim s As String
        Dim approvedby As String = ""
        Dim rejectedby As String = ""
        Dim finalizedby As String = ""
        Dim e As Employee
        Dim loggedInUser As Employee

        Try
            If puk = Membership.GetUser.ProviderUserKey.ToString Then
                loggedInUser = New Employee(Membership.GetUser.UserName)
                e = New Employee(r.EmpID)

                If loggedInUser.ID = e.ID Or loggedInUser.ID = e.Supervisor Or loggedInUser.ID = e.DelegatedTo Or loggedInUser.Organization.ID = e.ID Or (loggedInUser.Organization.Parent.ID = e.Organization.Parent.ID And loggedInUser.IsAdmin) Then
                    e = Nothing

                    If Not IsDBNull(r.FinalizedBy) Then
                        If r.FinalizedBy > 0 Then
                            e = New Employee(r.FinalizedBy)
                            finalizedby = e.FirstName & " " & e.LastName
                            e = Nothing
                        End If
                    End If

                    If Not IsDBNull(r.RejectedBy) Then
                        If r.RejectedBy > 0 Then
                            e = New Employee(r.RejectedBy)
                            rejectedby = e.FirstName & " " & e.LastName
                            e = Nothing
                        End If
                    End If

                    s = "<br><table width='100%' border=0>"
                    s = s & "<tr style='height:20px;'><td rowspan='10' valign='top'><img src='../images/calendar2.png' /></td><td></td><td width='125px' class='labelText'>Created:</td><td class='labelText' align='right'>" & r.CreatedDate & "</td></tr>"
                    '<td class='labelText'>Approved:</td><td class='labelText' align='right'>" & r.ApprovedDate & "</td></tr><tr><td></td><td class='labelText'>Approved By:</td><td class='labelText' align='right'>" & approvedby & "</td></tr>

                    Select Case r.Status
                        'Case 3 : s = s & "<tr style='height:20px;'><td></td><td class='labelText' width='125px'>Submitted:</td><td class='labelText' align='right'>" & r.SubmittedDate & "</td></tr><tr><td></td><td class='labelText'>Approved:</td><td class='labelText' align='right'>" & r.ApprovedDate & "</td></tr><tr><td></td><td class='labelText'>Approved By:</td><td class='labelText' align='right'>" & approvedby & "</td></tr>"
                        Case 4 : s = s & "<tr style='height:20px;'><td></td><td class='labelText' width='125px'>Submitted:</td><td class='labelText' align='right'>" & r.SubmittedDate & "</td></tr><tr><td></td><tr><td></td><td class='labelText'>Finalized:</td><td class='labelText' align='right'>" & r.FinalizedDate & " </td></tr><tr><td></td><td class='labelText'>Finalized By:</td><td class='labelText' align='right'>" & finalizedby & "</td></tr>"
                        Case 5 : s = s & "<tr style='height:20px;'><td></td><td class='labelText' width='125px'>Submitted:</td><td class='labelText' align='right'>" & r.SubmittedDate & "</td></tr><tr><td></td><td class='labelText'>Rejected:</td><td class='labelText' align='right'>" & r.RejectedDate & "</td></tr><tr><td class='labelText'>Rejected By:</td><td align='right'>" & rejectedby & "</td></tr>"
                    End Select

                    s = s & "</table>"
                Else
                    Throw New Exception
                End If
            Else
                Throw New Exception
            End If

        Catch ex As Exception
            Throw ex

        Finally
            r = Nothing
            loggedInUser = Nothing
            e = Nothing
        End Try

        Return s

    End Function

    
    Private Sub cmdAttachFile_Click(sender As Object, e As System.EventArgs) Handles cmdAttachFile.Click

        Dim i = UploadFile(FileUpload2, hdnExpenseID.Value)

        Select Case i
            Case 0 : Session("alert") = "There was an error while uploading your file"
            Case 1 : GetMessage(138)
            Case 2 : Session("alert") = "File was not uploaded. File cannot be larger than 5MB"
        End Select

        gvexpenses.DataBind()
    End Sub


    Private Sub Page_LoadComplete(sender As Object, e As System.EventArgs) Handles Me.LoadComplete
        Dim rpt As New Report

        If Request.QueryString("msg") = "submitted" Then
            Session("msg") = GetMessage(284)
            Response.Redirect("mreports.aspx")

        ElseIf Request.QueryString("msg") = "finalized" Then
            Session("msg") = "Report has been finalized"
            Response.Redirect("mreports.aspx?e=1")

        ElseIf Request.QueryString("msg") = "rejected" Then
            Session("msg") = "Report has been rejected"
            Response.Redirect("mreports.aspx?e=1")

        End If

        If Request.QueryString("e") <> 1 And Not IsPostBack Then
            rpt.GetOpenReport(Session("selectedEmp"))
            hdnOpenReport.Value = rpt.Status = 1
            If hdnOpenReport.Value = True Then labelReportName.Text = IIf(rpt.ID <> 0, " - " & rpt.Name, "")
            hdnReportID.Value = rpt.ID
            txtStatusID.Text = rpt.Status
            If rpt.ID > 0 Then
                If Not IsNothing(rpt.Expenses) Then
                    If rpt.Expenses.Count >= 25 Then
                        Session("msg") = "Adding expenses has been disabled for this report. You have reached the maximum of 25 expenses per report."
                        Session("msgHeight") = "60px"
                    End If
                End If
            End If

        End If

        rpt = Nothing

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
                'For Each childcc In childc.controls
                'If TypeOf childcc Is ContentPlaceHolder Then
                'For Each childccc In childc.controls
                If TypeOf childc Is Label Then
                    If childc.id Like "lbl*" Then
                        id = Replace(childc.id, "_", "")
                        childc.text = d.GetDescription(CInt(Replace(id, "lbl", "")), Left(Session("language"), 1))
                    End If

                ElseIf TypeOf childc Is GridView Then
                    For Each col In childc.columns
                        col.headertext = d.GetDescription(CInt(col.headertext), Left(Session("language"), 1))
                    Next
                End If
            Next
            'End If
            'Next
            'Next
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


    Private Sub Translate2()
        hdnLanguage.Value = Session("language")
        hdnSubmitMessage.Value = GetMessage(126)
        hdnSubmitTitle.Value = GetMessageTitle(126)
        hdnDeleteRptMsg.Value = GetMessage(128)
        hdnDeleteRptTitle.Value = GetMessageTitle(128)
        hdnDeleteExpMsg.Value = GetMessage(137)
        hdnDeleteExpTitle.Value = GetMessageTitle(137)
        gvReports.EmptyDataText = GetMessage(107)
        gvExpenses.EmptyDataText = GetMessage(132)
        hdnSubmitTooltip.Value = GetMessage(240)
        hdnAddExpTooltip.Value = GetMessage(131)
        hdnEditTooltip.Value = GetMessage(109)
        hdnSelectTooltip.Value = GetMessage(108)
        hdnViewExpRptTooltip.Value = GetMessage(110)
        hdnExpDataEntryTooltip.Value = GetMessage(75)
        hdnFinalizeMessage.Value = GetMessage(321)
        hdnFinalizeTitle.Value = GetMessage(144)
        hdnCancelText.Value = GetMessage(142)
    End Sub

    Private Sub InitializeReportGrid()
        If Not IsPostBack Then
            txtEmpID.Text = Session("emp").id
            Dim SqlDataSource1 As New SqlDataSource
            SqlDataSource1.ID = "SqlDataSource1"
            Me.Page.Controls.Add(SqlDataSource1)
            SqlDataSource1.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings("dbadvaloremConnStr").ConnectionString
            SqlDataSource1.SelectCommand = "Select REPORT_NAME from tblReport Where EMP_ID=@var"
            SqlDataSource1.SelectParameters.Add("@var", System.TypeCode.String, txtEmpID.Text)
            gvReports.DataSource = SqlDataSource1
            gvReports.DataBind()

        End If

    End Sub

End Class