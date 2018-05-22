Public Class MyProfile
    Inherits System.Web.UI.Page

    Private Sub MyProfile_Error(sender As Object, e As System.EventArgs) Handles Me.Error
        If IsNothing(Session("error")) Then Session("error") = GetMessage(273) : Session("msgHeight") = 50
        Response.Redirect("../login.aspx")
    End Sub

    ''' <summary>
    ''' On page load, get employee details to display on screen
    ''' </summary>
    ''' <param name="sender"></param>
    ''' <param name="e"></param>
    ''' <remarks></remarks>
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim employee As Employee
        Dim i As Integer

        Try
            CheckLanguage()

            Session("currentpage") = "MyProfile.aspx"
            hdnOrgID.Value = Session("emp").OrgID

            If Not IsPostBack Then
                If Session("emp").Supervisor <> 0 And Not IsDBNull(Session("emp").Supervisor) Then
                    employee = New Employee(CInt(Session("emp").Supervisor))
                    lblSupervisor.Text = "<table width='100%' border=0><tr><td width='33%'>" & employee.LastName & ", " & employee.FirstName & "</td><td width='67%' style='color:#cd1e1e'><a href='mailto:" & employee.Email & "?subject=Advataxes'  style='color:#cd1e1e'>" & employee.Email & "</a></td></tr></table>"
                    employee = Nothing
                End If

                If Session("emp").organization.approvallevel = 2 And Session("emp").finalizer <> 0 Then
                    employee = New Employee(CInt(Session("emp").finalizer))
                    lblFinalizer.Text = "<table width='100%' border=0><tr><td width='33%'>" & employee.LastName & ", " & employee.FirstName & "</td><td width='67%' style='color:#cd1e1e'><a href='mailto:" & employee.Email & "?subject=Advataxes'  style='color:#cd1e1e'>" & employee.Email & "</a></td></tr></table>"
                    employee = Nothing
                    lblFinalizer.Visible = True
                    lbl382.Visible = True
                End If

                If Session("emp").DelegatedTo <> 0 And Not IsDBNull(Session("emp").DelegatedTo) Then
                    employee = New Employee(CInt(Session("emp").DelegatedTo))
                    lblDelegate.Text = "<table width='100%' border=0><tr><td width='33%'>" & employee.LastName & ", " & employee.FirstName & "</td><td width='67%' style='color:#cd1e1e'><a href='mailto:" & employee.Email & "?subject=Advataxes'  style='color:#cd1e1e'>" & employee.Email & "</a></td></tr></table>"
                    employee = Nothing
                End If

                txtFirstName.Text = Session("emp").FirstName
                txtLastName.Text = Session("emp").LastName
                txtTitle.Text = Session("emp").Title
                txtPhone.Text = Session("emp").Phone
                cboLang.SelectedValue = Session("emp").defaultlanguage

                If Session("emp").isadmin Then txtStatus.Text = "Admin"
                If Session("emp").approvallevel = 1 Then txtStatus.Text += IIf(txtStatus.Text <> "", " / ", "") & GetMessage(159)
                If Session("emp").approvallevel = 2 Then txtStatus.Text += IIf(txtStatus.Text <> "", " / ", "") & GetMessage(382)
                If Session("emp").notifyfinalized Then txtStatus.Text += IIf(txtStatus.Text <> "", " / ", "") & GetMessage(239)
                If txtStatus.Text = "" Then txtStatus.Text = GetMessage(73)

                Session("emp").organization.getemployees()

                lblAdmin.Text = "<table width='100%' border=0>"
                For Each employee In Session("emp").organization.employees

                    If employee.IsAdmin Then
                        i += 1
                        lblAdmin.Text = lblAdmin.Text & "<tr " & IIf(i Mod 2 = 0, "", "") & "><td width='33%'>" & employee.LastName & ", " & employee.FirstName & "</td><td width='67%'  style='color:#cd1e1e'><a href='mailto:" & employee.Email & "?subject=Advataxes'  style='color:#cd1e1e'>" & employee.Email & "</a></td></tr>"
                        'style='background-color:#efefef;'
                    End If

                Next
                lblAdmin.Text = lblAdmin.Text & "</table>"
            Else
                lblMsg2.Text = "Changes saved"
            End If

            cboLang.Items(0).Text = IIf(Session("emp").defaultlanguage = "French", "Anglais", "English")
            cboLang.Items(1).Text = IIf(Session("emp").defaultlanguage = "French", "Francais", "French")

            Translate()
        Catch ex As Exception
            lblError.Text = "Error: " & ex.Message

        Finally
            employee = Nothing
        End Try
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

    
    ''' <summary>
    ''' Save changes to the user's profile when they click the save button
    ''' </summary>
    ''' <param name="sender"></param>
    ''' <param name="e"></param>
    ''' <remarks></remarks>
    Private Sub cmdSave_Click(sender As Object, e As System.EventArgs) Handles cmdSave.Click
        Dim employee As New Employee(CInt(Session("emp").id))

        Try
            employee.Title = txtTitle.Text
            employee.Phone = txtPhone.Text
            employee.DefaultLanguage = cboLang.SelectedValue
            Session("language") = employee.DefaultLanguage
            employee.Update()

            Session("emp") = New Employee(employee.ID)

        Catch ex As Exception
            lblError.Text = "Error: " & ex.Message

        Finally
            employee = Nothing
            Response.Redirect("myprofile.aspx")
        End Try
    End Sub

    ''' <summary>
    ''' Save changes to the user's password
    ''' </summary>
    ''' <param name="sender"></param>
    ''' <param name="e"></param>
    ''' <remarks></remarks>
    Private Sub cmdSavePassword_Click(sender As Object, e As System.EventArgs) Handles cmdSavePassword.Click
        If Membership.ValidateUser(Session("emp").Username.ToString, txtOldPassword.Text) Then
            Membership.GetUser(Session("emp").Username.ToString).ChangePassword(txtOldPassword.Text, txtNewPassword.Text)
            lblMsg2.Text = "Password changed successfully"
        Else
            lblMsg2.Text = "Old password is incorrect"
        End If
    End Sub


    ''' <summary>
    ''' Cycle through the controls and translate the page
    ''' </summary>
    ''' <remarks></remarks>
    Public Sub Translate()
        On Error Resume Next
        Dim d As New Description
        Dim c As Object
        Dim col As Object
        Dim childc As Object, childcc As Object, childccc As Object, childcccc As Object


        If IsNothing(Session("language")) Then Session("language") = Session("emp").defaultlanguage

        If Not IsNothing(Request.QueryString("lang")) Then
            If Request.QueryString("lang") = "f" Then
                session("language") = "French"
            Else
                session("language") = "English"
            End If
        End If

        For Each c In Page.Controls
            For Each childc In c.controls
                For Each childcc In childc.controls
                    If TypeOf childcc Is ContentPlaceHolder Then
                        For Each childccc In childcc.controls
                            If TypeOf childccc Is Label Then
                                If childccc.id Like "lbl*" Then childccc.text = d.GetDescription(CInt(Replace(childccc.id, "lbl", "")), Left(session("language"), 1))

                            ElseIf TypeOf childccc Is Button Then
                                ID = Replace(childccc.text, "_", "")
                                childccc.text = d.GetDescription(CInt(Replace(ID, "lbl", "")), Left(Session("language"), 1))

                            ElseIf TypeOf childccc Is Panel Then
                                For Each childcccc In childccc.controls
                                    If TypeOf childcccc Is Label Then
                                        If childcccc.id Like "lbl*" Then childcccc.text = d.GetDescription(CInt(Replace(childcccc.id, "lbl", "")), Left(session("language"), 1))

                                    ElseIf TypeOf childcccc Is Button Then
                                        ID = Replace(childcccc.text, "_", "")
                                        childcccc.text = d.GetDescription(CInt(Replace(ID, "lbl", "")), Left(Session("language"), 1))
                                    End If
                                Next

                            ElseIf TypeOf childccc Is GridView Then
                                For Each col In childccc.columns
                                    col.headertext = d.GetDescription(CInt(col.headertext), Left(session("language"), 1))
                                Next
                            End If
                        Next
                    End If
                Next
            Next
        Next

    End Sub
End Class