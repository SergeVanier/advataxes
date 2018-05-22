Public Class SignupEN
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Session("language") = "English"
        Response.Redirect("signup.aspx")

    End Sub

End Class