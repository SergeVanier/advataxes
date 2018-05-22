Imports System.Threading
Imports System.Globalization

Public Class TaxCalculator
    Inherits System.Web.UI.Page

    Private _language As String

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        sqlJur.SelectParameters.Add("language", If(_language = "en", "English", "Francais"))
    End Sub

    Private Sub cboJur_DataBound(sender As Object, e As System.EventArgs) Handles cboJur.DataBound

    End Sub

    Protected Overrides Sub InitializeCulture()
        If Not IsNothing(Page.RouteData.Values("language")) And Page.RouteData.Values("language") = "fr" Then
            _language = "fr"
            Thread.CurrentThread.CurrentUICulture = New CultureInfo("fr")
        Else
            _language = "en"
            Thread.CurrentThread.CurrentUICulture = New CultureInfo("en")
        End If

    End Sub


    <System.Web.Services.WebMethod()>
    Public Shared Function GetTaxRates(jurID As Integer, catID As Integer, expDate As String, taxIncExc As Integer, size As Integer) As Array
        Dim c As New Category(catID)
        Dim aC(4) As String
        Dim o As New Org

        aC(0) = c.GetGST(jurID, catID, expDate, taxIncExc)
        aC(1) = c.GetQST(jurID, catID, expDate, taxIncExc)
        If aC(0) = "0" Then aC(0) = c.GetHST(jurID, catID, expDate, taxIncExc)

        o.Type = New OrgType(3)
        aC(2) = c.GetITC(jurID, size, Now.ToShortDateString) * o.GetCRAactualRatio("GST", Now.ToShortDateString, 1)
        aC(3) = c.GetITR(jurID, size, Now.ToShortDateString) * o.GetCRAactualRatio("QST", Now.ToShortDateString, 1)
        aC(4) = c.GetRITC(jurID, size, Now.ToShortDateString) * o.GetCRAactualRatio("GST", Now.ToShortDateString, 1)

        c = Nothing
        o = Nothing
        Return aC

    End Function

End Class