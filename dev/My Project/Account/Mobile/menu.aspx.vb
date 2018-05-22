Public Class menu
    Inherits System.Web.UI.Page

    Private Sub menu_Error(sender As Object, e As System.EventArgs) Handles Me.Error
        If IsNothing(Session("error")) Then Session("error") = GetMessage(273) : Session("msgHeight") = 50
        Response.Redirect("../../mobile/mlogin.aspx")
    End Sub

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

        If Not ValidLogin Then Response.Redirect("../../mobile/mlogin.aspx")

        If (isPageExpired()) Then
            Response.Redirect("expired.htm")
        End If


        Response.Cache.SetCacheability(HttpCacheability.NoCache)
        Response.Cache.SetExpires(DateTime.UtcNow.AddHours(-1))
        Response.Cache.SetNoStore()
        Response.Cache.SetNoServerCaching()

        If Session("emp") Is Nothing Then
            Response.Redirect("../../mobile/mlogin.aspx")
        End If
    End Sub

    Private Sub cmdMyExpenses_Click(sender As Object, e As System.EventArgs) Handles cmdMyExpenses.Click
        Response.Redirect("mReports.aspx")
    End Sub

    Private Sub cmdUploadReceipt_Click(sender As Object, e As System.EventArgs) Handles cmdUploadReceipt.Click
        Response.Redirect("UploadReceipt.aspx")
    End Sub

    Private Sub cmdLogout_Click(sender As Object, e As System.Web.UI.ImageClickEventArgs) Handles cmdLogout.Click
        Session("emp") = Nothing
        Session.Clear()
        Session.Abandon()
        Response.Cache.SetExpires(DateTime.UtcNow.AddMinutes(-1))
        Response.Cache.SetCacheability(HttpCacheability.NoCache)
        Response.Cache.SetNoStore()
        FormsAuthentication.SignOut()
        Session("msg") = "You've been logged out"
        Response.Redirect("../../mobile/mlogin.aspx")
    End Sub

    Function isPageExpired() As Boolean
        If (Session("TimeStamp") = Nothing And
            ViewState("TimeStamp") = Nothing) Then
            Return False

        ElseIf (Session("TimeStamp") = ViewState("TimeStamp")) Then
            Return False
        Else
            Return True
        End If

    End Function

End Class