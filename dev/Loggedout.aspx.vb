Public Class loggedout
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim u As System.Web.Security.MembershipUser
        Dim sUsers As String = ""
        Dim lang As String

        FormsAuthentication.SignOut()

        For Each u In Membership.GetAllUsers
            If u.IsOnline Then sUsers += u.UserName & "<BR>"
        Next

        lang = Session("language")
        SendEmail("sholdaway@advalorem.ca", Session("emp").username & " has just logged out, Online: " & Membership.GetNumberOfUsersOnline, sUsers, "English")
        Session("emp") = Nothing
        Session.Clear()
        Session.Abandon()
        Session.RemoveAll()
        Response.Cache.SetExpires(DateTime.UtcNow.AddMinutes(-1))
        Response.Cache.SetCacheability(HttpCacheability.NoCache)
        Response.Cache.SetNoStore()
        Response.Cache.SetNoServerCaching()
        Response.Cookies("ASP.NET_SessionId").Value = String.Empty
        Response.Cookies("ASP.NET_SessionId").Expires = DateTime.Now.AddMonths(-20)
        Response.Cookies.Add(New HttpCookie("ASP.NET_SessionId", ""))
        Session("CompleteSettings") = ""
        u = Nothing

        If Not IsNothing(Request.QueryString("m")) Then
            Response.Redirect("mobile/mlogin.aspx?action=loggedout")
        Else
            If lang = "English" Then
                Response.Redirect("login.aspx?action=loggedout")
            Else
                Response.Redirect("login.aspx?action=deconnecter")
            End If

        End If
    End Sub

End Class