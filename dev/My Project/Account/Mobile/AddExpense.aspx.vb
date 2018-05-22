Imports System.Data
Imports System.Data.SqlClient
Imports System.Configuration
Imports System.IO
Imports System.Net




Partial Public Class AddExpense

    Inherits System.Web.UI.Page

    Dim blnSubmit As Boolean, ExpenseID As Integer, linenum As Integer


    'Dim blnSubmit As Boolean
    'Dim ExpenseID As Integer
    'Dim linenum As Integer


    Private Sub AddExpense_Error(sender As Object, e As System.EventArgs) Handles Me.Error
        'On Error Resume Next
        If IsNothing(Session("error")) Then Session("error") = GetMessage(273) & " - " & linenum : Session("msgHeight") = 50
        Response.Redirect("../../mobile/mlogin.aspx")
    End Sub



    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim rpt As New Report, i As Single, d As New Description
        'Dim i As Single
        'Dim d As New Description

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


            'Session("selectedEmp") = IIf(cboDelegate.Visible, cboDelegate.SelectedValue, Session("emp").id)

            Session("currentpage") = "mReports.aspx" & IIf(Request.QueryString("e") <> 1, "", "?e=1")
            Translate()
            hdnCancelText.Value = GetMessage(142)

            Dim r As New Report(CInt(Request.QueryString("id")))

            If Not IsPostBack Then
                lbl131.Text += " - " & r.Name
                'lbl109.Text += " - " & r.Name
                txtExpDate.Text = r.CreatedDate
                hdnExpDate.Value = r.CreatedDate
                r = Nothing

                hdnOrgID.Value = Session("emp").OrgID
                txtEmpID.Text = Session("emp").id
                txtSuperID.Text = Session("emp").ID
                hdnLoggedInEmpID.Value = Session("emp").ID
                hdnPUK.Value = Membership.GetUser(Session("emp").username.ToString).ProviderUserKey.ToString
            End If

            If Request.QueryString("e") = 1 And Not IsPostBack Then
                hdnReportID.Value = ""
                txtEmpID.Text = ""

            ElseIf Not IsPostBack Then
                hdnReportID.Value = rpt.ID
                'cmdEdit.Visible = rpt.Status = 1 Or rpt.Status = 5
            End If

            For i = 0.01 To 0.99 Step 0.01
                cboRate.Items.Add(FormatNumber(i, 2))
            Next

            Translate2()

        Catch ex As Exception
            'Session("Error") = IIf(Session("emp").isadvalorem, ex.Message, GetMessage(273 ))

        Finally
            If Not IsNothing(Session("error")) Then Response.Redirect("~/error.aspx")

            rpt = Nothing
            d = Nothing
        End Try

        Response.Cache.SetCacheability(HttpCacheability.NoCache)
        Response.Cache.SetExpires(DateTime.UtcNow.AddHours(-1))
        Response.Cache.SetNoStore()
        Response.Cache.SetNoServerCaching()

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


    Public Sub CreateExpense()
        Dim exp As New Expense
        Dim oc As New OrgCat(hdnOrgCatID.Value)
        Dim d As New Date(Right(hdnExpDate.Value, 4), Mid(hdnExpDate.Value, 4, 2), Left(hdnExpDate.Value, 2))
        Dim r As Report
        Dim ParentOrg As Org
        Dim o As Org
        Dim emp As Employee
        Dim amt As Decimal
        Dim curr As Currency
        Dim exchangeRate As Single
        Dim gstPaid As Single, qstPaid As Single
        Try
            If Not IsNothing(Request.QueryString("expID")) Then
                exp = New Expense(CInt(Request.QueryString("expID")))
                r = New Report(exp.ReportID)
            Else
                exp.ReportID = CInt(Request.QueryString("id"))
                hdnReportID.Value = CInt(Request.QueryString("id"))
                r = New Report(exp.ReportID)
            End If

            If r.Emp.ID <> Session("emp").id And r.Emp.Supervisor <> Session("emp").id Then Throw New Exception

            emp = New Employee(r.EmpID)
            ParentOrg = emp.Organization.Parent

            o = emp.Organization
            linenum = 1
            exp.OrgCategory.ID = hdnOrgCatID.Value
            exp.OrgCategory.Category.ID = oc.Category.ID

            If oc.Category.ID = 5 Then
                exp.Jurisdiction.ID = cboTaxRate.SelectedValue
            Else
                exp.Jurisdiction.ID = cboJur.SelectedValue
            End If

            exp.CurrID = cboCurr.SelectedValue
            curr = New Currency(exp.CurrID)
            exp.TaxStatus = cboTaxIE.SelectedValue
            'exp.TaxStatus = IIf(hdnCatID.Value = 1 Or hdnCatID.Value = 2 Or hdnCatID.Value = 4 Or hdnCatID.Value = 6 Or hdnCatID.Value = 7 Or hdnCatID.Value = 8 Or hdnCatID.Value = 12 Or hdnCatID.Value = 13 Or hdnCatID.Value = 14 Or hdnCatID.Value = 47 Or hdnCatID.Value = 41, 1, cboTaxIE.SelectedValue)
            exp.SupplierName = txtSupplier.Text
            exp.Gratuities = 0
            exp.Rate = 1
            If txtGrat.Text <> "" Then exp.Gratuities = CSng(txtGrat.Text)
            exp.Comment = txtComment.Text
            exp.Attendees = txtAttendees.Text

            exp.DateOfExpense = d
            linenum = 2
            If hdnGST.Value <> "" Then exp.GSTPaid = CSng(hdnGST.Value)
            'If txtHST.Text <> "" Then exp.HSTPaid = CSng(txtHST.Text)
            If hdnQST.Value <> "" Then exp.QSTPaid = CSng(hdnQST.Value)

            If oc.Category.ID = 4 And oc.AllowanceAmt > 0 Then
                exp.Rate = CSng(oc.AllowanceAmt)
                txtAmt.Text = CSng(exp.Rate) * CSng(txtKM.Text)
            Else
                If cboRate.SelectedValue <> "" And cboRate.SelectedValue <> "0" Then exp.Rate = CSng(cboRate.SelectedValue)
            End If

            If oc.Category.IsAllowance And oc.Category.ID <> 4 And oc.AllowanceAmt > 0 Then
                exp.Amount = oc.AllowanceAmt
            Else
                exp.Amount = IIf(exp.TaxStatus = 1, CSng(txtAmt.Text), CSng(txtAmt.Text) + exp.GSTPaid + exp.QSTPaid)
            End If
            linenum = 3
            gstPaid = exp.GSTPaid
            qstPaid = exp.QSTPaid
            amt = (exp.Amount + exp.Gratuities)


            ' Get the exchange rate
            If curr.Symbol <> "CAD" Then
                '2017-04-27 Function GetExchangeRate not used anymore because the OANDA's API doesn't work anymore
                'exchangeRate = currency.GetExchangeRate(expense.DateOfExpense, expense.DateOfExpense)

                exchangeRate = curr.GetExchangeRateManual(exp.DateOfExpense, curr.Symbol)
                gstPaid = (gstPaid * exchangeRate) : gstPaid += gstPaid * ParentOrg.InterestRate
                qstPaid = (qstPaid * exchangeRate) : qstPaid += qstPaid * ParentOrg.InterestRate
                amt = (exp.Amount + exp.Gratuities) * exchangeRate
            End If


            exp.AmountCDN = IIf(exp.CurrID <> 25, amt + (amt * ParentOrg.InterestRate), amt)

            exp.RITC = FormatNumber(exp.OrgCategory.Category.GetRITC(exp.Jurisdiction.ID, o.OrgSizeGST, exp.DateOfExpense) * exp.GSTPaid * o.GetCRAactualRatio("GST", exp.DateOfExpense, o.GetCRA("GST", exp.DateOfExpense)), 2)

            If exp.OrgCategory.Category.ID = 4 Then
                Select Case exp.Jurisdiction.ID
                    Case 2 : exp.RITC = exp.RITC * o.kmON
                    Case 10 : exp.RITC = exp.RITC * o.kmBC
                    Case 4 : exp.RITC = exp.RITC * o.kmPEI
                End Select
            End If
            linenum = 4
            exp.ITC = FormatNumber(exp.OrgCategory.Category.GetITC(exp.Jurisdiction.ID, o.OrgSizeGST, exp.DateOfExpense) * gstPaid * o.GetCRAactualRatio("GST", exp.DateOfExpense, o.GetCRA("GST", exp.DateOfExpense)), 2)
            exp.ITR = FormatNumber(exp.OrgCategory.Category.GetITR(exp.Jurisdiction.ID, o.OrgSizeQST, exp.DateOfExpense) * qstPaid * o.GetCRAactualRatio("QST", exp.DateOfExpense, o.GetCRA("QST", exp.DateOfExpense)), 2)
            exp.Reimburse = Not chkDontReimburse.Checked
            exp.Project = cboProject.Text
            exp.WorkOrder = cboWO.Text
            exp.CostCenter = cboCC.Text

            If hdnExpenseID.Value = 0 Then
                exp.Create()
                exp.ID = exp.GetLastID(hdnReportID.Value)
            Else
                exp.ID = CInt(hdnExpenseID.Value)
                exp.Update()
            End If

            Dim i = UploadFile(FileUpload1, exp.ID)
            linenum = 5
            Select Case i
                Case 0 : Session("alert") = "There was an error while uploading your file"
                Case 1 : Session("msg") = GetMessage(138)
                Case 2 : Session("alert") = "File was not uploaded. File cannot be larger than 5MB"
            End Select

            linenum = 6

        Catch e As Exception
            If Session("emp").isadvalorem Then
                Session("Error") = e.Message
            Else
                Session("Error") = GetMessage(273)
            End If
            Response.Redirect("../../error.aspx")

        Finally
            txtExpenseID.Text = 0

            exp = Nothing
            oc = Nothing
            ParentOrg = Nothing
            o = Nothing
            curr = Nothing
            emp = Nothing

        End Try

    End Sub

    Public Sub Cancel()
        txtExpenseID.Text = 0
    End Sub

    <System.Web.Services.WebMethod()>
    Public Shared Function GetExpense(expID As Integer, puk As String) As Array
        Dim exp As Expense
        Dim emp As Employee
        Dim r As Report
        Dim loggedInUser As Employee
        Dim aEXP(29) As String

        Try
            If puk = Membership.GetUser.ProviderUserKey.ToString Then
                loggedInUser = New Employee(Membership.GetUser.UserName)
                exp = New Expense(expID)
                r = New Report(exp.ReportID)
                emp = New Employee(r.EmpID)

                If loggedInUser.ID = emp.ID Or loggedInUser.ID = emp.Supervisor Or loggedInUser.ID = emp.DelegatedTo Then
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
                    aEXP(11) = IIf(exp.OrgCategory.Category.AllowSupplier, 1, 0)
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
                    aEXP(24) = exp.Project
                    aEXP(25) = exp.WorkOrder
                    aEXP(26) = exp.CostCenter
                    aEXP(27) = IIf(exp.OrgCategory.Category.IsAllowance, 1, 0)
                    aEXP(28) = exp.OrgCategory.AllowanceAmt
                    aEXP(29) = exp.Attendees
                Else
                    Throw New Exception
                End If
            Else
                Throw New Exception
            End If

        Catch ex As Exception
            aEXP(0) = "ERROR: " & ex.Message
            Throw ex

        Finally
            exp = Nothing
            r = Nothing
            emp = Nothing
            loggedInUser = Nothing
        End Try

        Return aEXP
    End Function


    <System.Web.Services.WebMethod()>
    Public Shared Function GetTaxRates(jurID As Integer, catID As Integer, expDate As String, taxIncExc As Integer, orgCatID As Integer, kmRate As Single) As Array
        Dim c As New Category(catID)
        Dim aC(4) As String
        Dim validateKM As Integer
        Dim oc As New OrgCat(orgCatID)

        validateKM = 1

        If catID = 4 Then
            Dim o As New Org(oc.OrgID)

            validateKM = o.ValidateKMRate(jurID, kmRate, expDate)

            o = Nothing
        End If

        aC(0) = c.GetGST(jurID, catID, expDate, taxIncExc) * validateKM
        aC(1) = c.GetQST(jurID, catID, expDate, taxIncExc) * validateKM
        If aC(0) = "0" Then aC(0) = c.GetHST(jurID, catID, expDate, taxIncExc) * validateKM
        aC(2) = validateKM
        'aC(2) = c.GetHST(jurID, catID, expDate, taxIncExc)
        aC(3) = IIf(oc.Category.IsAllowance, 1, 0)
        aC(4) = oc.AllowanceAmt

        c = Nothing
        oc = Nothing
        Return aC

    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function GetAllows(orgCatID As Integer) As Array
        Dim oc As OrgCat
        Dim c As Category
        Dim aC(15) As String

        Try
            oc = New OrgCat(orgCatID)
            c = New Category(oc.CatID)

            aC(0) = IIf(c.AllowSupplier, 1, 0)
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
            aC(11) = IIf(c.IsAllowance, 1, 0)
            aC(12) = oc.RequiredSegments
            aC(13) = IIf(c.AllowAttendees, 1, 0)
            aC(14) = GetMessage(368, "English")
            aC(15) = IIf(oc.DefaultCostCenter.ID > 0, oc.DefaultCostCenter.PWCNumber, 0)

        Catch ex As Exception
            Throw ex

        Finally
            c = Nothing
            oc = Nothing
        End Try

        Return aC


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



        'If Not IsDBNull(r.ApprovedBy) Then
        '    If r.ApprovedBy > 0 Then
        '        e = New Employee(r.ApprovedBy)
        '        approvedby = e.FirstName & " " & e.LastName
        '        e = Nothing
        '    End If
        'End If



        Return s

    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Sub DeleteReceipt(expID As Integer)
        Dim exp As New Expense

        exp.DeleteReceipt(expID)

        exp = Nothing
    End Sub



    Private Sub cmdSaveExpense_Click(sender As Object, e As System.EventArgs) Handles cmdSaveExpense.Click
        CreateExpense()
        Session("msgHeight") = "25px"
        Response.Redirect("mreports.aspx")
    End Sub

    Private Sub cmdSaveExpense2_Click(sender As Object, e As System.EventArgs) Handles cmdSaveExpense2.Click
        Dim rID As Integer

        CreateExpense()

        If Not IsNothing(Request.QueryString("id")) Then
            rID = CInt(Request.QueryString("id"))
        Else
            Dim exp As New Expense(CInt(Request.QueryString("expID")))
            Dim r As New Report(exp.ReportID)
            rID = r.ID
        End If

        Response.Redirect("AddExpense.aspx?id=" & rID)
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
                        childc.text = d.GetDescription(CInt(Replace(id, "lbl", "")), Left(Session("language"), 1))
                    End If

                ElseIf TypeOf childc Is Button Then
                    id = Replace(childc.text, "_", "")
                    childc.text = d.GetDescription(CInt(Replace(id, "lbl", "")), Left(Session("language"), 1))

                ElseIf TypeOf childc Is GridView Then
                    For Each col In childc.columns
                        col.headertext = d.GetDescription(CInt(col.headertext), Left(Session("language"), 1))
                    Next
                End If
            Next

        Next
    End Sub

    Private Sub cboCat_DataBound(sender As Object, e As System.EventArgs) Handles cboCat.DataBound
        cboCat.Items.Insert(0, "")
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
        cboTaxIE.Items(0).Text = GetMessage(135)
        cboTaxIE.Items(1).Text = GetMessage(136)
        hdnSubmitTooltip.Value = GetMessage(240)
        hdnAddExpTooltip.Value = GetMessage(131)
        hdnEditTooltip.Value = GetMessage(109)
        hdnSelectTooltip.Value = GetMessage(108)
        hdnViewExpRptTooltip.Value = GetMessage(110)
        hdnExpDataEntryTooltip.Value = GetMessage(75)
        hdnFinalizeMessage.Value = GetMessage(321)
        hdnFinalizeTitle.Value = GetMessage(144)
        hdnCancelText.Value = GetMessage(142)
        cboCat.DataTextField = IIf(Session("language") = "English", "CAT_NAME", "CAT_NAME_FR")
    End Sub

    Private Sub cboCC_DataBound(sender As Object, e As System.EventArgs) Handles cboCC.DataBound
        cboCC.Items.Insert(0, "")

    End Sub

    Private Sub cboProject_DataBound(sender As Object, e As System.EventArgs) Handles cboProject.DataBound
        cboProject.Items.Insert(0, "")
    End Sub

    Private Sub cboWO_DataBound(sender As Object, e As System.EventArgs) Handles cboWO.DataBound
        cboWO.Items.Insert(0, "")
    End Sub

    Private Sub cmdCancel_Click(sender As Object, e As System.EventArgs) Handles cmdCancel.Click
        Response.Redirect("mreports.aspx")
    End Sub
End Class