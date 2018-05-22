Public Partial Class Site
    Inherits System.Web.UI.MasterPage

    Private Sub Page_Error(sender As Object, e As System.EventArgs) Handles Me.Error
        If IsNothing(Session("error")) Then Session("error") = GetMessage(273) : Session("msgHeight") = 50
        Response.Redirect("../login.aspx")
    End Sub



    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim o As Org

        'If Session("emp").username.ToString.Contains("sholdaway") Then
        '    Response.Write("session " & Session.SessionID & "<BR>")
        '    Response.Write("ASP.NET " & Request.Cookies("ASP.NET_SessionId").Value)
        'End If

        Try
            CheckLanguage()
            If IsNothing(Session("language")) Then Session("language") = "English"

            If Not Session("emp") Is Nothing Then
                lblLastLoggedIn.Text = GetMessage(226) & ": " & Session("lastLoginDate")

                o = Session("emp").organization.parent
                lblCompany.Text = Session("emp").Organization.Name

                Dim p As New Period(o.ID, 1, "Start")
                Session("CompleteSettings") = ""

                If p.ID = 0 Then Session("CompleteSettings") = "<a href='admin.aspx?tab=7' style='color:#cd1e1e;'>Click here</a> to complete your global settings."
                If o.GetCRA("GST", "01/01/2012") = 2 Then Session("CompleteSettings") += "<a href='admin.aspx?tab=6'  style='color:#cd1e1e;'>Click here</a> to complete your organization details."

                p = Nothing
                lbl162.Text = GetMessage(162)
                lbl283.Text = GetMessage(283)
                hdnLoginText.Value = GetMessage(95)
                hdnLogoutText.Value = GetMessage(84)
                lblBilling.Text = GetMessage(542)
                lblMyProfile.Text = GetMessage(54)
                lblContactUs.Text = GetMessage(86)
            End If

        Catch ex As Exception
            ' Response.Redirect("login.aspx")
        Finally
            o = Nothing
        End Try
        Response.Cache.SetExpires(DateTime.UtcNow.AddMinutes(-1))
        Response.Cache.SetCacheability(HttpCacheability.NoCache)
        Response.Cache.SetNoStore()
    End Sub

    Private Sub CheckLanguage()
        Try
            If Not IsNothing(Request.QueryString("lang")) Then
                If Request.QueryString("lang") = "f" Then
                    Session("language") = "French"
                Else
                    Session("language") = "English"
                End If
            Else
                If Not IsNothing(Session("emp")) Then Session("language") = Session("emp").defaultlanguage
            End If

        Catch ex As Exception
            Session("language") = "French"
        End Try

    End Sub

    Private Sub MainMenu_MenuItemDataBound(sender As Object, e As System.Web.UI.WebControls.MenuEventArgs) Handles MainMenu.MenuItemDataBound
        Dim mnuItem As SiteMapNode = e.Item.DataItem
        Dim d As New Description

        If Not IsNothing(Session("emp")) Then
            If e.Item.Text = "Admin" Then
                If Not Session("emp").IsAdmin Then e.Item.Parent.ChildItems.Remove(e.Item)

            ElseIf e.Item.Text = "Reports" Then
                If Not Session("emp").IsAccountant Then e.Item.Parent.ChildItems.Remove(e.Item)
            End If

            If Not Session("emp").IsSupervisor And e.Item.Text = "Submitted Expenses" Then e.Item.Parent.ChildItems.Remove(e.Item)
            If Not Session("emp").TagEntry And e.Item.Text = "Tags" Then e.Item.Parent.ChildItems.Remove(e.Item)

            e.Item.Text = d.GetDescription(CInt(mnuItem.ResourceKey), Left(Session("language"), 1))

        End If
    End Sub



End Class