Imports System.Data
Imports System.Data.SqlClient
Imports System.Configuration
Imports System.IO
Imports System.Net




Partial Public Class AddReport
    Inherits System.Web.UI.Page

    Dim blnSubmit As Boolean
    Dim ExpenseID As Integer
    Dim linenum As Integer


    Private Sub AddReport_Error(sender As Object, e As System.EventArgs) Handles Me.Error
        'On Error Resume Next
        'If IsNothing(Session("error")) Then Session("error") = GetMessage(273 ) & " - " & linenum : Session("msgHeight") = 50
        'Response.Redirect("~/login.aspx")
    End Sub



    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If IsNothing(Session("emp")) Then Response.Redirect("../mobile/mlogin.aspx")

        Try
            GetConnectionString()
            CheckLanguage()

            Translate()

            If Not IsNothing(Request.QueryString("id")) And Not IsPostBack Then
                Dim r As New Report(CInt(Request.QueryString("id")))

                txtReportName.Text = r.Name
                r = Nothing
            End If


        Catch ex As Exception
            'Session("Error") = IIf(Session("emp").isadvalorem, ex.Message, GetMessage(273 ))

        Finally
            If Not IsNothing(Session("error")) Then Response.Redirect("~/error.aspx")

        End Try
        Response.Cache.SetCacheability(HttpCacheability.NoCache)
        Response.Cache.SetExpires(DateTime.UtcNow.AddHours(-1))
        Response.Cache.SetNoStore()
        Response.Cache.SetNoServerCaching()

    End Sub

    Private Sub cmdSaveReport_Click(sender As Object, e As System.EventArgs) Handles cmdSaveReport.Click
        CreateReport()
    End Sub


    Public Sub CreateReport()
        Dim rpt As Report

        'Force a report name, else it will just spin eternally (artf146915)
        If String.IsNullOrEmpty(txtReportName.Text) Then
            txtReportName.Text = "M" + DateTime.Now.ToString("MyyyyMMdd HHmm")
        End If

        Try
            If Request.QueryString("id") <> 0 Then
                rpt = New Report(CInt(Request.QueryString("id")))
                rpt.Name = txtReportName.Text
                rpt.Update()

            Else
                rpt = New Report
                rpt.Create(txtReportName.Text, Session("emp").OrgID, Session("emp").ID, 1)
            End If

        Catch ex As Exception
            If Session("emp").isadvalorem Then
                Session("Error") = ex.Message
            Else
                Session("Error") = GetMessage(273)
            End If

            Response.Redirect("../error.aspx")

        Finally
            rpt = Nothing
            txtReportName.Text = ""
            Response.Redirect("mreports.aspx")
        End Try

    End Sub



    Public Sub Translate()
        On Error Resume Next
        Dim d As New Description
        Dim c As Object
        Dim col As Object
        Dim childc As Object, childcc As Object, childccc As Object, childcccc As Object
        Dim id As String


        For Each c In Page.Controls
            For Each childc In c.controls
                If TypeOf childc Is Label Then
                    If childc.id Like "lbl*" Then
                        id = Replace(childc.id, "_", "")
                        childc.text = d.GetDescription(CInt(Replace(id, "lbl", "")), Left(Session("language"), 1))
                    End If

                ElseIf TypeOf childc Is Button Then
                    id = Replace(childc.text, "_", "")
                    childc.text = d.GetDescription(CInt(Replace(id, "lbl", "")), Left(Session("language"), 1))

                ElseIf TypeOf childc Is GridView Then
                    For Each col In childc.columns
                        col.headertext = d.GetDescription(CInt(col.headertext), Left(Session("language"), 1))
                    Next
                End If
            Next

        Next
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



    Private Sub cmdCancel_Click(sender As Object, e As System.EventArgs) Handles cmdCancel.Click
        Response.Redirect("mreports.aspx")
    End Sub
End Class