Imports System.Threading
Imports System.Globalization

Public Class AdvataxesPageBase
    Inherits System.Web.UI.Page

    Protected Overrides Sub InitializeCulture()
        If Not IsNothing(Session("emp")) AndAlso Session("emp").defaultLanguage = "French" Then
            Thread.CurrentThread.CurrentUICulture = New CultureInfo("fr")
        ElseIf Not IsNothing(Request.QueryString("lang")) AndAlso Request.QueryString("lang") = "f" Then
            Thread.CurrentThread.CurrentUICulture = New CultureInfo("fr")
        Else
            Thread.CurrentThread.CurrentUICulture = New CultureInfo("en")
        End If

        MyBase.InitializeCulture()
    End Sub

End Class
