Imports System.Data
Imports System.Data.SqlClient

Public Class Admin    
    Inherits System.Web.UI.Page
    Dim AmtTotal As Double = 0 : Dim ITCTotal As Double = 0 : Dim ITRTotal As Double = 0 : Dim RITCTotal As Double = 0 : Dim debitTotal As Double = 0 : Dim RITCTotalOnt As Double = 0 : Dim RITCTotalBC As Double = 0 : Dim RITCTotalPEI As Double = 0
    Dim ITC As Double, ITR As Double, RITC As Double
    Dim i As Integer, iItems As Integer



    Private Sub Admin_Error(sender As Object, e As System.EventArgs) Handles Me.Error
        If IsNothing(Session("error")) Then Session("error") = GetMessage(273) : Session("msgHeight") = 50

        Response.Redirect("../login.aspx")
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try
            GetConnectionString()
            Translate()

            If Session("ExecuteSave") <> "" Then hdnExecuteSave.Value = "False"
            Session("ExecuteSave") = ""


            If Not IsNothing(Session("selectedTab")) Then hdnSelectedTab.Value = Session("selectedTab")
            Session("selectedTab") = Nothing
            If Not IsNothing(Request.QueryString("tab")) Then hdnSelectedTab.Value = Request.QueryString("tab")

            If Request.QueryString("unlock") <> "" And Session("emp").isadmin Then UnlockUser()
            InitializePage()

            gvOrgCat.DataBind()
            gvAuditTrail.DataBind()
            

        Catch ex As Exception
            If Not IsNothing(Session("message")) Then 'no authorization to view this page
                Response.Redirect("../message.aspx")
            Else
                If Session("emp").isadvalorem Then
                    Session("msg") = ex.Message
                Else
                    If Session("msg") = "" Then Session("msg") = GetMessage(273, hdnLanguage.Value)
                End If

                Response.Write(ex.Message)
            End If

        Finally

        End Try
    End Sub

    Private Sub InitializePage()
        Dim iCount As Integer

        If Not IsPostBack Then
            Session("currentpage") = "Admin.aspx"
            CheckLanguage()

            txtDashFrom.Text = DateAdd(DateInterval.Month, -1, Now).ToShortDateString
            txtDashTo.Text = Now.ToShortDateString

            If Not Session("emp").organization.parent.calendarmatch Then
                cboDataRange.Items(0).Enabled = False
                cboDataRange.SelectedIndex = 1
            End If

            hdnLanguage.Value = Session("emp").defaultlanguage
            hdnOrgID.Value = Session("emp").OrgID
            hdnUserID.Value = Session("emp").id
            hdnPUK.Value = Membership.GetUser.ProviderUserKey.ToString

            Dim organization As New Org

            organization = Session("emp").organization.parent
            Session("parentOrg") = organization
            hdnParentID.Value = organization.ID
            hdnAccSeg.Value = organization.AccSegment
            Translate2(organization)

            cboType.SelectedValue = Session("emp").organization.OrgTypeID
            txtOrgName.Text = Session("emp").organization.name

            cboOrg.SelectedValue = Session("emp").OrgID

            Dim Period As New Period(organization.ID, 1, "Start")

            If Period.ID > 0 Then
                cboFirstMonth.Enabled = False
                cboPeriodNum.Enabled = False
                txtITCAcct.Enabled = False
                txtITRAcct.Enabled = False
                txtRITCBC.Enabled = False
                txtRITCON.Enabled = False
                txtRITCPEI.Enabled = False
                cboInterestRate.Enabled = False
                txtAcctPayable.Enabled = False
                cboRetention.Enabled = False
                cmdEditSettings.Visible = False
                lblEditSettings.Visible = False
            End If

            cboFinancialYear.Items.Clear()
            Dim firstyear As Integer = 2013

            Do Until firstyear = Now.Year + 2
                cboFinancialYear.Items.Add(firstyear)
                firstyear += 1
            Loop

            cboFinancialYear.SelectedValue = Now.Year

            Dim iPeriods As Integer = organization.NumberOfPeriods

            cboPeriodNum.SelectedValue = organization.NumberOfPeriods
            cboFirstMonth.SelectedIndex = organization.FirstMonth - 1
            cboRetention.SelectedValue = organization.Retention
            cboInterestRate.SelectedValue = organization.InterestRate
            txtAcctPayable.Text = organization.AccountPayable
            txtITCAcct.Text = organization.ITCAccount
            txtITRAcct.Text = organization.ITRAccount
            txtRITCBC.Text = organization.ritcBCAccount
            txtRITCON.Text = organization.ritcONAccount
            txtRITCPEI.Text = organization.ritcPEIAccount

            lblPeriodnumData.Text = organization.NumberOfPeriods
            lblFirstMonthData.Text = cboFirstMonth.SelectedItem.Text
            lblRetentionData.Text = organization.Retention & " " & GetMessage(445) & IIf(organization.Retention > 1, "s", "")
            lblCurrencyOffsetData.Text = organization.InterestRate * 100 & " %"
            lblAcctPayableData.Text = organization.AccountPayable
            lblITCAcctData.Text = organization.ITCAccount
            lblITRAcctData.Text = organization.ITRAccount
            lblRITCBCData.Text = organization.ritcBCAccount
            lblRITCONData.Text = organization.ritcONAccount
            lblRITCPEIData.Text = organization.ritcPEIAccount
            lblApprovalLevel.Text = organization.Parent.ApprovalLevel

            cboPeriod.Items.Clear()
            For iCount = 1 To iPeriods
                cboPeriod.Items.Add(iCount)
            Next

            cboKmON.Items.Clear()
            cboKmPEI.Items.Clear()
            For iCount = 100 To 0 Step -1
                cboKmON.Items.Add(iCount)
                cboKmPEI.Items.Add(iCount)
            Next

            hdnAllowEditOrg.Value = organization.GetCRA("GST", "01/01/2012") = 2
            If hdnAllowEditOrg.Value <> "True" And Not Session("emp").username.contains("sholdaway") And Not Session("emp").isadvalorem Then gvOrgs.Columns(1).Visible = False

            chkConfirmOrg.Visible = True
            chkConfirmGS.Visible = True

            gvEmployees.Columns(9).Visible = Session("emp").organization.parent.approvallevel = 2

            organization = Nothing
            Period = Nothing
        End If

        For iCount = 100 To 0 Step -1
            cboGSTRate.Items.Add(iCount)
        Next

        For iCount = 100 To 0 Step -1
            cboQSTRate.Items.Add(iCount)
        Next

        'show the delete user account button in the grid if the account logged in is sholdaway
        gvAdvaloremListOfUsers.Columns(11).Visible = Session("emp").id = 1281
        gvEmployees.Columns(2).Visible = Session("emp").organization.displayDivision


        hdnSelectableRateText.Value = GetMessage(335)
        hdnOtherExpenseTxText.Value = GetMessage(336)
        hdnOtherExpenseNtText.Value = GetMessage(337)
        hdnExportExcelText.Value = GetMessage(224)
        LoadcboData()
        txtAsOf.Text = Format(Now, "dd/MM/yyyy")

    End Sub


    Private Sub UnlockUser()
        Dim employee As New Employee(CInt(Request.QueryString("unlock")))
        Membership.GetUser(employee.Username).UnlockUser()
        employee = Nothing
        gvEmployees.DataBind()
        lblMsg.Text = GetMessage(385)
    End Sub


    Private Sub LoadSupervisors()
        GetConnectionString()
        Dim sqlConn = New SqlConnection(connString.ConnectionString)
        sqlConn.Open()

        Dim com As SqlCommand = New SqlCommand("GetSupervisors", sqlConn)
        Dim rs As SqlDataReader
        Dim orgID As Integer

        If cboOrg.SelectedValue = "" Then
            orgID = Session("emp").organization.id
        Else
            orgID = CInt(cboOrg.SelectedValue)
        End If

        com.CommandType = CommandType.StoredProcedure
        com.Parameters.Add(New SqlParameter("@OrgID", SqlDbType.Int)).Value = orgID

        com.Connection = sqlConn
        rs = com.ExecuteReader

        cboSupervisor.Items.Clear()
        cboSupervisor.Items.Add("")
        cboSupervisor.Items(0).Value = 0

        cboFinalizer.Items.Clear()
        cboFinalizer.Items.Add("")
        cboFinalizer.Items(0).Value = 0

        While rs.Read
            If (rs("APPROVAL_LEVEL") = 1) Then
                cboSupervisor.Items.Add(rs("SUPER_NAME"))
                cboSupervisor.Items(cboSupervisor.Items.Count - 1).Value = rs("EMP_ID")
            End If

            If (rs("APPROVAL_LEVEL") = 2) Then
                cboFinalizer.Items.Add(rs("SUPER_NAME"))
                cboFinalizer.Items(cboFinalizer.Items.Count - 1).Value = rs("EMP_ID")
            End If
        End While

        rs.Close()
        com.Dispose()
        sqlConn.Close()
    End Sub


    Private Sub LoadDelegates()
        GetConnectionString()
        Dim sqlConn = New SqlConnection(connString.ConnectionString)
        sqlConn.Open()

        Dim com As SqlCommand = New SqlCommand("GetDelegates", sqlConn)
        Dim rs As SqlDataReader
        Dim orgID As Integer

        If cboOrg.SelectedValue = "" Then
            orgID = Session("emp").organization.id
        Else
            orgID = CInt(cboOrg.SelectedValue)
        End If

        com.CommandType = CommandType.StoredProcedure
        com.Parameters.Add(New SqlParameter("@OrgID", SqlDbType.Int)).Value = orgID

        com.Connection = sqlConn
        rs = com.ExecuteReader

        cboDelegate.Items.Clear()
        cboDelegate.Items.Add("")
        While rs.Read
            cboDelegate.Items.Add(rs("DELEGATE_NAME"))
            cboDelegate.Items(cboDelegate.Items.Count - 1).Value = rs("EMP_ID")
        End While

        rs.Close()
        com.Dispose()
        sqlConn.Close()

    End Sub


    Private Sub cmdSaveCompany_Click(sender As Object, e As System.EventArgs) Handles cmdSaveCompany.Click
        Dim organization As New Org
        Dim dDate As Date
        Dim GSTRate As Decimal
        Dim QSTRate As Decimal
        Dim employeeID As Integer

        Try
            If hdnExecuteSave.Value = "True" Then
                If txtOrgID2.Text <> "0" Then
                    organization = New Org(CInt(txtOrgID2.Text))
                Else
                    organization.Name = txtOrgName.Text
                End If

                'organization.Retention = cboRetention.SelectedValue
                If organization.OrgTypeID = 0 Then organization.OrgTypeID = cboType.SelectedValue
                organization.JurID = cboJurisdiction.SelectedValue
                If txtGST.Text <> "" Then organization.GST = CInt(txtGST.Text)
                If txtQST.Text <> "" Then organization.QST = CInt(txtQST.Text)
                organization.GSTReg = cboGSTReg.SelectedIndex
                organization.QSTReg = cboQSTReg.SelectedIndex
                organization.OrgSizeGST = IIf(organization.GSTReg, cboLargeGST.SelectedValue, 0)
                organization.OrgSizeQST = IIf(organization.QSTReg, cboLargeQST.SelectedValue, 0)
                organization.Code = txtOrgCode.Text

                If organization.GSTReg Then GSTRate = cboGSTRate.SelectedValue
                If organization.QSTReg Then QSTRate = cboQSTRate.SelectedValue

                organization.kmON = CSng(cboKmON.Text) / 100
                organization.kmPEI = CSng(cboKmPEI.Text) / 100

                If txtGSTDate.Text = "" Or txtGSTDate.Text = "12:00:00 AM" Then
                    dDate = New Date("2001", "01", "01")
                Else
                    dDate = New Date(Right(txtGSTDate.Text, 4), Mid(txtGSTDate.Text, 4, 2), Left(txtGSTDate.Text, 2))
                End If
                organization.GSTDate = dDate

                If txtQSTDate.Text = "" Or txtQSTDate.Text = "12:00:00 AM" Then
                    dDate = New Date("2001", "01", "01")
                Else
                    dDate = New Date(Right(txtQSTDate.Text, 4), Mid(txtQSTDate.Text, 4, 2), Left(txtQSTDate.Text, 2))
                End If
                organization.QSTDate = dDate

                If organization.ID <> 0 Then
                    organization.Update()
                Else
                    organization.ParentOrg = Session("emp").organization
                    organization.Create()
                    organization = New Org(organization.GetLastCreated(CInt(Session("emp").organization.id)))
                End If

                organization.CreateCRA(cboGSTRate.SelectedValue, cboQSTRate.SelectedValue)

                'reinitialize employee session variable to reload the company settings if any changes were made
                employeeID = CInt(Session("emp").id)
                Session("emp") = Nothing
                Session("emp") = New Employee(employeeID)

                gvOrgs.DataBind()
                cboOrg.DataBind()

                txtOrgID2.Text = 0
                Session("ExecuteSave") = "False"
            End If

            Session("msg") = GetMessage(196, hdnLanguage.Value) 'changes saved successfully

        Catch ex As Exception
            If Session("emp").isadvalorem Then
                Session("Error") = ex.Message
            Else
                Session("Error") = GetMessage(273)
            End If

            Response.Redirect("../error.aspx")

        Finally
            organization = Nothing
            Session("selectedTab") = "3"
            Response.Redirect("admin.aspx")
        End Try

    End Sub

    Private Sub gvOrgs_SelectedIndexChanged(sender As Object, e As System.EventArgs) Handles gvOrgs.SelectedIndexChanged
        hdnSelectedOrg.Value = gvOrgs.DataKeys(gvOrgs.SelectedIndex).Value.ToString()
    End Sub

    Private Sub cmdSaveOC_Click(sender As Object, e As System.EventArgs) Handles cmdSaveOC.Click
        Dim organizationCategory As New OrgCat

        organizationCategory.GLAccount = cboAccount.SelectedValue
        organizationCategory.Note = txtNote.Text
        organizationCategory.AllowanceAmt = CSng(txtAllowance.Text)
        organizationCategory.RequiredSegments = IIf(chkProject.Checked, "P", "N")
        organizationCategory.RequiredSegments += IIf(chkCostCenter.Checked, "C", "N")
        organizationCategory.FactorMethod = chkFactorMethod.Checked

        If hdnOrgCatID.Value = 0 Then
            organizationCategory.OrgID = cboOrg.SelectedValue
            organizationCategory.CatID = CInt(hdnSelCat.Value)
            Dim category As New Category(organizationCategory.CatID)
            organizationCategory.Active = True
            organizationCategory.DefaultCostCenter.ID = cboDefaultCC.SelectedValue
            organizationCategory.Create()
            CreateAuditTrail(0, Session("emp").id, "tblOrgCategory", "", "Added Category", "", category.Name & " GL:" & organizationCategory.GLAccount & IIf(organizationCategory.Note <> "", " - " & organizationCategory.Note, ""), "")
            category = Nothing
        End If

        gvCategories.DataBind()
        gvOrgCat.DataBind()

        organizationCategory = Nothing

        Session("selectedTab") = "2"
        Session("selectedOrg") = cboOrg.SelectedValue
        Response.Redirect("admin.aspx")
    End Sub

    Private Sub gvCategories_SelectedIndexChanged(sender As Object, e As System.EventArgs) Handles gvCategories.SelectedIndexChanged
        modalAddOrgCat.Show()
    End Sub


    <System.Web.Services.WebMethod()>
    Public Shared Sub DeleteOrgCat(orgCatID As Integer)
        Dim organizationCategory As New OrgCat

        organizationCategory.ID = orgCatID
        organizationCategory.Delete()

        organizationCategory = Nothing
    End Sub

    <System.Web.Services.WebMethod()>
    Public Shared Sub DeleteEmp(empID As Integer)
        Dim employee As New Employee(empID)

        Membership.DeleteUser(employee.Username)
        employee.Delete()

        employee = Nothing
    End Sub

    <System.Web.Services.WebMethod()>
    Public Shared Sub DeleteOrg(orgID As Integer)

        Dim organization As New Org(orgID)
        Dim employee As Employee

        organization.GetEmployees()

        If Not IsNothing(organization.Employees) Then
            For Each employee In organization.Employees
                Membership.DeleteUser(employee.Username)
            Next
        End If

        organization.Delete()
        employee = Nothing
        organization = Nothing
    End Sub

    <System.Web.Services.WebMethod()>
    Public Shared Function GetOrgCategory(orgCatID As Integer, lang As String, puk As String) As Dictionary(Of String, String)
        Dim orgCategory As New OrgCat(orgCatID)
        Dim category As New Category(orgCategory.CatID)
        Dim loggedInUser As Employee
        Dim organization As New Org(orgCategory.OrgID)
        Dim orgCategoryDictionary As New Dictionary(Of String, String)
        Dim account As Account

        Try
            If puk = Membership.GetUser.ProviderUserKey.ToString Then
                loggedInUser = New Employee(Membership.GetUser.UserName)

                If loggedInUser.Organization.ID = orgCategory.OrgID Or loggedInUser.Organization.Parent.ID = organization.Parent.ID Then
                    account = New Account(orgCategory.GLAccount, organization.ID)
                    With orgCategoryDictionary
                        .Add("GLAccount", orgCategory.GLAccount)
                        .Add("Note", orgCategory.Note)
                        .Add("AllowNote", IIf(category.AllowNote, 1, 0))
                        .Add("CategoryName", IIf(lang = "English", orgCategory.Category.Name, orgCategory.Category.NameFR))
                        .Add("IsAllowance", IIf(orgCategory.Category.IsAllowance, 1, 0))
                        .Add("AllowanceAmount", orgCategory.AllowanceAmt)
                        .Add("RequiredSegments", orgCategory.RequiredSegments)
                        .Add("AccountName", orgCategory.GLAccount & " - " & account.Name)
                        .Add("DefaultCostCenterID", orgCategory.DefaultCostCenter.ID)
                        .Add("FactorMethod", IIf(orgCategory.FactorMethod, 1, 0))
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
            account = Nothing
            orgCategory = Nothing
            category = Nothing
        End Try

        Return orgCategoryDictionary

    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function GetCategory(catID As Integer, lang As String) As Dictionary(Of String, String)
        Dim category As New Category(catID)
        Dim categoryDictionary As New Dictionary(Of String, String)

        With categoryDictionary
            .Add("AllowNote", IIf(category.AllowNote, 1, 0))
            .Add("CategoryDescription", IIf(lang = "English", category.Description, category.DescriptionFR))
            .Add("CategoryName", IIf(lang = "English", category.Name, category.NameFR))
            .Add("IsAllowance", IIf(category.IsAllowance, 1, 0))

            'hide factor method checkbox if category is one of the following
            .Add("AllowFactorMethod", IIf(catID = iALLOWANCE Or catID = iDONATION Or catID = iFIXED_CAR_ALLOWANCE Or catID = iINSURANCE_PREMIUM Or catID = iKM_ALLOWANCE Or catID = iLODGING_ALLOWANCE Or catID = iMEAL_ALLOWANCE Or catID = iMEAL_ALLOWANCE_LONG_HAUL_TRUCK Or catID = iPERSONAL_USE Or catID = iTOLLS Or catID = iSELECTABLE_RATE, 0, 1))
        End With

        category = Nothing

        Return categoryDictionary
    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function GetDescription(id As Integer, lang As String) As Dictionary(Of String, String)
        Dim description As New Description(id)
        Dim descriptionDictionary As New Dictionary(Of String, String)

        With descriptionDictionary
            If lang = "E" Then
                .Add("Title", description.EnglishTitle)
                .Add("Description", description.EnglishDescription)
            Else
                .Add("Title", description.FrenchTitle)
                .Add("Description", description.FrenchTitle)
            End If

        End With

        description = Nothing

        Return descriptionDictionary
    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function GetEmployee(empID As Integer, puk As String) As Dictionary(Of String, String)
        Dim employee As New Employee(empID)
        Dim loggedInUser As Employee
        Dim employeeDictionary As New Dictionary(Of String, String)

        Try
            If puk = Membership.GetUser.ProviderUserKey.ToString Then
                loggedInUser = New Employee(Membership.GetUser.UserName)

                If loggedInUser.Organization.ID = employee.Organization.ID Or loggedInUser.Organization.Parent.ID = employee.Organization.Parent.ID Then

                    With employeeDictionary
                        .Add("LastName", employee.LastName)
                        .Add("FirstName", employee.FirstName)
                        .Add("Email", employee.Email)
                        .Add("UserName", employee.Username)
                        .Add("IsAdmin", IIf(employee.IsAdmin, 1, 0))
                        .Add("IsAccountant", IIf(employee.IsAccountant, 1, 0))
                        .Add("IsSupervisor", IIf(employee.IsSupervisor, 1, 0))
                        .Add("EmployeeID", employee.ID)
                        .Add("OrganizationID", employee.OrgID)
                        .Add("Supervisor", employee.Supervisor)
                        .Add("EmployeeNumber", employee.EmpNum)
                        .Add("Division", employee.DivCode)
                        .Add("Notify", IIf(employee.NotifyFinalized, 1, 0))
                        .Add("DelegatedTo", employee.DelegatedTo)
                        .Add("AllowTagEntry", IIf(employee.TagEntry, 1, 0))
                        .Add("EmployeeApprovalLevel", employee.ApprovalLevel)
                        .Add("OrganizationApprovalLevels", employee.Organization.Parent.ApprovalLevel)
                        .Add("Finalizer", employee.Finalizer)
                        .Add("DefaultProjectID", employee.DefaultProject.ID)
                        .Add("LockDefaultProject", IIf(employee.LockDefaultProject, 1, 0))
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
            employee = Nothing
            loggedInUser = Nothing
        End Try

        Return employeeDictionary
    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function GetSupervisors(orgID As Integer) As String
        GetConnectionString()
        Dim sqlConn = New SqlConnection(connString.ConnectionString)
        Dim stringBuilder As New StringBuilder

        sqlConn.Open()

        Dim com As SqlCommand = New SqlCommand("GetSupervisors", sqlConn)
        Dim rs As SqlDataReader

        com.CommandType = CommandType.StoredProcedure
        com.Parameters.Add(New SqlParameter("@OrgID", SqlDbType.Int)).Value = orgID
        com.Connection = sqlConn
        rs = com.ExecuteReader

        stringBuilder.Append("<option></option>")
        While rs.Read
            stringBuilder.Append("<option value='" & rs("EMP_ID") & "'>" & rs("SUPER_NAME") & "</option>")
        End While

        rs.Close()
        com.Dispose()
        sqlConn.Close()

        Return stringBuilder.ToString
    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function CheckUsername(username As String) As Integer
        Dim employee As New Employee(username)

        CheckUsername = employee.ID

        employee = Nothing
    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function CheckEmpNum(empNum As String, orgID As Integer) As Integer
        Dim employee As New Employee()

        CheckEmpNum = employee.GetUserByEmpNum(empNum, orgID)

        employee = Nothing
    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function SetSuper(empID As Integer, lang As String) As String
        Dim supervisor As New Employee(empID)
        Dim sResult As String
        Dim sEmail As String, sMsg As String = ""
        Dim hasEmployees As Boolean
        Dim childEmployee As Employee
        Dim loggedInUser As New Employee(Membership.GetUser.UserName)

        supervisor.Organization.GetEmployees()
        For Each childEmployee In supervisor.Organization.Employees
            If childEmployee.Finalizer = empID Or childEmployee.Supervisor = empID Then
                hasEmployees = True
                Exit For
            End If
        Next

        If Not hasEmployees Then
            CreateAuditTrail(empID, loggedInUser.ID, "tblEmployee", "Approver", "Modified Employee", IIf(supervisor.ApprovalLevel > 0, "True", "False"), IIf(supervisor.ApprovalLevel > 0, "False", "True"), supervisor.LastName & ", " & supervisor.FirstName)
            supervisor.ApprovalLevel = IIf(supervisor.ApprovalLevel = 1, 0, 1)
            supervisor.IsSupervisor = supervisor.ApprovalLevel > 0
            supervisor.Update()
            'supervisorDictionary.Add("SupervisorFullName", supervisor.LastName & ", " & supervisor.FirstName)

            sEmail = GetMessage(31, supervisor.DefaultLanguage)

            sEmail = Replace(sEmail, "(Name)", supervisor.FirstName & " " & supervisor.LastName)
            SendEmail(supervisor.Email, "Advataxes: " & GetMessage(409, supervisor.DefaultLanguage), sEmail, supervisor.DefaultLanguage)
        Else
            If supervisor.ApprovalLevel = 1 Then
                sMsg = GetMessage(407, loggedInUser.DefaultLanguage) 'employee is currently assigned to other employees as an approver
            Else
                sMsg = GetMessage(408, loggedInUser.DefaultLanguage) 'employee is currently assigned to other employees as a finalizer
            End If
        End If

        'if the supervisor has employees, he cannot be removed as a supervisor so return a message, if he has no employees,
        'return successful
        sResult = IIf(hasEmployees, sMsg, "Successful")

        supervisor = Nothing
        childEmployee = Nothing

        Return sResult
    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function SetFinalizer(empID As Integer, lang As String) As String
        Dim finalizer As New Employee(empID), childEmployee As Employee
        Dim sResult As String, sEmail As String, sMsg As String = ""
        Dim hasEmployees As Boolean
        Dim loggedInUser As New Employee(Membership.GetUser.UserName)

        finalizer.Organization.GetEmployees()
        For Each childEmployee In finalizer.Organization.Employees
            If childEmployee.Finalizer = empID Or childEmployee.Supervisor = empID Then
                hasEmployees = True
                Exit For
            End If
        Next

        If Not hasEmployees Then
            CreateAuditTrail(empID, loggedInUser.ID, "tblEmployee", "Finalizer", "Modified Employee", IIf(finalizer.ApprovalLevel = 2, "True", "False"), IIf(finalizer.ApprovalLevel = 2, "False", "True"), finalizer.LastName & ", " & finalizer.FirstName)
            finalizer.SetFinalizer(IIf(finalizer.ApprovalLevel = 2, 0, 2))
            finalizer.SetSupervisor(IIf(finalizer.ApprovalLevel = 2, False, True))
            sEmail = GetMessage(31, finalizer.DefaultLanguage)
            sEmail = Replace(sEmail, "(Name)", finalizer.FirstName & " " & finalizer.LastName)
            SendEmail(finalizer.Email, "Advataxes: " & GetMessage(409, finalizer.DefaultLanguage), sEmail, finalizer.DefaultLanguage)
        Else
            If finalizer.ApprovalLevel = 2 Then
                sMsg = GetMessage(410, loggedInUser.DefaultLanguage)  'user is already assigned as a finalizer
            Else
                sMsg = GetMessage(411, loggedInUser.DefaultLanguage) ' user is already assigned as an approver
            End If
        End If

        sResult = IIf(hasEmployees, sMsg, "Successful")

        finalizer = Nothing
        childEmployee = Nothing
        loggedInUser = Nothing

        Return sResult
    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Sub SetTagEntry(empID As Integer, lang As String)
        Dim employee As New Employee(empID)
        Dim loggedInUser As New Employee(Membership.GetUser.UserName)
        Dim stringBuilder As New StringBuilder

        CreateAuditTrail(empID, loggedInUser.ID, "tblEmployee", "Create Tags", "Modified Employee", employee.TagEntry, Not employee.TagEntry, employee.LastName & ", " & employee.FirstName)
        employee.TagEntry = Not employee.TagEntry
        employee.Update()

        stringBuilder.Append(GetMessage(31, employee.DefaultLanguage))
        stringBuilder.Replace("(Name)", employee.FirstName & " " & employee.LastName)
        SendEmail(employee.Email, "Advataxes: " & GetMessage(409, employee.DefaultLanguage), stringBuilder.ToString, employee.DefaultLanguage)

        loggedInUser = Nothing
        employee = Nothing
    End Sub

    <System.Web.Services.WebMethod()>
    Public Shared Sub SetViewReports(empID As Integer, lang As String)
        Dim employee As New Employee(empID)
        Dim loggedInUser As New Employee(Membership.GetUser.UserName)
        Dim stringBuilder As New StringBuilder

        CreateAuditTrail(empID, loggedInUser.ID, "tblEmployee", "View Reports", "Modified Employee", employee.IsAccountant, Not employee.IsAccountant, employee.LastName & ", " & employee.FirstName)
        employee.IsAccountant = Not employee.IsAccountant
        employee.Update()

        stringBuilder.Append(GetMessage(31, employee.DefaultLanguage))
        stringBuilder.Replace("(Name)", employee.FirstName & " " & employee.LastName)
        SendEmail(employee.Email, "Advataxes: " & GetMessage(409, employee.DefaultLanguage), stringBuilder.ToString, employee.DefaultLanguage)

        loggedInUser = Nothing
        employee = Nothing
    End Sub


    <System.Web.Services.WebMethod()>
    Public Shared Sub SetNotify(empID As Integer, lang As String)
        Dim employee As New Employee(empID)
        Dim loggedInUser As New Employee(Membership.GetUser.UserName)
        Dim stringBuilder As New StringBuilder

        CreateAuditTrail(empID, loggedInUser.ID, "tblEmployee", "Notify", "Modified Employee", employee.NotifyFinalized, Not employee.NotifyFinalized, employee.LastName & ", " & employee.FirstName)
        employee.SetNotifyFinalized(IIf(employee.NotifyFinalized, False, True))
        stringBuilder.Append(GetMessage(31, employee.DefaultLanguage))

        stringBuilder.Replace("(Name)", employee.FirstName & " " & employee.LastName)
        SendEmail(employee.Email, "Advataxes: " & GetMessage(409, employee.DefaultLanguage), stringBuilder.ToString, employee.DefaultLanguage)

        loggedInUser = Nothing
        employee = Nothing
    End Sub

    <System.Web.Services.WebMethod()>
    Public Shared Sub UnlockUser(empID As Integer)
        Dim employee As New Employee(empID)

        Membership.GetUser(employee.Username).UnlockUser()

        employee = Nothing
    End Sub

    <System.Web.Services.WebMethod()>
    Public Shared Function SetActive(empID As Integer, userID As Integer) As String
        Dim employee As New Employee(empID), childEmployee As Employee
        Dim hasEmployees As Boolean
        Dim returnString As String = ""

        'if we are deactivating an employee, check first if they have any employees assigned to them. 
        'if they do, the employee cannot be deactivated
        If employee.Active Then
            employee.Organization.GetEmployees()
            For Each childEmployee In employee.Organization.Employees
                If childEmployee.Finalizer = empID Or childEmployee.Supervisor = empID Then
                    hasEmployees = True
                    Exit For
                End If
            Next
        End If

        'if there are no employee assigned to this employee, they can be deactivated if we are deactivating
        If Not hasEmployees Then
            CreateAuditTrail(empID, userID, "tblEmployee", "Active", "Modified Employee", employee.Active, Not employee.Active, employee.LastName & ", " & employee.FirstName)
            employee.SetActive(IIf(employee.Active, False, True))
        Else
            returnString = GetMessage(412, employee.DefaultLanguage)
        End If

        employee = Nothing
        childEmployee = Nothing
        Return returnString

    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Sub SetActiveOrgCategory(orgCatID As Integer, userID As Integer)
        Dim orgCategory As New OrgCat(orgCatID)
        Dim modRec As String

        modRec = orgCategory.Category.Name & IIf(orgCategory.Note <> "", "--", "") & orgCategory.Note & IIf(orgCategory.Note <> "", "--", "")

        CreateAuditTrail(orgCatID, userID, "tblOrgCategory", "Active", "Modified Category", orgCategory.Active, Not orgCategory.Active, modRec)
        orgCategory.SetActive(IIf(orgCategory.Active, False, True))

        orgCategory = Nothing
    End Sub


    <System.Web.Services.WebMethod()>
    Public Shared Sub SetActiveAccount(accID As Integer, userID As Integer)
        Dim account As New Account(accID)

        CreateAuditTrail(accID, userID, "tblAccount", "Active", "Modified Account", account.Active, Not account.Active, account.Name)
        account.Active = Not account.Active
        account.Update()

        account = Nothing
    End Sub

    <System.Web.Services.WebMethod()>
    Public Shared Function SetActiveOrg(orgID As Integer, userID As Integer) As String
        Dim organization As New Org(orgID)

        CreateAuditTrail(orgID, userID, "tblOrg", "Active", "Modified Organization", organization.Active, Not organization.Active, organization.Name)
        organization.SetActive(IIf(organization.Active, False, True))

        SetActiveOrg = organization.Name
        organization = Nothing
    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Sub SetAdmin(empID As Integer, lang As String)
        Dim employee As Employee
        Dim stringBuilder As New StringBuilder
        Dim loggedInUser As New Employee(Membership.GetUser.UserName)

        employee = New Employee(empID)

        If employee.IsAdmin Then
            Roles.RemoveUserFromRole(employee.Username, "Admin")
        Else
            If Not Roles.IsUserInRole(employee.Username, "Admin") Then Roles.AddUserToRole(employee.Username, "Admin")
        End If

        CreateAuditTrail(empID, loggedInUser.ID, "tblEmployee", "Admin", "Modified Employee", employee.IsAdmin, Not employee.IsAdmin, employee.LastName & ", " & employee.FirstName)
        employee.SetAdmin(IIf(employee.IsAdmin, False, True))

        stringBuilder.Append(GetMessage(31, employee.DefaultLanguage))
        stringBuilder.Replace("(Name)", employee.FirstName & " " & employee.LastName)

        SendEmail(employee.Email, "Advataxes: " & GetMessage(409, employee.DefaultLanguage), stringBuilder.ToString, employee.DefaultLanguage)

        employee = Nothing
        loggedInUser = Nothing
    End Sub

    <System.Web.Services.WebMethod()>
    Public Shared Sub DisplayProject(orgID As Integer, lang As String)
        Dim organization As Org

        organization = New Org(orgID)
        organization.DisplayProject = Not organization.DisplayProject
        organization.Update()

        organization = Nothing
    End Sub

    <System.Web.Services.WebMethod()>
    Public Shared Sub DisplayWorkOrder(orgID As Integer, lang As String)
        Dim organization As Org

        organization = New Org(orgID)
        organization.DisplayWorkOrder = Not organization.DisplayWorkOrder
        organization.Update()

        organization = Nothing
    End Sub

    <System.Web.Services.WebMethod()>
    Public Shared Sub DisplayCostCenter(orgID As Integer, lang As String)
        Dim organization As Org

        organization = New Org(orgID)
        organization.DisplayCostCenter = Not organization.DisplayCostCenter
        organization.Update()

        organization = Nothing
    End Sub

    <System.Web.Services.WebMethod()>
    Public Shared Sub SetAccountant(empID As Integer)
        Dim employee As New Employee(empID)

        employee.SetAccountant(IIf(employee.IsAccountant, False, True))

        employee = Nothing
    End Sub

    <System.Web.Services.WebMethod()>
    Public Shared Function GetOrganization(orgID As Integer) As Dictionary(Of String, String)
        Dim organizationDictionary As New Dictionary(Of String, String)
        Dim CRA As Single
        Dim period As New Period(orgID, 1, "Start")
        Dim loggedInUser As New Employee(Membership.GetUser().UserName)
        Dim organization As New Org(orgID)

        Try
            With organizationDictionary
                .Add("Address1", IIf(IsDBNull(organization.Address1), "", organization.Address1))
                .Add("Address2", IIf(IsDBNull(organization.Address2), "", organization.Address2))
                .Add("Commercial", IIf(organization.Commercial, "2", "1"))
                .Add("Exempt", IIf(organization.Exempt, "2", "1"))
                .Add("ForProfit", IIf(organization.ForProfit, "2", "1"))
                .Add("GSTNumber", organization.GST)
                .Add("GSTRegistrant", IIf(organization.GSTReg, "2", "1"))
                .Add("JurisdictionName", organization.Jur.Name)
                .Add("OrganizationName", organization.Name)
                .Add("OrganizationType", IIf(loggedInUser.DefaultLanguage = "English", organization.Type.Name, organization.Type.NameFR))
                .Add("GSTSize", organization.OrgSizeGST)
                .Add("QSTNumber", organization.QST)
                .Add("QSTRegistrant", IIf(organization.QSTReg, "2", "1"))
                .Add("QSTSize", organization.OrgSizeQST)

                CRA = FormatNumber(organization.GetCRA("GST", Now) * 100, 0)
                .Add("CRA_GST", IIf(CRA = 200, 100, CRA)) 'if 200 is returned, it means there is no entry in table so return 100% by default
                .Add("RetentionPeriod", organization.Retention)
                .Add("TypeID", organization.Type.ID)
                .Add("GSTDate", organization.GSTDate)
                .Add("QSTDate", organization.QSTDate)
                .Add("JurisdictionID", organization.Jur.ID)
                .Add("AccountPayalbe", organization.AccountPayable)
                .Add("ParentID", organization.Parent.ID)

                CRA = FormatNumber(organization.GetCRA("QST", Now) * 100, 0)
                .Add("CRA_QST", IIf(CRA = 200, 100, CRA)) 'if 200 is returned, it means there is no entry in table so return 100% by default
                .Add("ITCAccount", organization.ITCAccount)
                .Add("ITRAccount", organization.ITRAccount)
                .Add("RITCOntarioAccount", organization.ritcONAccount)
                .Add("RITCBCAccount", organization.ritcBCAccount)

                .Add("CreditCardOffset", organization.InterestRate)
                .Add("PeriodID", period.ID)
                .Add("OrganizationCode", organization.Code)
                .Add("KM_ON", FormatNumber(organization.kmON * 100, 0))
                .Add("KM_BC", FormatNumber(organization.kmBC * 100, 0))
                .Add("KM_PEI", FormatNumber(organization.kmPEI * 100, 0))
                .Add("ApprovalLevels", organization.Parent.ApprovalLevel)
            End With

            organization = Nothing

        Catch ex As Exception
            Throw ex

        End Try

        GetOrganization = organizationDictionary
    End Function


    <System.Web.Services.WebMethod()>
    Public Shared Function GetDashboard(orgID As Integer, puk As String) As String
        Dim sbDashboard As New StringBuilder
        Dim i As Integer
        Dim organization As New Org(orgID)
        Dim employee As New Employee(Membership.GetUser.UserName.ToString)

        Try
            If puk = Membership.GetUser.ProviderUserKey.ToString And (employee.Organization.ID = organization.ID Or employee.Organization.Parent.ID = organization.Parent.ID) Then
                organization.GetEmployees()
                sbDashboard.Append("<div id='Dashboard' style='overflow:scroll;height:850px; width:98%;'><br /><table width='100%'><tr><td style='font-weight:bold;'>" & GetMessage(149, employee.DefaultLanguage) & "</td><td style='font-weight:bold;'>" & GetMessage(148, employee.DefaultLanguage) & "</td><td style='font-weight:bold;'>" & GetMessage(226, employee.DefaultLanguage) & "</td></tr><tr><td colspan='3' style='background-color:#cd1e1e;'></td></tr>")

                For Each employee In organization.Employees
                    i = i + 1
                    sbDashboard.Append("<tr " & IIf(i Mod 2 = 0, "style='background-color:#efefef;'", "") & "><td class='labelText'>")
                    sbDashboard.Append(employee.LastName)
                    sbDashboard.Append("</td><td class='labelText'>")
                    sbDashboard.Append(employee.FirstName)
                    sbDashboard.Append("</td><td class='labelText' >")
                    sbDashboard.Append(Membership.GetUser(employee.Username).LastLoginDate)
                    sbDashboard.Append("</td></tr>")
                Next

            Else
                sbDashboard.Append("<div id='Dashboard' style='overflow:scroll;height:850px; width:98%;'><br /><table width='100%'><tr><td style='font-weight:bold;'>" & GetMessage(431, employee.DefaultLanguage) & "</td></tr>")
            End If

            If sbDashboard.ToString <> "" Then sbDashboard.Append("</table></div>")

        Catch ex As Exception
            Throw ex

        Finally
            organization = Nothing
            employee = Nothing
        End Try

        GetDashboard = sbDashboard.ToString
    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function GetEmpReports(empID As Integer) As String
        Dim stringBuilder As New StringBuilder
        Dim report As Report

        Try
            Dim employee As New Employee(empID)

            For Each report In employee.Reports
                If report.Status = 4 Then 'if finalized
                    stringBuilder.Append("<option value='" & report.ID & "'>" & report.Name & "</option>")
                End If
            Next

            employee = Nothing

        Catch ex As Exception
            Throw ex
        End Try

        GetEmpReports = stringBuilder.ToString
    End Function

    Private Sub Admin_LoadComplete(sender As Object, e As System.EventArgs) Handles Me.LoadComplete
        LoadSupervisors()

        If Session("selectedOrg") <> "" Then
            cboOrg.SelectedValue = CInt(Session("selectedOrg"))
            Session("selectedOrg") = ""
        End If
    End Sub

    Private Sub cmdSaveSettings_Click(sender As Object, e As System.EventArgs) Handles cmdSaveSettings.Click
        Dim organization As Org
        Dim iPeriods As Integer
        Dim i As Integer
        Dim period As Period
        Dim periodNumber As Integer
        Dim icnt As Integer


        Try
            organization = Session("emp").Organization.parent

            period = New Period(organization.ID, 1, "Start")

            If period.ID = 0 Then
                organization.NumberOfPeriods = cboPeriodNum.SelectedValue
                organization.FirstMonth = cboFirstMonth.SelectedIndex + 1
            End If

            organization.CalendarMatch = cboCalendarMatch.SelectedValue
            organization.Retention = cboRetention.SelectedValue
            organization.AccountPayable = txtAcctPayable.Text
            organization.InterestRate = cboInterestRate.SelectedValue
            organization.ITCAccount = txtITCAcct.Text
            organization.ITRAccount = txtITRAcct.Text
            organization.ritcBCAccount = txtRITCBC.Text
            organization.ritcONAccount = txtRITCON.Text
            organization.ritcPEIAccount = txtRITCPEI.Text
            organization.DisplayProject = IIf(cboSegment2.SelectedValue = "P" Or cboSegment3.SelectedValue = "P" Or cboSegment4.SelectedValue = "P", True, False)
            organization.DisplayCostCenter = IIf(cboSegment2.SelectedValue = "C" Or cboSegment3.SelectedValue = "C" Or cboSegment4.SelectedValue = "C", True, False)
            organization.DisplayDivision = IIf(cboSegment1.SelectedValue = "D" Or cboSegment2.SelectedValue = "D", True, False)
            organization.DisplayWorkOrder = cboWO.SelectedValue
            organization.AccSegment = cboSegment1.SelectedValue & cboSegment2.SelectedValue & cboSegment3.SelectedValue & cboSegment4.SelectedValue
            organization.ApprovalLevel = cboApprovalLevel.SelectedValue

            lblRetentionData.Text = organization.Retention & " year(s)"
            lblCurrencyOffsetData.Text = organization.InterestRate & " %"
            lblAcctPayableData.Text = organization.AccountPayable
            lblITCAcctData.Text = organization.ITCAccount
            lblITRAcctData.Text = organization.ITRAccount
            lblRITCBCData.Text = organization.ritcBCAccount
            lblRITCONData.Text = organization.ritcONAccount

            If period.ID = 0 Then
                Session("emp").Organization.parent.FirstMonth = organization.FirstMonth
                Session("emp").Organization.parent.NumberOfPeriods = organization.NumberOfPeriods
            End If

            Session("emp").Organization.parent = organization

            If cboPeriodNum.SelectedValue <> cboPeriod.Items.Count Then
                iPeriods = Session("emp").Organization.parent.NumberOfPeriods

                cboPeriod.Items.Clear()
                For i = 1 To iPeriods
                    cboPeriod.Items.Add(i)
                Next
            End If

            If period.ID = 0 Then
                period.PeriodMonth = organization.FirstMonth
                periodNumber = 1
                icnt = 1

                For i = 1 To 12

                    If (organization.FirstMonth <> 1 And period.PeriodMonth < organization.FirstMonth) Or organization.FirstMonth = 1 Then
                        period.SubtractYear = 0
                    Else
                        period.SubtractYear = 1

                    End If

                    period.PeriodNum = periodNumber
                    period.Create()
                    period.PeriodMonth = period.PeriodMonth + 1
                    If period.PeriodMonth > 12 Then period.PeriodMonth = period.PeriodMonth - 12

                    icnt = icnt + 1
                    If icnt > 12 / organization.NumberOfPeriods Then
                        icnt = 1
                        periodNumber = periodNumber + 1
                    End If
                Next
            End If

            organization.Update()
            Session("msg") = GetMessage(196, hdnLanguage.Value) '"Changes saved successfully"

        Catch ex As Exception
            Response.Redirect("~/error.aspx")
        Finally
            Response.Redirect("admin.aspx?tab=4")
            organization = Nothing
            period = Nothing
        End Try
    End Sub

    Private Sub cmdSaveEmployee_Click(sender As Object, e As System.EventArgs) Handles cmdSaveEmployee.Click

        If txtEmpID.Text = 0 Or txtEmpID.Text = "" Then
            CreateEmployee()
        Else
            UpdateEmployee()
        End If

        txtUserName.Enabled = True
        txtEmpID.Text = 0
    End Sub

    Private Sub UpdateEmployee()
        Dim employee As Employee

        Try
            Dim delegateID As Integer

            employee = New Employee(CInt(txtEmpID.Text))

            With Membership.GetUser(employee.Username)
                .Email = txtEmail.Text
            End With

            Membership.UpdateUser(Membership.GetUser(employee.Username))

            employee.Title = employee.Title
            employee.Email = txtEmail.Text
            employee.Phone = employee.Phone
            employee.IsAdmin = chkIsAdmin.Checked
            employee.IsSupervisor = chkIsSuper.Checked Or chkFinalizer.Checked
            employee.IsAccountant = chkViewReports.Checked

            If employee.IsAdmin Then
                If Not Roles.IsUserInRole(employee.Username, "Admin") Then Roles.AddUserToRole(employee.Username, "Admin")
            Else
                If Roles.IsUserInRole(employee.Username, "Admin") Then Roles.RemoveUserFromRole(employee.Username, "Admin")
            End If

            employee.Supervisor = cboSupervisor.SelectedValue
            employee.Finalizer = cboFinalizer.SelectedValue
            delegateID = employee.DelegatedTo
            employee.DelegatedTo = cboDelegate.SelectedValue
            employee.EmpNum = IIf(employee.EmpNum = "null", txtEmpNum.Text, employee.EmpNum)
            employee.DivCode = IIf(employee.DivCode = "null", cboDiv.SelectedValue, employee.DivCode)
            employee.NotifyFinalized = chkNotify.Checked
            employee.TagEntry = chkTagEntry.Checked
            employee.ApprovalLevel = IIf(chkIsSuper.Checked, 1, IIf(chkFinalizer.Checked, 2, 0))
            employee.DefaultProject.ID = cboDefaultProject.SelectedValue
            employee.LockDefaultProject = chkLockDefaultProject.Checked
            CompareEmployee(employee)

            employee.Update()
            gvEmployees.DataBind()

            Session("selectedOrg") = cboOrg.SelectedValue
            Session("selectedTab") = "1"

        Catch ex As Exception
            Response.Redirect("~/error.aspx")

        Finally
            cboSupervisor.SelectedIndex = -1
            txtFName.Text = Nothing
            txtLName.Text = Nothing
            txtEmail.Text = Nothing
            txtUserName.Text = Nothing
            chkIsSuper.Checked = False
            chkIsAdmin.Checked = False
            employee = Nothing
            Response.Redirect("~/Admin/admin.aspx")
        End Try

    End Sub


    Private Sub CompareEmployee(updatedEmp As Employee)
        Dim employee As New Employee(updatedEmp.ID)
        Dim oldValue As String, newValue As String


        If employee.DelegatedTo <> updatedEmp.DelegatedTo Then CreateAuditTrail(employee.ID, Session("emp").id, "tblEmployee", "Delegate", "", IIf(employee.DelegatedTo = 0, "None", employee.DelegatedTo), IIf(updatedEmp.DelegatedTo = 0, "None", updatedEmp.DelegatedTo), employee.LastName & ", " & employee.FirstName)
        If employee.Email <> updatedEmp.Email Then CreateAuditTrail(employee.ID, Session("emp").id, "tblEmployee", "Email", "", employee.Email, updatedEmp.Email, employee.LastName & ", " & employee.FirstName)

        If employee.Finalizer <> updatedEmp.Finalizer Then
            Dim oldfinalizer As New Employee(employee.Finalizer)
            Dim newFinalizer As New Employee(updatedEmp.Finalizer)
            CreateAuditTrail(employee.ID, Session("emp").id, "tblEmployee", "Finalizer", "Modified Employee", oldfinalizer.LastName & ", " & oldfinalizer.FirstName, newFinalizer.LastName & ", " & newFinalizer.FirstName, employee.LastName & ", " & employee.FirstName)
            oldfinalizer = Nothing
            newFinalizer = Nothing
        End If

        If employee.Supervisor <> updatedEmp.Supervisor Then
            Dim oldSuper As New Employee(employee.Supervisor)
            Dim newSuper As New Employee(updatedEmp.Supervisor)
            CreateAuditTrail(employee.ID, Session("emp").id, "tblEmployee", "Supervisor", "Modified Employee", oldSuper.LastName & ", " & oldSuper.FirstName, newSuper.LastName & ", " & newSuper.FirstName, employee.LastName & ", " & employee.FirstName)
            oldSuper = Nothing
            newSuper = Nothing
        End If

        If employee.FirstName <> updatedEmp.FirstName Then CreateAuditTrail(employee.ID, Session("emp").id, "tblEmployee", "First Name", "Modified Employee", employee.FirstName, updatedEmp.FirstName, employee.LastName & ", " & employee.FirstName)
        If employee.LastName <> updatedEmp.LastName Then CreateAuditTrail(employee.ID, Session("emp").id, "tblEmployee", "Last Name", "Modified Employee", employee.LastName, updatedEmp.LastName, employee.LastName & ", " & employee.FirstName)
        If employee.IsAccountant <> updatedEmp.IsAccountant Then CreateAuditTrail(employee.ID, Session("emp").id, "tblEmployee", "View Reports", "Modified Employee", employee.IsAccountant, updatedEmp.IsAccountant, employee.LastName & ", " & employee.FirstName)
        If employee.IsAdmin <> updatedEmp.IsAdmin Then CreateAuditTrail(employee.ID, Session("emp").id, "tblEmployee", "Admin", "Modified Employee", employee.IsAdmin, updatedEmp.IsAdmin, employee.LastName & ", " & employee.FirstName)
        If employee.NotifyFinalized <> updatedEmp.NotifyFinalized Then CreateAuditTrail(employee.ID, Session("emp").id, "tblEmployee", "Notify", "Modified Employee", employee.NotifyFinalized, updatedEmp.NotifyFinalized, employee.LastName & ", " & employee.FirstName)
        If employee.TagEntry <> updatedEmp.TagEntry Then CreateAuditTrail(employee.ID, Session("emp").id, "tblEmployee", "Tags", "Modified Employee", employee.TagEntry, updatedEmp.TagEntry, employee.LastName & ", " & employee.FirstName)
        If employee.Title <> updatedEmp.Title Then CreateAuditTrail(employee.ID, Session("emp").id, "tblEmployee", "Title", "Modified Employee", employee.Title, updatedEmp.Title, employee.LastName & ", " & employee.FirstName)

        If employee.IsSupervisor <> updatedEmp.IsSupervisor Then
            Select Case employee.ApprovalLevel
                Case 0 : oldValue = "None"
                Case 1 : oldValue = "Approver"
                Case 2 : oldValue = "Finalizer"
            End Select

            Select Case updatedEmp.ApprovalLevel
                Case 0 : newValue = "None"
                Case 1 : newValue = "Approver"
                Case 2 : newValue = "Finalizer"
            End Select

            CreateAuditTrail(employee.ID, Session("emp").id, "tblEmployee", "Approval Level", "Modified Employee", oldValue, newValue, employee.LastName & ", " & employee.FirstName)
        End If

        employee = Nothing
    End Sub

    Private Sub CreateEmployee()
        Dim status As MembershipCreateStatus
        Dim employee As Employee
        Dim userMembership As MembershipUser
        Dim stringBuilder As New StringBuilder
        Dim sStatus As String

        Try
            Membership.CreateUser(txtUserName.Text, "Password_1", txtEmail.Text, "question", "answer", True, status)

            If status.ToString = "Success" Then
                employee = New Employee(txtUserName.Text)
                employee.OrgID = CInt(cboOrg.SelectedValue)
                employee.FirstName = txtFName.Text
                employee.LastName = txtLName.Text
                employee.Email = txtEmail.Text
                employee.IsAdmin = chkIsAdmin.Checked
                employee.IsSupervisor = chkIsSuper.Checked Or chkFinalizer.Checked
                employee.IsAccountant = chkViewReports.Checked

                If employee.IsAdmin Or employee.IsAccountant Then Roles.AddUserToRole(txtUserName.Text, "Admin")

                employee.Username = txtUserName.Text
                employee.Supervisor = cboSupervisor.SelectedValue
                employee.Finalizer = cboFinalizer.SelectedValue
                employee.DelegatedTo = cboDelegate.SelectedValue
                employee.TagEntry = chkTagEntry.Checked
                employee.ApprovalLevel = IIf(chkIsSuper.Checked, 1, IIf(chkFinalizer.Checked, 2, 0))
                employee.EmpNum = txtEmpNum.Text
                employee.DefaultProject.ID = cboDefaultProject.SelectedValue
                employee.LockDefaultProject = chkLockDefaultProject.Checked
                employee.DivCode = cboDiv.SelectedValue
                employee.NotifyFinalized = chkNotify.Checked

                employee.Create()
                employee = Nothing

                gvEmployees.DataBind()

                userMembership = Membership.GetUser(txtUserName.Text)

                stringBuilder.Append(GetMessage(26, Session("emp").defaultlanguage))
                stringBuilder.Replace("(username)", userMembership.UserName)
                stringBuilder.Replace("(Name)", txtFName.Text & " " & txtLName.Text)
                stringBuilder.Replace("(approver)", cboSupervisor.SelectedItem.Text)
                stringBuilder.Replace("(org)", cboOrg.SelectedItem.Text)

                sStatus = ""
                If chkIsAdmin.Checked Then
                    sStatus = "Admin"
                End If

                If chkIsSuper.Checked Then
                    If sStatus = "Admin" Then sStatus += "/"
                    sStatus += "Approver"
                End If

                If sStatus = "" Then
                    stringBuilder.Replace("Status: (status)", "")
                    stringBuilder.Replace("Statut : (status)", "")
                Else
                    stringBuilder.Replace("(status)", sStatus)
                End If

                stringBuilder.Replace("(admin)", Session("emp").firstname & " " & Session("emp").lastname)
                stringBuilder.Replace("(link)", "https://www.advataxes.ca/PasswordReset.aspx?id=" + userMembership.ProviderUserKey.ToString)

                SendEmail(userMembership.Email, GetMessageTitle(26, Session("emp").defaultlanguage), stringBuilder.ToString, Session("emp").defaultlanguage)
                Session("msg") = GetMessage(274, Session("emp").defaultlanguage) & " " & userMembership.Email  '"Employee was added successfully. An email was sent to " & u.Email & "."

                employee = New Employee(txtUserName.Text)
                CreateAuditTrail(employee.ID, Session("emp").id, "tblEmployee", "", "Created Employee", "", employee.LastName & ", " & employee.FirstName, "")

            Else

                lblInvalidUserName.Visible = True
                If status.ToString = "DuplicateUserName" Then lblInvalidUserName.Text = GetMessage(275, Session("emp").defaultlanguage)

            End If

            Session("selectedOrg") = cboOrg.SelectedValue
            Session("selectedTab") = "1"

        Catch ex As Exception
            Session("error") = ex.Message
            Response.Redirect("../error.aspx")


        Finally
            cboSupervisor.SelectedIndex = -1
            txtFName.Text = Nothing
            txtLName.Text = Nothing
            txtEmail.Text = Nothing
            txtUserName.Text = Nothing
            chkIsSuper.Checked = False
            chkIsAdmin.Checked = False
            employee = Nothing
            userMembership = Nothing

            Response.Redirect("~/Admin/admin.aspx")
        End Try

    End Sub

    Private Sub cboOrg_SelectedIndexChanged(sender As Object, e As System.EventArgs) Handles cboOrg.SelectedIndexChanged
        Dim i As Integer

        i = cboOrg.SelectedIndex
        gvOrgs.DataBind()
        cboOrg.DataBind()
        cboOrg.SelectedIndex = i
    End Sub


    Private Sub cboDelegate_DataBound(sender As Object, e As System.EventArgs) Handles cboDelegate.DataBound
        cboDelegate.Items.Insert(0, "")
        cboDelegate.Items(0).Value = 0
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
                                id = Replace(childccc.id, "_", "")
                                If id Like "lbl*" Then
                                    childccc.text = d.GetDescription(CInt(Replace(id, "lbl", "")), Left(Session("emp").defaultlanguage, 1))

                                ElseIf childccc.id Like "CT*" Then
                                    childccc.text = GetCustomTag(Right(childccc.id, 1))
                                End If

                            ElseIf TypeOf childccc Is Panel Then
                                For Each childcccc In childccc.controls
                                    If TypeOf childcccc Is Label Then
                                        id = Replace(childcccc.id, "_", "")
                                        If id Like "lbl*" Then
                                            childcccc.text = d.GetDescription(CInt(Replace(id, "lbl", "")), Left(Session("emp").defaultlanguage, 1))

                                        ElseIf childcccc.id Like "CT*" Then
                                            childcccc.text = GetCustomTag(Right(childcccc.id, 1))
                                        End If

                                    ElseIf TypeOf childccc Is HiddenField Then
                                        id = Replace(childccc.id, "_", "")
                                        If id Like "hdnT*" Then childccc.text = d.GetDescription(CInt(Replace(id, "hdnT", "")), Left(Session("emp").defaultlanguage, 1))
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

                            ElseIf TypeOf childccc Is HiddenField Then
                                id = Replace(childccc.id, "_", "")
                                If id Like "hdnT*" Then childccc.text = d.GetDescription(CInt(Replace(id, "hdnT", "")), Left(Session("emp").defaultlanguage, 1))

                            End If
                        Next

                    End If

                Next
            Next
        Next

    End Sub


    Private Sub Translate2(o As Org)
        Dim i As Integer

        Try
            cboDataType.Items(0).Text = GetMessage(517)
            cboDataType.Items(1).Text = GetMessage(519)

            cboFirstMonth.Items.Clear()
            cboFirstMonth.Items.Add(IIf(Session("emp").defaultlanguage = "English", "January", "janvier"))
            cboFirstMonth.Items.Add(IIf(Session("emp").defaultlanguage = "English", "February", "fevrier"))
            cboFirstMonth.Items.Add(IIf(Session("emp").defaultlanguage = "English", "March", "mars"))
            cboFirstMonth.Items.Add(IIf(Session("emp").defaultlanguage = "English", "April", "avril"))
            cboFirstMonth.Items.Add(IIf(Session("emp").defaultlanguage = "English", "May", "mai"))
            cboFirstMonth.Items.Add(IIf(Session("emp").defaultlanguage = "English", "June", "juin"))
            cboFirstMonth.Items.Add(IIf(Session("emp").defaultlanguage = "English", "July", "juillet"))
            cboFirstMonth.Items.Add(IIf(Session("emp").defaultlanguage = "English", "August", "aout"))
            cboFirstMonth.Items.Add(IIf(Session("emp").defaultlanguage = "English", "September", "septembre"))
            cboFirstMonth.Items.Add(IIf(Session("emp").defaultlanguage = "English", "October", "octobre"))
            cboFirstMonth.Items.Add(IIf(Session("emp").defaultlanguage = "English", "November", "novembre"))
            cboFirstMonth.Items.Add(IIf(Session("emp").defaultlanguage = "English", "December", "decembre"))

            cboHideInactive.Items(0).Text = GetMessage(175)
            cboHideInactive.Items(1).Text = GetMessage(422)

            cboDataRange.Items(0).Text = GetMessage(211)
            cboDataRange.Items(1).Text = GetMessage(213)
            hdnViewReport.Value = GetMessage(223)

            hdnInactiveCatMsg.Value = GetMessage(281)
            hdnCatStatusMsgTitle.Value = GetMessageTitle(281)
            gvCategories.EmptyDataText = GetMessage(282)

            hdnCancelText.Value = GetMessage(142)

            lblWarning.Text = GetMessage(174)
            lblWarningGS.Text = GetMessage(174)
            cboGSTReg.Items(0).Text = GetMessage(280)
            cboGSTReg.Items(1).Text = GetMessage(279)
            cboQSTReg.Items(0).Text = GetMessage(280)
            cboQSTReg.Items(1).Text = GetMessage(279)
            cboLargeGST.Items(0).Text = GetMessage(280)
            cboLargeGST.Items(1).Text = GetMessage(279)
            cboLargeQST.Items(0).Text = GetMessage(280)
            cboLargeQST.Items(1).Text = GetMessage(279)
            cmdSaveCompany.Text = GetMessage(140)
            cmdSaveEmployee.Text = GetMessage(140)
            cmdSaveOC.Text = GetMessage(140)
            cmdSaveSettings.Text = GetMessage(140)
            cmdCancelNewEmp.Text = GetMessage(142)
            cmdCancelSaveCompany.Text = GetMessage(142)
            cmdCancelSaveSettings.Text = GetMessage(142)
            cmdCancelVideo.Text = GetMessage(146)
            cmdCancelVidOrg.Text = GetMessage(146)
            hdnOrgCodeLabelText.Value = GetMessage(177)
            hdnJurLabelText.Value = GetMessage(43)
            hdnGSTRegLabelText.Value = GetMessage(178)
            hdnQSTRegLabelText.Value = GetMessage(179)
            hdnLargeGSTLabelText.Value = GetMessage(190)
            hdnLargeQSTLabelText.Value = GetMessage(191)
            hdnRatioLabelText.Value = GetMessage(320)
            hdnRITCKMLabelText.Value = GetMessage(318)
            hdnShowProjectText.Value = GetMessage(328)
            hdnShowWorkOrderText.Value = GetMessage(329)
            hdnShowCostCenterText.Value = GetMessage(330)
            lblFrom2.Text = GetMessage(379)
            lblTo2.Text = GetMessage(380)
            hdnUnexpectedError.Value = GetMessage(384)
            lblInvalidUserName.Text = GetMessage(275)
            hdnAprvrFnlzrReq.Value = GetMessage(386)
            hdnApproverReq.Value = GetMessage(387)
            hdnFinalizerReq.Value = GetMessage(388)
            hdnUnlocked.Value = GetMessage(385)
            hdnSetAdmin.Value = GetMessage(389)
            hdnSetEmpActive.Value = GetMessage(391)
            hdnSetEmpInactive.Value = GetMessage(392)
            hdnActiveCatMsg.Value = GetMessage(203)
            hdnSetAccActive.Value = GetMessage(393)
            hdnSetAccInactive.Value = GetMessage(394)
            hdnSetOrgActive.Value = GetMessage(395)
            hdnSetOrgInactive.Value = GetMessage(396)
            hdnSetFinalizer.Value = GetMessage(397)
            hdnRemoveFinalizer.Value = GetMessage(398)
            hdnSetApprover.Value = GetMessage(399)
            hdnRemoveApprover.Value = GetMessage(400)
            hdnSetTagEntry.Value = GetMessage(401)
            hdnRemoveTagEntry.Value = GetMessage(402)
            hdnSetDownloaded.Value = GetMessage(403)
            hdnRemoveDownloaded.Value = GetMessage(404)
            hdnSetNotify.Value = GetMessage(405)
            hdnRemoveNotify.Value = GetMessage(406)
            hdnRemoveAdmin.Value = GetMessage(390)
            hdnYes.Value = GetMessage(279)
            hdnNo.Value = GetMessage(280)
            hdnGSTRatio.Value = GetMessage(447)
            hdnQSTRatio.Value = GetMessage(448)
            hdnPEI.Value = GetMessageTitle(183)
            cboDownloadedOption.Items(0).Text = GetMessage(452)
            cboDownloadedOption.Items(1).Text = GetMessage(414)
            hdnLimitAmt.Value = GetMessage(453)
            hdnFixedAmt.Value = GetMessage(288)
            hdnEmpNumAlreadyAssigned.Value = GetMessage(458)
            cmdApply.Text = GetMessage(456)
            hdnActiveParent.Value = GetMessage(176)
            hdnLoginInfo.Value = GetMessage(225)
            hdnDownloaded.Value = GetMessage(414)
            hdnGST.Value = GetMessage(355)
            hdnQST.Value = GetMessage(356)
            hdnYourAccountNames.Value = GetMessage(477)
            hdnDetailed.Value = GetMessage(478)
            hdnExpenseReport.Value = GetMessage(235)
            hdnSetViewReports.Value = GetMessage(492)
            hdnRemoveViewReports.Value = GetMessage(493)
            hdnViewReports.Value = GetMessage(494)
            lblDefaultCC.Text = Replace(GetMessage(510), "(customtag)", GetCustomTag("C"))
            lblDefaultProject.Text = Replace(GetMessage(510), "(customtag)", GetCustomTag("P"))
            lblLockDefault.Text = Replace(GetMessage(515), "(customtag)", GetCustomTag("P"))
            lblProjectRequired.Text = Replace(GetMessage(454), "(customtag)", LCase(GetCustomTag("P")))
            lblCCRequired.Text = Replace(GetMessage(454), "(customtag)", LCase(GetCustomTag("C")))
            lblProjectRequired2.Text = Replace(GetMessage(454), "(customtag)", LCase(GetCustomTag("P")))
            lblCCRequired2.Text = Replace(GetMessage(454), "(customtag)", LCase(GetCustomTag("C")))
            ValidationSummary1.HeaderText = GetMessage(553)

        Catch ex As Exception
            If Session("emp").isadvalorem Then
                Session("Error") = ex.Message
            Else
                Session("Error") = GetMessage(273)
            End If

            Response.Redirect("../error.aspx")
        End Try

    End Sub

    Private Sub cmdCancelVideo_Click(sender As Object, e As System.EventArgs) Handles cmdCancelVideo.Click
        Session("selectedTab") = "4"
        Response.Redirect("admin.aspx")
    End Sub

    Private Sub cmdEmpVideo_Click(sender As Object, e As System.EventArgs) Handles cmdEmpVideo.Click
        Session("selectedTab") = "1"
        Response.Redirect("admin.aspx")
    End Sub


    Private Sub cmdApply_Click(sender As Object, e As System.EventArgs) Handles cmdApply.Click

        Dim row As GridViewRow
        Dim report As Report

        For Each row In gvDownloads.Rows
            report = New Report(CInt(gvDownloads.DataKeys(row.DataItemIndex).Value))
            report.Downloaded = CInt(cboDownloadedOption.SelectedValue)
            report.Update()
        Next

        gvDownloads.DataBind()

    End Sub

    <System.Web.Services.WebMethod()>
    Public Shared Sub SetDownloaded(rptID As Integer)
        Dim report As New Report(rptID)

        report.Downloaded = Not report.Downloaded
        report.Update()

        report = Nothing
    End Sub

    Private Sub SummaryDetailedCSV(Optional TSV As Boolean = False)
        Dim report As Report
        Dim stringBuilder As New StringBuilder
        Dim buffer() As Byte
        Dim memoryStream = New System.IO.MemoryStream
        Dim dStartDate As Date, dEndDate As Date
        Dim organization = New Org(CInt(cboOrg.SelectedValue))
        Dim reportYear As Integer = CInt(Right(txtFrom2.Text, 4))
        Dim reportDay As Integer = CInt(Left(txtFrom2.Text, 2))
        Dim reportMonth As Integer = CInt(Mid(txtFrom2.Text, 4, 2))

        dStartDate = New Date(reportYear, reportMonth, reportDay)

        reportYear = CInt(Right(txtTo2.Text, 4))
        reportDay = CInt(Left(txtTo2.Text, 2))
        reportMonth = CInt(Mid(txtTo2.Text, 4, 2))

        dEndDate = New Date(reportYear, reportMonth, reportDay)

        organization.GetReports(dStartDate, dEndDate)
        AmtTotal = 0 : ITCTotal = 0 : ITRTotal = 0 : RITCTotal = 0 : debitTotal = 0 : RITCTotalOnt = 0 : RITCTotalBC = 0 : RITCTotalPEI = 0

        If Not IsNothing(organization.Reports) Then
            For Each report In organization.Reports
                If stringBuilder.ToString = "" Then stringBuilder.Append("""Report#"",""Finalized"",""Acct#"",""Emp/TP"",""Type"",""Amount""" & vbCrLf)
                stringbuilder.Append(SummaryDetailedCSV2(report.ID))
                report.Downloaded = True
                report.Update()
            Next

            If stringbuilder.ToString = "" Then stringbuilder.Append(GetMessage(413))
            If TSV Then stringbuilder.Replace(""",""", vbTab) : stringbuilder.Replace("""", "")

            buffer = Encoding.Default.GetBytes(stringbuilder.ToString)
            memoryStream.Write(buffer, 0, buffer.Length)
            Response.Clear()
            Response.AddHeader("Content-Disposition", "attachment; filename=Summary." & IIf(TSV, "tsv", "csv"))
            Response.AddHeader("Content-Length", memoryStream.Length.ToString())
            Response.ContentType = "text/plain"
            memoryStream.WriteTo(Response.OutputStream)
            Response.End()

        End If

        report = Nothing
        organization = Nothing
        gvDownloads.DataBind()
    End Sub

    Private Function SummaryDetailedCSV2(reportID As Integer) As String
        Dim memoryStream = New System.IO.MemoryStream
        Dim credit As Double
        Dim iMonth As Integer
        Dim report = New Report(reportID)
        Dim stringBuilder As New StringBuilder
        Dim sbAccSegment As New StringBuilder
        Dim sbOtherAccPayable As New StringBuilder, sbAccPayable As New StringBuilder
        Dim organizationCategory As New OrgCat
        Dim period As Period
        Dim periodNum As Integer
        Dim organization As New Org(CInt(cboOrg.SelectedValue))
        Dim expense As Expense
        Dim rpt As String
        rpt = "R"
        Try
            If report.EmpID = Session("emp").ID Or (report.Emp.Supervisor = Session("emp").id) Or Session("emp").isadmin Then

                stringBuilder.Append("<accPayable>")
                stringBuilder.Append("<otherAccPayables>")

                ITCTotal = 0 : ITRTotal = 0 : RITCTotalBC = 0 : RITCTotalOnt = 0 : RITCTotalPEI = 0 : ITC = 0 : ITR = 0 : RITC = 0

                'check period
                For iMonth = 1 To 12
                    period = New Period(report.Emp.Organization.ID, iMonth)
                    If period.PeriodMonth = Month(report.FinalizedDate) Then
                        periodNum = period.PeriodNum
                        Exit For
                    End If
                Next

                For Each expense In report.Expenses
                    sbAccSegment.Clear()
                    sbAccPayable.Clear()

                    ITC += expense.ITC
                    ITR += expense.ITR

                    stringBuilder.Append("""" & "R" + report.ReportNumberFormatted & """")
                    stringBuilder.Append(",""" & Format(report.FinalizedDate, "yyyyMMdd") & """")
                    'stringBuilder.Append(",""" & report.Emp.EmpNum & """")

                    If organization.Parent.AccSegment.IndexOf("D") = 0 Then sbAccSegment.Append(report.Emp.DivCode)
                    If organization.Parent.AccSegment.IndexOf("A") = 0 Then sbAccSegment.Append(expense.OrgCategory.GLAccount)

                    If organization.Parent.AccSegment.IndexOf("D") = 1 Then sbAccSegment.Append(" " & report.Emp.DivCode)
                    If organization.Parent.AccSegment.IndexOf("A") = 1 Then sbAccSegment.Append(" " & expense.OrgCategory.GLAccount)
                    If organization.Parent.AccSegment.IndexOf("P") = 1 Then sbAccSegment.Append(" " & expense.Project)
                    If organization.Parent.AccSegment.IndexOf("C") = 1 Then sbAccSegment.Append(" " & expense.CostCenter)

                    If organization.Parent.AccSegment.IndexOf("P") = 2 Then sbAccSegment.Append(" " & expense.Project)
                    If organization.Parent.AccSegment.IndexOf("C") = 2 Then sbAccSegment.Append(" " & expense.CostCenter)

                    If organization.Parent.AccSegment.IndexOf("P") = 3 Then sbAccSegment.Append(" " & expense.Project)
                    If organization.Parent.AccSegment.IndexOf("C") = 3 Then sbAccSegment.Append(" " & expense.CostCenter)

                    stringBuilder.Append(",""" & sbAccSegment.ToString & ",""" & report.Emp.EmpNum & """,""D"",""" & Replace(FormatNumber(expense.AmountCDN - expense.ITC - expense.ITR + expense.RITC, 2).ToString, ",", "") & """" & vbCrLf)

                    If Not expense.Reimburse Then
                        sbOtherAccPayable.Append("""" & "R" + report.ReportNumberFormatted & """")
                        sbOtherAccPayable.Append(",""" & Format(report.FinalizedDate, "yyyyMMdd") & """")
                        sbOtherAccPayable.Append(",""" & organization.Parent.AccountPayable & """")
                        sbOtherAccPayable.Append(",""" & expense.TPNum & """")
                        sbOtherAccPayable.Append(",""C""")
                        sbOtherAccPayable.Append(",""" & FormatNumber(expense.AmountCDN, 2) & """" & vbCrLf)
                    Else
                        credit += CDec(expense.AmountCDN)
                    End If

                    RITCTotalBC = organizationCategory.GetRITCTotals(report.ID, 10)
                    RITCTotalOnt = organizationCategory.GetRITCTotals(report.ID, 2)
                    RITCTotalPEI = organizationCategory.GetRITCTotals(report.ID, 4)
                    AmtTotal += CDec(expense.AmountCDN) + expense.RITC
                Next

                If credit > 0 Then sbAccPayable.Append(BuildLine(report, organization.Parent.AccountPayable, "C", credit))

                stringBuilder.Replace("<accPayable>", sbAccPayable.ToString)
                stringBuilder.Replace("<otherAccPayables>", sbOtherAccPayable.ToString)

                If ITC > 0 Then stringBuilder.Append(BuildLine(report, organization.Parent.ITCAccount, "D", ITC))
                If ITR > 0 Then stringBuilder.Append(BuildLine(report, organization.Parent.ITRAccount, "D", ITR))
                If RITCTotalOnt > 0 Then stringBuilder.Append(BuildLine(report, organization.Parent.ritcONAccount, "C", RITCTotalOnt))
                If RITCTotalBC > 0 Then stringBuilder.Append(BuildLine(report, organization.Parent.ritcBCAccount, "C", RITCTotalBC))
                If RITCTotalPEI > 0 Then stringBuilder.Append(BuildLine(report, organization.Parent.ritcPEIAccount, "C", RITCTotalPEI))
            Else
                stringBuilder.Append("No authorization to view this data")
            End If

        Catch ex As Exception
            Throw ex

        Finally
            organizationCategory = Nothing
            organization = Nothing
            period = Nothing
            expense = Nothing
            report = Nothing
        End Try

        Return stringBuilder.ToString
    End Function


    Private Function BuildLine(report As Report, sAccount As String, sType As String, value As Double)
        Dim sbTotal As New StringBuilder

        sbTotal.Append("""" & "R" + report.ReportNumberFormatted & """")
        sbTotal.Append(",""" & Format(report.FinalizedDate, "yyyyMMdd") & """")
        sbTotal.Append(",""" & sAccount & """")
        sbTotal.Append(",""" & report.Emp.EmpNum & """")
        sbTotal.Append(",""" & sType & """")
        sbTotal.Append(",""" & FormatNumber(value, 2) & """" & vbCrLf)

        Return sbTotal.ToString
    End Function

    Private Sub cmdCSV_Click(sender As Object, e As System.Web.UI.ImageClickEventArgs) Handles cmdCSV.Click
        SummaryDetailedCSV()
    End Sub

    ' Private Sub cmdTSV_Click(sender As Object, e As System.Web.UI.ImageClickEventArgs) Handles cmdTSV.Click
    '    SummaryDetailedCSV(True)
    'End Sub


    Private Sub cboDataType_SelectedIndexChanged(sender As Object, e As System.EventArgs) Handles cboDataType.SelectedIndexChanged
        LoadcboData()
    End Sub


    Public Sub LoadcboData()
        Dim i As Integer

        cboData.Items.Clear()

        If cboDataType.SelectedValue = "Master" Then
            Dim li As New ListItem

            If Session("emp").organization.parent.displayproject Then
                li.Value = "M1"
                li.Text = GetCustomTag("P") & "s"
                cboData.Items.Insert(i, li)
                i += 1
                li = Nothing
            End If

            li = New ListItem
            li.Value = "M2"
            li.Text = GetMessage(381)    'accounts 
            cboData.Items.Insert(i, li)
            i += 1

            li = New ListItem
            li.Value = "M3"
            li.Text = GetMessage(80)  'categories
            cboData.Items.Insert(i, li)
            i += 1

            li = New ListItem
            li.Value = "M4"
            li.Text = GetMessage(79)  'employees
            cboData.Items.Insert(i, li)
            i += 1


        Else
            Dim li As New ListItem

            li.Value = "X1"
            li.Text = GetMessage(503)  'pending reports
            cboData.Items.Insert(0, li)

            li = New ListItem
            li.Value = "X2"
            li.Text = GetMessage(501)  'reports by approver
            cboData.Items.Insert(1, li)

            If Session("emp").organization.parent.approvallevel = 2 Then
                li = New ListItem
                li.Value = "X3"
                li.Text = GetMessage(502) 'reports by finalizer
                cboData.Items.Insert(2, li)
            End If

        End If

    End Sub


    Private Sub cboDefaultProject_DataBound(sender As Object, e As System.EventArgs) Handles cboDefaultProject.DataBound
        Dim li = New ListItem
        li.Value = "0"
        li.Text = ""
        cboDefaultProject.Items.Insert(0, li)
    End Sub

    Private Sub cboDefaultCC_DataBound(sender As Object, e As System.EventArgs) Handles cboDefaultCC.DataBound
        Dim li = New ListItem
        li.Value = "0"
        li.Text = ""
        cboDefaultCC.Items.Insert(0, li)
    End Sub


    Private Sub cmdCancelNewEmp_Click(sender As Object, e As System.EventArgs) Handles cmdCancelNewEmp.Click
        Response.Redirect("admin.aspx?tab=1")
    End Sub

    Private Sub cmdRefreshGrid_Click(sender As Object, e As System.Web.UI.ImageClickEventArgs) Handles cmdRefreshGrid.Click
        hdnSelectedTab.Value = 7
    End Sub
End Class