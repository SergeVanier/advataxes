Public Class SignupFR
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Session("language") = "French"
        Response.Redirect("signup.aspx")
    End Sub

End Class