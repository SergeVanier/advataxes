Public Class SubscribeFR
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Session("language") = "French"
        Response.Redirect("subscribe.aspx")
    End Sub

End Class