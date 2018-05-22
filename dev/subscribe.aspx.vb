Public Class subscribe
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim o As Org

        Try
            If Not IsPostBack Then
                GetConnectionString()
                Translate()

                If Not IsNothing(Session("upgrade")) Then
                    o = Session("emp").organization.parent

                    txtOrg.Text = o.Name
                    txtAddress.Text = o.Address1
                    txtAddress2.Text = o.Address2
                    txtCity.Text = o.City
                    txtEmail.Text = Session("emp").email
                    txtFName.Text = Session("emp").firstname
                    txtLName.Text = Session("emp").lastname
                    txtPhone.Text = Session("emp").phone
                    txtPostal.Text = o.Postal
                    txtTitle.Text = Session("emp").title
                    cboType.SelectedValue = o.Type.ID
                    cboType.Enabled = False

                End If
            End If

        Catch ex As Exception
            Session("error") = ex.Message

        Finally
            o = Nothing

            If Not IsNothing(Session("error")) Then
                If Session("error") <> "" Then
                    Response.Redirect("error.aspx")
                End If
            End If
        End Try
        

    End Sub

    Private Sub cmdRegister_Click(sender As Object, e As System.EventArgs) Handles cmdRegister.Click
        Session("jurID") = cboProvince.SelectedValue
        Session("jur") = cboProvince.SelectedItem.Text
        Session("jurIndex") = cboProvince.SelectedIndex
        Session("org") = txtOrg.Text
        Session("orgType") = cboType.SelectedValue
        Session("firstName") = txtFName.Text
        Session("lastName") = txtLName.Text
        Session("title") = txtTitle.Text
        Session("address1") = txtAddress.Text
        Session("address2") = txtAddress2.Text
        Session("postal") = txtPostal.Text
        Session("city") = txtCity.Text
        Session("phone") = txtPhone.Text
        Session("username") = txtUserName.Text

        Dim status As MembershipCreateStatus
        Dim emp As New Employee
        Dim d As New Description(25)
        Dim s As String
        Dim o = New Org
        Dim u As MembershipUser

        Try
            If IsNothing(Session("upgrade")) Then
                Membership.CreateUser( _
                    txtUserName.Text, _
                    txtPassword.Text, _
                    txtEmail.Text, _
                    "question", _
                    "answer", _
                    True, _
                    status)

                If status.ToString = "Success" Then
                    o.GSTRate = 1
                    o.QSTRate = 1

                    o.AccountStatus = 1
                    o.Name = txtOrg.Text
                    o.JurID = cboProvince.SelectedValue
                    o.Address1 = txtAddress.Text
                    o.Address2 = txtAddress2.Text
                    o.Postal = txtPostal.Text
                    o.City = txtCity.Text
                    o.Active = 1
                    o.OrgTypeID = cboType.SelectedValue
                    o.CountryID = cboCountry.SelectedValue

                    o.Create()
                    o = Nothing
                    o = New Org(txtOrg.Text)

                    emp.Username = txtUserName.Text
                    emp.OrgID = o.ID
                    emp.FirstName = txtFName.Text
                    emp.LastName = txtLName.Text
                    emp.Title = txtTitle.Text
                    emp.IsAdmin = True
                    emp.IsSupervisor = True
                    emp.IsAccountant = False
                    emp.Email = txtEmail.Text
                    emp.Phone = txtPhone.Text

                    emp.Create()

                    Roles.AddUserToRole(emp.Username, "Admin")

                    u = Membership.GetUser(emp.Username)

                    s = d.EnglishDescription
                    s = (Replace(s, "(name)", emp.FirstName & " " & emp.LastName))
                    s = (Replace(s, "(OrgName)", o.Name))
                    s = (Replace(s, "(username)", emp.Username))
                    s = Replace(s, "you must activate your account", "you must <a href='https://www.advataxes.ca/login.aspx?action=activate&id=" + u.ProviderUserKey.ToString + "&username=" + u.UserName + "'>activate your account</a>")

                    d = Nothing

                    SendEmail(u.Email, "Advataxes: Account created ", s, Session("language"))

                    Session("msg") = "<p style='font-size:1.3em;'>Your account was created.</p><br><p>An email was sent to " & u.Email & ".</p><br><p>Click the link in the email to activate your account.</p>"
                    Session("msgTitle") = "Account Created"

                Else
                    'SendEmail("sholdaway@advalorem.ca", "error", status.ToString, "English")
                End If

            Else

                o = Session("emp").organization.parent
                'If IsNothing(Session("emp").organization.parentorg) Then
                '    o = New Org(CInt(Session("emp").organization.id))
                'Else
                '    o = New Org(CInt(Session("emp").organization.parentorg.id))
                'End If

                o.Name = txtOrg.Text
                o.JurID = cboProvince.SelectedValue
                o.CountryID = cboCountry.SelectedValue
                o.CountryName = cboCountry.SelectedItem.Text
                o.Address1 = txtAddress.Text
                o.Address2 = txtAddress2.Text
                o.Postal = txtPostal.Text
                o.City = txtCity.Text
                o.OrgTypeID = cboType.SelectedValue
                o.Update()

            End If


        Catch ex As Exception
            'SendEmail("sholdaway@advalorem.ca", "error", ex.Message & status.ToString, "English")
            Session("error") = GetMessage(273)

        Finally
            u = Nothing
            o = Nothing
            emp = Nothing
            d = Nothing

            If Not IsNothing(Session("error")) Then
                If Session("error") <> "" Then
                    Response.Redirect("error.aspx")
                Else
                    Response.Redirect("payment.aspx")
                End If

            Else
                Response.Redirect("payment.aspx")
            End If
        End Try


    End Sub

    <System.Web.Services.WebMethod()>
    Public Shared Function CheckUsername(username As String) As Integer
        Dim emp As New Employee(username)

        CheckUsername = emp.ID

        emp = Nothing
    End Function

    Public Sub Translate()
        On Error Resume Next

        Dim d As New Description
        Dim c As Object
        Dim col As Object
        Dim childc As Object, childcc As Object, childccc As Object, childcccc As Object
        Dim id As String

        'If IsNothing(Session("language")) Then Session("language") = Session("emp").defaultlanguage

        If Not IsNothing(Request.QueryString("lang")) Then
            If Request.QueryString("lang") = "f" Then
                Session("language") = "French"
            Else
                Session("language") = "English"
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
                                    col.headertext = d.GetDescription(CInt(col.headertext), Left(Session("language"), 1))
                                Next
                            End If
                        Next
                    End If
                Next
            Next
        Next
    End Sub

    Private Sub cboType_DataBound(sender As Object, e As System.EventArgs) Handles cboType.DataBound
        cboType.Items.Insert(0, "")
    End Sub

    Private Sub cboProvince_DataBound(sender As Object, e As System.EventArgs) Handles cboProvince.DataBound
        cboProvince.Items.Insert(0, "")
    End Sub

    Private Sub cboCountry_DataBound(sender As Object, e As System.EventArgs) Handles cboCountry.DataBound
        'cboCountry.Items.Insert(0, "")
    End Sub

    Private Sub chkTermsOfUse_CheckedChanged(sender As Object, e As System.EventArgs) Handles chkTermsOfUse.CheckedChanged
        If chkTermsOfUse.Checked Then
            hdnTermsAccepted.Text = "True"
        Else
            hdnTermsAccepted.Text = ""
        End If


    End Sub
End Class