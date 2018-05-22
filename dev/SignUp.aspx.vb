Public Class SignUp
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        GetConnectionString()
        cmdRegister.Text = GetMessage(313)
        Translate()

    End Sub

    Private Sub cmdRegister_Click(sender As Object, e As System.EventArgs) Handles cmdRegister.Click
        Dim status As MembershipCreateStatus
        Dim organization As New Org
        Dim employee As New Employee
        Dim description As New Description(25)
        Dim userMembership As MembershipUser
        Dim stringBuilder As New StringBuilder

        Try
            Membership.CreateUser(
                txtUserName.Text,
                txtPassword.Text,
                txtEmail.Text,
                "question",
                "answer",
                True,
                status)

            If status.ToString = "Success" Then
                organization.GSTRate = 1
                organization.QSTRate = 1
                organization.AccountStatus = 2
                organization.Name = txtOrg.Text
                organization.Active = 1
                organization.OrgTypeID = cboType.SelectedValue
                organization.Create()
                organization = Nothing
                organization = New Org(txtOrg.Text)

                employee.Username = txtUserName.Text
                employee.OrgID = organization.ID

                employee.FirstName = txtFName.Text
                employee.LastName = txtLName.Text
                employee.Title = txtTitle.Text
                employee.Username = txtUserName.Text
                employee.IsAdmin = True
                employee.IsSupervisor = True
                employee.IsAccountant = False
                employee.IsAdvalorem = True
                employee.Email = txtEmail.Text
                employee.Phone = ""

                employee.Create()

                Roles.AddUserToRole(employee.Username, "Admin")

                userMembership = Membership.GetUser(txtUserName.Text)
                Diagnostics.Debug.Write(txtUserName.Text)
                stringBuilder.Append(description.EnglishDescription)
                stringBuilder.Replace("(name)", employee.FirstName & " " & employee.LastName)
                stringBuilder.Replace("(OrgName)", organization.Name)
                stringBuilder.Replace("(username)", employee.Username)
                stringBuilder.Replace("you must activate your account", "you must <a href='https://www.advataxes.ca/login.aspx?action=activate&id=" + userMembership.ProviderUserKey.ToString + "&username=" + userMembership.UserName + "'>activate your account</a>")

                SendEmail(userMembership.Email, "Advataxes: Account created ", stringBuilder.ToString, Session("language"))
                Session("NewUserEmail") = userMembership.Email

                Response.Redirect("message.aspx?id=364")
            Else
                lblInvalidUserName.Visible = True
                If status.ToString = "DuplicateUserName" Then lblInvalidUserName.Text = "Username already exists"
            End If

        Catch ex As MembershipCreateUserException
            MsgBox(GetErrorMessage(ex.StatusCode))

        Catch ex As HttpException
            MsgBox(ex.Message)

        Finally
            userMembership = Nothing
            organization = Nothing
            employee = Nothing
            description = Nothing
        End Try
    End Sub

    Private Sub cmdCancel_Click(sender As Object, e As System.EventArgs) Handles cmdCancel.Click
        Response.Redirect("~/index.html")
    End Sub

    <System.Web.Services.WebMethod()>
    Public Shared Function CheckUsername(username As String) As Integer
        Dim employee As New Employee(username)

        CheckUsername = employee.ID

        employee = Nothing
    End Function

    Public Sub Translate()
        On Error Resume Next
        Dim d As New Description
        Dim c As Object
        Dim col As Object
        Dim childc As Object, childcc As Object, childccc As Object, childcccc As Object
        Dim id As String

        'If IsNothing(Session("language")) Then Session("language") = Session("emp").defaultlanguage

        'If Not IsNothing(Request.QueryString("lang")) Then
        '    If Request.QueryString("lang") = "f" Then
        '        session("language") = "French"
        '    Else
        Session("language") = "English"
        '    End If
        'End If

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
End Class