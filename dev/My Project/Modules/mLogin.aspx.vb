Imports System.Web.Security
Imports System.Text.RegularExpressions

Partial Public Class mLogin
    Inherits System.Web.UI.Page

    Private Sub mLogin_Error(sender As Object, e As System.EventArgs) Handles Me.Error
        If IsNothing(Session("error")) Then Session("error") = GetMessage(273) : Session("msgHeight") = 50
        Response.Redirect("mlogin.aspx")
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        GetConnectionString()

        If IsNothing(Session("language")) Then Session("language") = "English"
        If Not IsNothing(Request.QueryString("err")) Then Session("error") = GetMessage(CInt(Request.QueryString("err"))) : Session("msgHeight") = Right(Request.QueryString("err"), 2) : Response.Redirect("mlogin.aspx")
        If Not IsNothing(Request.QueryString("msg")) Then Session("msg") = GetMessage(CInt(Request.QueryString("msg"))) : Session("msgHeight") = Right(Request.QueryString("err"), 2) : Response.Redirect("mlogin.aspx")
        If Not IsNothing(Request.QueryString("timedout")) Then Session("msg") = "Your session has timed out. Please login again"
        
        If Request.QueryString("action") = "activate" Then
            Dim u As MembershipUser
            Dim userid = Request.QueryString("id")
            Dim username = Request.QueryString("username")

            u = Membership.GetUser(username)

            If userid = u.ProviderUserKey.ToString Then
                Dim emp As New Employee(username)

                emp.Activated = True
                emp.Update()
                emp = Nothing
                Response.Redirect("mlogin.aspx?msg=347")

            End If
        End If

        On Error Resume Next

        Dim userLogin As System.Web.UI.WebControls.Login = Me.Login2
        Dim userNameTextBox As TextBox = CType(userLogin.FindControl("UserName"), TextBox)

        If userNameTextBox IsNot Nothing Then
            SetFocus(userNameTextBox)
        End If

    End Sub


    Private Sub Login2_LoggedIn(sender As Object, e As System.EventArgs) Handles Login2.LoggedIn
        Dim err As Integer
        Dim sUsers As String = ""
        Dim u As System.Web.Security.MembershipUser

        Session("username") = Login2.UserName.ToString
        Session("emp") = New Employee(Login2.UserName.ToString)

        Try
            For Each u In Membership.GetAllUsers
                If u.IsOnline Then sUsers += u.UserName & "<BR>"
            Next

            SendEmail("sholdaway@advalorem.ca", Session("emp").username & " just logged in (mobile), Online: " & Membership.GetNumberOfUsersOnline, sUsers, "English")

            If Not Session("emp").Activated Then
                Session("emp") = Nothing
                Session.Abandon()
                FormsAuthentication.SignOut()
                err = 349

            ElseIf Not Session("emp").active Then
                Session("emp") = Nothing
                Session.Abandon()
                FormsAuthentication.SignOut()
                'Session("error") = "Your account has been suspended.Contact your administrator to have your account reactivated."
                err = 470

            ElseIf Session("emp").organization.parent.accountstatus = 1 Then
                If DateAdd(DateInterval.Day, 30, Session("emp").organization.createdDate) < Now Then
                    Session("emp") = Nothing
                    Session.Abandon()
                    FormsAuthentication.SignOut()
                    err = 346 'trial expired

                End If

            Else
                
                Dim rpt As New Report
                rpt.GetOpenReport(Session("emp").id)
                Session("OpenReport") = rpt.Status = 1
                rpt = Nothing
            End If

        Catch ex As Exception

        Finally
            u = Nothing
            If err > 0 Then Response.Redirect("mlogin.aspx?err=" & err)

        End Try

    End Sub

    Private Sub Login_LoadComplete(sender As Object, e As System.EventArgs) Handles Me.LoadComplete
        Response.Cookies.Add(New HttpCookie("ASP.NET_SessionId", ""))
    End Sub


    Private Sub Login2_LoginError(sender As Object, e As System.EventArgs) Handles Login2.LoginError

        Session("error") = GetMessage(348, Session("language"))
        Session("msgHeight") = 70

        Login2.FailureText = GetMessage(427, Session("language"))

        Try
            If Membership.GetUser(Login2.UserName.ToString).IsLockedOut Then
                Session("error") = GetMessage(350) 'account is locked
                Session("msgHeight") = 50
                'Response.Redirect("error.aspx")
            End If

        Catch ex As Exception
            'Session("msg") = "Username doesn't exist"
        End Try

        'Dim UserIPAddress
        'UserIPAddress = Request.ServerVariables("HTTP_X_FORWARDED_FOR")

        'If UserIPAddress = "" Then
        ' UserIPAddress = Request.ServerVariables("REMOTE_ADDR")
        'End If

        'Session("msg") = UserIPAddress
    End Sub


    Private Sub cmdRequestPassword_Click(sender As Object, e As System.EventArgs) Handles cmdRequestPassword.Click
        Dim u As MembershipUser
        Dim s As String
        Dim er As Boolean = False
        Dim emp As Employee
        Dim token As String

        Session("msg") = Nothing

        Try
            u = Membership.GetUser(txtResetPassword.Text)
            emp = New Employee(txtResetPassword.Text)
            's = "http://localhost:59546/PasswordReset.aspx?id=" + u.ProviderUserKey.ToString + "&username=" + u.UserName
            token = GetToken(20)
            s = "You have requested to reset your password. If you didn't make this request, contact your administrator.<br><br>"
            s += "Click <a href='https://www.advataxes.ca/PasswordReset.aspx?token=" + token + "'>here</a> to reset your password<br><br>"
            's = "https://dev.advataxes.ca/PasswordReset.aspx?id=" + u.ProviderUserKey.ToString + "&username=" + u.UserName 
            emp.PwdToken = token
            emp.Update()

            SendEmail(u.Email, "Advataxes: Reset Password ", s, emp.DefaultLanguage)


            'Session("message") = GetMessage(93 ) & u.Email
            'Session("msgTitle") = "Reset Password"
            'Response.Redirect("message.aspx")

        Catch ex As Exception
            Session("error") = "Username " & txtResetPassword.Text & " doesn't exist."
            'er = True

        Finally
            ModalPopupExtender1.Hide()
            u = Nothing
            emp = Nothing
            If Not er Then Response.Redirect("../message.aspx?id=93")

        End Try

    End Sub

End Class