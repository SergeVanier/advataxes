Public Class Tags
    Inherits System.Web.UI.Page

    Private Shared Property emp As Object


    ''' <summary>
    ''' on an unexpected error, redirect to the login page
    ''' </summary>
    ''' <param name="sender"></param>
    ''' <param name="e"></param>
    ''' <remarks></remarks>
    Private Sub Tags_Error(sender As Object, e As System.EventArgs) Handles Me.Error
        If IsNothing(Session("error")) Then Session("error") = GetMessage(273, "English") : Session("msgHeight") = 50
        Response.Redirect("../login.aspx")
    End Sub

    ''' <summary>
    ''' on page load, translate controls and get custom tags
    ''' </summary>
    ''' <param name="sender"></param>
    ''' <param name="e"></param>
    ''' <remarks></remarks>
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Session("currentpage") = "Tags.aspx"
        CheckLanguage()

        Session("orgID") = Session("emp").organization.id
        hdnOrgID.Value = Session("orgID")
        hdnPUK.Value = Membership.GetUser.ProviderUserKey.ToString
        If Not IsNothing(Session("selectedTab")) Then hdnSelectedTab.Value = Session("selectedTab")
        Session("selectedTab") = Nothing

        cboHideInactive.Items(0).Text = GetMessage(175)
        cboHideInactive.Items(1).Text = GetMessage(422)
        hdnAdd.Value = GetMessage(278)
        hdnAccount.Value = GetMessage(268)
        hdnTP.Value = GetMessage(421)
        hdnCancel.Value = GetMessage(142)
        hdnActiveAccount.Value = GetMessage(393)
        hdnInactiveAccount.Value = GetMessage(394)
        hdnActivePWCMsg.Value = GetMessage(474)
        hdnInactivePWCMsg.Value = GetMessage(475)
        hdnUnexpectedError.Value = GetMessage(384)
        hdnIsAdvalorem.Value = Session("emp").isadvalorem
        rfvName.ErrorMessage = GetMessage(559)
        rfvNumber.ErrorMessage = GetMessage(560)

        gvDivision.EmptyDataText = GetMessage(481)

        If Not IsPostBack Then
            'hidden fields used to store values in table. at the time of saving, if these fields are empty, it means we are adding new values,
            'if at the time of save these fields had values, it means we are updaing existing values
            hdnCustomTagCostCenter_English.Value = GetCustomTag("C", "English")
            hdnCustomTagDivision_English.Value = GetCustomTag("D", "English")
            hdnCustomTagProject_English.Value = GetCustomTag("P", "English")
            hdnCustomTagWorkOrder_English.Value = GetCustomTag("W", "English")
            hdnCustomTagCostCenter_French.Value = GetCustomTag("C", "French")
            hdnCustomTagDivision_French.Value = GetCustomTag("D", "French")
            hdnCustomTagProject_French.Value = GetCustomTag("P", "French")
            hdnCustomTagWorkOrder_French.Value = GetCustomTag("W", "French")

            txtCustomTagCostCenter_English.Text = GetCustomTag("C", "English")
            txtCustomTagDivision_English.Text = GetCustomTag("D", "English")
            txtCustomTagProject_English.Text = GetCustomTag("P", "English")
            txtCustomTagWorkOrder_English.Text = GetCustomTag("W", "English")
            txtCustomTagCostCenter_French.Text = GetCustomTag("C", "French")
            txtCustomTagDivision_French.Text = GetCustomTag("D", "French")
            txtCustomTagProject_French.Text = GetCustomTag("P", "French")
            txtCustomTagWorkOrder_French.Text = GetCustomTag("W", "French")

            cboHideInactive.SelectedValue = 1
            Translate()
        End If

        'check for account type, third party or advance, and show or hide appropriate columns
        gvAccounts.Columns(4).Visible = cboAccType.SelectedValue = "TP" Or cboAccType.SelectedValue = "Advance"
        gvAccounts.Columns(1).Visible = cboAccType.SelectedValue = "TP" Or cboAccType.SelectedValue = "Advance"

    End Sub


    ''' <summary>
    ''' To save a new project, work order, cost center, division or account
    ''' </summary>
    ''' <param name="sender"></param>
    ''' <param name="e"></param>
    ''' <remarks></remarks>
    Private Sub cmdSavePWC_Click(sender As Object, e As System.EventArgs) Handles cmdSavePWC.Click

        If hdnPWCType.Value = "A" Then 'if type is account
            Dim account As New Account

            account.Number = txtPWCNumber.Text
            account.Name = txtPWCDescription.Text
            account.Type = cboAccType.SelectedValue
            If cboAccType.SelectedValue = "TP" Then account.VendorNumber = txtVendor.Text

            If cboAccType.SelectedValue = "Advance" Then
                account.VendorNumber = IIf(cboVendorType.SelectedValue = "Emp", cboVendor.SelectedValue, "General" & GetToken(6))
            End If

            account.OrgID = Session("emp").organization.id
            account.Create()
            account = Nothing
            gvAccounts.DataBind()

        Else  'type is project/workorder/costcenter/division
            Dim pwc As New PWC   'object for project/workorder/costcenter/division

            pwc.OrgID = CInt(Session("orgID"))
            pwc.PWCNumber = txtPWCNumber.Text
            pwc.PWCDescription = txtPWCDescription.Text
            pwc.PWCType = hdnPWCType.Value

            If hdnPWCID.Value = 0 Then
                pwc.Create()
            Else
                pwc.Update()
            End If

            If hdnPWCType.Value = "P" Then gvProjects.DataBind() 'if type is project
            If hdnPWCType.Value = "D" Then gvDivision.DataBind() 'if type is division
            If hdnPWCType.Value = "W" Then gvWO.DataBind() 'if type is work order
            If hdnPWCType.Value = "C" Then gvCC.DataBind() 'if type is cost center

            pwc = Nothing
        End If
    End Sub

    ''' <summary>
    ''' To activate or deactivate an account
    ''' </summary>
    ''' <param name="accID">Account ID</param>
    ''' <remarks></remarks>
    <System.Web.Services.WebMethod()>
    Public Shared Sub SetActiveAcc(accID As Integer)
        Dim account As New Account(accID)
        Dim loggedInUser = New Employee(Membership.GetUser().UserName)

        CreateAuditTrail(accID, loggedInUser.ID, "tblAccount", "Active", "", account.Active, Not account.Active, account.Name)
        account.Active = Not account.Active
        account.Update()

        loggedInUser = Nothing
        account = Nothing
    End Sub

    ''' <summary>
    ''' Check to see if the Tag being created already exists
    ''' </summary>
    ''' <param name="pwcNum">The new number being added</param>
    ''' <param name="pwcType">Type of number being added</param>
    ''' <param name="orgID">organization ID</param>
    ''' <returns>0 if the Tag doesn't exist and the Tag ID if it does exist</returns>
    ''' <remarks></remarks>
    <System.Web.Services.WebMethod()>
    Public Shared Function TagExists(pwcNum As String, pwcType As String, orgID As Integer) As Integer
        If pwcType = "A" Then  'if type is account
            Dim account As New Account(pwcNum, orgID)

            TagExists = account.ID
            account = Nothing

        Else 'type is project, workorder, costcenter, division
            Dim pwc As New PWC(pwcNum, pwcType, orgID)

            TagExists = (pwc.ID And (pwc.PWCType = pwcType))

            pwc = Nothing
        End If

    End Function


    ''' <summary>
    ''' Check if the vendor being entered already exists
    ''' </summary>
    ''' <param name="vendorNum">The vendor number being added</param>
    ''' <param name="orgID">organization ID</param>
    ''' <returns>0 if vendor number doesn't exist, vendor ID if it does exist</returns>
    ''' <remarks></remarks>
    <System.Web.Services.WebMethod()>
    Public Shared Function CheckVendorExists(vendorNum As String, orgID As Integer) As Integer
        Dim account As New Account

        CheckVendorExists = account.CheckVendorExists(vendorNum, orgID)
        account = Nothing
    End Function

    ''' <summary>
    ''' Activates/deactivates a project, work order, cost center or division
    ''' </summary>
    ''' <param name="pwcID">number being activated/deactivated</param>
    ''' <param name="puk">provider user key - unique key to identify a login</param>
    ''' <remarks></remarks>
    <System.Web.Services.WebMethod()>
    Public Shared Sub SetActivePWC(pwcID As Integer, puk As String)
        Dim pwc As New PWC(pwcID)
        Dim employee As Employee

        Try
            If Membership.GetUser.ProviderUserKey.ToString = puk Then
                employee = New Employee(Membership.GetUser.UserName)

                If employee.Organization.ID = pwc.OrgID Or employee.Organization.Parent.ID = pwc.OrgID Then
                    CreateAuditTrail(pwcID, employee.ID, "tblPWC", pwc.PWCDescription & " Active", "", pwc.Active, Not pwc.Active, pwc.PWCNumber)
                    pwc.Active = Not pwc.Active
                    pwc.Update()
                Else
                    Throw New Exception
                End If
            Else
                Throw New Exception
            End If

        Catch ex As Exception
            Throw ex

        Finally
            pwc = Nothing
            employee = Nothing
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

    Private Sub cmdSaveCustom_Click(sender As Object, e As System.EventArgs) Handles cmdSaveCustom.Click
        Dim bCreateCostCenter As Boolean = hdnCustomTagCostCenter_English.Value = "" And hdnCustomTagCostCenter_French.Value = "" 'true=create, false=update
        Dim bCreateProject As Boolean = hdnCustomTagProject_English.Value = "" And hdnCustomTagProject_French.Value = "" 'true=create, false=update
        Dim bCreateWorkOrder As Boolean = hdnCustomTagWorkOrder_English.Value = "" And hdnCustomTagWorkOrder_French.Value = "" 'true=create, false=update
        Dim bCreateDivision As Boolean = hdnCustomTagDivision_English.Value = "" And hdnCustomTagDivision_French.Value = "" 'true=create, false=update

        SaveCustomTag(bCreateCostCenter, "C", txtCustomTagCostCenter_English.Text, txtCustomTagCostCenter_French.Text) 'save cost center
        SaveCustomTag(bCreateProject, "P", txtCustomTagProject_English.Text, txtCustomTagProject_French.Text) 'save project
        SaveCustomTag(bCreateWorkOrder, "W", txtCustomTagWorkOrder_English.Text, txtCustomTagWorkOrder_French.Text) 'save work order
        SaveCustomTag(bCreateDivision, "D", txtCustomTagDivision_English.Text, txtCustomTagDivision_French.Text) 'save division
    End Sub


    Private Sub cboAccType_SelectedIndexChanged(sender As Object, e As System.EventArgs) Handles cboAccType.SelectedIndexChanged

        If cboAccType.SelectedValue <> "TP" Then cboHideInactive.SelectedValue = "1"
        gvAccounts.DataBind()

    End Sub

    Private Sub Tags_LoadComplete(sender As Object, e As System.EventArgs) Handles Me.LoadComplete
        cboAccType.Items(0).Text = GetMessage(550) 'Advance
        cboAccType.Items(1).Text = GetMessage(548) 'Employee Payable
        cboAccType.Items(2).Text = GetMessage(547) 'Employee Credit Card Payable
        cboAccType.Items(3).Text = GetMessage(549) 'Tax Payable
        cboAccType.Items(4).Text = GetMessage(72)  'Expenses
        
    End Sub

    
End Class