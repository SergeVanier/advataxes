Public Class loggedin
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim ValidLogin As Boolean = True

        Session("language") = "English"

        GetConnectionString()

        If IsNothing(Session("emp")) And Not IsNothing(Membership.GetUser) Then Session("emp") = New Employee(Membership.GetUser.UserName)

        If Not Session("emp").Activated Then
            Session("emp") = Nothing
            Session.Abandon()
            Session("msgTitle") = "Activate Account"
            Session("message") = "Your account hasn't been activated yet.<br><br>To activate your account, please click the link that was sent to the email address you used to create your account."
            FormsAuthentication.SignOut()
            ValidLogin = False

        ElseIf Not Session("emp").active Then
            Session("emp") = Nothing
            Session("msgTitle") = "Account Deactivated"
            Session("message") = "<table border='0'><tr rowspan='2'><td><table><tr style='height:40px;'><td class='labelText' style='font-size:1.6em;'>Your account has been deactivated.</td></tr><tr><td class='labelText' valign='top' style='height:50px;'>Contact your administrator to get your account reactivated.</td></tr></table></td></tr></table>"
            FormsAuthentication.SignOut()
            ValidLogin = False

        ElseIf Session("emp").organization.parent.accountstatus = 1 Then
            If DateAdd(DateInterval.Day, 30, Session("emp").organization.createdDate) < Now Then
                Session("emp") = Nothing
                Session.Abandon()
                Session("msgTitle") = "Trial Expired"
                Session("message") = "<table border='0'><tr rowspan='2'><td><table><tr style='height:40px;'><td class='labelText' style='font-size:1.6em;'>Your 30 day trial has expired.</td></tr><tr><td class='labelText' valign='top' style='height:50px;'>   </td></tr></table></td></tr></table>"
                FormsAuthentication.SignOut()
                ValidLogin = False
            End If
        End If

        If ValidLogin Then
            Response.Redirect("account/welcome.aspx")
        Else
            Response.Redirect("message.aspx")
        End If

    End Sub

End Class