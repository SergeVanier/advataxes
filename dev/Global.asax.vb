Imports System.Web.SessionState
Imports System.Web.Routing
Imports System.Linq
Imports System.IO

Public Class Global_asax
    Inherits System.Web.HttpApplication

    Sub Application_Start(ByVal sender As Object, ByVal e As EventArgs)
        ' Fires when the application is started
        RegisterRoutes(RouteTable.Routes)
    End Sub

    Sub Session_Start(ByVal sender As Object, ByVal e As EventArgs)
        ' Fires when the session is started
    End Sub

    Sub Application_BeginRequest(ByVal sender As Object, ByVal e As EventArgs)
        ' Fires at the beginning of each request
    End Sub

    Sub Application_AuthenticateRequest(ByVal sender As Object, ByVal e As EventArgs)
        ' Fires upon attempting to authenticate the use
        
    End Sub

    Sub Application_Error(ByVal sender As Object, ByVal e As EventArgs)
        ' Fires when an error occurs
#If DEBUG Then
        File.WriteAllLines(Path.Combine(Server.MapPath("~/Logs"), DateTime.Now.ToString("yyyy-MM-dd")), "Unhandled error occured in Advataxes: " + Server.GetLastError().ToString())
#Else
        Response.Redirect("~/Error.aspx")
#End If


    End Sub

    Sub Session_End(ByVal sender As Object, ByVal e As EventArgs)
        ' Fires when the session ends
    End Sub

    Sub Application_End(ByVal sender As Object, ByVal e As EventArgs)
        ' Fires when the application ends
    End Sub

    Sub RegisterRoutes(ByVal routes As RouteCollection)
        routes.MapPageRoute("TaxCalculatorFR", "fr/CalculateurDeTaxes", "~/TaxCalculator.aspx", True, New RouteValueDictionary(New With {.language = "fr"}))
        routes.MapPageRoute("TaxCalculatorEN", "en/TaxCalculator", "~/TaxCalculator.aspx", True, New RouteValueDictionary(New With {.language = "en"}))
    End Sub
End Class