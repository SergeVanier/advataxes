Imports System.Data
Imports System.Data.SqlClient
Imports System.Configuration
Imports System.IO
Imports System.Net




Partial Public Class Reports
    Inherits System.Web.UI.Page

    Dim blnSubmit As Boolean
    Dim ExpenseID As Integer


    Private Sub Reports_Error(sender As Object, e As System.EventArgs) Handles Me.Error
        'On Error Resume Next

        'Response.Redirect("../error.aspx")
    End Sub



    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim rpt As New Report
        Dim i As Single
        Dim d As New Description

        Try
            GetConnectionString()

            If IsNothing(Session("selectedEmp")) Then
                Session("selectedEmp") = Session("emp").id
            Else
                If cboDelegate.SelectedValue = "" Then
                    If Session("selectedEmp").ToString = "" Then Session("selectedEmp") = Session("emp").id
                Else
                    Session("selectedEmp") = cboDelegate.SelectedValue
                End If

            End If


            If Request.QueryString("e") <> 1 Then
                Session("currentpage") = "Reports.aspx"
            Else
                Session("currentpage") = "Reports.aspx?e=1"
            End If

            If IsNothing(Session("emp")) Then
                FormsAuthentication.SignOut()
                Response.Redirect("../login.aspx")
            End If

            If Not Session("emp").Activated Then
                Session("emp") = Nothing
                Session("msg") = "Your account hasn't been activated yet.<br><br>To activate your account, please click the link that was sent to the email address you used to create your account."
                FormsAuthentication.SignOut()
                Response.Redirect("../error.aspx")

            ElseIf Not Session("emp").active Then
                Session("emp") = Nothing
                Session("msg") = "<table border='0'><tr rowspan='2'><td><table><tr style='height:40px;'><td class='labelText' style='font-size:1.6em;'>Your account has been suspended.</td></tr><tr><td class='labelText' valign='top' style='height:50px;'>Contact your administrator to have your account reactivated.</td></tr></table></td></tr></table>"
                FormsAuthentication.SignOut()
                Response.Redirect("../error.aspx")

            ElseIf Session("emp").organization.accountstatus = 1 Then
                If DateAdd(DateInterval.Day, 30, Session("emp").organization.createdDate) < Now Then
                    Session("emp") = Nothing
                    Session("msg") = "<table border='0'><tr rowspan='2'><td><table><tr style='height:40px;'><td class='labelText' style='font-size:1.6em;'>Your 30 day trial has expired.</td></tr><tr><td class='labelText' valign='top' style='height:50px;'>   </td></tr></table></td></tr></table>"
                    FormsAuthentication.SignOut()
                    Response.Redirect("../error.aspx")
                End If
            End If

            translate()

            hdnOrgID.Value = Session("emp").OrgID
            txtEmpID.Text = Session("emp").id
            txtSuperID.Text = Session("emp").ID
            GridView2.DataBind()

            If IsPostBack Then GridView1.DataBind()

            If Request.QueryString("e") <> 1 Then

                rpt.GetOpenReport(Session("selectedEmp"))
                hdnOpenReport.Value = rpt.Status = 1
                If cboStatus.SelectedIndex = 1 Then labelReportName.Text = IIf(rpt.ID <> 0, " - " & rpt.Name, "")
                hdnReportID.Value = rpt.ID
                txtStatusID.Text = rpt.Status
                'hdnReportDate.Value = rpt.CreatedDate
                'If cboStatus.SelectedIndex = 1 Then txtExpDate.Text = rpt.CreatedDate
                'cmdNew.Visible = rpt.Status = 0

            End If

            cboEmp.Visible = Session("emp").IsSupervisor And Request.QueryString("e") = 1

            If Request.QueryString("e") = 1 And Not IsPostBack Then
                hdnReportID.Value = ""
                lbl73.Visible = True 'employee
                cboStatus.Items.RemoveAt(0)
                cboStatus.Items.Remove("Open")
                txtEmpID.Text = ""
                GridView1.DataSourceID = "SQLDataSource6"

                cboStatus.Items(0).Text = GetMessage(106, Session("language"))
                cboStatus.Items(1).Text = GetMessage(78, Session("language"))
                cboEmp.Items(0).Text = GetMessage(104, Session("language"))
                'GridView1.Columns.Item(2).ItemStyle.Width = 150

                'Dim r As New Report
                'lblPendingApproval.Text = "Pending Approval: " & r.GetPendingCount(CInt(txtSuperID.Text))
                'r = Nothing

            ElseIf Not IsPostBack Then

                cboStatus.SelectedIndex = 1
                GridView1.SelectedIndex = 0
                hdnReportID.Value = rpt.ID

                cmdEdit.Visible = rpt.Status = 1 Or rpt.Status = 5
                labelReportName.Text = IIf(rpt.ID <> 0, " - ", "") & rpt.Name
                'hdnReportDate.Value = rpt.CreatedDate
                'txtExpDate.Text = rpt.CreatedDate
                GridView1.DataSourceID = "SqlDatasource1"

                cboStatus.Items(0).Text = GetMessage(104, Session("language"))
                cboStatus.Items(1).Text = GetMessage(105, Session("language"))
                cboStatus.Items(2).Text = GetMessage(106, Session("language"))
                cboStatus.Items(3).Text = GetMessage(78, Session("language"))
            End If

            If Request.QueryString("e") <> 1 Then
                Select Case cboStatus.SelectedIndex
                    Case 0 : GridView1.Columns(5).HeaderText = "Date" : GridView1.Columns(5).SortExpression = "LAST_DATE"
                    Case 1 : GridView1.Columns(5).HeaderText = d.GetDescription(77, Left(Session("language"), 1)) : GridView1.Columns(5).SortExpression = "CREATED_DATE"
                    Case 2 : GridView1.Columns(5).HeaderText = d.GetDescription(58, Left(Session("language"), 1)) : GridView1.Columns(5).SortExpression = "SUBMITTED_DATE"
                        'Case 3 : GridView1.Columns(5).HeaderText = "Approved" : GridView1.Columns(5).SortExpression = "APPROVED_DATE"
                    Case 3 : GridView1.Columns(5).HeaderText = d.GetDescription(78, Left(Session("language"), 1)) : GridView1.Columns(5).SortExpression = "FINALIZED_DATE"
                End Select

                GridView1.Columns(3).Visible = False
                GridView1.Columns(7).Visible = False
                GridView1.Columns(8).Visible = False
                GridView1.Columns(10).Visible = False

                GridView1.Columns(1).Visible = cboStatus.SelectedIndex < 2
                GridView1.Columns(9).Visible = cboStatus.SelectedIndex < 2

                GridView2.Columns(1).Visible = cboStatus.SelectedIndex < 2
                GridView2.Columns(13).Visible = cboStatus.SelectedIndex < 2
            Else
                GridView1.Columns(3).Visible = True
                GridView1.Columns(10).Visible = cboStatus.SelectedIndex = 0
                GridView1.Columns(9).Visible = False
                GridView2.Columns(13).Visible = False

                Select Case cboStatus.SelectedIndex
                    Case 0 : GridView1.Columns(10).Visible = True : GridView1.Columns(8).Visible = True : GridView1.Columns(7).Visible = True : GridView1.Columns(5).HeaderText = d.GetDescription(58, Left(Session("language"), 1))
                        'Case 1 : GridView1.Columns(7).Visible = True : GridView1.Columns(8).Visible = False : GridView1.Columns(5).HeaderText = "Approved"
                    Case 1 : GridView1.Columns(8).Visible = False : GridView1.Columns(7).Visible = False : GridView1.Columns(5).HeaderText = d.GetDescription(78, Left(Session("language"), 1))
                End Select
                GridView1.Columns(1).Visible = False
            End If

            GridView1.Columns(8).Visible = False

            For i = 0.01 To 0.99 Step 0.01
                cboRate.Items.Add(FormatNumber(i, 2))
            Next

            hdnLanguage.Value = Session("language")

            hdnSubmitMessage.Value = GetMessage(126, Session("language"))
            hdnSubmitTitle.Value = GetMessageTitle(126, Session("language"))

            hdnDeleteRptMsg.Value = GetMessage(128, Session("language"))
            hdnDeleteRptTitle.Value = GetMessageTitle(128, Session("language"))

            hdnDeleteExpMsg.Value = GetMessage(137, Session("language"))
            hdnDeleteExpTitle.Value = GetMessageTitle(137, Session("language"))

            GridView1.EmptyDataText = GetMessage(132, Session("language"))
            GridView2.EmptyDataText = GetMessage(107, Session("language"))

            cboTaxIE.Items(0).Text = GetMessage(135, Session("language"))
            cboTaxIE.Items(1).Text = GetMessage(136, Session("language"))
            hdnSubmitTooltip.Value = GetMessage(240, Session("language"))
            hdnAddExpTooltip.Value = GetMessage(131, Session("language"))
            hdnEditTooltip.Value = GetMessage(109, Session("language"))
            hdnSelectTooltip.Value = GetMessage(108, Session("language"))
            hdnViewExpRptTooltip.Value = GetMessage(110, Session("language"))
            hdnExpDataEntryTooltip.Value = GetMessage(75, Session("language"))
            hdnFinalizeMessage.Value = GetMessage(321, Session("language"))
            hdnFinalizeTitle.Value = GetMessage(144, Session("language"))
            hdnCancelText.Value = GetMessage(142, Session("language"))
            'cboDelegate.Items(0).Text = GetMessage(228, Session("language"))
            cmdSaveExpense.Text = GetMessage(140, Session("language"))
            cmdSaveExpense2.Text = GetMessage(141, Session("language"))
            cmdCancel.Text = GetMessage(142, Session("language"))
            cmdSaveReport.Text = GetMessage(140, Session("language"))

            If Session("language") = "English" Then
                cboCat.DataTextField = "CAT_NAME"
            Else
                cboCat.DataTextField = "CAT_NAME_FR"
            End If

        Catch ex As Exception
            Session("Error") = ex.Message
            Response.Redirect("~/error.aspx")

        Finally
            rpt = Nothing
            d = Nothing
        End Try

    End Sub

    Private Sub LoadRates()
        GetConnectionString()
        Dim sqlConn = New SqlConnection(connString.ConnectionString)
        sqlConn.Open()
        'DBConnect()

        Dim com As SqlCommand = New SqlCommand("GetAirTaxRates", sqlConn)
        Dim rs As SqlDataReader

        com.CommandType = CommandType.StoredProcedure

        com.Connection = sqlConn
        rs = com.ExecuteReader


        cboTaxRate.Items.Clear()
        cboTaxRate.Items.Add("")
        While rs.Read
            cboTaxRate.Items.Add(rs("TR_DESCRIPTION"))
            cboTaxRate.Items(cboTaxRate.Items.Count - 1).Value = rs("JUR_ID")
        End While

        rs.Close()
        com.Dispose()
        sqlConn.Close()
    End Sub


    Private Sub GridView1_PageIndexChanged(sender As Object, e As System.EventArgs) Handles GridView1.PageIndexChanged
        GridView1.SelectedIndex = -1
        GridView2.SelectedIndex = -1

        cmdEdit.Visible = False
        'cmdDelete.Visible = False
        'cmdSubmit.Visible = False

        cmdDeleteExp.Visible = False
        cmdEditExp.Visible = False


    End Sub

    Private Sub GridView1_RowDataBound(sender As Object, e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GridView1.RowDataBound
        e.Row.Cells(0).Attributes.Add("title", "Select")
        'If e.Row.RowType = DataControlRowType.DataRow Then
        '    e.Row.Attributes.Add("onmouseover", "this.style.cursor='pointer';")
        '    'e.Row.Attributes.Add("onmouseout", "this.style.backgroundColor='';")

        '    e.Row.Attributes.Add("onclick", Page.ClientScript.GetPostBackEventReference(sender, "Select$" + e.Row.RowIndex.ToString))
        'End If
    End Sub

    Protected Sub GridView1_SelectedIndexChanged(ByVal sender As Object, ByVal e As EventArgs) Handles GridView1.SelectedIndexChanged
        Dim rpt As New Report(GridView1.SelectedDataKey.Value)

        txtStatusID.Text = rpt.Status
        labelReportName.Text = " - " & rpt.Name
        hdnReportID.Value = GridView1.SelectedDataKey.Value
        'hdnReportDate.Value = rpt.CreatedDate

        'cmdNew.Visible = Request.QueryString("e") <> 1
        cmdEdit.Visible = rpt.Status = 1 Or rpt.Status = 5  'Open/rejected


        rpt = Nothing

        GridView2.SelectedIndex = -1
    End Sub


    <System.Web.Services.WebMethod()>
    Public Shared Sub DeleteExpense(expID As Integer)
        Dim exp As New Expense()

        exp.ID = expID
        exp.Delete()
        exp = Nothing

    End Sub

    <System.Web.Services.WebMethod()>
    Public Shared Sub DeleteReport(rptID As Integer)
        Dim rpt As New Report()

        rpt.ID = rptID
        rpt.Delete()
        rpt = Nothing

    End Sub


    Private Sub cmdEdit_Click(sender As Object, e As System.EventArgs) Handles cmdEdit.Click
        'blnEdit = True
        txtReportName.Text = GridView1.SelectedRow.Cells(1).Text
        ModalPopupExtender2.Show()

    End Sub



    Public Sub CreateExpense()
        Dim exp As New Expense
        Dim oc As New OrgCat(hdnOrgCatID.Value)
        Dim d As New Date(Right(txtExpDate.Text, 4), Mid(txtExpDate.Text, 4, 2), Left(txtExpDate.Text, 2))
        Dim r As Report
        Dim ParentOrg As Org
        Dim o As Org
        Dim emp As Employee
        Dim amt As Decimal
        Dim curr As Currency

        modalProcessing.Show()
        Try

            exp.ReportID = GridView1.SelectedValue
            r = New Report(exp.ReportID)
            emp = New Employee(r.EmpID)
            If IsNothing(emp.Organization.ParentOrg) Then
                ParentOrg = New Org(emp.Organization.ID)
            Else
                ParentOrg = New Org(emp.Organization.ParentOrg.ID)
            End If

            o = New Org(emp.Organization.ID)

            exp.OrgCategory.ID = hdnOrgCatID.Value
            exp.OrgCategory.Category.ID = oc.Category.ID

            If oc.Category.ID = 5 Then
                exp.Jurisdiction.ID = cboTaxRate.SelectedValue
            Else
                exp.Jurisdiction.ID = cboJur.SelectedValue
            End If

            exp.CurrID = cboCurr.SelectedValue
            curr = New Currency(exp.CurrID)
            exp.TaxStatus = IIf(hdnCatID.Value = 1 Or hdnCatID.Value = 2 Or hdnCatID.Value = 4 Or hdnCatID.Value = 6 Or hdnCatID.Value = 7 Or hdnCatID.Value = 8 Or hdnCatID.Value = 12 Or hdnCatID.Value = 13 Or hdnCatID.Value = 14 Or hdnCatID.Value = 47 Or hdnCatID.Value = 41, 1, cboTaxIE.SelectedValue)
            exp.SupplierName = txtSupplier.Text
            exp.Gratuities = 0
            exp.Rate = 1           
            If txtGrat.Text <> "" Then exp.Gratuities = CSng(txtGrat.Text)
            exp.Comment = txtComment.Text
            exp.DateOfExpense = d

            If hdnGST.Value <> "" Then exp.GSTPaid = CSng(hdnGST.Value)
            'If txtHST.Text <> "" Then exp.HSTPaid = CSng(txtHST.Text)
            If hdnQST.Value <> "" Then exp.QSTPaid = CSng(hdnQST.Value)

            If oc.Category.ID = 4 And oc.AllowanceAmt > 0 Then
                exp.Rate = CSng(oc.AllowanceAmt)
                txtAmt.Text = CSng(exp.Rate) * CSng(txtKM.Text)
            Else
                If cboRate.SelectedValue <> "" And cboRate.SelectedValue <> "0" Then exp.Rate = CSng(cboRate.SelectedValue)
            End If

            If oc.Category.IsAllowance And oc.Category.ID <> 4 Then
                exp.Amount = oc.AllowanceAmt
            Else
                exp.Amount = IIf(exp.TaxStatus = 1, CSng(txtAmt.Text), CSng(txtAmt.Text) + exp.GSTPaid + exp.QSTPaid)
            End If

            amt = IIf(exp.CurrID <> 25, ((exp.Amount + exp.Gratuities) * curr.GetExchangeRate(exp.DateOfExpense, exp.DateOfExpense)), exp.Amount + exp.Gratuities)
            exp.AmountCDN = IIf(exp.CurrID <> 25, amt + (amt * ParentOrg.InterestRate), amt)

            exp.RITC = FormatNumber(exp.OrgCategory.Category.GetRITC(exp.Jurisdiction.ID, Session("emp").Organization.OrgSizeGST, exp.DateOfExpense) * exp.GSTPaid * ParentOrg.GetCRAactualRatio("GST", exp.DateOfExpense, ParentOrg.GetCRA("GST", exp.DateOfExpense)), 2)

            If exp.OrgCategory.Category.ID = 4 Then
                Select Case exp.Jurisdiction.ID
                    Case 2 : exp.RITC = exp.RITC * o.kmON
                    Case 10 : exp.RITC = exp.RITC * o.kmBC
                    Case 4 : exp.RITC = exp.RITC * o.kmPEI
                End Select
            End If

            exp.ITC = FormatNumber(exp.OrgCategory.Category.GetITC(exp.Jurisdiction.ID, Session("emp").Organization.OrgSizeGST, exp.DateOfExpense) * exp.GSTPaid * ParentOrg.GetCRAactualRatio("GST", exp.DateOfExpense, ParentOrg.GetCRA("GST", exp.DateOfExpense)), 2)
            exp.ITR = FormatNumber(exp.OrgCategory.Category.GetITR(exp.Jurisdiction.ID, Session("emp").Organization.OrgSizeQST, exp.DateOfExpense) * exp.QSTPaid * ParentOrg.GetCRAactualRatio("QST", exp.DateOfExpense, ParentOrg.GetCRA("QST", exp.DateOfExpense)), 2)
            exp.Reimburse = Not chkDontReimburse.Checked


            If txtExpenseID.Text = 0 Then
                exp.Create()
                exp.ID = exp.GetLastID(hdnReportID.Value)
            Else
                exp.ID = CInt(txtExpenseID.Text)
                exp.Update()
            End If

            UploadFile(FileUpload1, exp.ID)

            Session("msg") = GetMessage(138, Session("language"))

            If hdnUnlockGST.Value = "Yes" Then
                CreateAuditTrail("", "Unlock GST", 0, Session("emp").id)
                hdnUnlockGST.Value = "No"
            End If

            If hdnUnlockQST.Value = "Yes" Then
                CreateAuditTrail("", "Unlock QST", 0, Session("emp").id)
                hdnUnlockQST.Value = "No"
            End If


        Catch e As Exception
            Session("ERROR") = e.Message
            Response.Redirect("../error.aspx")

        Finally
            txtExpenseID.Text = 0
            GridView2.DataBind()
            exp = Nothing
            oc = Nothing
            ParentOrg = Nothing
            o = Nothing
            curr = Nothing
            emp = Nothing
            modalProcessing.Hide()
        End Try

    End Sub


    Private Sub cboStatus_SelectedIndexChanged(sender As Object, e As System.EventArgs) Handles cboStatus.SelectedIndexChanged
        hdnReportID.Value = ""
        GridView1.SelectedIndex = -1
        GridView2.DataBind()
        cmdEdit.Visible = False
        labelReportName.Text = ""

        If cboStatus.SelectedIndex = 1 And Request.QueryString("e") = "" Then
            Dim rpt As New Report

            rpt.GetOpenReport(Session("selectedEmp"))
            txtStatusID.Text = rpt.Status
            GridView1.SelectedIndex = 0
            hdnReportID.Value = rpt.ID
            cmdEdit.Visible = rpt.Status = 1 Or rpt.Status = 5
            rpt = Nothing

        ElseIf cboStatus.SelectedIndex <> 1 And Request.QueryString("e") = "" Then
            txtStatusID.Text = "0"
        End If

    End Sub

    Private Sub GridView2_SelectedIndexChanged(sender As Object, e As System.EventArgs) Handles GridView2.SelectedIndexChanged
        ExpenseID = GridView2.SelectedValue

        cmdEditExp.Visible = GridView1.SelectedRow.Cells(3).Text = "Open"
        cmdDeleteExp.Visible = GridView1.SelectedRow.Cells(3).Text = "Open"

    End Sub


    Private Sub cmdEditExp_Click(sender As Object, e As System.EventArgs) Handles cmdEditExp.Click

        Dim exp As New Expense(CInt(txtExpenseID.Text))

        'Me.txtExpenseID.Text = GridView2.SelectedValue
        cboCat.SelectedValue = exp.OrgCategory.Category.ID
        cboJur.SelectedValue = exp.Jurisdiction.ID
        cboCurr.Text = exp.CurrID
        txtSupplier.Text = exp.SupplierName
        cboRate.Text = String.Format("{0:F2}", exp.Rate)
        txtGrat.Text = String.Format("{0:F2}", exp.Gratuities)
        txtAmt.Text = String.Format("{0:F2}", exp.Amount)
        txtComment.Text = exp.Comment

        exp = Nothing
        'txtExpenseID.Visible = False
        'ModalPopupExtender4.Show()

    End Sub


    Public Sub Cancel()
        txtExpenseID.Text = 0
    End Sub


    Public Sub CloseModal()
        ModalPopupExtender2.Hide()
    End Sub


    'Private Sub Button2_Click(sender As Object, e As System.EventArgs) Handles Button2.Click
    '    ModalPopupExtender1.Hide()
    'End Sub

    Private Sub cmdApprove_Click(sender As Object, e As System.Web.UI.ImageClickEventArgs) Handles cmdApprove.Click
        Dim r As New Report

        r.ID = CInt(GridView1.SelectedDataKey.Value)
        r.Approve()
        r = Nothing

        cmdApprove.Visible = False
        GridView1.DataBind()
        GridView1.SelectedIndex = -1
    End Sub

    Private Sub cboEmp_SelectedIndexChanged(sender As Object, e As System.EventArgs) Handles cboEmp.SelectedIndexChanged
        If cboEmp.SelectedItem.Text = "All" Then
            Response.Redirect("reports.aspx?e=1")
            'GridView1.DataSourceID = "SqlDatasource6"

        Else
            GridView1.DataSourceID = "SqlDatasource7"
            'txtEmpID.Text = cboEmp.SelectedValue.ToString
        End If

        hdnReportID.Value = ""

        GridView1.SelectedIndex = -1
        GridView2.SelectedIndex = -1
    End Sub

    <System.Web.Services.WebMethod()>
    Public Shared Function GetOtherExpenseDetails(expID As Integer) As String
        Dim exp As New Expense(expID)
        Dim resp As String
        Dim s As String

        resp = "<tr><td colspan='20'>"

        'If Not IsDBNull(exp.Gratuities) Then If exp.OrgCategory.Category.AllowGratuity Then resp = resp & "Gratuity: " & FormatNumber(exp.Gratuities, 2)

        'If resp <> "<tr><td colspan='10'>" Then resp = resp & "<br />"
        'If exp.Rate > 0 Then
        'If resp <> "<tr><td colspan='20'>" Then resp = resp & "<br />"
        'resp = resp & "Rate: " & FormatNumber(exp.Rate, 2)
        'End If

        'If exp.Rate > 0 Then resp = resp & "<br /># of KM: " & CInt(exp.Amount / exp.Rate)

        If Not IsDBNull(exp.Comment) And exp.Comment <> "" Then
            s = Replace(exp.Comment, "<", "")
            s = Replace(s, ">", "")

            If resp <> "<tr><td colspan='20'>" Then resp = resp & "<br />"
            resp = resp & "Comment: " & s
            
        End If

        'If Not IsDBNull(exp.Receipt) And exp.Receipt <> "" Then
        '    If resp <> "<tr><td colspan='10'>" Then resp = resp & "<br />"

        '    s = "javascript:popup('../uploads/" & exp.Receipt & "')"
        '    resp = resp & "<a href=""" & s & """>View Receipt</a>"
        'End If

        resp = resp & "</td></tr>"
        exp = Nothing
        'rs.Close()
        'com.Dispose()
        'sqlConn.Close()

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
    Public Shared Sub ApproveReport(rptID As Integer, lang As String)
        Dim r As New Report(rptID)
        Dim exp As Expense
        Dim u As MembershipUser
        Dim s As String
        Dim emp As Employee
        Dim amt As Double, onbehalf As Double
        Dim o As Org

        emp = New Employee(r.EmpID)
        r.Approve()

        o = New Org(emp.Organization.ID)

        For Each exp In r.Expenses
            If exp.Reimburse Then
                amt += exp.AmountCDN
            Else
                onbehalf += exp.AmountCDN
            End If

        Next

        u = Membership.GetUser(emp.Username)

        s = emp.FirstName & " " & emp.LastName & ", <br><br>"
        s = s & "Your expense report (" & r.Name & ") has been approved on " & Format(Now, "dd/MM/yyyy") & ".<br><br>"
        s = s & "Amount: " & FormatNumber(amt + onbehalf, 2) & " $ CAD<br>"

        If onbehalf > 0 Then
            s = s & "Paid on behalf of employee: " & FormatNumber(onbehalf, 2) & " $ CAD<br>"
            s = s & "Amount to reimburse: " & FormatNumber(amt, 2) & " $ CAD<br>"
        End If
        's = Replace(s, "(Name)", emp.FirstName & " " & emp.LastName)
        's = Replace(s, "(reportname)", r.Name)
        's = Replace(s, "(amount)", FormatNumber(amt + onbehalf, 2) & " $ CAD")
        's = Replace(s, "(onbehalf)", FormatNumber(onbehalf, 2) & " $ CAD")
        's = Replace(s, "(reimburse)", FormatNumber(amt - onbehalf, 2) & " $ CAD")
        's = Replace(s, "(date)", Format(Now, "dd/MM/yyyy"))
        's = Replace(s, "(finalizedBy)", approver.FirstName & " " & approver.LastName)

        s = s & "<br>You can consult  www.advataxes.ca to view the details in My Expenses.<br><br>"
        s = s & "Should you have any questions, do not hesitate to contact us at info@advalorem.ca<br><br><br><br>"
        s = s & "This message is confidential, may be privileged and is intended for the above-named recipient(s) only. If you have received this message in error, please notify us at info.advataxes.ca  and delete this message from your system. Any unauthorized use or disclosure of this message is strictly prohibited."
        s = s & "AdValorem Inc. assumes no responsibility for errors, inaccuracies or omissions in this report, and does not warrant the accuracy or completeness of the information contained. Ad Valorem Inc.  shall not be liable for any special, indirect, incidental, or consequential damages that may result from this report."

        SendEmail(emp.Email, "Advataxes: Your report has been approved", s, lang)

        o = Nothing
        u = Nothing
        emp = Nothing
        exp = Nothing
        r = Nothing
    End Sub

    <System.Web.Services.WebMethod()>
    Public Shared Sub FinalizeReport(rptID As Integer, lang As String)
        Dim r As New Report(rptID)
        Dim exp As Expense
        Dim u As MembershipUser
        Dim s As String
        Dim emp As Employee
        Dim approver As Employee
        Dim amt As Double, onbehalf As Double
        Dim o As Org
        Dim d As New Description(29)
        Dim itc As Double, itr As Double, ritcBC As Double, ritcON As Double, ritcPEI As Double

        r.FinalizeReport()
        emp = New Employee(r.EmpID)
        approver = New Employee(emp.Supervisor)
        o = New Org(emp.Organization.ID)

        For Each exp In r.Expenses
            If exp.Reimburse Then
                amt += exp.AmountCDN
            Else
                onbehalf += exp.AmountCDN
            End If

            itc += exp.ITC
            itr += exp.ITR
            If exp.Jurisdiction.ID = 10 Then ritcBC += exp.RITC
            If exp.Jurisdiction.ID = 2 Then ritcON += exp.RITC
            If exp.Jurisdiction.ID = 4 Then ritcPEI += exp.RITC

        Next



        If o.ITCAccount <> "" And itc > 0 Then r.UpdateDebitCredit("DT", o.ITCAccount, itc)
        If o.ITRAccount <> "" And itr > 0 Then r.UpdateDebitCredit("DT", o.ITRAccount, itr)
        If o.ritcBCAccount <> "" And ritcBC > 0 Then r.UpdateDebitCredit("CR", o.ritcBCAccount, ritcBC)
        If o.ritcONAccount <> "" And ritcON > 0 Then r.UpdateDebitCredit("CR", o.ritcONAccount, ritcON)
        If o.ritcPEIAccount <> "" And ritcPEI > 0 Then r.UpdateDebitCredit("CR", o.ritcPEIAccount, ritcPEI)

        u = Membership.GetUser(emp.Username)

        s = d.EnglishDescription

        s = Replace(s, "(Name)", emp.FirstName & " " & emp.LastName)
        s = Replace(s, "(reportname)", r.Name)
        s = Replace(s, "(amount)", FormatNumber(amt + onbehalf, 2) & " $ CAD")

        If onbehalf > 0 Then
            s = Replace(s, "(onbehalf)", FormatNumber(onbehalf, 2) & " $ CAD")
            s = Replace(s, "(reimburse)", FormatNumber(amt, 2) & " $ CAD")
        Else
            s = Replace(s, "Paid on behalf: (onbehalf)<br>", "")
            s = Replace(s, "Amount to reimburse: (reimburse)<br>", "")
        End If

        s = Replace(s, "(date)", Format(Now, "dd/MM/yyyy"))
        s = Replace(s, "(finalizedBy)", approver.FirstName & " " & approver.LastName)

        SendEmail(emp.Email, "Advataxes: Your report has been finalized", s, lang)

        d = Nothing
        d = New Description(30)

        s = d.EnglishDescription
        s = Replace(s, "(Name),", "")
        s = Replace(s, "(org)", emp.Organization.Name)
        s = Replace(s, "(reportname)", r.Name)
        s = Replace(s, "(amount)", FormatNumber(amt + onbehalf, 2) & " $ CAD")

        If onbehalf > 0 Then
            s = Replace(s, "(onbehalf)", FormatNumber(onbehalf, 2) & " $ CAD")
            s = Replace(s, "(reimburse)", FormatNumber(amt, 2) & " $ CAD")
        Else
            s = Replace(s, "Paid on behalf: (onbehalf)<br>", "")
            s = Replace(s, "Amount to reimburse: (reimburse)<br>", "")
        End If

        s = Replace(s, "(date)", Format(Now, "dd/MM/yyyy"))
        s = Replace(s, "(submittedBy)", emp.FirstName & " " & emp.LastName)
        s = Replace(s, "(finalizedBy)", approver.FirstName & " " & approver.LastName)

        emp = Nothing
        approver = Nothing
        o.GetEmployees()

        For Each emp In o.Employees
            If emp.NotifyFinalized Then
                SendEmail(emp.Email, "Advataxes: A report has been finalized", emp.FirstName & " " & emp.LastName & ",<br>" & s, lang)
            End If
        Next

        o = Nothing
        u = Nothing
        emp = Nothing
        exp = Nothing
        r = Nothing
    End Sub

    <System.Web.Services.WebMethod()>
    Public Shared Sub UnfinalizeReport(rptID As Integer)
        Dim r As New Report(rptID)

        r.ID = CInt(rptID)

        r.UpdateStatus(6)
        r = Nothing
    End Sub

    <System.Web.Services.WebMethod()>
    Public Shared Sub RejectReport(rptID As Integer, reason As String, lang As String)
        'Dim d As New Description(32)
        Dim r As New Report(rptID)
        Dim exp As Expense
        Dim u As MembershipUser
        Dim s As String
        Dim emp As Employee
        Dim approver As Employee
        Dim amt As Double, onbehalf As Double
        'Dim o As Org

        r.ReasonRejected = Replace(reason, "<", "")
        r.ReasonRejected = Replace(r.ReasonRejected, ">", "")
        r.UpdateStatus(5)

        emp = New Employee(r.EmpID)
        approver = New Employee(emp.Supervisor)

        ' o = New Org(emp.Organization.ID)

        For Each exp In r.Expenses
            If exp.Reimburse Then
                amt += exp.AmountCDN
            Else
                onbehalf += exp.AmountCDN
            End If
        Next

        u = Membership.GetUser(emp.Username)

        s = GetMessage(32, lang)
        s = Replace(s, "(Name)", emp.FirstName & " " & emp.LastName)
        s = Replace(s, "(reportname)", r.Name)
        s = Replace(s, "(reason)", r.ReasonRejected)
        s = Replace(s, "(amount)", FormatNumber(amt + onbehalf, 2) & " $ CAD")

        If onbehalf > 0 Then
            s = Replace(s, "(onbehalf)", FormatNumber(onbehalf, 2) & " $ CAD")
            s = Replace(s, "(reimburse)", FormatNumber(amt, 2) & " $ CAD")
        Else
            s = Replace(s, GetMessage(221, lang) & ": (onbehalf)<br>", "")
            s = Replace(s, GetMessage(257, lang) & ": (reimburse)<br>", "")
        End If

        s = Replace(s, "(date)", Format(Now, "dd/MM/yyyy"))
        s = Replace(s, "(rejectedby)", approver.FirstName & " " & approver.LastName)


        SendEmail(emp.Email, GetMessageTitle(32, lang), s, lang)

        'o = Nothing
        u = Nothing
        emp = Nothing
        exp = Nothing
        r = Nothing
        'd = Nothing
        approver = Nothing
    End Sub

    <System.Web.Services.WebMethod()>
    Public Shared Function SubmitReport(rptID As Integer, lang As String) As Array
        Dim s(2) As String
        Dim r As New Report(rptID)
        Dim emp As New Employee(r.EmpID)

        s(0) = ""

        If IsNothing(r.Expenses) Then
            'd = New Description(33)
            s(0) = GetMessage(33, lang) ' IIf(lang = "English", d.EnglishDescription, d.FrenchDescription)
            s(2) = GetMessageTitle(33, lang) ' IIf(lang = "English", d.EnglishTitle, d.FrenchTitle)

        ElseIf emp.Supervisor = 0 Then
            'd = New Description(34)
            s(0) = GetMessage(34, lang) ' IIf(lang = "English", d.EnglishDescription, d.FrenchDescription)
            s(2) = GetMessageTitle(34, lang) ' IIf(lang = "English", d.EnglishTitle, d.FrenchTitle)

        Else
            'd = New Description(28)
            Dim approver As New Employee(emp.Supervisor)

            r.Submit()

            s(1) = GetMessage(28, lang)
            s(1) = Replace(s(1), "(Name)", approver.FirstName & " " & approver.LastName)
            s(1) = Replace(s(1), "(submittedBy)", emp.FirstName & " " & emp.LastName)
            s(1) = Replace(s(1), "(reportname)", r.Name)

            SendEmail(approver.Email, GetMessageTitle(28, lang), s(1), lang)
            s(1) = GetMessage(130, lang)
            approver = Nothing
        End If

        r = Nothing
        emp = Nothing

        SubmitReport = s
    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function GetReport(rptID As Integer) As Array
        Dim r As New Report(rptID)
        Dim e As New Employee(r.EmpID)
        Dim o As New Org(e.OrgID)
        Dim rpt(3) As String

        rpt(0) = r.Name
        rpt(1) = r.Status
        rpt(2) = r.CreatedDate
        rpt(3) = o.Jur.ID

        r = Nothing
        e = Nothing
        o = Nothing
        Return rpt

    End Function



    <System.Web.Services.WebMethod()>
    Public Shared Function GetExpense(expID As Integer) As Array
        Dim exp As Expense

        Try

            exp = New Expense(expID)
            Dim aEXP(23) As String

            aEXP(0) = exp.OrgCategory.Category.ID
            aEXP(1) = IIf(exp.TaxStatus = 1, exp.Amount, exp.Amount - exp.GSTPaid - exp.QSTPaid)
            aEXP(2) = exp.Comment
            aEXP(3) = exp.CurrID
            aEXP(4) = exp.DateOfExpense
            aEXP(5) = exp.Gratuities
            aEXP(6) = exp.Jurisdiction.ID
            aEXP(7) = exp.Rate
            aEXP(8) = exp.SupplierName
            aEXP(9) = exp.TaxStatus
            aEXP(10) = IIf(exp.OrgCategory.Category.AllowAmt, 1, 0)
            aEXP(11) = IIf(exp.OrgCategory.Category.AllowCat, 1, 0)
            aEXP(12) = IIf(exp.OrgCategory.Category.AllowGratuity, 1, 0)
            aEXP(13) = IIf(exp.OrgCategory.Category.AllowJur, 1, 0)
            aEXP(14) = IIf(exp.OrgCategory.Category.AllowKM, 1, 0)
            aEXP(15) = IIf(exp.OrgCategory.Category.AllowNote, 1, 0)
            aEXP(16) = IIf(exp.OrgCategory.Category.AllowRate, 1, 0)
            aEXP(17) = IIf(exp.OrgCategory.Category.AllowTaxRate, 1, 0)
            aEXP(18) = FormatNumber(exp.GSTPaid, 2)
            aEXP(19) = FormatNumber(exp.QSTPaid, 2)
            aEXP(20) = exp.OrgCategory.ID
            aEXP(21) = IIf(IsNothing(exp.ReceiptName), "", exp.ReceiptName)
            aEXP(22) = IIf(exp.Reimburse, "0", "1")
            aEXP(23) = exp.Amount

            Return aEXP

        Catch ex As Exception
            Dim aEXP(0) As String
            aEXP(0) = "ERROR: " & ex.Message
        Finally
            exp = Nothing
        End Try

    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function GetTaxRates(jurID As Integer, catID As Integer, expDate As String, taxIncExc As Integer, orgID As Integer, kmRate As Single) As Array
        Dim c As New Category(catID)
        Dim aC(2) As String
        Dim validateKM As Integer

        validateKM = 1

        If catID = 4 Then
            Dim o As New Org(orgID)

            validateKM = o.ValidateKMRate(jurID, kmRate, expDate)

            o = Nothing
        End If

        aC(0) = c.GetGST(jurID, catID, expDate, taxIncExc) * validateKM
        aC(1) = c.GetQST(jurID, catID, expDate, taxIncExc) * validateKM
        If aC(0) = "0" Then aC(0) = c.GetHST(jurID, catID, expDate, taxIncExc) * validateKM
        aC(2) = validateKM
        'aC(2) = c.GetHST(jurID, catID, expDate, taxIncExc)

        c = Nothing

        Return aC

    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function GetAllows(orgCatID As Integer) As Array
        Dim oc As New OrgCat(orgCatID)
        Dim c As New Category(oc.CatID)
        Dim aC(10) As String


        aC(0) = IIf(c.AllowCat, 1, 0)
        aC(1) = IIf(c.AllowRate, 1, 0)
        aC(2) = IIf(c.AllowGratuity, 1, 0)
        aC(3) = IIf(c.AllowJur, 1, 0)
        aC(4) = IIf(c.AllowKM, 1, 0)
        aC(5) = IIf(c.AllowAmt, 1, 0)
        aC(6) = IIf(c.AllowTaxRate, 1, 0)
        aC(7) = c.ID
        aC(8) = IIf(c.AllowTaxIE, 1, 0)
        aC(9) = IIf(c.AllowReimburse, 1, 0)
        aC(10) = oc.AllowanceAmt


        c = Nothing
        oc = Nothing

        Return aC

    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function GetDates(rptID As Integer) As String
        Dim r As New Report(rptID)
        Dim s As String
        Dim approvedby As String = ""
        Dim rejectedby As String = ""
        Dim finalizedby As String = ""
        Dim e As Employee

        If Not IsDBNull(r.ApprovedBy) Then
            If r.ApprovedBy > 0 Then
                e = New Employee(r.ApprovedBy)
                approvedby = e.FirstName & " " & e.LastName
                e = Nothing
            End If
        End If

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

        Select Case r.Status
            Case 3 : s = s & "<tr style='height:20px;'><td></td><td class='labelText' width='125px'>Submitted:</td><td class='labelText' align='right'>" & r.SubmittedDate & "</td></tr><tr><td></td><td class='labelText'>Approved:</td><td class='labelText' align='right'>" & r.ApprovedDate & "</td></tr><tr><td></td><td class='labelText'>Approved By:</td><td class='labelText' align='right'>" & approvedby & "</td></tr>"
            Case 4 : s = s & "<tr style='height:20px;'><td></td><td class='labelText' width='125px'>Submitted:</td><td class='labelText' align='right'>" & r.SubmittedDate & "</td></tr><tr><td></td><td class='labelText'>Approved:</td><td class='labelText' align='right'>" & r.ApprovedDate & "</td></tr><tr><td></td><td class='labelText'>Approved By:</td><td class='labelText' align='right'>" & approvedby & "</td></tr><tr><td></td><td class='labelText'>Finalized:</td><td class='labelText' align='right'>" & r.FinalizedDate & " </td></tr><tr><td></td><td class='labelText'>Finalized By:</td><td class='labelText' align='right'>" & finalizedby & "</td></tr>"
            Case 5 : s = s & "<tr style='height:20px;'><td></td><td class='labelText' width='125px'>Submitted:</td><td class='labelText' align='right'>" & r.SubmittedDate & "</td></tr><tr><td></td><td class='labelText'>Rejected:</td><td class='labelText' align='right'>" & r.RejectedDate & "</td></tr><tr><td class='labelText'>Rejected By:</td><td align='right'>" & rejectedby & "</td></tr>"
        End Select

        r = Nothing

        s = s & "</table>"

        Return s

    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Sub DeleteReceipt(expID As Integer)
        Dim exp As New Expense

        exp.DeleteReceipt(expID)

        exp = Nothing
    End Sub


    Private Sub ExportExcel()
        GetConnectionString()
        Dim sqlConn = New SqlConnection(connString.ConnectionString)
        sqlConn.Open()
        'DBConnect()

        If cboReportType.SelectedIndex <> 0 Then
            Dim table As New DataTable
            Dim pdf As New Spire.DataExport.PDF.PDFExport
            table.Columns.Add("Date", GetType(String))
            table.Columns.Add("Jur", GetType(String))
            table.Columns.Add("Category", GetType(String))
            table.Columns.Add("Total Amt", GetType(String))
            table.Columns.Add("ITC", GetType(String))
            table.Columns.Add("ITR", GetType(String))
            table.Columns.Add("RITC", GetType(String))
            table.Columns.Add("Net Amt", GetType(String))
            table.Columns.Add("Supplier", GetType(String))
            table.Columns.Add("Comment", GetType(String))

            table.Rows.Add(25, "Indocin", "David", DateTime.Now)
            table.Rows.Add(50, "Enebrel", "Sam", DateTime.Now)
            table.Rows.Add(10, "Hydralazine", "Christoff", DateTime.Now)
            table.Rows.Add(21, "Combivent", "Janet", DateTime.Now)
            table.Rows.Add(100, "Dilantin", "Melanie", DateTime.Now)

            pdf.DataSource = Spire.DataExport.Common.ExportSource.DataTable
            pdf.DataTable = table
            pdf.ActionAfterExport = Spire.DataExport.Common.ActionType.OpenView
            pdf.SaveToHttpResponse("result.pdf", Response)
        Else
            Dim xl As New Spire.DataExport.XLS.CellExport
            Dim html As New Spire.DataExport.HTML.HTMLExport
            Dim command As New SqlCommand()
            Dim s As New Spire.DataExport.Collections.StringListCollection

            command.Connection = sqlConn
            command.CommandType = CommandType.StoredProcedure
            command.CommandText = "ExportExpenses"
            command.Parameters.Add(New SqlParameter("@ReportID", SqlDbType.Int)).Value = hdnReportID.Value
            Dim r As New Report(hdnReportID.Value)

            'pdf.SQLCommand = command
            'pdf.ActionAfterExport = Spire.DataExport.Common.ActionType.OpenView
            'pdf.AutoFitColWidth = True
            'pdf.PDFOptions.PageOptions.Orientation = Spire.DataExport.Common.PageOrientation.Landscape
            'pdf.PDFOptions.DataFont.Size = "9"
            'pdf.SaveToHttpResponse("test.pdf", Response)
            s.Add(Session("emp").Organization.Name)
            s.Add(r.Name)
            s.Add(CStr(r.CreatedDate))
            s.Add("")


            xl.Header = s
            xl.ActionAfterExport = Spire.DataExport.Common.ActionType.OpenView

            Dim workSheet1 As New Spire.DataExport.XLS.WorkSheet()
            Dim columnFormat1 As New Spire.DataExport.XLS.ColumnFormat()

            columnFormat1.Width = 300

            workSheet1.Header = s

            workSheet1.ColumnFormats.Add(columnFormat1)
            workSheet1.Options.CustomDataFormat.Borders.Left.Color = Spire.DataExport.XLS.CellColor.Blue
            workSheet1.Options.TitlesFormat.FillStyle.Background = Spire.DataExport.XLS.CellColor.Black
            workSheet1.Options.TitlesFormat.Font.Color = Spire.DataExport.XLS.CellColor.White
            workSheet1.Options.TitlesFormat.Font.Bold = True

            workSheet1.SetColumnWidth(1, 10)
            workSheet1.SetColumnWidth(2, 40)
            workSheet1.SetColumnWidth(3, 20)
            workSheet1.SetColumnWidth(4, 15)
            workSheet1.SetColumnWidth(5, 18)
            workSheet1.SetColumnWidth(6, 8)
            workSheet1.SetColumnWidth(7, 8)
            workSheet1.SetColumnWidth(8, 8)
            workSheet1.SetColumnWidth(9, 5)
            workSheet1.SetColumnWidth(10, 40)



            Dim stripStyle1 = New Spire.DataExport.XLS.StripStyle()
            Dim stripStyle2 = New Spire.DataExport.XLS.StripStyle()

            stripStyle1.FillStyle.Background = Spire.DataExport.XLS.CellColor.LightYellow
            stripStyle1.FillStyle.Pattern = Spire.DataExport.XLS.Pattern.None
            stripStyle1.Font.Name = "Calibri"
            stripStyle1.Font.Size = 11.5F
            stripStyle1.Alignment.Horizontal = Spire.DataExport.XLS.HorizontalAlignment.Center
            stripStyle1.Borders.Top.Style = Spire.DataExport.XLS.CellBorderStyle.Thin
            stripStyle1.Borders.Bottom.Style = Spire.DataExport.XLS.CellBorderStyle.Thin
            stripStyle1.Borders.Right.Style = Spire.DataExport.XLS.CellBorderStyle.Thin
            stripStyle1.Borders.Left.Style = Spire.DataExport.XLS.CellBorderStyle.Thin


            stripStyle2.FillStyle.Background = Spire.DataExport.XLS.CellColor.LightGreen
            stripStyle2.Font.Name = "Calibri"
            stripStyle2.Font.Size = 11.5F
            stripStyle2.Alignment.Horizontal = Spire.DataExport.XLS.HorizontalAlignment.Center
            stripStyle2.Borders.Top.Style = Spire.DataExport.XLS.CellBorderStyle.Thin
            stripStyle2.Borders.Bottom.Style = Spire.DataExport.XLS.CellBorderStyle.Thin
            stripStyle2.Borders.Right.Style = Spire.DataExport.XLS.CellBorderStyle.Thin
            stripStyle2.Borders.Left.Style = Spire.DataExport.XLS.CellBorderStyle.Thin

            workSheet1.Options.TitlesFormat.FillStyle.Pattern = Spire.DataExport.XLS.Pattern.Solid
            workSheet1.SQLCommand = command
            xl.Sheets.Add(workSheet1)
            workSheet1.ItemType = Spire.DataExport.XLS.CellItemType.Row
            workSheet1.ItemStyles.Add(stripStyle1)
            workSheet1.ItemStyles.Add(stripStyle2)
            xl.SaveToHttpResponse(r.Name & ".xls", Response)
            r = Nothing

        End If

        sqlConn.Close()
        'DBDisconnect()

    End Sub


    Private Sub ExportPDF()
        GetConnectionString()
        Dim pdf As New Spire.DataExport.PDF.PDFExport
        Dim command As New SqlCommand()
        Dim s As String = ""
        Dim r As New Report(hdnReportID.Value)
        Dim i As Integer
        Dim ITC As Decimal, ITR As Decimal, RITC As Decimal
        Dim ss As New Spire.DataExport.Collections.StringListCollection


        Dim sqlConn = New SqlConnection(connString.ConnectionString)
        sqlConn.Open()
        'DBConnect()

        pdf.ActionAfterExport = Spire.DataExport.Common.ActionType.OpenView
        'pdf.AutoFitColWidth = True
        pdf.PDFOptions.PageOptions.Orientation = Spire.DataExport.Common.PageOrientation.Landscape
        pdf.PDFOptions.DataFont.Size = 7
        pdf.PDFOptions.PageOptions.MarginLeft = 0.5

        pdf.Header.Add(Session("emp").Organization.Name)
        pdf.Header.Add(r.Name)
        pdf.Header.Add(CStr(r.CreatedDate))

        pdf.Header.Add(s)


        If cboReportType.SelectedIndex <> 0 Then
            Dim table As New DataTable

            table.Columns.Add("Date", GetType(String))
            table.Columns.Add("Jur", GetType(String))
            table.Columns.Add("Category", GetType(String))
            table.Columns.Add("Total Amt", GetType(String))
            table.Columns.Add("ITC", GetType(String))
            table.Columns.Add("ITR", GetType(String))
            table.Columns.Add("RITC", GetType(String))
            table.Columns.Add("Net Amt", GetType(String))
            table.Columns.Add("Supplier", GetType(String))
            table.Columns.Add("Comment", GetType(String)).MaxLength = 500


            Do Until i = r.Expenses.Count
                ITC = FormatNumber(r.Expenses(i).OrgCategory.Category.GetITC(r.Expenses(i).Jurisdiction.ID, Session("emp").Organization.OrgSizeGST, r.CreatedDate) * r.Expenses(i).GSTPaid, 2)
                ITR = FormatNumber(r.Expenses(i).OrgCategory.Category.GetITR(r.Expenses(i).Jurisdiction.ID, Session("emp").Organization.OrgSizeQST, r.CreatedDate) * r.Expenses(i).QSTPaid, 2)
                RITC = FormatNumber(r.Expenses(i).OrgCategory.Category.GetRITC(r.Expenses(i).Jurisdiction.ID, Session("emp").Organization.OrgSizeGST, r.CreatedDate) * r.Expenses(i).GSTPaid, 2)

                table.Rows.Add(r.Expenses(i).DateOfExpense, _
                           IIf(r.Expenses(i).OrgCategory.Category.ID = 5, "N/A", r.Expenses(i).Jurisdiction.Abbreviation), _
                           r.Expenses(i).OrgCategory.Category.Name & "&nbsp;&nbsp;&nbsp;" & r.Expenses(i).OrgCategory.Note, _
                           FormatNumber(r.Expenses(i).Amount, 2), _
                           FormatNumber(ITC, 2), _
                           FormatNumber(ITR, 2), _
                           FormatNumber(RITC, 2), _
                           FormatNumber(r.Expenses(i).Amount - ITC - ITR + RITC, 2), _
                           r.Expenses(i).SupplierName, _
                           r.Expenses(i).Comment)

                'AmtTotal = AmtTotal + r.Expenses(i).Amount
                'ITCTotal = ITCTotal + ITC
                'ITRTotal = ITRTotal + ITR
                'RITCTotal = RITCTotal + RITC
                'NetTotal = NetTotal + (r.Expenses(i).Amount - ITC - ITR + RITC)
                'If r.Expenses(i).Jurisdiction.ID = 10 Then RITCTotalBC = RITCTotalBC + RITC
                'If r.Expenses(i).Jurisdiction.ID = 2 Then RITCTotalOnt = RITCTotalOnt + RITC
                i = i + 1
            Loop


            pdf.DataSource = Spire.DataExport.Common.ExportSource.DataTable
            pdf.DataTable = table
            pdf.AutoFitColWidth = False
            'ss.Add("0,10")
            'ss.Add("1,10")
            'ss.Add("2,500")



            'pdf.ColumnsWidth().Add("10")
            'pdf.ColumnsWidth().Add("10")
            'pdf.ColumnsWidth().Add("10")

            pdf.ActionAfterExport = Spire.DataExport.Common.ActionType.OpenView
            pdf.SaveToHttpResponse("result.pdf", Response)
        Else

            Dim table As New DataTable


            table.Columns.Add("Date", GetType(String))
            table.Columns.Add("Category", GetType(String))
            table.Columns.Add("Supplier", GetType(String))
            table.Columns.Add("Jur", GetType(String))
            table.Columns.Add("Rate/Grat", GetType(String))
            table.Columns.Add("Amt", GetType(String))
            table.Columns.Add("GST Paid", GetType(String))
            table.Columns.Add("QST Paid", GetType(String))
            table.Columns.Add("Curr", GetType(String))
            table.Columns.Add("Comment", GetType(String))



            Dim com As SqlCommand = New SqlCommand("ExportExpenses", sqlConn)
            Dim rs As SqlDataReader

            com.CommandType = CommandType.StoredProcedure
            com.Parameters.Add(New SqlParameter("@ReportID", SqlDbType.VarChar)).Value = hdnReportID.Value
            com.Connection = sqlConn
            rs = com.ExecuteReader

            While rs.Read
                table.Rows.Add(rs(0), rs(1), rs(2), rs(3), rs(4), rs(5), rs(6), rs(7), rs(8), rs(9))

            End While

            rs.Close()
            com.Dispose()
            sqlConn.Close()

            pdf.DataSource = Spire.DataExport.Common.ExportSource.DataTable
            pdf.DataTable = table
            pdf.AutoFitColWidth = False
            'ss.Add("0,10")
            'ss.Add("1,10")
            'ss.Add("2,500")

            'pdf.ColumnsWidth().Add("10")
            'pdf.ColumnsWidth().Add("10")
            'pdf.ColumnsWidth().Add("10")

            pdf.ActionAfterExport = Spire.DataExport.Common.ActionType.OpenView
            pdf.SaveToHttpResponse("result.pdf", Response)

            Exit Sub

            '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
            command.Connection = sqlConn
            command.CommandType = CommandType.StoredProcedure
            command.CommandText = "ExportExpenses"
            command.Parameters.Add(New SqlParameter("@ReportID", SqlDbType.Int)).Value = hdnReportID.Value

            pdf.SQLCommand = command
            pdf.AutoFitColWidth = True
            'pdf.ColumnsWidth().Add = 10

            'pdf.ColumnsWidth(1).Add("10")
            'pdf.ColumnsWidth(2).Add("10")

            pdf.SaveToHttpResponse(r.Name & ".pdf", Response)
            pdf.ColumnsWidth(1) = 500
            pdf.ActionAfterExport = 1

            modalExport.Hide()

        End If

        r = Nothing
        pdf = Nothing
        sqlConn.Close()

        'DBDisconnect()
    End Sub



    '    Sub GetData()
    '        Dim DataSheet As Worksheet
    '        Dim endDate As String
    '        Dim startDate As String
    '        Dim fromCurr As String
    '        Dim toCurr As String
    '        Dim str As String
    '        Dim LastRow As Integer


    '        Application.ScreenUpdating = False
    '        Application.DisplayAlerts = False
    '        Application.Calculation = xlCalculationManual

    '        Sheets("Data").Cells.Clear()

    '        DataSheet = ActiveSheet

    '        startDate = DataSheet.Range("startDate").Value
    '        endDate = DataSheet.Range("endDate").Value
    '        fromCurr = DataSheet.Range("fromCurr").Value
    '        toCurr = DataSheet.Range("toCurr").Value

    '        str = "http://www.oanda.com/currency/historical-rates/download?quote_currency=" _
    '          & fromCurr _
    '          & "&end_date=" _
    '          & Year(endDate) & "-" & Month(endDate) & "-" & Day(endDate) _
    '          & "&start_date=" _
    '          & Year(startDate) & "-" & Month(startDate) & "-" & Day(startDate) _
    '          & "&period=daily&display=absolute&rate=0&data_range=c&price=bid&view=table&base_currency_0=" _
    '          & toCurr _
    '          & "&base_currency_1=&base_currency_2=&base_currency_3=&base_currency_4=&download=csv"

    'QueryQuote:
    '        With Sheets("Data").QueryTables.Add(Connection:="URL;" & str, Destination:=Sheets("Data").Range("a1"))
    '            .BackgroundQuery = True
    '            .TablesOnlyFromHTML = False
    '            .Refresh(BackgroundQuery:=False)
    '            .SaveData = True
    '        End With

    '        Sheets("Data").Range("a5").CurrentRegion.TextToColumns(Destination:=Sheets("Data").Range("a5"), DataType:=xlDelimited, _
    '        TextQualifier:=xlDoubleQuote, ConsecutiveDelimiter:=False, Tab:=False, _
    '        Semicolon:=False, Comma:=True, Space:=False, other:=True, OtherChar:=",", FieldInfo:=Array(1, 2))

    '        Sheets("Data").Columns("A:B").ColumnWidth = 12
    '        Sheets("Data").Range("A1:b2").Clear()

    '        LastRow = Sheets("Data").UsedRange.Row - 6 + Sheets("Data").UsedRange.Rows.Count

    '        Sheets("Data").Range("A" & LastRow + 2 & ":b" & LastRow + 5).Clear()

    '        Sheets("Data").Sort.SortFields.Add(Key:=Range("A5:A" & LastRow), _
    '            SortOn:=xlSortOnValues, Order:=xlAscending, DataOption:=xlSortNormal)
    '        With Sheets("Data").Sort
    '            .SetRange(Range("A5:b" & LastRow))
    '            .Header = xlYes
    '            .MatchCase = False
    '            .Orientation = xlTopToBottom
    '            .SortMethod = xlPinYin
    '            .Apply()
    '        End With

    '        DeleteCharts()

    '        Application.DisplayAlerts = True

    '        With ActiveSheet.ChartObjects.Add _
    '                (Left:=Range("A11").Left, Width:=375, Top:=Range("A11").Top, Height:=225)
    '            .Chart.SetSourceData(Source:=Sheets("Data").Range("A5:b" & LastRow))
    '            .Chart.ChartType = xlLine
    '        End With

    '        Dim ch As ChartObject
    '        For Each ch In ActiveSheet.ChartObjects
    '            ch.Select()
    '            ActiveChart.Axes(xlValue).MinimumScale = WorksheetFunction.Min(Sheets("Data").Range("b5:b" & LastRow))
    '            ActiveChart.Axes(xlValue).MaximumScale = WorksheetFunction.Max(Sheets("Data").Range("b5:b" & LastRow))
    '            ActiveChart.Legend.Select()
    '            Selection.Delete()
    '        Next ch

    '    End Sub


    Private Sub cmdSaveExpense_Click(sender As Object, e As System.EventArgs) Handles cmdSaveExpense.Click
        CreateExpense()

        Response.Redirect("reports.aspx" & IIf(IsNothing(Request.QueryString("e")), "", "?e=1"))
    End Sub

    Private Sub cmdSaveExpense2_Click(sender As Object, e As System.EventArgs) Handles cmdSaveExpense2.Click
        CreateExpense()

        ModalPopupExtender4.Show()
    End Sub

    Private Sub cmdCancel_Click(sender As Object, e As System.EventArgs) Handles cmdCancel.Click

    End Sub

    Private Sub cmdAttachFile_Click(sender As Object, e As System.EventArgs) Handles cmdAttachFile.Click
        UploadFile(FileUpload2, hdnExpenseID.Value)
        GridView2.DataBind()
    End Sub


    Private Sub cmdSaveReport_Click(sender As Object, e As System.EventArgs) Handles cmdSaveReport.Click
        CreateReport()

    End Sub

    Private Sub cmdExport_Click(sender As Object, e As System.EventArgs) Handles cmdExport.Click
        modalExport.Hide()

        Select Case cboExport.SelectedValue
            Case "Excel" : ExportExcel()
            Case "PDF" : ExportPDF()
        End Select


    End Sub


    Private Sub Page_LoadComplete(sender As Object, e As System.EventArgs) Handles Me.LoadComplete
        If Request.QueryString("s") = "submitted" Then
            Session("msg") = GetMessage(284, Session("language"))
            Response.Redirect("reports.aspx")
        End If


    End Sub

    Private Sub cboDelegate_DataBound(sender As Object, e As System.EventArgs) Handles cboDelegate.DataBound
        cboDelegate.Items.Insert(0, GetMessage(228, Session("language")))
        cboDelegate.Items(0).Value = Session("emp").id

        cboDelegate.Visible = cboDelegate.Items.Count > 1
        lbl69.Visible = cboDelegate.Items.Count > 1

        cboDelegate.SelectedValue = Session("selectedEmp")
    End Sub

    Private Sub cboDelegate_SelectedIndexChanged(sender As Object, e As System.EventArgs) Handles cboDelegate.SelectedIndexChanged

    End Sub


    Public Sub CreateReport()
        Dim rpt As Report

        Try
            If hdnReportIDEdit.Value <> 0 Then
                rpt = New Report(hdnReportIDEdit.Value)
                rpt.Name = txtReportName.Text
                rpt.Update()

            Else
                rpt = New Report
                If cboDelegate.Visible Then
                    rpt.Create(txtReportName.Text, Session("emp").OrgID, cboDelegate.SelectedValue, 1)
                Else
                    rpt.Create(txtReportName.Text, Session("emp").OrgID, Session("emp").ID, 1)
                End If

            End If

        Catch ex As Exception
            Session("Error") = ex.Message
            Response.Redirect("../error.aspx")
        Finally
            hdnOpenReport.Value = True
            rpt = Nothing
            txtReportName.Text = ""
            'GridView1.DataBind()
            If Request.QueryString("e") <> "" Then
                Response.Redirect("reports.aspx?e=1")
            Else
                Response.Redirect("reports.aspx")
            End If
        End Try
    End Sub


    Public Sub Translate()
        On Error Resume Next
        Dim d As New Description
        Dim c As Object
        Dim col As Object
        Dim childc As Object, childcc As Object, childccc As Object, childcccc As Object
        Dim id As String

        If IsNothing(session("language")) Then session("language") = IIf(session("emp").defaultlanguage = 1, "English", "French")

        If Not IsNothing(Request.QueryString("lang")) Then
            If Request.QueryString("lang") = "f" Then
                session("language") = "French"
            Else
                session("language") = "English"
            End If
        End If

        For Each c In Page.Controls
            For Each childc In c.controls
                For Each childcc In childc.controls
                    If TypeOf childcc Is ContentPlaceHolder Then
                        For Each childccc In childcc.controls
                            If TypeOf childccc Is Label Then
                                If childccc.id Like "lbl*" Then
                                    id = Replace(childccc.id, "_", "")
                                    childccc.text = d.GetDescription(CInt(Replace(id, "lbl", "")), Left(Session("language"), 1))
                                End If

                            ElseIf TypeOf childccc Is Panel Then
                                For Each childcccc In childccc.controls
                                    If TypeOf childcccc Is Label Then

                                        If childcccc.id Like "lbl*" Then
                                            id = Replace(childcccc.id, "_", "")
                                            childcccc.text = d.GetDescription(CInt(Replace(id, "lbl", "")), Left(Session("language"), 1))
                                        End If

                                    End If
                                Next

                            ElseIf TypeOf childccc Is GridView Then
                                For Each col In childccc.columns
                                    col.headertext = d.GetDescription(CInt(col.headertext), Left(session("language"), 1))
                                Next
                            End If
                        Next
                    End If
                Next
            Next
        Next

    End Sub

    Private Sub cboCat_DataBound(sender As Object, e As System.EventArgs) Handles cboCat.DataBound
        cboCat.Items.Insert(0, "")
    End Sub
End Class