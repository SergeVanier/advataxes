Public Class UploadReceipt
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsNothing(Request.QueryString("id")) Then
            cmdUpload.Text = "Attach"
            lblUploadTitle.Text = "Attach Receipt"
        Else
            cmdUpload.Text = "Upload"
            lblUploadTitle.Text = "Upload Receipt"
        End If
        LinkButton1.Attributes.Add("onclick", "document.getElementById('" + FileUpload1.ClientID + "').click(); return false;")
    End Sub

    Private Sub cmdUpload_Click(sender As Object, e As System.EventArgs) Handles cmdUpload.Click
        Session("msg") = "Receipt was uploaded"

        Try
            If Not IsNothing(Request.QueryString("id")) Then
                Session("msg") = "Receipt was attached"
                UploadFile(FileUpload1, CInt(Request.QueryString("id")))                
            Else
                UploadFile(CInt(Session("emp").id), FileUpload1)
            End If

        Catch
            Session("msg") = "There was an error while uploading your receipt"
            Response.Redirect("UploadReceipt.aspx?upload=error")

        Finally
            If Not IsNothing(Request.QueryString("id")) Then
                Response.Redirect("mreports.aspx")
            Else
                Response.Redirect("UploadReceipt.aspx?upload=succeeded")
            End If
        End Try
    End Sub

    Private Sub cmdCancel_Click(sender As Object, e As System.EventArgs) Handles cmdCancel.Click
        Response.Redirect("menu.aspx")
    End Sub
End Class