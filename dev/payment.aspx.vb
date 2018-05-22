Public Class order
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'Response.Redirect("~/paypal/ipn.aspx")
        'Session("jurID") = 1
        'Session("jur") = "Quebec"
        'If Request.QueryString("advalorem") = "" Then Response.Redirect("login.aspx")
    End Sub


    <System.Web.Services.WebMethod()>
    Public Shared Function Calculate(jurID As Integer, numOfEmp As Integer) As Array
        GetConnectionString()

        Dim GST As Single, HST As Single, QST As Single, subtotal As Single
        Dim c As New Category
        Dim a(4) As Single


        GST = c.GetGST(jurID, 29, Format(Now, "dd/MM/yyyy"))
        HST = c.GetHST(jurID, 29, Format(Now, "dd/MM/yyyy"))
        QST = c.GetQST(jurID, 29, Format(Now, "dd/MM/yyyy"))
        subtotal = FormatNumber(numOfEmp * 50, 2)

        a(0) = FormatNumber(subtotal * GST, 2)
        a(1) = FormatNumber(subtotal * HST, 2)
        a(2) = FormatNumber(subtotal * QST, 2)
        a(3) = subtotal
        a(4) = subtotal + FormatNumber(a(0), 2) + FormatNumber(a(1), 2) + FormatNumber(a(2), 2)

        Calculate = a
    End Function
End Class