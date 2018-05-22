Public Class info
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim id As Integer = CInt(Request.QueryString("id"))
        Dim d As New Description(id)
        Dim a(2) As String

        'Session("language") = "English"

        If Session("language") = "English" Then
            a(0) = d.EnglishTitle
            a(1) = d.EnglishDescription
        Else
            a(0) = d.FrenchTitle
            a(1) = d.FrenchDescription
        End If

        Response.Write("<table border='0' width='100%'><tr><td align='left' style='color:#cd1e1e;font-size:1.8em;'>" + a(0) + "</td><td align='right'><img src='../images/av.png' width='55px' height='45px' /></td></tr><tr><td></td></tr><tr height='3px'><td colspan='2' style='background-image:url(../images/redline.png); background-repeat:repeat-x;'></td></tr><tr><td colspan='2' ><br/>" + a(1) + "</td></tr></table>")

        d = Nothing
    End Sub



End Class