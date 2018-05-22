Public Class Guidelines
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        hdnAdmin.Value = Session("emp").isadmin
        hdnApprover.Value = Session("emp").issupervisor

    End Sub

End Class