Imports System.Web.Security
Imports System.Text.RegularExpressions
Imports System.Web.Configuration.WebConfigurationManager

Partial Public Class Login
    Inherits System.Web.UI.Page

    Protected Sub Page_PreIinit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        'Dim maintenanceMode As String = AppSettings("MaintenanceMode")

        'If maintenanceMode.ToLower().Equals("maintenance") Then

        '    Response.Redirect("index.html")

        'End If
    End Sub

    Private Sub Login_Error(sender As Object, e As System.EventArgs) Handles Me.Error
        If IsNothing(Session("error")) Then Session("error") = GetMessage(273, Session("language")) : Session("msgHeight") = 50
        Response.Redirect("login.aspx")
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        GetConnectionString()

        If Request.QueryString("action") = "loggedout" Then
            Session("msg") = GetMessage(426, "English")
            Session("language") = "English"

        ElseIf Request.QueryString("action") = "deconnecter" Then
            Session("msg") = GetMessage(426, "French")
            Session("language") = "French"
        Else
            Session("msg") = Nothing
        End If

        If Not IsNothing(Request.QueryString("error")) Or Not IsNothing(Session("error")) Then
            If Not IsNothing(Session("error")) Then
                lblError.Text = Session("error")
            Else
                lblError.Text = GetMessage(273)
            End If
        End If

        If IsNothing(Request.QueryString("lang")) And IsNothing(Request.QueryString("action")) Then
            Session("language") = "English"
        ElseIf Not IsNothing(Request.QueryString("lang")) And IsNothing(Request.QueryString("action")) Then
            Session("language") = "French"
        End If

        If Session("language") = "French" Then
            lnkLang.Text = "English"
            lnkLang.PostBackUrl = "login.aspx"
        Else
            lnkLang.Text = "French"
            lnkLang.PostBackUrl = "login.aspx?lang=f"
        End If


        If IsNothing(Session("language")) Then Session("language") = "English"
        If Not IsNothing(Request.QueryString("err")) Then Session("error") = GetMessage(CInt(Request.QueryString("err")), Session("language")) : Session("msgHeight") = Right(Request.QueryString("err"), 2) : Response.Redirect("login.aspx")
        If Not IsNothing(Request.QueryString("msg")) Then Session("msg") = GetMessage(CInt(Request.QueryString("msg")), Session("language")) : Session("msgHeight") = Right(Request.QueryString("err"), 2) : Response.Redirect("login.aspx")
        'If Not IsNothing(Request.QueryString("timedout")) Then Session("msg") = "Your session has timed out. Please login again"

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
                Response.Redirect("login.aspx?msg=347")

            End If

        End If

        'If Not IsNothing(Session("emp")) Then Response.Redirect("account/reports.aspx")

        On Error Resume Next

        Dim userLogin As System.Web.UI.WebControls.Login = Me.Login2
        Dim userNameTextBox As TextBox = CType(userLogin.FindControl("UserName"), TextBox)

        If userNameTextBox IsNot Nothing Then
            SetFocus(userNameTextBox)
            'userNameTextBox.Focus() 
        End If



        lblLogin.Text = GetMessage(95, Session("language"))
        Login2.UserNameLabelText = GetMessage(206, Session("language"))
        Login2.PasswordLabelText = GetMessage(230, Session("language"))
        lnkForgotPwd.Text = GetMessage(99, Session("language"))
        Login2.LoginButtonText = GetMessage(95, Session("language"))
        lblResetPassword.Text = GetMessage(473, Session("language"))
        hdnCancelText.Value = GetMessage(142, Session("language"))
        cmdRequestPassword.Text = GetMessage(240, Session("language"))
        lblUserName.Text = GetMessage(206, Session("language"))
        lblResetPasswordTitle.Text = GetMessageTitle(473, Session("language"))
        'ModalPopupExtender2.Show()
    End Sub


    Private Sub Login2_LoggedIn(sender As Object, e As System.EventArgs) Handles Login2.LoggedIn
        Dim err As Integer
        Dim sUsers As String = ""
        Dim u As System.Web.Security.MembershipUser

        Session("username") = Login2.UserName.ToString
        Session("emp") = New Employee(Login2.UserName.ToString)
        Session("language") = Session("emp").defaultlanguage

        Try
            For Each u In Membership.GetAllUsers
                If u.IsOnline Then sUsers += u.UserName & "<BR>"
            Next

            SendEmail("sholdaway@advalorem.ca", Session("emp").username & " just logged in, Online: " & Membership.GetNumberOfUsersOnline, sUsers, "English")
            SendEmail("svanier@advalorem.ca", Session("emp").username & " just logged in, Online: " & Membership.GetNumberOfUsersOnline, sUsers, "English")

            If Not Session("emp").Activated Then
                Session("emp") = Nothing
                Session.Abandon()
                FormsAuthentication.SignOut()
                err = 349

            ElseIf Not Session("emp").active Then
                Session("emp") = Nothing
                Session.Abandon()
                FormsAuthentication.SignOut()
                err = 470
                'Session("error") = "Your account has been suspended.Contact your administrator to have your account reactivated."

            ElseIf Session("emp").organization.parent.accountstatus = 1 Then
                If DateAdd(DateInterval.Day, 30, Session("emp").organization.createdDate) < Now Then
                    Session("emp") = Nothing
                    Session.Abandon()
                    FormsAuthentication.SignOut()
                    err = 346 'trial expired

                End If

            Else
                'If Session("emp").isadmin And Session("emp").organization.parent.showwelcome Then
                'Response.Redirect("account/welcome.aspx")
                'Else
                'Response.Redirect("account/reports.aspx")
                'End If

            End If

        Catch ex As Exception

        Finally
            u = Nothing
            If err > 0 Then Response.Redirect("login.aspx?err=" & err)

        End Try

        'MsgBox(Membership.GetUser.UserName.ToString)
        ' MsgBox(UserProfile.GetUserProfile.Description)
    End Sub

    Private Sub Login_LoadComplete(sender As Object, e As System.EventArgs) Handles Me.LoadComplete
        If Not IsPostBack Then
            Session("emp") = Nothing
            Response.Cookies.Add(New HttpCookie("ASP.NET_SessionId", ""))
        End If
    End Sub

    Private Sub Login2_LoggingIn(sender As Object, e As System.Web.UI.WebControls.LoginCancelEventArgs) Handles Login2.LoggingIn
        On Error Resume Next
        Session("lastLoginDate") = Membership.GetUser(Login2.UserName).LastLoginDate
    End Sub


    Private Sub Login2_LoginError(sender As Object, e As System.EventArgs) Handles Login2.LoginError

        Session("error") = GetMessage(348, Session("language"))
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
        Dim s As String
        Dim er As Boolean = False
        Dim emp As Employee
        Dim token As String

        Session("msg") = Nothing

        Try
            emp = New Employee(txtResetPassword.Text)
            token = GetToken(20)

            s = GetMessage(428, emp.DefaultLanguage)
            s = Replace(s, "(user)", txtResetPassword.Text)
            s = Replace(s, "(token)", token)

            emp.PwdToken = token
            emp.Update()
            SendEmail(emp.Email, GetMessageTitle(428, emp.DefaultLanguage), s, emp.DefaultLanguage)


        Catch ex As Exception
            Session("error") = GetMessage(429)
            er = True

        Finally
            ModalPopupExtender1.Hide()
            emp = Nothing
            If Not er Then Response.Redirect("message.aspx?id=93")

        End Try

    End Sub

End Class