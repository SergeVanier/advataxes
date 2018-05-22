Imports System.Data
Imports System.Data.SqlClient
Imports System.Configuration
Imports System.IO
Imports System.Net
Imports System.Drawing

Partial Public Class Reports
	Inherits Advataxes.AdvataxesPageBase

	Public Const iREVERSED As Integer = 99

	Dim blnSubmit As Boolean
	Dim ExpenseID As Integer
	Dim linenum As Integer
	Public isSubmitted As Boolean = False


	''' <summary>
	''' Handles unexpected errors that happen on the page. If there's an error, redirect to login page
	''' </summary>
	''' <param name="sender"></param>
	''' <param name="e"></param>
	''' <remarks></remarks>
	Private Sub Reports_Error(sender As Object, e As System.EventArgs) Handles Me.Error
		'If IsNothing(Session("error")) Then Session("error") = GetMessage(273) : Session("msgHeight") = 75
		'Response.Redirect("/login.aspx?error=true")
	End Sub


    ''' <summary>
    ''' On page load, check for settings like status, selected employee, if we should switch to submitted expenses for a supervisor,
    ''' check for an open report if just a regular employee, change the datasource of the reports gridview if dates were selected for
    ''' finalized reports or depending on what status is selected and for which employee if delegate option is available
    ''' </summary>
    ''' <param name="sender"></param>
    ''' <param name="e"></param>
    ''' <remarks></remarks>
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Try
            isSubmitted = If(Not IsNothing(Request.QueryString("submitted")) AndAlso Request.QueryString("submitted") = 1, True, False)
            GetConnectionString()
            CheckLanguage()
            Translate()
            Translate2()

            InitializeVariables()
            InitializeReportGrid()
            InitializeExpenseGrid()

            'essais pour west penetone
            'If Session("emp").OrgID = 1313 Then
            '    cboCurr.Attributes("style") = "visibility: hidden"
            '    gridViewExpenses.Columns(15).Visible = False
            'End If
            Dim org As Org

            org = Session("emp").Organization
            If org.QSTReg = False Then
                gridViewExpenses.Columns(13).Visible = False

            End If

            'GetGuidelines()

            If Not IsNothing(Request.QueryString("ce")) AndAlso Request.QueryString("ce") = 1 Then modalCreateExpense.Show()

        Catch ex As Exception
            Throw

        Finally
            If Not IsNothing(Session("error")) Then Response.Redirect("~/error.aspx")

        End Try

        Response.Cache.SetExpires(DateTime.UtcNow.AddMinutes(-1))
        Response.Cache.SetCacheability(HttpCacheability.NoCache)
        Response.Cache.SetNoStore()

    End Sub

    Private Sub InitializeVariables()
		Dim report As New Report
		Dim iKMRate As Single

		Session("currentpage") = "Reports.aspx" & If(Not IsNothing(Request.QueryString("submitted")) AndAlso Request.QueryString("submitted") = 1, "?submitted=1", "")
		Session("error") = Nothing

		hdnOrgID.Value = Session("emp").OrgID
		txtEmpID.Text = Session("emp").id
		txtSuperID.Text = Session("emp").ID
		hdnLoggedInEmpID.Value = Session("emp").ID
		hdnPUK.Value = Membership.GetUser(Session("emp").username.ToString).ProviderUserKey.ToString
		cboEmp.Visible = Session("emp").IsSupervisor AndAlso Not IsNothing(Request.QueryString("submitted")) AndAlso Request.QueryString("submitted") = 1
		If IsNothing(Request.QueryString("submitted")) Then Session("SelectedReport") = Nothing
		If Not IsNothing(Session("ExpDate")) Then hdnExpDate.Value = Session("ExpDate")

		If Not IsNothing(Request.QueryString("action")) Then
            If Request.QueryString("action") = "receitdeleted" Then Session("msg") = GetMessage(432)
            If Request.QueryString("action") = "expdeleted" Then Session("msg") = GetMessage(139)
            Response.Redirect(Request.Path & IIf(IsNothing(Request.QueryString("submitted")), "", "?submitted=1"))
        End If

        If IsPostBack Then
            Page.ClientScript.RegisterClientScriptBlock(Me.GetType(), "IsPostBack", "var isPostBack = true;", True)
            If String.IsNullOrWhiteSpace(txtFrom.Text) Then hdnFrom.Value = "01/07/2010"
            If String.IsNullOrWhiteSpace(txtTo.Text) Then hdnTo.Value = Format(Now, "dd/MM/yyyy")
        Else
            Page.ClientScript.RegisterClientScriptBlock(Me.GetType(), "IsPostBack", "var isPostBack = false;", True)
            hdnTo.Value = Format(Now, "dd/MM/yyyy")

            For iKMRate = 0.01 To 0.99 Step 0.01
                cboRate.Items.Add(FormatNumber(iKMRate, 2))
            Next
        End If
        cboRate.Items.RemoveAt(0)
        'when loading page, check if we are loading reports for the logged in user or for the delegated user selected from cboDelegate
        If Not IsPostBack And Not IsNothing(Request.QueryString("empID")) Then
            Session("selectedEmp") = New Employee(CInt(Request.QueryString("empID")))

        ElseIf IsNothing(Session("selectedEmp")) Then
            If cboDelegate.Visible And cboDelegate.SelectedValue <> "" Then
                Session("selectedEmp") = New Employee(CInt(cboDelegate.SelectedValue))
            Else
                Session("selectedEmp") = New Employee(CInt(Session("emp").id))
            End If
        Else
            Session("selectedEmp") = New Employee(CInt(Session("selectedEmp").id))
        End If

        Session("selectedEmpID") = Session("selectedEmp").id
        cboProject.Enabled = Not Session("selectedEmp").LockDefaultProject

        txtFrom.Visible = cboStatus.SelectedValue = "Finalized"
        lblFrom.Visible = cboStatus.SelectedValue = "Finalized"
        txtTo.Visible = cboStatus.SelectedValue = "Finalized"
        lblTo.Visible = cboStatus.SelectedValue = "Finalized"
        cmdRefreshGrid.Visible = cboStatus.SelectedValue = "Finalized"

        If Not isSubmitted Then
            If Not IsPostBack Then
                report.GetOpenReport(CInt(Session("selectedEmp").id))
                hdnOpenReport.Value = report.Status = 1
                cboStatus.SelectedIndex = 1

                hdnReportID.Value = report.ID
                txtExpDate.Text = If(IsNothing(Session("ExpDate")), report.CreatedDate, Session("ExpDate"))
                hdnExpDate.Value = If(IsNothing(Session("ExpDate")), report.CreatedDate, Session("ExpDate"))
                labelReportName.Text = If(report.ID <> 0, "", "") & report.Name

                If Session("emp").organization.approvallevel = 1 Then cboStatus.Items.RemoveAt(3)
            End If
        Else
            If Not IsPostBack Then
                hdnReportID.Value = ""
                lbl73.Visible = True 'employee
                cboStatus.Items.RemoveAt(0)
                cboStatus.Items.Remove("Open")
                txtEmpID.Text = ""

                If Session("emp").approvallevel = 2 Then
                    cboStatus.Items.RemoveAt(0)
                    cboEmp.DataSourceID = "sqlListOfEmployeesByFinalizer"
                    cboStatus.Items(0).Text = GetMessage(253)
                    cboStatus.Items(1).Text = GetMessage(78)
                    cboEmp.Items(0).Text = GetMessage(104)
                Else
                    cboStatus.Items.Remove("Approved")
                    cboEmp.DataSourceID = "sqlListOfEmployeesBySupervisor"
                    cboStatus.Items(0).Text = GetMessage(106)
                    cboStatus.Items(1).Text = GetMessage(78)
                    cboEmp.Items(0).Text = GetMessage(104)
                End If
            End If
        End If

        report = Nothing
    End Sub

    Private Sub InitializeExpenseGrid()
        gridViewExpenses.Columns(6).Visible = Session("emp").Organization.parent.displayworkorder
        gridViewExpenses.Columns(7).Visible = Session("emp").Organization.parent.displayproject
        gridViewExpenses.Columns(8).Visible = Session("emp").Organization.parent.displaycostcenter
        'gridViewExpenses.Columns(16).Visible = cboStatus.SelectedValue = "Open"

        If Not isSubmitted Then
            gridViewExpenses.Columns(1).Visible = cboStatus.SelectedValue = "Open"
        Else
            If (Session("emp").approvallevel = 1 And Session("emp").organization.approvallevel = 1) Or (Session("emp").approvallevel = 2) Then
                If cboStatus.SelectedValue = "%" Then gridViewExpenses.Columns(1).Visible = True
            End If

        End If

        'new code to disable the pencil
        Dim submitted As String = Request.QueryString("submitted")
        If submitted = "1" Then

            If cboStatus.SelectedValue = "Finalized" Then

                If gridViewExpenses.Columns(1).Visible = True Then
                    gridViewExpenses.Columns(1).Visible = False
                End If
            End If
        End If
        'new code end 



    End Sub

	Private Sub InitializeReportGrid()

		If Not IsNothing(Session("SelectedReport")) Then gridViewReports.SelectedIndex = CInt(Session("SelectedReport"))

		If Not isSubmitted Then
			If Not IsPostBack Then
				gridViewReports.SelectedIndex = 0
				gridViewReports.DataSourceID = "sqlReportsByEmpID"
			End If

			If Not IsNothing(cboStatus.SelectedValue) AndAlso cboStatus.SelectedValue = "Finalized" Then
				gridViewReports.DataSourceID = "sqlFinalizedWithDates"
			Else
				gridViewReports.DataSourceID = "sqlReportsByEmpID"
			End If

			Select Case cboStatus.SelectedValue
				Case "%" : gridViewReports.Columns(5).HeaderText = "Date" : gridViewReports.Columns(5).SortExpression = "LAST_DATE"
				Case "Open" : gridViewReports.Columns(5).HeaderText = GetMessage(77) : gridViewReports.Columns(5).SortExpression = "CREATED_DATE"
				Case "Pending Approval" : gridViewReports.Columns(5).HeaderText = GetMessage(58) : gridViewReports.Columns(5).SortExpression = "SUBMITTED_DATE"
				Case "Approved" : gridViewReports.Columns(5).HeaderText = GetMessage(253) : gridViewReports.Columns(5).SortExpression = "APPROVED_DATE"
				Case "Finalized" : gridViewReports.Columns(5).HeaderText = GetMessage(78) : gridViewReports.Columns(5).SortExpression = "FINALIZED_DATE"
			End Select

			gridViewReports.Columns(3).Visible = False
			gridViewReports.Columns(7).Visible = False
			gridViewReports.Columns(10).Visible = False
			gridViewReports.Columns(1).Visible = Not IsNothing(cboStatus.SelectedValue) AndAlso cboStatus.SelectedValue = "Open"
			gridViewReports.Columns(8).Visible = False
			gridViewReports.Columns(9).Visible = Not IsNothing(cboStatus.SelectedValue) AndAlso cboStatus.SelectedValue = "Open"

		Else
			If Not IsPostBack Then
				If Session("emp").approvallevel <> 2 Then
					gridViewReports.DataSourceID = "sqlReportsBySuperID"
				End If
			End If

			Select Case cboStatus.SelectedValue
				Case "Approved" : gridViewReports.DataSourceID = "sqlReportsByFinalizerID"
				Case "Pending Approval" : gridViewReports.DataSourceID = IIf(cboEmp.SelectedIndex = 0, "sqlReportsBySuperID", "sqlReportsBySuperIDandEmpID")
				Case "Finalized"
					If Session("emp").approvallevel = 1 Then
						gridViewReports.DataSourceID = IIf(cboEmp.SelectedIndex = 0, "sqlReportsBySuperIDWithDates", "sqlReportsBySuperIDandEmpIDWithDates")
					Else
						gridViewReports.DataSourceID = IIf(cboEmp.SelectedIndex = 0, "sqlReportsByFinalizerIDWithDates", "sqlReportsByFinalizerIDandEmpIDWithDates")
					End If
			End Select

            gridViewReports.Columns(3).Visible = True
			gridViewReports.Columns(9).Visible = False

			If (Session("emp").approvallevel = 1 And Session("emp").organization.approvallevel = 1) Or (Session("emp").approvallevel = 2) Then
				Select Case cboStatus.SelectedValue
					Case "%" : gridViewReports.Columns(10).Visible = True : gridViewReports.Columns(8).Visible = True : gridViewReports.Columns(7).Visible = True : gridViewReports.Columns(5).HeaderText = GetMessage(58)
					Case "Open" : gridViewReports.Columns(8).Visible = False : gridViewReports.Columns(7).Visible = False : gridViewReports.Columns(5).HeaderText = GetMessage(78)
                End Select
            End If

            gridViewReports.Columns(1).Visible = False
            gridViewReports.Columns(7).Visible = cboStatus.SelectedValue = "Pending Approval" Or cboStatus.SelectedValue = "Approved"
            gridViewReports.Columns(8).Visible = (Session("emp").approvallevel = 1 And Session("emp").organization.parent.approvallevel = 2) And cboStatus.SelectedValue = "Pending Approval"
            gridViewReports.Columns(10).Visible = (cboStatus.SelectedValue = "Pending Approval" And Session("emp").approvallevel = 1 And Session("emp").organization.parent.approvallevel = 1) Or (cboStatus.SelectedValue = "Approved" And Session("emp").approvallevel = 2)
            gridViewReports.Columns(11).Visible = False

        End If
    End Sub

    Private Sub GetGuidelines()
        Dim guidelines As String

        guidelines = "var _guidelinesSteps; $(document).ready(function() {"
        If cboStatus.SelectedValue = "Open" Or cboStatus.SelectedValue = "%" Then
            guidelines += GetMessage(675)
        ElseIf cboStatus.SelectedValue = "Finalized" Or cboStatus.SelectedValue = "Pending Approval" Then
            guidelines += GetMessage(676)
        End If
        guidelines += "});"
        guidelines = guidelines.Replace("GRIDVIEWREPORTS_CLIENTID", gridViewReports.ClientID).Replace("gridViewExpenses_CLIENTID", gridViewExpenses.ClientID).Replace("LBL72_CLIENTID", lbl72.ClientID)
        Page.ClientScript.RegisterClientScriptBlock(Me.GetType(), "Guidelines", guidelines, True)
    End Sub

    ''' <summary>
    ''' Executes when the user selects a different page on the reports gridview
    ''' </summary>
    ''' <param name="sender">system variable</param>
    ''' <param name="e">system variable</param>
    ''' <remarks>Clears the selected index of the expenses gridview when the page of the reports gridview is changed to ensure that the expenses listed for a previously selected report are not still displayed</remarks>
    Private Sub GridViewReports_PageIndexChanged(sender As Object, e As System.EventArgs) Handles gridViewReports.PageIndexChanged
        gridViewReports.SelectedIndex = -1
        gridViewExpenses.SelectedIndex = -1
    End Sub

    ''' <summary>
    ''' Executes when data is bound to the reports gridview
    ''' </summary>
    ''' <param name="sender">system variable</param>
    ''' <param name="e">system variable</param>
    ''' <remarks>Adds a tooltip to the select icon of a row</remarks>
    Private Sub GridViewReports_RowDataBound(sender As Object, e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles gridViewReports.RowDataBound
        e.Row.Cells(0).Attributes.Add("title", GetMessage(108))
    End Sub

    ''' <summary>
    ''' Executes when the selected index is changed on the reports gridview
    ''' </summary>
    ''' <param name="sender"></param>
    ''' <param name="e"></param>
    ''' <remarks>Sets a new report object to the report that was selected. Sets the labelReportname and gets the number of expenses 
    ''' that are in the report to check if the report has 25 expenses. If the report has 25 expenses, the report is locked and
    ''' no more expenses can be added.</remarks>
    Protected Sub GridViewReports_SelectedIndexChanged(ByVal sender As Object, ByVal e As EventArgs) Handles gridViewReports.SelectedIndexChanged
        Dim report As New Report(gridViewReports.SelectedDataKey.Value)

        txtStatusID.Text = report.Status
        labelReportName.Text = report.Name
        hdnReportID.Value = gridViewReports.SelectedDataKey.Value

        If Request.QueryString("submitted") <> 1 Then
            If Not IsNothing(report.Expenses) Then
                If report.Expenses.Count > 25 And report.Status = 1 Then Session("msg") = GetMessage(433)
            End If
        End If

        report = Nothing

        gridViewExpenses.SelectedIndex = -1
        Session("SelectedReport") = gridViewReports.SelectedIndex
    End Sub

    ''' <summary>
    ''' Called from jquery when a user clicks on the garbage can to delete an expense.
    ''' </summary>
    ''' <param name="expID">Expense ID</param>
    ''' <param name="puk">provider user key - unique key to identify a login</param>
    ''' <returns>An integer to verify if the delete succeeded. 1 = success, 0 = fail</returns>
    ''' <remarks>puk is used to verify that the user is allowed to 
    ''' delete the expense. To delete an expense, a user must be the creator or the supervisor or the delgate.</remarks>
    <System.Web.Services.WebMethod()>
    Public Shared Function DeleteExpense(expID As Integer, puk As String) As Integer
        Dim expense As New Expense(expID)


        Return expense.Delete(puk)

        expense = Nothing
    End Function

    ''' <summary>
    ''' Called from jquery when a user clicks on the garbage can to delete a report
    ''' </summary>
    ''' <param name="rptID">Report ID</param>
    ''' <param name="puk">provider user key - unique key to identify a login</param>
    ''' <remarks>puk is used used to identify if a user is allowed to delete the report.
    ''' A user can delete a report if they are the creator or the delegate.</remarks>
    <System.Web.Services.WebMethod()>
    Public Shared Sub DeleteReport(rptID As Integer, puk As String)
        Dim report As New Report(rptID)

        report.Delete(puk)

        report = Nothing
    End Sub

    ''' <summary>
    ''' Called when a user clicks the Save button or the Save+ button on the create expense screen
    ''' </summary>
    ''' <param name="savePlus">boolean to know if the user clicked the save button or the save+ button</param>
    ''' <remarks>Loads all the values contained in the webform into an expense object. I then calls the Create or Update method of the
    ''' expense oject depending if we are creating a new expense or updating an old expense. This is determined by the ID contained in the  
    ''' textbox txtExpenseID. If the value is 0, we are creating a new expense. If the value is anything other than 0, we are updating.
    ''' </remarks>
    Public Sub CreateExpense(Optional savePlus As Boolean = False)
        Dim expense As New Expense
        Dim organizationCategory As OrgCat
        Dim expenseDate As Date
        Dim report As Report
        Dim ParentOrganization As Org
        Dim organization As Org
        Dim amount As Decimal
        Dim currency As Currency
        'Dim changedFields As String
        Dim exchangeRate As Single
        Dim gstPaid As Single, qstPaid As Single

        Try
            organizationCategory = New OrgCat(hdnOrgCatID.Value)
            expenseDate = New Date(Right(hdnExpDate.Value, 4), Mid(hdnExpDate.Value, 4, 2), Left(hdnExpDate.Value, 2))

            linenum = 1
            expense.ReportID = gridViewReports.SelectedValue
            report = New Report(expense.ReportID)

            ParentOrganization = report.Emp.Organization.Parent

            organization = report.Emp.Organization
            linenum = 1
            expense.OrgCategory.ID = hdnOrgCatID.Value
            expense.OrgCategory.Category.ID = organizationCategory.Category.ID


            ' Fix for defect artf65234
            ' Cartegory 5 means category i...
            ' if we see the dropdown list in the aspx file DataValueField
            '<asp:DropDownList ID="cboTaxRate" runat="server" DataSourceID="sqlGetAirTaxRates" DataTextField="TR_DESCRIPTION" DataValueField="JUR_ID" /></td>
            ' the Datavalue field is associated to the Jurisdiction ID provided by the stored procedure
            If organizationCategory.Category.ID = 5 Then
                expense.Jurisdiction.ID = CInt(cboTaxRate.SelectedValue)
            Else
                expense.Jurisdiction.ID = cboJur.SelectedValue
            End If

            expense.CurrID = cboCurr.SelectedValue      'Curr not as in current but as in currency
            currency = New Currency(expense.CurrID)
            expense.TaxStatus = cboTaxIE.SelectedValue      'to be confirmed: taxIE = tax included/excluded, boolean
            expense.SupplierName = txtSupplier.Text
            expense.Gratuities = 0
            expense.Rate = 1
            If txtGrat.Text <> "" Then expense.Gratuities = CSng(txtGrat.Text)
            expense.Comment = txtComment.Text
            expense.Attendees = txtAttendees.Text
            expense.DateOfExpense = expenseDate
            linenum = 2
            If hdnGST.Value <> "" Then expense.GSTPaid = CSng(hdnGST.Value)
            If hdnQST.Value <> "" Then expense.QSTPaid = CSng(hdnQST.Value)

            If organizationCategory.Category.ID = 4 And organizationCategory.AllowanceAmt > 0 Then
                expense.Rate = CSng(organizationCategory.AllowanceAmt)
                txtAmt.Text = CSng(expense.Rate) * CSng(txtKM.Text)
            Else
                If cboRate.SelectedValue <> "" And cboRate.SelectedValue <> "0" Then expense.Rate = CSng(cboRate.SelectedValue)
            End If

            If organizationCategory.Category.IsAllowance And organizationCategory.Category.ID <> 4 And organizationCategory.AllowanceAmt > 0 Then
                expense.Amount = organizationCategory.AllowanceAmt
            Else
                expense.Amount = IIf(expense.TaxStatus = 1, CSng(txtAmt.Text), CSng(txtAmt.Text) + expense.GSTPaid + expense.QSTPaid)
            End If
            linenum = 3
            gstPaid = expense.GSTPaid
            qstPaid = expense.QSTPaid
            amount = (expense.Amount + expense.Gratuities)

            ' Get the exchange rate
            If currency.Symbol <> "CAD" Then
                '2017-04-27 Function GetExchangeRate not used anymore because the OANDA's API doesn't work anymore
                'exchangeRate = currency.GetExchangeRate(expense.DateOfExpense, expense.DateOfExpense)

                exchangeRate = currency.GetExchangeRateManual(expense.DateOfExpense, currency.Symbol)
                gstPaid = (gstPaid * exchangeRate) : gstPaid += gstPaid * ParentOrganization.InterestRate
                qstPaid = (qstPaid * exchangeRate) : qstPaid += qstPaid * ParentOrganization.InterestRate
                amount = (expense.Amount + expense.Gratuities) * exchangeRate
            End If

            expense.AmountCDN = IIf(expense.CurrID <> 25, amount + (amount * ParentOrganization.InterestRate), amount)

            ' 2017-05-24 - Fix for the missing penny in the report when using another currency than CAD
            ' expense.AmountCDN Is a Decimal, the Function Math.Round Is quite broken, we need to round the decimals lowly to make sure that it will round as expected
            expense.AmountCDN = Math.Round(expense.AmountCDN, 9, MidpointRounding.AwayFromZero)
            expense.AmountCDN = Math.Round(expense.AmountCDN, 8, MidpointRounding.AwayFromZero)
            expense.AmountCDN = Math.Round(expense.AmountCDN, 7, MidpointRounding.AwayFromZero)
            expense.AmountCDN = Math.Round(expense.AmountCDN, 6, MidpointRounding.AwayFromZero)
            expense.AmountCDN = Math.Round(expense.AmountCDN, 5, MidpointRounding.AwayFromZero)
            expense.AmountCDN = Math.Round(expense.AmountCDN, 4, MidpointRounding.AwayFromZero)
            expense.AmountCDN = Math.Round(expense.AmountCDN, 3, MidpointRounding.AwayFromZero)
            expense.AmountCDN = Math.Round(expense.AmountCDN, 2, MidpointRounding.AwayFromZero)

            expense.RITC = FormatNumber(expense.OrgCategory.Category.GetRITC(expense.Jurisdiction.ID, organization.OrgSizeGST, expense.DateOfExpense) * gstPaid * organization.GetCRAactualRatio("GST", expense.DateOfExpense, organization.GetCRA("GST", expense.DateOfExpense)), 2)

            ' If is Kilometers
            If expense.OrgCategory.Category.ID = 4 Then
                Select Case expense.Jurisdiction.ID
                    Case 2 : expense.RITC = expense.RITC * organization.kmON
                    Case 10 : expense.RITC = expense.RITC * organization.kmBC
                    Case 4 : expense.RITC = expense.RITC * organization.kmPEI
                End Select
            End If

            expense.ITC = FormatNumber(expense.OrgCategory.Category.GetITC(expense.Jurisdiction.ID, organization.OrgSizeGST, expense.DateOfExpense) * gstPaid * organization.GetCRAactualRatio("GST", expense.DateOfExpense, organization.GetCRA("GST", expense.DateOfExpense)), 2)
            expense.ITR = FormatNumber(expense.OrgCategory.Category.GetITR(expense.Jurisdiction.ID, organization.OrgSizeQST, expense.DateOfExpense) * qstPaid * organization.GetCRAactualRatio("QST", expense.DateOfExpense, organization.GetCRA("QST", expense.DateOfExpense)), 2)
            expense.Reimburse = Not chkDontReimburse.Checked

            If chkDontReimburse.Checked Then expense.TPNum = cboTP.SelectedValue

            If organizationCategory.RequiredSegments.IndexOf("P") <> -1 Then expense.Project = IIf(report.Emp.LockDefaultProject, report.Emp.DefaultProject.PWCNumber, cboProject.SelectedValue)
            If organizationCategory.RequiredSegments.IndexOf("C") <> -1 Then expense.CostCenter = IIf(organizationCategory.DefaultCostCenter.ID > 0, organizationCategory.DefaultCostCenter.PWCNumber, cboCC.SelectedValue)
            If organization.DisplayWorkOrder Then expense.WorkOrder = cboWO.SelectedValue

            'We will add some bits of validation here before we try anything
            Dim validationResults As ValidationResults = expense.Validate()

            If validationResults.IsValid Then
                If txtExpenseID.Text = 0 Then
                    expense.Create()
                    expense.ID = expense.GetLastID(hdnReportID.Value)
                Else
                    expense.ID = CInt(txtExpenseID.Text)

                    CompareExpense(expense)
                    expense.Update()
                End If

                Dim i As Integer

                If hdnSelectedReceipt.Value = 0 Then
                    i = UploadFile(FileUpload1, expense.ID)
                Else
                    i = GetUploadedFile(expense)
                End If


                linenum = 5
                Select Case i
                    Case 0 : Session("alert") = AdvataxesResources.My.Resources.Expenses.GenericErrorFileUpload
                    Case 1 : Session("msg") = AdvataxesResources.My.Resources.Expenses.ConfirmExpenseSave
                    Case 2 : Session("alert") = AdvataxesResources.My.Resources.Expenses.UploadedFileIsTooLarge
                End Select

                linenum = 6
            Else    'Hmmm, our expense is not valid
                For Each ValidationError As ValidationError In validationResults.Errors
                    Dim validationLabel As Label = Me.FindControl("validationError_" & ValidationError.Key)
                    If Not IsNothing(validationLabel) Then
                        validationLabel.Text = ValidationError.ErrorMessage
                        validationLabel.Visible = True
                    End If
                Next
            End If


        Catch e As Exception

            Session("Error") = e.Message

            'If Session("emp").isadvalorem Then
            '    Session("Error") = e.Message
            'Else
            '    Session("Error") = AdvataxesResources.My.Resources.Common.GenericUnhandledError
            'End If
            Response.Redirect("~/error.aspx")

        Finally
            txtExpenseID.Text = 0
            gridViewExpenses.DataBind()
            expense = Nothing
            organizationCategory = Nothing
            ParentOrganization = Nothing
            organization = Nothing
            currency = Nothing
            If IsNothing(Session("SelectedReport")) Then Session("SelectedReport") = 0 'if selected index was never changed on report grid, set selected report to the first record in grid
            If Session("error") = "" Then Response.Redirect("reports.aspx" & IIf(savePlus, "?ce=1", IIf(IsNothing(Request.QueryString("submitted")), "", "?submitted=1"))) 'ce=1: create another expense, save plus button was clicked
        End Try

    End Sub

    ''' <summary>
    ''' Called when a user saves an expense
    ''' </summary>
    ''' <param name="updatedExpense">The expense object containing changed or new values if any</param>
    ''' <remarks>This routine accepts an expense object with all the values contained in the expense screen. It then creates a new expense object
    ''' containing all the values that are contained in the table. It then compares the table values and the screen values to find any differences.
    ''' If any differences are found, then those differences are written to tblAuditTrail to keep track of any changes made.</remarks>
    Private Sub CompareExpense(updatedExpense As Expense)
        'routine to compare old values with new values to find out which fields have been modified
        Dim expense As Expense

        Try
            expense = New Expense(updatedExpense.ID)
            If FormatNumber(expense.Amount, 2) <> FormatNumber(updatedExpense.Amount, 2) Then CreateAuditTrail(expense.ID, Session("emp").id, "tblExpense", "Amount", "Modified Expense", FormatNumber(expense.Amount, 2), FormatNumber(updatedExpense.Amount, 2), "Report:" & expense.Rpt.Name)
            If expense.Attendees <> updatedExpense.Attendees Then CreateAuditTrail(expense.ID, Session("emp").id, "tblExpense", "Attendees", "Modified Expense", expense.Attendees, updatedExpense.Attendees, "Report:" & expense.Rpt.Name)
            If expense.Comment <> updatedExpense.Comment Then CreateAuditTrail(expense.ID, Session("emp").id, "tblExpense", "Comment", "Modified Expense", expense.Comment, updatedExpense.Comment, "Report:" & expense.Rpt.Name)
            If expense.CostCenter <> updatedExpense.CostCenter Then CreateAuditTrail(expense.ID, Session("emp").id, "tblExpense", "Cost Center", "Modified Expense", expense.CostCenter, updatedExpense.CostCenter, "Report:" & expense.Rpt.Name)
            If expense.Currency.ID <> updatedExpense.CurrID Then CreateAuditTrail(expense.ID, Session("emp").id, "tblExpense", "Currency", "Modified Expense", expense.CurrID, updatedExpense.CurrID, "Report:" & expense.Rpt.Name)
            If expense.DateOfExpense <> updatedExpense.DateOfExpense Then CreateAuditTrail(expense.ID, Session("emp").id, "tblExpense", "Expense Date", "Modified Expense", expense.DateOfExpense, updatedExpense.DateOfExpense, "Report:" & expense.Rpt.Name)
            If FormatNumber(expense.Gratuities, 2) <> FormatNumber(updatedExpense.Gratuities, 2) Then CreateAuditTrail(expense.ID, Session("emp").id, "tblExpense", "Tip", "Modified Expense", FormatNumber(expense.Gratuities, 2), FormatNumber(updatedExpense.Gratuities, 2), "Report:" & expense.Rpt.Name)
            If FormatNumber(expense.GSTPaid, 2) <> FormatNumber(updatedExpense.GSTPaid, 2) And FormatNumber(expense.Amount, 2) = FormatNumber(updatedExpense.Amount, 2) Then CreateAuditTrail(expense.ID, Session("emp").id, "tblExpense", "GST", "Modified Expense", FormatNumber(expense.GSTPaid, 2), FormatNumber(updatedExpense.GSTPaid, 2), "Report:" & expense.Rpt.Name)
            If FormatNumber(expense.QSTPaid, 2) <> FormatNumber(updatedExpense.QSTPaid, 2) And FormatNumber(expense.Amount, 2) = FormatNumber(updatedExpense.Amount, 2) Then CreateAuditTrail(expense.ID, Session("emp").id, "tblExpense", "QST", "Modified Expense", FormatNumber(expense.QSTPaid, 2), FormatNumber(updatedExpense.QSTPaid, 2), "Report:" & expense.Rpt.Name)
            If expense.Jurisdiction.ID <> updatedExpense.Jurisdiction.ID Then CreateAuditTrail(expense.ID, Session("emp").id, "tblExpense", "Jurisdiction", "Modified Expense", expense.Jurisdiction.Name, updatedExpense.Jurisdiction.Name, "Report:" & expense.Rpt.Name)
            If expense.Project <> updatedExpense.Project Then CreateAuditTrail(expense.ID, Session("emp").id, "tblExpense", "Project", "Modified Expense", expense.Project, updatedExpense.Project, "Report:" & expense.Rpt.Name)
            If FormatNumber(expense.Rate, 2) <> FormatNumber(updatedExpense.Rate, 2) Then CreateAuditTrail(expense.ID, Session("emp").id, "tblExpense", "Rate", "Modified Expense", FormatNumber(expense.Rate, 2), FormatNumber(updatedExpense.Rate, 2), "Report:" & expense.Rpt.Name)
            If expense.ReceiptName <> updatedExpense.ReceiptName Then CreateAuditTrail(expense.ID, Session("emp").id, "tblExpense", "Receipt", "Modified Expense", "", "", "Report:" & expense.Rpt.Name)
            If expense.Reimburse <> updatedExpense.Reimburse Then CreateAuditTrail(expense.ID, Session("emp").id, "tblExpense", "Reimburse", "Modified Expense", expense.Reimburse, updatedExpense.Reimburse, "Report:" & expense.Rpt.Name)
            If expense.SupplierName <> updatedExpense.SupplierName Then CreateAuditTrail(expense.ID, Session("emp").id, "tblExpense", "Supplier", "Modified Expense", expense.SupplierName, updatedExpense.SupplierName, "Report:" & expense.Rpt.Name)
            If expense.TPNum <> updatedExpense.TPNum Then CreateAuditTrail(expense.ID, Session("emp").id, "tblExpense", "Third Party", "Modified Expense", expense.TPName, updatedExpense.TPName, "Report:" & expense.Rpt.Name)
            If expense.WorkOrder <> updatedExpense.WorkOrder Then CreateAuditTrail(expense.ID, Session("emp").id, "tblExpense", "Work Order", "Modified Expense", expense.WorkOrder, updatedExpense.WorkOrder, "Report:" & expense.Rpt.Name)

        Catch ex As Exception
            Throw ex
        Finally
            expense = Nothing
        End Try

    End Sub

    ''' <summary>
    ''' Retrieves a receipt that is stored in tblUploadedReceipts. This receipt wes uploaded by the user using their phone and they are
    ''' now using that receipt to fill out an expense.
    ''' </summary>
    ''' <param name="expense">The expense to which the user is attaching the receipt</param>
    ''' <returns>0 if the attach failed, 1 if it succeeded</returns>
    ''' <remarks>Gets the uploaded file from tblUploadedReceipts, attaches it to the expense and then deletes it from tblUploadedReceipts</remarks>
    Private Function GetUploadedFile(expense As Expense) As Integer
        GetConnectionString()
        Dim sqlConn = New SqlConnection(connString.ConnectionString)
        Dim i As Integer = 1
        sqlConn.Open()
        Dim com As SqlCommand = New SqlCommand("GetReceipt", sqlConn)
        Dim rs As SqlDataReader

        Try
            com.CommandType = CommandType.StoredProcedure
            com.Parameters.Add(New SqlParameter("@ID", SqlDbType.Int)).Value = hdnSelectedReceipt.Value
            com.Connection = sqlConn
            rs = com.ExecuteReader

            While rs.Read
                UploadFile(rs("RECEIPT"), rs("RECEIPT_TYPE"), rs("RECEIPT_DATE"), expense.ID)
                DeleteUploadedReceipt()
                Session("selectedEmp") = New Employee(CInt(Session("selectedEmp").id))
            End While


        Catch ex As Exception
            i = 0

        Finally
            rs.Close()
            com.Dispose()
            com = Nothing
            sqlConn.Close()
            sqlConn = Nothing
            rs = Nothing
        End Try

        Return i
    End Function

    ''' <summary>
    ''' Called from GetUploadedFile. Deletes the receipt from tblUploadedReceipt once it is used for an expense
    ''' </summary>
    ''' <remarks></remarks>
    Private Sub DeleteUploadedReceipt()

        GetConnectionString()
        Dim sqlConn = New SqlConnection(connString.ConnectionString)
        Dim com As SqlCommand = New SqlCommand("DeleteUploadedReceipt", sqlConn)

        Try
            sqlConn.Open()
            com.CommandType = CommandType.StoredProcedure
            com.Parameters.Add(New SqlParameter("@ID", SqlDbType.Int)).Value = hdnSelectedReceipt.Value
            com.Connection = sqlConn
            com.ExecuteNonQuery()

        Catch ex As Exception
            Throw New Exception

        Finally
            com.Dispose()
            com = Nothing
            sqlConn.Close()
            sqlConn = Nothing
        End Try
    End Sub

    ''' <summary>
    ''' Called when a user selects a status from the cboStatus dropdown
    ''' </summary>
    ''' <param name="sender"></param>
    ''' <param name="e"></param>
    ''' <remarks>When the status is changed, it checks to see if the status is "Open". If so, it will automatically retrieve the expenses
    ''' for the open report and display them. If the status isn't "Open", it will clear the grids and display nothing.</remarks>
    Private Sub cboStatus_SelectedIndexChanged(sender As Object, e As System.EventArgs) Handles cboStatus.SelectedIndexChanged
        Try
            hdnReportID.Value = ""
            gridViewReports.SelectedIndex = -1
            gridViewExpenses.DataBind()
            labelReportName.Text = ""

            If cboStatus.SelectedIndex = 1 AndAlso Not isSubmitted Then
                Dim report As New Report

                report.GetOpenReport(Session("selectedEmp").id)
                txtStatusID.Text = report.Status
                gridViewReports.SelectedIndex = 0
                hdnReportID.Value = report.ID
                report = Nothing

            ElseIf cboStatus.SelectedIndex <> 1 And Request.QueryString("submitted") = "" Then
                txtStatusID.Text = "0"
            End If

        Catch ex As Exception

            Throw ex
        End Try

    End Sub

    Public Sub Cancel()
        txtExpenseID.Text = 0
    End Sub


    Public Sub CloseModal()
        modalCreateReport.Hide()
    End Sub

    ''' <summary>
    ''' Called when a user makes a selection from the delegate dropdown list
    ''' </summary>
    ''' <param name="sender"></param>
    ''' <param name="e"></param>
    ''' <remarks>Changes the datasource of the reports grid depending on what value is selected. Allows the grid to be filtered by
    ''' a combination of dates, employees and status</remarks>
    Private Sub cboEmp_SelectedIndexChanged(sender As Object, e As System.EventArgs) Handles cboEmp.SelectedIndexChanged
        If cboEmp.SelectedItem.Text = "All" Then
            If cboStatus.SelectedIndex = 0 Then
                gridViewReports.DataSourceID = "sqlReportsBySuperID"
            Else
                gridViewReports.DataSourceID = "sqlReportsBySuperIDWithDates"
            End If

        Else
            If cboStatus.SelectedIndex = 0 Then
                gridViewReports.DataSourceID = "sqlReportsBySuperIDandEmpID"
            Else
                gridViewReports.DataSourceID = "sqlReportsBySuperIDandEmpIDWithDates"
            End If

        End If

        hdnReportID.Value = ""

        gridViewReports.SelectedIndex = -1
        gridViewExpenses.SelectedIndex = -1
        gridViewReports.DataBind()
    End Sub

    ''' <summary>
    ''' Called from jquery when a user clicks on the + symbol that might appear in the first column of the expense grid when there is extra info
    ''' to display
    ''' </summary>
    ''' <param name="expID">Expense ID</param>
    ''' <returns>A string value in the form of a table row containing extra data to display in a new row of the expense grid</returns>
    ''' <remarks>Retrieves extra info like comments, attendees, uploaded receipt date, and creates a new row in the expense grid to display
    ''' to the user</remarks>
    <System.Web.Services.WebMethod()>
    Public Shared Function GetOtherExpenseDetails(expID As Integer) As String
        Dim expense As New Expense(expID)
        Dim sbReturnValue As New StringBuilder
        Dim sbFilterAngleBrackets As New StringBuilder

        sbReturnValue.Append("<tr><td colspan='20'>")

        If Not IsDBNull(expense.Attendees) And expense.Attendees <> "" Then
            'remove any illegal angle brackets
            sbFilterAngleBrackets.Append(expense.Attendees)
            sbFilterAngleBrackets.Replace("<", "")
            sbFilterAngleBrackets.Replace(">", "")

            If sbReturnValue.ToString <> "<tr><td colspan='20'>" Then sbReturnValue.Append("<br />")
            sbReturnValue.Append("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" & GetMessage(369) & ": " & sbFilterAngleBrackets.ToString)

        End If

        If Not IsDBNull(expense.Comment) And expense.Comment <> "" Then
            'remove any illegal angle brackets
            sbFilterAngleBrackets.Append(expense.Comment)
            sbFilterAngleBrackets.Replace("<", "")
            sbFilterAngleBrackets.Replace(">", "")

            If sbReturnValue.ToString <> "<tr><td colspan='20'>" Then sbReturnValue.Append("<br />")
            sbReturnValue.Append("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" & GetMessage(48) & ": " & sbFilterAngleBrackets.ToString)

        End If

        If Not IsDBNull(expense.ReceiptDate) And expense.ReceiptDate <> "#12:00:00 AM#" Then
            If sbReturnValue.ToString <> "<tr><td colspan='20'>" Then sbReturnValue.Append("<br />")
            sbReturnValue.Append("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" & GetMessage(561) & ": " & expense.ReceiptDate.ToShortDateString)
        End If

        sbReturnValue.Append("</td></tr>")
        expense = Nothing

        Return sbReturnValue.ToString
    End Function


    ''' <summary>
    ''' Called from jquery to approve a report when a supervisor clicks the green thumbs up in the reports gridview
    ''' </summary>
    ''' <param name="rptID">Report ID</param>
    ''' <param name="puk">provider user key - unique key to identify a login</param>
    ''' <returns>0 if the approve failed, 1 if the approve succeeded</returns>
    ''' <remarks></remarks>
    <System.Web.Services.WebMethod()>
    Public Shared Function ApproveReport(rptID As Integer, puk As String) As String
        Dim report As New Report(rptID)

        Return report.Approve(puk)

        report = Nothing
    End Function

    ''' <summary>
    ''' Called from jquery to check that the logged in user owns the receipt being used 
    ''' </summary>
    ''' <param name="rID">Receipt ID</param>
    ''' <param name="puk">provider user key - unique key to identify a login</param>
    ''' <remarks></remarks>
    <System.Web.Services.WebMethod()>
    Public Shared Sub CheckReceiptNum(rID As Integer, puk As String)
        Dim receipt As New UploadedReceipt(rID)
        Dim loggedInUser As Employee

        Try
            If puk = Membership.GetUser.ProviderUserKey.ToString Then
                loggedInUser = New Employee(Membership.GetUser.UserName)
                If loggedInUser.ID <> receipt.Owner.ID Then
                    Throw New Exception
                End If
            End If

        Catch ex As Exception
            Throw ex

        Finally
            receipt = Nothing
            loggedInUser = Nothing
        End Try
    End Sub

    ''' <summary>
    ''' Called from jquery to finalize a report when a finalizer clicks on the gold thumbs up in the reports gridview
    ''' </summary>
    ''' <param name="rptID">Report ID</param>
    ''' <param name="puk">provider user key - unique key to identify a login</param>
    ''' <returns>0 if the finalize failed, 1 if the finalize succeeded</returns>
    ''' <remarks></remarks>
    <System.Web.Services.WebMethod()>
    Public Shared Function FinalizeReport(rptID As Integer, puk As String) As String
        Dim report As New Report(rptID)

        Return report.FinalizeReport(puk)

        report = Nothing
    End Function


    ''' <summary>
    ''' Called from jquery when a supervisor or finalizer clicks the red thumbs down on the reports gridview
    ''' </summary>
    ''' <param name="rptID">Report ID</param>
    ''' <param name="reason">The reason the report was rejected</param>
    ''' <param name="puk">provider user key - unique key to identify a login</param>
    ''' <returns>0 if the reject failed, 1 if the reject succeeded</returns>
    ''' <remarks></remarks>
    <System.Web.Services.WebMethod()>
    Public Shared Function RejectReport(rptID As Integer, reason As String, puk As String) As String
        Dim report As New Report(rptID)

        report.ReasonRejected = reason

        Return report.Reject(puk)

        report = Nothing
    End Function


    ''' <summary>
    ''' Function was written to reverse a report but the actual functionality to reverse a report has not been implemented 
    ''' in the application yet. 
    ''' </summary>
    ''' <param name="rptID">Report ID</param>
    ''' <param name="puk">provider user key - unique key to identify a login</param>
    ''' <returns></returns>
    ''' <remarks></remarks>

    <System.Web.Services.WebMethod()>
    Public Shared Function ReverseReport(rptID As Integer, puk As String) As String
        Dim report As New Report(rptID)
        Dim RevID As Integer
        Dim expense As Expense
        Dim s As String
        s = ""
        Dim approver As Employee

        Try
            If puk = Membership.GetUser.ProviderUserKey.ToString Then
                approver = New Employee(Membership.GetUser.UserName)

                If approver.ID = report.Emp.Supervisor Then
                    report.ID = 0
                    report.Create(report.Name, report.Emp.Organization.ID, report.Emp.ID, iREVERSED)
                    RevID = report.GetLastID(report.Emp.ID)
                    report = Nothing
                    report = New Report(RevID)
                    report.UpdateStatus(iREVERSED)
                    report = Nothing
                    report = New Report(rptID)
                    report.ReversedID = RevID
                    report.Update()

                    For Each expense In report.Expenses
                        expense.ReportID = RevID
                        expense.Gratuities = 0 - expense.Gratuities
                        expense.Amount = 0 - expense.Amount
                        expense.GSTPaid = 0 - expense.GSTPaid
                        expense.QSTPaid = 0 - expense.QSTPaid
                        expense.ITC = 0 - expense.ITC
                        expense.ITR = 0 - expense.ITR
                        expense.RITC = 0 - expense.RITC
                        expense.AmountCDN = 0 - expense.AmountCDN
                        expense.Create()
                    Next
                    s = ""

                End If
            End If

        Catch ex As Exception
            s = ex.Message

        Finally
            expense = Nothing
            report = Nothing
            approver = Nothing
        End Try

        Return s
    End Function

    ''' <summary>
    ''' Called from jquery to submit a report when the user clicks on the "Submit Report" icon
    ''' </summary>
    ''' <param name="rptID">Report ID of the report to submit</param>
    ''' <param name="puk">provider user key - unique key to identify the user login</param>
    ''' <returns>0 if the submit failed, 1 if the submit succeeded and a message if there was a failure sending the notification emails</returns>
    ''' <remarks></remarks>
    <System.Web.Services.WebMethod()>
    Public Shared Function SubmitReport(rptID As Integer, puk As String) As Dictionary(Of String, String)
        Dim report As New Report(rptID)

        Return report.Submit(puk)

        report = Nothing
    End Function


    ''' <summary>
    ''' Gets the values for a selected report
    ''' </summary>
    ''' <param name="rptID">Report ID of the selected report</param>
    ''' <param name="puk">provider user key - unique key to identify the user login</param>
    ''' <returns>An array containing all report values</returns>
    ''' <remarks></remarks>
    <System.Web.Services.WebMethod()>
    Public Shared Function GetReport(rptID As Integer, puk As String) As Dictionary(Of String, String)
        Dim report As New Report(rptID)
        Dim reportDictionary As New Dictionary(Of String, String)
        Dim loggedInUser As Employee

        Try
            If puk = Membership.GetUser.ProviderUserKey.ToString Then
                loggedInUser = New Employee(Membership.GetUser.UserName)
                If loggedInUser.ID = report.Emp.ID Or loggedInUser.ID = report.Emp.Supervisor Or loggedInUser.ID = report.Emp.DelegatedTo Then
                    With reportDictionary
                        .Add("ReportName", report.Name)
                        .Add("ReportStatus", report.Status)
                        .Add("CreatedDate", report.CreatedDate)
                        .Add("JurisdictionID", report.Emp.Organization.Jur.ID)
                        .Add("DefaultProject", report.Emp.DefaultProject.PWCNumber)
                    End With

                Else
                    Throw New Exception
                End If
            Else
                Throw New Exception
            End If

        Catch ex As Exception
            Throw ex

        Finally
            report = Nothing
            loggedInUser = Nothing
        End Try

        Return reportDictionary

    End Function

    ''' <summary>
    ''' Called by jquery to get the values related to an expense
    ''' </summary>
    ''' <param name="expID">Expense ID of selected expense</param>
    ''' <param name="puk">provider user key - unique key to identify a login</param>
    ''' <returns>An array of expense values</returns>
    ''' <remarks>puk is used to validate if the logged in user is allowed to access the expense. User's allowed to access the expense are
    ''' the creator, supervisor, finalizer and delegate</remarks>
    <System.Web.Services.WebMethod()>
    Public Shared Function GetExpense(expID As Integer, puk As String) As Dictionary(Of String, String)
        Dim expenseDictionary As New Dictionary(Of String, String)
        Dim expense As Expense
        Dim loggedInUser As Employee

        Try
            If puk = Membership.GetUser.ProviderUserKey.ToString Then
                loggedInUser = New Employee(Membership.GetUser.UserName)
                expense = New Expense(expID)

                If loggedInUser.ID = expense.Rpt.Emp.ID Or loggedInUser.ID = expense.Rpt.Emp.Supervisor Or loggedInUser.ID = expense.Rpt.Emp.DelegatedTo Or loggedInUser.ID = expense.Rpt.Emp.Finalizer Then

                    With expenseDictionary
                        .Add("Comment", expense.Comment)
                        .Add("CategoryID", expense.OrgCategory.Category.ID)
                        .Add("Amount", IIf(expense.TaxStatus = 1, expense.Amount, expense.Amount - expense.GSTPaid - expense.QSTPaid - expense.Gratuities))
                        .Add("CurrencyID", expense.CurrID)
                        .Add("ExpenseDate", expense.DateOfExpense)
                        .Add("Gratuities", expense.Gratuities)
                        .Add("JurisdictionID", expense.Jurisdiction.ID)
                        .Add("Rate", expense.Rate)
                        .Add("Supplier", expense.SupplierName)
                        .Add("TaxStatus", expense.TaxStatus)
                        .Add("AllowSupplier", expense.OrgCategory.Category.AllowSupplier)
                        .Add("AllowAmount", expense.OrgCategory.Category.AllowAmt)
                        .Add("AllowGratuity", expense.OrgCategory.Category.AllowGratuity)
                        .Add("AllowJurisdiction", expense.OrgCategory.Category.AllowJur)
                        .Add("AllowKM", expense.OrgCategory.Category.AllowKM)
                        .Add("AllowNote", expense.OrgCategory.Category.AllowNote)
                        .Add("AllowRate", expense.OrgCategory.Category.AllowRate)
                        .Add("AllowTaxRate", expense.OrgCategory.Category.AllowTaxRate)
                        .Add("GSTPaid", FormatNumber(expense.GSTPaid, 2))
                        .Add("QSTPaid", FormatNumber(expense.QSTPaid, 2))
                        .Add("OrgCategoryID", expense.OrgCategory.ID)
                        .Add("ReceiptName", IIf(IsNothing(expense.ReceiptName), "", expense.ReceiptName))
                        .Add("Reimburse", IIf(expense.Reimburse, "0", "1"))
                        .Add("Total", expense.Amount)
                        .Add("Project", expense.Project)
                        .Add("WorkOrder", expense.WorkOrder)
                        .Add("CostCenter", expense.CostCenter)
                        .Add("IsAllowance", expense.OrgCategory.Category.IsAllowance)
                        .Add("AllowanceAmount", expense.OrgCategory.AllowanceAmt)
                        .Add("TPNum", expense.TPNum)
                        .Add("AllowAttendees", expense.OrgCategory.Category.AllowAttendees)
                        .Add("Attendees", expense.Attendees)
                        .Add("RequiredSegments", expense.OrgCategory.RequiredSegments)
                        If expense.OrgCategory.Category.ID = 4 Then .Add("NumberOfKM", CInt(expense.Amount / expense.Rate))
                    End With
                Else
                    Throw New Exception
                End If
            Else
                Throw New Exception
            End If

        Catch ex As Exception
            Throw ex

        Finally
            expense = Nothing
            loggedInUser = Nothing
        End Try

        Return expenseDictionary
    End Function


    ''' <summary>
    ''' Called from jquery to get the GST and QST to calculate the taxes on an expense
    ''' </summary>
    ''' <param name="jurID">Jurisdiction ID of the expense</param>
    ''' <param name="catID">category ID of the expense</param>
    ''' <param name="expDate">Transaction date of the expense</param>
    ''' <param name="taxIncExc">Expense is defined as 1 = tax included or 0 = before tax</param>
    ''' <param name="orgCatID">organization category ID</param>
    ''' <param name="kmRate">The KM rate the user selected if the expense is defined as kilometers</param>
    ''' <returns>An array containing the GST/HST, QST, KM value, if the expense is an allowance, allowance amount </returns>
    ''' <remarks></remarks>

    <System.Web.Services.WebMethod()>
    Public Shared Function GetTaxRates(jurID As Integer, catID As Integer, expDate As String, taxIncExc As Integer, orgCatID As Integer, kmRate As Single) As Dictionary(Of String, String)
        Dim category As New Category(catID)
        Dim categoryDictionary As New Dictionary(Of String, String)
        Dim validateKM As Integer
        Dim organizationCategory As New OrgCat(orgCatID)


        validateKM = 1

        'if category is KM
        If catID = iKM_ALLOWANCE Then
            Dim organization As New Org(organizationCategory.OrgID)

            'check that the KM rate selected is below the allowable limit for the selected jurisdiction and date. 
            'if the KM rate entered goes over the allowable limit, a message will be displayed on the create expense screen
            validateKM = organization.ValidateKMRate(jurID, kmRate, expDate)

            organization = Nothing
        End If

        With categoryDictionary
            .Add("GSTHST", category.GetGST(jurID, catID, expDate, taxIncExc) * validateKM)
            .Add("QST", category.GetQST(jurID, catID, expDate, taxIncExc) * validateKM)
            If categoryDictionary("GSTHST") = "0" Then categoryDictionary("GSTHST") = category.GetHST(jurID, catID, expDate, taxIncExc) * validateKM
            .Add("ValidateKM", validateKM)
            .Add("IsAllowance", organizationCategory.Category.IsAllowance)
            .Add("AllowanceAmount", organizationCategory.AllowanceAmt)
        End With

        category = Nothing
        organizationCategory = Nothing
        Return categoryDictionary

    End Function

    ''' <summary>
    ''' Called from jquery when an expense type is selected from cboCat on the expense screen.
    ''' Determines which fields to show on the expense screen depending what expense type has been selected
    ''' </summary>
    ''' <param name="orgCatID">organization category ID</param>
    ''' <param name="lang">language</param>
    ''' <returns>An array defining which fields to display on the create expense screen</returns>
    ''' <remarks></remarks>
    <System.Web.Services.WebMethod()>
    Public Shared Function GetAllows(orgCatID As Integer, lang As String) As Dictionary(Of String, String)
        Dim organizationCategory As OrgCat
        Dim category As Category
        Dim categoryDictionary As New Dictionary(Of String, String)

        Try
            organizationCategory = New OrgCat(orgCatID)
            category = New Category(organizationCategory.CatID)

            With categoryDictionary
                .Add("AllowSupplier", category.AllowSupplier)
                .Add("AllowRate", category.AllowRate)
                .Add("AllowGratuity", category.AllowGratuity)
                .Add("AllowJurisdiction", category.AllowJur)
                .Add("AllowKM", category.AllowKM)
                .Add("AllowAmount", category.AllowAmt)
                .Add("AllowTaxRate", category.AllowTaxRate)
                .Add("CategoryID", category.ID)
                .Add("AllowTaxIncludedExcluded", category.AllowTaxIE)
                .Add("AllowReimburse", category.AllowReimburse)
                .Add("AllowanceAmount", organizationCategory.AllowanceAmt)
                .Add("IsAllowance", category.IsAllowance)
                .Add("RequiredSegments", organizationCategory.RequiredSegments)
                .Add("AllowAttendees", category.AllowAttendees)
                .Add("LimitMessage", GetMessage(368, lang))
                .Add("DefaultCostCenter", IIf(organizationCategory.DefaultCostCenter.ID > 0, organizationCategory.DefaultCostCenter.PWCNumber, 0))
            End With


        Catch ex As Exception
            Throw ex

        Finally
            category = Nothing
            organizationCategory = Nothing
        End Try

        Return categoryDictionary

    End Function


    ''' <summary>
    ''' Called from jquery when a user clicks on the calendar icon in the report gridview. 
    ''' Displays all dates associated with the selected report
    ''' </summary>
    ''' <param name="rptID">Report ID of the selected report</param>
    ''' <param name="puk">provider user key - Unique key to identify a login</param>
    ''' <returns>A string in the form of a html table to display all dates associated with the selected report</returns>
    ''' <remarks></remarks>
    <System.Web.Services.WebMethod()>
    Public Shared Function GetDates(rptID As Integer, puk As String) As String
        Dim report As Report
        Dim employee As Employee
        Dim stringBuilder As New StringBuilder
        Dim approvedby As String = ""
        Dim rejectedby As String = ""
        Dim finalizedby As String = ""
        Dim loggedInUser As Employee

        Try
            report = New Report(rptID)

            If puk = Membership.GetUser.ProviderUserKey.ToString Then
                loggedInUser = New Employee(Membership.GetUser.UserName)

                If loggedInUser.ID = report.Emp.ID Or loggedInUser.ID = report.Emp.Supervisor Or loggedInUser.ID = report.Emp.DelegatedTo Or loggedInUser.Organization.ID = report.Emp.ID Or (loggedInUser.Organization.Parent.ID = report.Emp.Organization.Parent.ID And loggedInUser.IsAdmin) Then
                    If Not IsDBNull(report.FinalizedBy) Then
                        If report.FinalizedBy > 0 Then
                            employee = New Employee(report.FinalizedBy)
                            finalizedby = employee.FirstName & " " & employee.LastName
                            employee = Nothing
                        End If
                    End If

                    If Not IsDBNull(report.RejectedBy) Then
                        If report.RejectedBy > 0 Then
                            employee = New Employee(report.RejectedBy)
                            rejectedby = employee.FirstName & " " & employee.LastName
                            employee = Nothing
                        End If
                    End If

                    If Not IsDBNull(report.ApprovedBy) Then
                        If report.ApprovedBy > 0 Then
                            employee = New Employee(report.ApprovedBy)
                            approvedby = employee.FirstName & " " & employee.LastName
                            employee = Nothing
                        End If
                    End If

                    stringBuilder.Append("<br><table width='100%' border=0>")
                    stringBuilder.Append("<tr style='height:20px;'><td rowspan='10' valign='top'><img src='/images/calendar2.png' /></td><td></td><td width='125px' class='labelText'>" & GetMessage(77, loggedInUser.DefaultLanguage) & ":</td><td class='labelText' align='right'>" & report.CreatedDate & "</td></tr>")

                    Select Case report.Status
                        Case 3 : stringBuilder.Append("<tr style='height:20px;'><td></td><td class='labelText' width='125px'>" & GetMessage(58, loggedInUser.DefaultLanguage) & ":</td><td class='labelText' align='right'>" & report.SubmittedDate & "</td></tr><tr><td></td><td class='labelText'>" & GetMessage(253, loggedInUser.DefaultLanguage) & ":</td><td class='labelText' align='right'>" & report.ApprovedDate & "</td></tr><tr><td></td><td class='labelText'>" & GetMessage(253, loggedInUser.DefaultLanguage) & " " & GetMessage(254, loggedInUser.DefaultLanguage) & ":</td><td class='labelText' align='right'>" & approvedby & "</td></tr>")
                        Case 4 : stringBuilder.Append("<tr style='height:20px;'><td></td><td class='labelText' width='125px'>" & GetMessage(58, loggedInUser.DefaultLanguage) & ":</td><td class='labelText' align='right'>" & report.SubmittedDate & "</td></tr><tr><td></td><tr><td></td><td class='labelText'>" & GetMessage(78, loggedInUser.DefaultLanguage) & ":</td><td class='labelText' align='right'>" & report.FinalizedDate & " </td></tr><tr><td></td><td class='labelText'>" & GetMessage(78, loggedInUser.DefaultLanguage) & " " & GetMessage(254, loggedInUser.DefaultLanguage) & ":</td><td class='labelText' align='right'>" & finalizedby & "</td></tr>")
                        Case 5 : stringBuilder.Append("<tr style='height:20px;'><td></td><td class='labelText' width='125px'>" & GetMessage(58, loggedInUser.DefaultLanguage) & ":</td><td class='labelText' align='right'>" & report.SubmittedDate & "</td></tr><tr><td></td><td class='labelText'>" & GetMessage(438, loggedInUser.DefaultLanguage) & ":</td><td class='labelText' align='right'>" & report.RejectedDate & "</td></tr><tr><td class='labelText'>" & GetMessage(438, loggedInUser.DefaultLanguage) & " " & GetMessage(254, loggedInUser.DefaultLanguage) & ":</td><td align='right'>" & rejectedby & "</td></tr>")
                    End Select

                    stringBuilder.Append("</table>")
                Else
                    Throw New Exception
                End If
            Else
                Throw New Exception
            End If

        Catch ex As Exception
            Throw ex

        Finally
            report = Nothing
            loggedInUser = Nothing
            employee = Nothing
        End Try

        Return stringBuilder.ToString

    End Function


    ''' <summary>
    ''' Called from jquery when a user clicks the delete receipt link on the create expense screen.
    ''' </summary>
    ''' <param name="expID">Expense ID that the receipt is attached to </param>
    ''' <param name="puk">provider user key - Unique key to identify a login</param>
    ''' <remarks>puk is used to validate if the logged in user is allowed to delete the receipt. Users who are allowed to delete the receipt
    ''' are the creator/delegate, supervisor, finalizer</remarks>
    <System.Web.Services.WebMethod()>
    Public Shared Sub DeleteReceipt(expID As Integer, puk As String)
        Dim expense As New Expense(expID)
        Dim report As New Report(expense.ReportID)
        Dim loggedInUser As Employee

        If puk = Membership.GetUser.ProviderUserKey.ToString Then
            loggedInUser = New Employee(Membership.GetUser.UserName)

            If loggedInUser.ID = report.Emp.Supervisor Or loggedInUser.ID = report.Emp.Finalizer Or loggedInUser.ID = report.Emp.ID Then
                expense.DeleteReceipt(expID)
                CreateAuditTrail(expID, loggedInUser.ID, "tblExpense", "Receipt", "Deleted Receipt", "", "", "Report:" & expense.Rpt.Name)
                loggedInUser = Nothing
            End If
        End If

        report = Nothing
        expense = Nothing
    End Sub

    ''' <summary>
    ''' Called when a user clicks on the Save Expense button on the Create Expense screen
    ''' </summary>
    ''' <param name="sender"></param>
    ''' <param name="e"></param>
    ''' <remarks>Calls CreateExpense</remarks>
    Private Sub cmdSaveExpense_Click(sender As Object, e As System.EventArgs) Handles cmdSaveExpense.Click
        CreateExpense()
    End Sub

    ''' <summary>
    ''' Called when a user clicks the Save+ button on the Create Expense screen
    ''' </summary>
    ''' <param name="sender"></param>
    ''' <param name="e"></param>
    ''' <remarks>Calls CreateExpense with a parameter value of true to specify this is a Save+. 
    ''' Saves the expense date for the next expense</remarks>
    Private Sub cmdSaveExpense2_Click(sender As Object, e As System.EventArgs) Handles cmdSaveExpense2.Click
        CreateExpense(True)
        Session("ExpDate") = hdnExpDate.Value
    End Sub

    ''' <summary>
    ''' Called when user clicks the Save button on the panel pnlAttachFile
    ''' </summary>
    ''' <param name="sender"></param>
    ''' <param name="e"></param>
    ''' <remarks>Attaches a file from the user's computer to an expense. Creates an entry in the table tblAuditTrail</remarks>
    Private Sub cmdAttachFile_Click(sender As Object, e As System.EventArgs) Handles cmdAttachFile.Click
        Dim iResultOfUpload = UploadFile(FileUpload2, hdnExpenseID.Value)
        Dim expense As New Expense(hdnExpenseID.Value)

        Select Case iResultOfUpload
            Case 0 : Session("alert") = GetMessage(434) 'unexpected error
            Case 1   'upload succeeded
                GetMessage(138)
                CreateAuditTrail(hdnExpenseID.Value, Session("emp").id, "tblExpense", "Receipt", "Added Receipt", "", "", "Report:" & expense.Rpt.Name)
            Case 2 : Session("alert") = GetMessage(435) 'file was larger than 5MB
        End Select

        gridViewExpenses.DataBind()
        expense = Nothing
    End Sub

    Private Sub pnlCreateReport_LoadComplete(sender As Object, e As System.EventArgs) Handles Me.LoadComplete
        txtReportName.Text = DateTime.Now.ToString("yyyyMMdd HHmm")
    End Sub

    ''' <summary>
    ''' Called when user clicks the save button on the panel pnlCreateReport
    ''' </summary>
    ''' <param name="sender"></param>
    ''' <param name="e"></param>
    ''' <remarks>Calls CreateReport</remarks>
    Private Sub cmdSaveReport_Click(sender As Object, e As System.EventArgs) Handles cmdSaveReport.Click
        CreateReport()
    End Sub

    ''' <summary>
    ''' On LoadComplete, check for querystring parameters that might have been passed to display certain messages 
    ''' like an expense was deleted or saved etc.
    ''' </summary>
    ''' <param name="sender"></param>
    ''' <param name="e"></param>
    ''' <remarks></remarks>
    Private Sub Page_LoadComplete(sender As Object, e As System.EventArgs) Handles Me.LoadComplete
        Dim report As New Report

        If Not IsNothing(Request.QueryString("msg")) Then Session("msg") = GetMessage(CInt(Request.QueryString("msg")))

        If Request.QueryString("msg") = "284" Then 'report was submitted
            Response.Redirect("reports.aspx")

        ElseIf Not IsNothing(Request.QueryString("msg")) Then
            Response.Redirect("reports.aspx?submitted=1")
        End If

        If IsNothing(Request.QueryString("submitted")) Then
            report.GetOpenReport(Session("selectedEmp").id)
            hdnOpenReport.Value = report.Status = 1
            If cboStatus.SelectedIndex = 1 Then labelReportName.Text = IIf(report.ID <> 0, report.Name, "")
            hdnReportID.Value = report.ID
            txtStatusID.Text = report.Status

            If report.ID > 0 Then
                If Not IsNothing(report.Expenses) Then
                    If report.Expenses.Count = 25 Then
                        Session("msg") = GetMessage(433)
                        cmdSaveExpense2.Enabled = False
                    End If
                End If
            End If
        End If

        If Session("showAttachReceipt") = True Then
            modalAttachReceipt.Show()
            Session("showAttachreceipt") = Nothing
        End If

        Session("ExpDate") = Nothing
        report = Nothing
    End Sub

    ''' <summary>
    ''' Inserts value "Me" into the cboDelegate drowdown list. If cboDelegate has no items, hide it
    ''' </summary>
    ''' <param name="sender"></param>
    ''' <param name="e"></param>
    ''' <remarks></remarks>
    Private Sub cboDelegate_DataBound(sender As Object, e As System.EventArgs) Handles cboDelegate.DataBound
        cboDelegate.Items.Insert(0, GetMessage(228))
        cboDelegate.Items(0).Value = Session("emp").id

        cboDelegate.Visible = cboDelegate.Items.Count > 1
        lbl69.Visible = cboDelegate.Items.Count > 1

        cboDelegate.SelectedValue = Session("selectedEmp").id
        gridViewReports.DataBind()
    End Sub

    ''' <summary>
    ''' Change the selectedEmp if the value was changed in the cboDelegate dropdown list
    ''' </summary>
    ''' <param name="sender"></param>
    ''' <param name="e"></param>
    ''' <remarks></remarks>
    Private Sub cboDelegate_SelectedIndexChanged(sender As Object, e As System.EventArgs) Handles cboDelegate.SelectedIndexChanged
        Session("selectedEmp") = New Employee(CInt(cboDelegate.SelectedValue))
        Session("selectedEmpID") = Session("selectedEmp").id
    End Sub

    ''' <summary>
    ''' Called when user clicks the save button on the panel pnlCreateReport
    ''' </summary>
    ''' <remarks>Creates or updates a report</remarks>
    Public Sub CreateReport()
        Dim report As Report

        'Force a report name, else it will just spin eternally (artf146915)
        If String.IsNullOrEmpty(txtReportName.Text) Then
            txtReportName.Text = DateTime.Now.ToString("yyyyMMdd HHmm")
        End If

        Try
            If hdnReportIDEdit.Value <> 0 Then
                report = New Report(hdnReportIDEdit.Value)
                report.Name = txtReportName.Text
                report.Update()
            Else
                report = New Report
                report.Create(txtReportName.Text, Session("emp").OrgID, Session("selectedEmp").ID, 1)
            End If

            hdnReportID.Value = report.GetLastID(CInt(Session("selectedEmp").id))
            gridViewReports.DataBind()

        Catch ex As Exception
            If Session("emp").isadvalorem Then
                Session("Error") = ex.Message
            Else
                Session("Error") = GetMessage(273)
            End If

            Response.Redirect("/error.aspx")

        Finally
            hdnOpenReport.Value = True
            report = Nothing
            txtReportName.Text = ""
        End Try
    End Sub


    ''' <summary>
    ''' Cycles through all controls on the page to translate them. Will translate controls that start with lbl and contain an integer value.
    ''' This integer value is the ID in table tblDescription
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

    ''' <summary>
    ''' Inserts a blank row in the dropdown cboCat
    ''' </summary>
    ''' <param name="sender"></param>
    ''' <param name="e"></param>
    ''' <remarks></remarks>
    Private Sub cboCat_DataBound(sender As Object, e As System.EventArgs) Handles cboCat.DataBound
        cboCat.Items.Insert(0, "")
    End Sub

    Private Sub CheckLanguage()
        Try
            If Not IsNothing(Request.QueryString("lang")) Then
                If Request.QueryString("lang") = "f" Then
                    Session("language") = "French"
                Else
                    Session("language") = "English"
                End If
            Else
                Session("language") = Session("emp").defaultlanguage
            End If

        Catch ex As Exception
            Session("language") = "French"
        End Try

    End Sub

    ''' <summary>
    ''' Used to manually translate some objects that aren't handled automatically by Translate()
    ''' </summary>
    ''' <remarks></remarks>
    Private Sub Translate2()
        hdnLanguage.Value = Session("emp").defaultlanguage
        hdnExpDeletedMsg.Value = GetMessage(139)
        hdnRptDeletedMsg.Value = GetMessage(371)
        hdnSubmitMessage.Value = GetMessage(126)
        hdnSubmitTitle.Value = GetMessageTitle(126)
        hdnDeleteRptMsg.Value = GetMessage(128)
        hdnDeleteRptTitle.Value = GetMessageTitle(128)
        hdnDeleteExpMsg.Value = GetMessage(137)
        hdnDeleteExpTitle.Value = GetMessageTitle(137)
        hdnKMExceeds.Value = GetMessage(442)
        gridViewReports.EmptyDataText = GetMessage(107)
        gridViewExpenses.EmptyDataText = GetMessage(132)
        cboTaxIE.Items(0).Text = GetMessage(135)
        cboTaxIE.Items(1).Text = GetMessage(136)
        hdnSubmitTooltip.Value = GetMessage(240)
        hdnAddReportTooltip.Value = GetMessage(103)
        hdnAddExpTooltip.Value = GetMessage(131)
        hdnEditTooltip.Value = GetMessage(109)
        hdnSelectTooltip.Value = GetMessage(108)
        hdnReject.Value = GetMessage(417)
        hdnApprove.Value = GetMessage(418)
        hdnViewOtherDates.Value = GetMessage(416)
        hdnViewExpRptTooltip.Value = GetMessage(110)
        hdnExpDataEntryTooltip.Value = GetMessage(75)
        hdnFinalizeMessage.Value = GetMessage(321)
        hdnFinalizeTitle.Value = GetMessage(144)
        hdnCancelText.Value = GetMessage(142)
        cboCat.DataTextField = IIf(Session("emp").defaultlanguage = "English", "CAT_NAME", "CAT_NAME_FR")
        lblFrom.Text = GetMessage(379)
        lblTo.Text = GetMessage(380)
        hdnCurrOutsideJur.Value = GetMessage(449)
        hdnInsuranceMsg.Value = GetMessage(450)
        hdnPersonalUseMsg.Value = GetMessage(457)
        hdnApproveRpt.Value = GetMessage(467)
        hdnRejectRpt.Value = GetMessage(468)
        hdnReason.Value = GetMessage(469)
        hdnClose.Value = GetMessage(146)
        hdnDeleteReceipt.Value = GetMessage(496)
        AmtRequired.Text = GetMessage(504)
        RequiredFieldValidator4.Text = GetMessage(505)
        hdnTaxesExceedTotal.Value = GetMessage(540)
        hdnExpand.Value = GetMessage(133)

        'If the user language is in french, translate the status dropdownlist
        If Session("emp").defaultlanguage = "French" AndAlso IsNothing(Request.QueryString("submitted")) Then
            If Session("emp").organization.approvallevel = 2 Then
                cboStatus.Items(0).Text = GetMessage(104)
                cboStatus.Items(1).Text = GetMessage(105)
                cboStatus.Items(2).Text = GetMessage(106)
                cboStatus.Items(3).Text = GetMessage(253)
                cboStatus.Items(4).Text = GetMessage(78)
            Else
                cboStatus.Items(0).Text = GetMessage(104)
                cboStatus.Items(1).Text = GetMessage(105)
                cboStatus.Items(2).Text = GetMessage(106)
                cboStatus.Items(3).Text = GetMessage(78)
            End If
        End If

        If Not IsNothing(Request.QueryString("submitted")) AndAlso Request.QueryString("submitted") <> 1 Then
            If Session("emp").organization.approvallevel = 2 Then
                cboStatus.Items(0).Text = GetMessage(104)
                cboStatus.Items(1).Text = GetMessage(105)
                cboStatus.Items(2).Text = GetMessage(106)
                cboStatus.Items(3).Text = GetMessage(253)
                cboStatus.Items(4).Text = GetMessage(78)
            Else
                cboStatus.Items(0).Text = GetMessage(104)
                cboStatus.Items(1).Text = GetMessage(105)
                cboStatus.Items(2).Text = GetMessage(106)
                cboStatus.Items(3).Text = GetMessage(78)
            End If
        End If

    End Sub


    ''' <summary>
    ''' Inserts a blank row in the cboWO (WO = workorder) dropdown list.
    ''' </summary>
    ''' <param name="sender"></param>
    ''' <param name="e"></param>
    ''' <remarks></remarks>
    Private Sub cboWO_DataBound(sender As Object, e As System.EventArgs) Handles cboWO.DataBound
        cboWO.Items.Insert(0, "")
    End Sub


End Class