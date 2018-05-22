Public Class welcome
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim i As Integer
        Dim messages As Dictionary(Of Integer, String)

        Session("currentpage") = "welcome.aspx"

        Session("emp").GetLoginMessages()

        If Session("emp").loginmessages.count > 0 Then
            messages = Session("emp").loginmessages
            For i = 0 To messages.Count - 1
                lblMsg.Text += messages.ElementAt(i).Value & IIf(messages.Count > 1, "<BR>--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------", "") & "<BR><BR>"
            Next
        Else
            Response.Redirect("reports.aspx")
        End If

        cmdContinue.Text = GetMessage(541)

        CheckLanguage()

    End Sub

    Private Sub cmdContinue_Click(sender As Object, e As System.EventArgs) Handles cmdContinue.Click
        Session("emp").loginmessageIDs = ""
        Session("emp").Update()

        Response.Redirect("reports.aspx")
    End Sub

    Private Sub welcome_LoadComplete(sender As Object, e As System.EventArgs) Handles Me.LoadComplete
        Session("CompleteSettings") = ""
    End Sub

    Private Sub CheckLanguage()
        Try
            If IsNothing(Session("language")) Then
                Session("language") = Session("emp").defaultlanguage
            Else
                If Session("language") = "" Then Session("language") = Session("emp").defaultlanguage
            End If

            If Not IsNothing(Request.QueryString("lang")) Then
                If Request.QueryString("lang") = "f" Then
                    Session("language") = "French"
                Else
                    Session("language") = "English"
                End If
            End If

        Catch ex As Exception
            Session("language") = "French"
        End Try

    End Sub


End Class