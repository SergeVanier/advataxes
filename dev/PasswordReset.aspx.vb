Public Class PasswordReset
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load





    End Sub

    Private Sub cmdSavePassword_Click(sender As Object, e As System.EventArgs) Handles cmdSavePassword.Click
        Dim token As String
        Dim empID As Integer
        Dim emp As New Employee
        Dim u As MembershipUser
        Dim oldpass As String
        Dim sUsername As String
        Dim puk As System.Guid

        Try
            If Not IsNothing(Request.QueryString("token")) Then
                token = Request.QueryString("token")
                empID = emp.GetUserIDByPwdToken(token)
                If empID = 0 Then Throw New Exception
                emp = New Employee(empID)
                u = Membership.GetUser(emp.Username)
            Else
                puk = New System.Guid(Request.QueryString("id").ToString)
                u = Membership.GetUser(puk)
                emp = New Employee(u.UserName)
            End If

            oldpass = u.ResetPassword("answer")
            u.ChangePassword(oldpass, txtNewPassword.Text)
            Session("msg") = "Your password was saved"
            emp.Activated = True
            emp.PwdToken =
                String.Empty
            emp.Update()

        Catch ex As Exception
            If empID = 0 Then
                Session("msg") = "Failed to change password: Invalid Token"
            Else
                Session("msg") = "Failed to change password<br><br>"
            End If

        Finally
            Response.Redirect("login.aspx")
            emp = Nothing
        End Try


    End Sub

    Protected Sub cbDisplayPassword_CheckedChanged(sender As Object, e As EventArgs) Handles cbDisplayPassword.CheckedChanged

        If cbDisplayPassword.Checked Then
            txtNewPassword.TextMode = TextBoxMode.SingleLine
            txtConfirm.TextMode = TextBoxMode.SingleLine
        Else
            Dim newPass = txtNewPassword.Text
            Dim newPassConf = txtConfirm.Text

            txtNewPassword.TextMode = TextBoxMode.Password
            txtConfirm.TextMode = TextBoxMode.Password

            txtNewPassword.Text = newPass
            txtConfirm.Text = newPassConf

        End If
    End Sub
End Class