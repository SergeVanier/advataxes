Public Class message
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If IsNothing(Session("language")) Then Session("language") = "French"

        If Not IsNothing(Request.QueryString("id")) Then
            lblMsg.Text = GetMessage(CInt(Request.QueryString("id")), Session("language"))
            lblMsg.Text = Replace(lblMsg.Text, "(email)", Session("NewUserEmail"))
            lblMsgTitle.Text = GetMessageTitle(CInt(Request.QueryString("id")), Session("language"))
        
        End If

    End Sub

End Class