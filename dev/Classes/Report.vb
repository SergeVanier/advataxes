Imports System.Data
Imports System.Data.SqlClient

Public Class Report
    Public Const iOPEN As Integer = 1
    Public Const iSUBMITTED As Integer = 2
    Public Const iAPPROVED As Integer = 3
    Public Const iFINALIZED As Integer = 4
    Public Const iREJECTED As Integer = 5
    'Public Const iSUBMITTED As Integer = 6
    Public Const iREVERSED As Integer = 99

    Private _ID As Integer
    Private _approvedDate As Date
    Private _finalizedDate As Date
    Private _submittedDate As Date
    Private _rejectedDate As Date
    Private _lastDate As Date
    Private _statusID As Integer
    Private _name As String
    Private _statusName As String
    Private _createdDate As Date
    Private _empID As Integer
    Private _rptNum As Integer
    Private _rptNumFormatted As String
    Private _approvedBy As Integer
    Private _rejectedBy As Integer
    Private _finalizedBy As Integer
    Private _reasonRejected As String
    Private _reversedID As Integer
    Private _downloaded As Boolean
    Private _downloadedDate As Date

    Public Expenses() As Expense
    Public Emp As Employee

    Public Property Downloaded() As Boolean
        Get
            Return _downloaded
        End Get
        Set(ByVal value As Boolean)
            _downloaded = value
        End Set
    End Property

    Public Property DownloadedDate() As Date
        Get
            Return _downloadedDate
        End Get
        Set(ByVal value As Date)
            _downloadedDate = value
        End Set
    End Property

    Public Property ReasonRejected() As String
        Get
            Return _reasonRejected
        End Get
        Set(ByVal value As String)
            _reasonRejected = value
        End Set
    End Property

    Public Property StatusName() As String
        Get
            Return _statusName
        End Get
        Set(ByVal value As String)
            _statusName = value
        End Set
    End Property

    Public Property FinalizedBy() As Integer
        Get
            Return _finalizedBy
        End Get
        Set(ByVal value As Integer)
            _finalizedBy = value
        End Set
    End Property

    Public Property ReversedID() As Integer
        Get
            Return _reversedID
        End Get
        Set(ByVal value As Integer)
            _reversedID = value
        End Set
    End Property

    Public Property RejectedBy() As Integer
        Get
            Return _rejectedBy
        End Get
        Set(ByVal value As Integer)
            _rejectedBy = value
        End Set
    End Property

    Public Property ApprovedBy() As Integer
        Get
            Return _approvedBy
        End Get
        Set(ByVal value As Integer)
            _approvedBy = value
        End Set
    End Property

    Public Property CreatedDate() As Date
        Get
            Return _createdDate
        End Get
        Set(ByVal value As Date)
            _createdDate = value
        End Set
    End Property

    Public Property ApprovedDate() As Date
        Get
            Return _approvedDate
        End Get
        Set(ByVal value As Date)
            _approvedDate = value
        End Set
    End Property

    Public Property LastDate() As Date
        Get
            Return _lastDate
        End Get
        Set(ByVal value As Date)
            _lastDate = value
        End Set
    End Property

    Public Property RejectedDate() As Date
        Get
            Return _rejectedDate
        End Get
        Set(ByVal value As Date)
            _rejectedDate = value
        End Set
    End Property


    Public Property SubmittedDate() As Date
        Get
            Return _submittedDate
        End Get
        Set(ByVal value As Date)
            _submittedDate = value
        End Set
    End Property

    Public Property FinalizedDate() As Date
        Get
            Return _finalizedDate
        End Get
        Set(ByVal value As Date)
            _finalizedDate = value
        End Set
    End Property

    Public Property ReportNumber() As Integer
        Get
            Return _rptNum
        End Get
        Set(ByVal value As Integer)
            _rptNum = value
        End Set
    End Property

    Public Property ReportNumberFormatted() As String
        Get
            Return _rptNumFormatted
        End Get
        Set(ByVal value As String)
            _rptNumFormatted = value
        End Set
    End Property

    Public Property EmpID() As Integer
        Get
            Return _empID
        End Get
        Set(ByVal value As Integer)
            _empID = value
        End Set
    End Property


    Public Property Status() As Integer
        Get
            Return _statusID
        End Get
        Set(ByVal value As Integer)
            _statusID = value
        End Set
    End Property

    Public Property Name() As String
        Get
            Return _name
        End Get
        Set(ByVal value As String)
            _name = value
        End Set
    End Property


    Public Property ID() As Integer
        Get
            Return _ID
        End Get
        Set(ByVal value As Integer)
            _ID = value
        End Set
    End Property

    Public Sub UpdateDebitCredit(Type As String, GLAccount As String, Amount As Double)
        GetConnectionString()
        Dim sqlConn = New SqlConnection(connString.ConnectionString)
        sqlConn.Open()
        Dim employee As New Employee(EmpID)
        Dim com As SqlCommand = New SqlCommand("UpdateDebitCredit", sqlConn)


        com.CommandType = CommandType.StoredProcedure
        com.Parameters.Add(New SqlParameter("@Type", SqlDbType.VarChar)).Value = Type
        com.Parameters.Add(New SqlParameter("@ReportNum", SqlDbType.Int)).Value = ReportNumber
        com.Parameters.Add(New SqlParameter("@GLAccount", SqlDbType.VarChar)).Value = GLAccount
        com.Parameters.Add(New SqlParameter("@OrgID", SqlDbType.Int)).Value = employee.OrgID
        com.Parameters.Add(New SqlParameter("@Amount", SqlDbType.Money)).Value = Amount

        com.Connection = sqlConn
        com.ExecuteNonQuery()

        com.Dispose()
        sqlConn.Close()

        employee = Nothing
    End Sub


    Public Sub UpdateStatus(ByVal statusID As Integer)
        GetConnectionString()
        Dim sqlConn = New SqlConnection(connString.ConnectionString)
        sqlConn.Open()

        Dim approver As New Employee(Membership.GetUser.UserName)
        Dim com As SqlCommand = New SqlCommand("UpdateReportStatus", sqlConn)

        com.CommandType = CommandType.StoredProcedure
        com.Parameters.Add(New SqlParameter("@ReportID", SqlDbType.Int)).Value = _ID
        com.Parameters.Add(New SqlParameter("@StatusID", SqlDbType.Int)).Value = IIf(statusID = iREJECTED, iOPEN, IIf(statusID = 6, 2, statusID))
        com.Parameters.Add(New SqlParameter("@LastDate", SqlDbType.Date)).Value = Now
        com.Parameters.Add(New SqlParameter("@ReasonRejected", SqlDbType.NVarChar)).Value = ReasonRejected

        Select Case statusID
            Case iSUBMITTED : com.Parameters.Add(New SqlParameter("@SubmittedDate", SqlDbType.Date)).Value = Now
            Case iAPPROVED : com.Parameters.Add(New SqlParameter("@ApprovedDate", SqlDbType.Date)).Value = Now : com.Parameters.Add(New SqlParameter("@ApprovedBy", SqlDbType.Int)).Value = approver.ID
            Case iFINALIZED : com.Parameters.Add(New SqlParameter("@FinalizedDate", SqlDbType.Date)).Value = Now : com.Parameters.Add(New SqlParameter("@RptNum", SqlDbType.Int)).Value = ReportNumber : com.Parameters.Add(New SqlParameter("@FinalizedBy", SqlDbType.Int)).Value = approver.ID
            Case iREJECTED : com.Parameters.Add(New SqlParameter("@RejectedDate", SqlDbType.Date)).Value = Now : com.Parameters.Add(New SqlParameter("@RejectedBy", SqlDbType.Int)).Value = approver.ID
                'Case 6 : com.Parameters.Add(New SqlParameter("@RejectedDate", SqlDbType.Date)).Value = Now : com.Parameters.Add(New SqlParameter("@RejectedBy", SqlDbType.Int)).Value = approver.ID
            Case iREVERSED : com.Parameters.Add(New SqlParameter("@RejectedDate", SqlDbType.Date)).Value = Now : com.Parameters.Add(New SqlParameter("@RejectedBy", SqlDbType.Int)).Value = approver.ID
        End Select

        If SubmittedDate <> "#12:00:00 AM#" And statusID <> iSUBMITTED Then com.Parameters.Add(New SqlParameter("@SubmittedDate", SqlDbType.Date)).Value = SubmittedDate
        If ApprovedDate <> "#12:00:00 AM#" And statusID <> iAPPROVED Then com.Parameters.Add(New SqlParameter("@ApprovedDate", SqlDbType.Date)).Value = ApprovedDate : com.Parameters.Add(New SqlParameter("@ApprovedBy", SqlDbType.Int)).Value = ApprovedBy

        If statusID <> 6 Then
            If FinalizedDate <> "#12:00:00 AM#" And statusID <> iFINALIZED Then com.Parameters.Add(New SqlParameter("@FinalizedDate", SqlDbType.Date)).Value = FinalizedDate : com.Parameters.Add(New SqlParameter("@FinalizedBy", SqlDbType.Int)).Value = FinalizedBy
        End If

        If RejectedDate <> "#12:00:00 AM#" And statusID < 5 Then com.Parameters.Add(New SqlParameter("@RejectedDate", SqlDbType.Date)).Value = RejectedDate : com.Parameters.Add(New SqlParameter("@RejectedBy", SqlDbType.Int)).Value = RejectedBy

        com.Connection = sqlConn
        com.ExecuteNonQuery()

        approver = Nothing
        com.Dispose()
        sqlConn.Close()

    End Sub


    Public Function Amount(Optional IncludeTP As Boolean = False) As Double
        Dim expense As Expense
        Dim total As Double

        For Each expense In Expenses
            If expense.Reimburse Or IncludeTP Then total += expense.AmountCDN
        Next

        expense = Nothing
        Return total
    End Function

    Public Function Reject(puk As String) As String
        Dim expense As Expense
        Dim userMembership As MembershipUser
        Dim stringBuilder As New StringBuilder
        Dim approver As Employee
        Dim amount As Double, onbehalf As Double
        Dim AllowReject As Boolean


        Try
            If puk = Membership.GetUser.ProviderUserKey.ToString Then
                approver = New Employee(Membership.GetUser.UserName)

                If Status = iAPPROVED Then
                    AllowReject = approver.ID = Emp.Finalizer
                Else
                    AllowReject = approver.ID = Emp.Supervisor
                End If

                If AllowReject Then
                    ReasonRejected = Replace(ReasonRejected, "<", "")
                    ReasonRejected = Replace(ReasonRejected, ">", "")
                    UpdateStatus(iREJECTED)

                    For Each expense In Expenses
                        If expense.Reimburse Then
                            amount += expense.AmountCDN
                        Else
                            onbehalf += expense.AmountCDN
                        End If
                    Next

                    userMembership = Membership.GetUser(Emp.Username)

                    stringBuilder.Append(GetMessage(32, Emp.DefaultLanguage))
                    stringBuilder.Replace("(Name)", Emp.FirstName & " " & Emp.LastName)
                    stringBuilder.Replace("(reportname)", Name)
                    stringBuilder.Replace("(reason)", ReasonRejected)
                    stringBuilder.Replace("(amount)", FormatNumber(amount + onbehalf, 2) & " $ CAD")

                    stringBuilder.Replace("(date)", Format(Now, "dd/MM/yyyy"))
                    stringBuilder.Replace("(rejectedby)", approver.FirstName & " " & approver.LastName)

                    If Not SendEmail(Emp.Email, GetMessageTitle(32, Emp.DefaultLanguage), stringBuilder.ToString, Emp.DefaultLanguage) Then
                        stringBuilder.Clear()
                        stringBuilder.Append(GetMessage(436, approver.DefaultLanguage)) 'error sending email
                    Else
                        stringBuilder.Clear()
                    End If

                    CreateAuditTrail(ID, approver.ID, "", "", "Rejected report", "", "", Name)
                End If
            End If

        Catch ex As Exception
            stringBuilder.Clear()
            stringBuilder.Append(ex.Message)

        Finally
            userMembership = Nothing
            expense = Nothing
            approver = Nothing
        End Try

        Return stringBuilder.ToString

    End Function


    Public Sub Open()
        UpdateStatus(iOPEN)
    End Sub

    Public Function Approve(puk As String) As String
        Dim expense As Expense
        Dim userMembership As MembershipUser
        Dim stringBuilder As New StringBuilder
        Dim finalizer As Employee, approver As Employee
        Dim amount As Double, onbehalf As Double

        Try
            If puk = Membership.GetUser.ProviderUserKey.ToString Then
                approver = New Employee(Membership.GetUser.UserName)
                If approver.ID = Emp.Supervisor Then
                    UpdateStatus(iAPPROVED)

                    For Each expense In Expenses
                        If expense.Reimburse Then
                            amount += expense.AmountCDN
                        Else
                            onbehalf += expense.AmountCDN
                        End If
                    Next

                    userMembership = Membership.GetUser(Emp.Username)
                    finalizer = New Employee(Emp.Finalizer)

                    stringBuilder.Append(GetMessage(372, finalizer.DefaultLanguage))
                    stringBuilder.Replace("(Name)", finalizer.FirstName & " " & finalizer.LastName)
                    stringBuilder.Replace("(submittedBy)", Emp.FirstName & " " & Emp.LastName)
                    stringBuilder.Replace("(approvedBy)", approver.FirstName & " " & approver.LastName)
                    stringBuilder.Replace("(reportname)", Name)

                    If Not SendEmail(finalizer.Email, GetMessageTitle(372, finalizer.DefaultLanguage), stringBuilder.ToString, finalizer.DefaultLanguage) Then
                        stringBuilder.Clear()
                        stringBuilder.Append(GetMessage(436, finalizer.DefaultLanguage)) 'there was an error while sending email
                    Else
                        stringBuilder.Clear()
                    End If

                    CreateAuditTrail(ID, approver.ID, "", "", "Approved Report", "", "", Name)
                Else
                    Throw New Exception
                End If

            Else
                Throw New Exception
            End If

        Catch ex As Exception
            stringBuilder.Clear()
            stringBuilder.Append(ex.Message)

        Finally
            userMembership = Nothing
            finalizer = Nothing
            expense = Nothing
        End Try

        Return stringBuilder.ToString

    End Function

    Public Function Submit(puk As String) As Dictionary(Of String, String)
        Dim submitDictionary As New Dictionary(Of String, String)
        Dim loggedInUser As Employee
        Dim approver As Employee
        Dim stringBuilder As New StringBuilder

        Try
            submitDictionary.Add("ErrorMessage", "")

            If puk = Membership.GetUser.ProviderUserKey.ToString Then

                loggedInUser = New Employee(Membership.GetUser.UserName.ToString)
                approver = New Employee(loggedInUser.Supervisor)

                If loggedInUser.ID = Emp.ID Or Emp.DelegatedTo = loggedInUser.ID Then
                    If IsNothing(Expenses) Then 'no expenses entered
                        submitDictionary("ErrorMessage") = GetMessage(33, loggedInUser.DefaultLanguage)
                        submitDictionary.Add("MessageTitle", GetMessageTitle(33, loggedInUser.DefaultLanguage))

                        'no supervisor or finalizer assigned
                    ElseIf loggedInUser.Supervisor = 0 Or (loggedInUser.Finalizer = 0 And loggedInUser.Organization.ApprovalLevel = 2) Then
                        If loggedInUser.Organization.ApprovalLevel = 1 Then
                            submitDictionary("ErrorMessage") = GetMessage(34, loggedInUser.DefaultLanguage)
                            submitDictionary.Add("MessageTitle", GetMessageTitle(34, loggedInUser.DefaultLanguage))
                        Else
                            submitDictionary("ErrorMessage") = GetMessage(495, loggedInUser.DefaultLanguage)
                            submitDictionary.Add("MessageTitle", GetMessageTitle(495, loggedInUser.DefaultLanguage))
                        End If

                    Else 'report is valid for submitting
                        UpdateStatus(iSUBMITTED)

                        stringBuilder.Append(GetMessage(28, approver.DefaultLanguage))
                        stringBuilder.Replace("(Name)", approver.FirstName & " " & approver.LastName)
                        stringBuilder.Replace("(submittedBy)", loggedInUser.FirstName & " " & loggedInUser.LastName)
                        stringBuilder.Replace("(reportname)", Name)

                        If Not SendEmail(approver.Email, GetMessageTitle(28, approver.DefaultLanguage), stringBuilder.ToString, approver.DefaultLanguage) Then
                            submitDictionary("ErrorMessage") = GetMessage(436, loggedInUser.DefaultLanguage) 'error sending email
                        Else
                            submitDictionary.Add("SuccessMessage", GetMessage(130, loggedInUser.DefaultLanguage)) 'email succeeded
                        End If
                    End If

                    CreateAuditTrail(ID, Emp.ID, "", "", "Submitted Report", "", "", Name)
                Else
                    Throw New Exception
                End If
            Else
                Throw New Exception
            End If

        Catch ex As Exception
            Throw ex

        Finally
            approver = Nothing
            loggedInUser = Nothing
        End Try

        Return submitDictionary

    End Function

    Public Function FinalizeReport(puk As String) As String
        Dim expense As Expense
        Dim userMembership As MembershipUser
        Dim stringBuilder As New StringBuilder, stringBuilderFrench As New StringBuilder, sError As String = ""
        Dim approver As Employee
        Dim amount As Double, onbehalf As Double
        Dim organization As Org
        Dim itc As Double, itr As Double, ritcBC As Double, ritcON As Double, ritcPEI As Double
        Dim employee As Employee

        Try
            If puk = Membership.GetUser.ProviderUserKey.ToString Then
                approver = New Employee(Membership.GetUser.UserName)

                If approver.ID = Emp.Supervisor Or approver.ID = Emp.Finalizer Then
                    AssignReportNumber()
                    UpdateStatus(iFINALIZED)

                    organization = New Org(Emp.Organization.ID)

                    For Each expense In Expenses
                        If expense.Reimburse Then
                            amount += expense.AmountCDN
                        Else
                            onbehalf += expense.AmountCDN
                        End If

                        itc += expense.ITC
                        itr += expense.ITR
                        If expense.Jurisdiction.ID = 10 Then ritcBC += expense.RITC 'jurisdiction is BC
                        If expense.Jurisdiction.ID = 2 Then ritcON += expense.RITC 'jurisdiction is ontario
                        If expense.Jurisdiction.ID = 4 Then ritcPEI += expense.RITC 'jurisdiction is PEI
                    Next

                    If organization.Parent.ITCAccount <> "" And itc > 0 Then UpdateDebitCredit("DT", organization.Parent.ITCAccount, itc)
                    If organization.Parent.ITRAccount <> "" And itr > 0 Then UpdateDebitCredit("DT", organization.Parent.ITRAccount, itr)
                    If organization.Parent.ritcBCAccount <> "" And ritcBC > 0 Then UpdateDebitCredit("CR", organization.Parent.ritcBCAccount, ritcBC)
                    If organization.Parent.ritcONAccount <> "" And ritcON > 0 Then UpdateDebitCredit("CR", organization.Parent.ritcONAccount, ritcON)
                    If organization.Parent.ritcPEIAccount <> "" And ritcPEI > 0 Then UpdateDebitCredit("CR", organization.Parent.ritcPEIAccount, ritcPEI)

                    userMembership = Membership.GetUser(Emp.Username)

                    '========== format email to send to employee to say their report has been finalized ===================================
                    stringBuilder.Append(GetMessage(29, Emp.DefaultLanguage))
                    stringBuilder.Replace("(Name)", Emp.FirstName & " " & Emp.LastName)
                    stringBuilder.Replace("(reportname)", Name)
                    stringBuilder.Replace("(amount)", FormatNumber(amount + onbehalf, 2) & " $ CAD")

                    If onbehalf > 0 Then
                        stringBuilder.Replace("(onbehalf)", FormatNumber(onbehalf, 2) & " $ CAD")
                        stringBuilder.Replace("(reimburse)", FormatNumber(amount, 2) & " $ CAD")
                    Else
                        stringBuilder.Replace("Non-reimbursable: (onbehalf)<br>", "")
                        stringBuilder.Replace("Amount to reimburse: (reimburse)<br>", "")
                        stringBuilder.Replace("Non remboursable : (onbehalf)<br>", "")
                        stringBuilder.Replace("Montant à rembourser : (reimburse)<br>", "")
                    End If

                    stringBuilder.Replace("(date)", Format(Now, "dd/MM/yyyy"))
                    stringBuilder.Replace("(finalizedBy)", approver.FirstName & " " & approver.LastName)

                    If Not SendEmail(Emp.Email, GetMessageTitle(29, Emp.DefaultLanguage), stringBuilder.ToString, Emp.DefaultLanguage) Then
                        sError = "There was an error while sending email"
                    Else
                        sError = ""
                    End If
                    '================= format english email for notification ===============================================================
                    stringBuilder.Clear()
                    stringBuilder.Append(GetMessage(30, "English"))
                    stringBuilder.Replace("(Name),", "")
                    stringBuilder.Replace("(org)", Emp.Organization.Name)
                    stringBuilder.Replace("(reportname)", Name)
                    stringBuilder.Replace("(amount)", FormatNumber(amount + onbehalf, 2) & " $ CAD")

                    If onbehalf > 0 Then
                        stringBuilder.Replace("(onbehalf)", FormatNumber(onbehalf, 2) & " $ CAD")
                        stringBuilder.Replace("(reimburse)", FormatNumber(amount, 2) & " $ CAD")
                    Else
                        stringBuilder.Replace("Non-reimbursable: (onbehalf)<br>", "")
                        stringBuilder.Replace("Amount to reimburse: (reimburse)<br>", "")
                    End If

                    stringBuilder.Replace("(date)", Format(Now, "dd/MM/yyyy"))
                    stringBuilder.Replace("(submittedBy)", Emp.FirstName & " " & Emp.LastName)
                    stringBuilder.Replace("(finalizedBy)", approver.FirstName & " " & approver.LastName)

                    '================= format french email for notification ===============================================================
                    stringBuilderFrench.Append(GetMessage(30, "French"))
                    stringBuilderFrench.Replace("(Name),", "")
                    stringBuilderFrench.Replace("(org)", Emp.Organization.Name)
                    stringBuilderFrench.Replace("(reportname)", Name)
                    stringBuilderFrench.Replace("(amount)", FormatNumber(amount + onbehalf, 2) & " $ CAD")

                    If onbehalf > 0 Then
                        stringBuilderFrench.Replace("(onbehalf)", FormatNumber(onbehalf, 2) & " $ CAD")
                        stringBuilderFrench.Replace("(reimburse)", FormatNumber(amount, 2) & " $ CAD")
                    Else
                        stringBuilderFrench.Replace("Non remboursable : (onbehalf)<br>", "")
                        stringBuilderFrench.Replace("Montant à rembourser : (reimburse)<br>", "")
                    End If

                    stringBuilderFrench.Replace("(date)", Format(Now, "dd/MM/yyyy"))
                    stringBuilderFrench.Replace("(submittedBy)", Emp.FirstName & " " & Emp.LastName)
                    stringBuilderFrench.Replace("(finalizedBy)", approver.FirstName & " " & approver.LastName)
                    organization.GetEmployees()

                    For Each employee In organization.Employees
                        If employee.NotifyFinalized Then
                            If Not SendEmail(employee.Email, GetMessageTitle(30, employee.DefaultLanguage), employee.FirstName & " " & employee.LastName & ",<br>" & IIf(employee.DefaultLanguage = "English", stringBuilder.ToString, stringBuilderFrench.ToString), employee.DefaultLanguage) Then
                                sError = GetMessage(436, approver.DefaultLanguage) 'error sending email
                            Else
                                sError = ""
                            End If
                        End If
                    Next

                    CreateAuditTrail(ID, approver.ID, "", "", "Finalized Report", "", "", Name)
                Else
                    Throw New Exception
                End If
            Else
                Throw New Exception
            End If

        Catch ex As Exception
            Throw ex

        Finally
            organization = Nothing
            userMembership = Nothing
            employee = Nothing
            expense = Nothing
            approver = Nothing
        End Try

        Return sError

    End Function


    Private Sub AssignReportNumber()
        GetConnectionString()

        Dim sqlConn = New SqlConnection(connString.ConnectionString)
        sqlConn.Open()

        Dim com As SqlCommand = New SqlCommand("GetLastReportNum", sqlConn)
        Dim rs As SqlDataReader

        com.CommandType = CommandType.StoredProcedure
        com.Parameters.Add(New SqlParameter("@OrgID", SqlDbType.Int)).Value = Emp.Organization.ID

        com.Connection = sqlConn
        rs = com.ExecuteReader

        While rs.Read
            If Not IsDBNull(rs("REPORT_NUM")) Then ReportNumber = rs("REPORT_NUM") + 1 Else ReportNumber = 1
        End While

        com.Dispose()
        sqlConn.Close()
    End Sub

    Public Sub Create(ByVal pReportName As String, ByVal OrgID As Integer, ByVal EmpId As Integer, ByVal StatusID As Integer)
        GetConnectionString()
        Dim sqlConn = New SqlConnection(connString.ConnectionString)
        sqlConn.Open()
        Dim com As SqlCommand = New SqlCommand("CreateReport", sqlConn)

        com.CommandType = CommandType.StoredProcedure
        com.Parameters.Add(New SqlParameter("@ReportName", SqlDbType.NVarChar)).Value = pReportName
        com.Parameters.Add(New SqlParameter("@OrgID", SqlDbType.Int)).Value = OrgID
        com.Parameters.Add(New SqlParameter("@EmpID", SqlDbType.Int)).Value = EmpId
        com.Parameters.Add(New SqlParameter("@CreatedDate", SqlDbType.Date)).Value = Now
        com.Parameters.Add(New SqlParameter("@DeleteDate", SqlDbType.Date)).Value = DateAdd(DateInterval.Year, 1, Now)
        com.Parameters.Add(New SqlParameter("@StatusID", SqlDbType.Int)).Value = StatusID

        com.Connection = sqlConn
        com.ExecuteNonQuery()

        com.Dispose()
        sqlConn.Close()

    End Sub

    Public Sub Update()
        GetConnectionString()
        Dim sqlConn = New SqlConnection(connString.ConnectionString)
        sqlConn.Open()
        Dim com As SqlCommand = New SqlCommand("UpdateReport", sqlConn)

        com.CommandType = CommandType.StoredProcedure
        com.Parameters.Add(New SqlParameter("@ReportID", SqlDbType.Int)).Value = _ID
        com.Parameters.Add(New SqlParameter("@ReportName", SqlDbType.NVarChar)).Value = Name
        com.Parameters.Add(New SqlParameter("@ReversedID", SqlDbType.Int)).Value = ReversedID
        com.Parameters.Add(New SqlParameter("@Downloaded", SqlDbType.Bit)).Value = Downloaded
        If Downloaded Then com.Parameters.Add(New SqlParameter("@DownloadedDate", SqlDbType.Date)).Value = Now

        com.Connection = sqlConn
        com.ExecuteNonQuery()

        com.Dispose()
        sqlConn.Close()

    End Sub

    Public Sub Delete(puk As String)
        GetConnectionString()
        Dim sqlConn = New SqlConnection(connString.ConnectionString)
        sqlConn.Open()

        Dim com As SqlCommand = New SqlCommand("DeleteReport", sqlConn)
        com.CommandType = CommandType.StoredProcedure
        com.Parameters.Add(New SqlParameter("@ReportID", SqlDbType.Int)).Value = _ID
        Dim loggedInUser As Employee

        Try
            If puk = Membership.GetUser.ProviderUserKey.ToString Then
                loggedInUser = New Employee(Membership.GetUser.UserName)

                If loggedInUser.ID = Emp.ID Or loggedInUser.ID = Emp.DelegatedTo Then
                    com.Connection = sqlConn
                    com.ExecuteNonQuery()
                    com.Dispose()
                    sqlConn.Close()
                Else
                    Throw New Exception
                End If
            Else
                Throw New Exception
            End If

        Catch ex As Exception
            Throw ex

        Finally
            loggedInUser = Nothing
        End Try

    End Sub

    Public Sub GetOpenReport(EmpID As Integer)
        GetConnectionString()
        Dim sqlConn = New SqlConnection(connString.ConnectionString)
        sqlConn.Open()

        Dim com As SqlCommand = New SqlCommand("GetReportsByEmpID", sqlConn)
        Dim rs As SqlDataReader

        com.CommandType = CommandType.StoredProcedure
        com.Parameters.Add(New SqlParameter("@EmpID", SqlDbType.Int)).Value = EmpID
        com.Connection = sqlConn
        rs = com.ExecuteReader

        While rs.Read
            If rs("STATUS_ID") = 1 Then
                Status = rs("STATUS_ID")
                ID = rs("REPORT_ID")
                Name = rs("REPORT_NAME")
                If Not IsDBNull(rs("APPROVED_DATE")) Then ApprovedDate = rs("APPROVED_DATE")
                If Not IsDBNull(rs("SUBMITTED_DATE")) Then SubmittedDate = rs("SUBMITTED_DATE")
                CreatedDate = rs("CREATED_DATE")
                GetExpenses()
                Exit While
            End If
        End While

        rs.Close()
        com.Dispose()
        rs = Nothing
        com = Nothing
        sqlConn.Close()
    End Sub

    Public Sub New()

    End Sub

    Public Sub New(id As Integer, Optional IncludeExpenses As Boolean = True, Optional TPOnly As Boolean = False)
        Dim loggedInUser As New Employee(Membership.GetUser.UserName)
        GetConnectionString()
        Dim sqlConn = New SqlConnection(connString.ConnectionString)
        sqlConn.Open()

        Dim com As SqlCommand = New SqlCommand("GetReport", sqlConn)
        Dim rs As SqlDataReader

        com.CommandType = CommandType.StoredProcedure
        com.Parameters.Add(New SqlParameter("@ReportID", SqlDbType.Int)).Value = id
        com.Connection = sqlConn
        rs = com.ExecuteReader

        Try
            While rs.Read
                Me.ID = id
                Status = rs("STATUS_ID")
                StatusName = IIf(loggedInUser.DefaultLanguage = "French", rs("STATUS_NAME_FR"), rs("STATUS_NAME"))
                Name = rs("REPORT_NAME")
                EmpID = rs("EMP_ID")
                Emp = New Employee(CInt(rs("EMP_ID")))
                If Not IsDBNull(rs("APPROVED_DATE")) Then ApprovedDate = rs("APPROVED_DATE")
                If Not IsDBNull(rs("SUBMITTED_DATE")) Then SubmittedDate = rs("SUBMITTED_DATE")
                CreatedDate = rs("CREATED_DATE")
                If Not IsDBNull(rs("FINALIZED_DATE")) Then FinalizedDate = rs("FINALIZED_DATE")
                If Not IsDBNull(rs("REJECTED_DATE")) Then RejectedDate = rs("REJECTED_DATE")
                If Not IsDBNull(rs("LAST_DATE")) Then LastDate = rs("LAST_DATE")
                If Not IsDBNull(rs("REJECTED_BY")) Then RejectedBy = rs("REJECTED_BY")
                If Not IsDBNull(rs("APPROVED_BY")) Then ApprovedBy = rs("APPROVED_BY")
                If Not IsDBNull(rs("FINALIZED_BY")) Then FinalizedBy = rs("FINALIZED_BY")
                If Not IsDBNull(rs("REASON_REJECTED")) Then ReasonRejected = rs("REASON_REJECTED")

                If Not IsDBNull(rs("REPORT_NUM")) Then
                    ReportNumber = rs("REPORT_NUM")
                    ReportNumberFormatted = IIf(ReportNumber < 10, "000" & ReportNumber, IIf(ReportNumber < 100, "00" & ReportNumber, IIf(ReportNumber < 1000, "0" & ReportNumber, ReportNumber)))
                Else
                    ReportNumber = 0
                End If

                If Not IsDBNull(rs("DOWNLOADED_DATE")) Then DownloadedDate = rs("DOWNLOADED_DATE")
                If Not IsDBNull(rs("DOWNLOADED")) Then Downloaded = rs("DOWNLOADED")
            End While

            If IncludeExpenses Then GetExpenses(TPOnly)

        Catch ex As Exception
            Throw ex

        Finally
            loggedInUser = Nothing
            rs.Close()
            com.Dispose()
            sqlConn.Close()

        End Try
    End Sub

    Public Function GetPendingCount(SupervisorID As Integer) As Integer
        GetConnectionString()
        Dim sqlConn = New SqlConnection(connString.ConnectionString)
        sqlConn.Open()

        Dim com As SqlCommand = New SqlCommand("GetPendingCount", sqlConn)
        Dim rs As SqlDataReader

        com.CommandType = CommandType.StoredProcedure
        com.Parameters.Add(New SqlParameter("@SupervisorID", SqlDbType.Int)).Value = ID
        com.Connection = sqlConn
        rs = com.ExecuteReader

        While rs.Read
            GetPendingCount = rs(0)
        End While

        rs.Close()
        com.Dispose()
        sqlConn.Close()

    End Function

    Public Function GetReportCount(OrgID As Integer) As Integer
        GetConnectionString()
        Dim sqlConn = New SqlConnection(connString.ConnectionString)
        sqlConn.Open()

        Dim com As SqlCommand = New SqlCommand("GetReportCount", sqlConn)
        Dim rs As SqlDataReader

        com.CommandType = CommandType.StoredProcedure
        com.Parameters.Add(New SqlParameter("@OrgID", SqlDbType.Int)).Value = OrgID
        com.Connection = sqlConn
        rs = com.ExecuteReader

        While rs.Read
            GetReportCount = rs(0)
        End While

        rs.Close()
        com.Dispose()
        sqlConn.Close()

    End Function


    Public Function GetReportTotalsEmp(empID As Integer) As Array
        GetConnectionString()
        Dim tot(5) As Integer
        Dim i As Integer
        Dim sqlConn = New SqlConnection(connString.ConnectionString)
        sqlConn.Open()

        Dim com As SqlCommand = New SqlCommand("GetReportTotalsEmp", sqlConn)
        Dim rs As SqlDataReader

        com.CommandType = CommandType.StoredProcedure
        com.Parameters.Add(New SqlParameter("@empID", SqlDbType.Int)).Value = empID
        com.Connection = sqlConn
        rs = com.ExecuteReader

        While rs.Read
            tot(i) = rs(i)
            i += 1
        End While

        rs.Close()
        com.Dispose()
        sqlConn.Close()

        GetReportTotalsEmp = tot
    End Function



    Public Sub GetExpenses(Optional TPOnly As Boolean = False)
        GetConnectionString()
        Dim i As Integer
        Dim sqlConn = New SqlConnection(connString.ConnectionString)
        sqlConn.Open()

        Dim com As SqlCommand = New SqlCommand("GetExpenses", sqlConn)
        Dim rs As SqlDataReader
        Dim expense As Expense

        com.CommandType = CommandType.StoredProcedure
        com.Parameters.Add(New SqlParameter("@ReportID", SqlDbType.Int)).Value = ID
        If TPOnly Then com.Parameters.Add(New SqlParameter("@TPOnly", SqlDbType.Bit)).Value = 1

        com.Connection = sqlConn
        rs = com.ExecuteReader
        Try
            While rs.Read
                expense = New Expense(CInt(rs("EXPENSE_ID")))
                ReDim Preserve Expenses(i)
                Expenses(i) = expense
                i += 1
            End While

        Catch ex As Exception
            Throw ex

        Finally
            rs.Close()
            com.Dispose()
            sqlConn.Close()
        End Try
    End Sub

    Public Function GetLastID(empID As Integer) As Integer
        GetConnectionString()
        Dim sqlConn = New SqlConnection(connString.ConnectionString)
        Dim lastID As Integer

        sqlConn.Open()

        Dim com As SqlCommand = New SqlCommand("GetLastReportID", sqlConn)
        Dim rs As SqlDataReader

        com.CommandType = CommandType.StoredProcedure
        com.Parameters.Add(New SqlParameter("@EmpID", SqlDbType.Int)).Value = empID
        com.Connection = sqlConn
        rs = com.ExecuteReader

        While rs.Read
            lastID = rs("LAST_RPT_ID")
        End While

        rs.Close()
        com.Dispose()
        sqlConn.Close()
        sqlConn = Nothing
        rs = Nothing

        GetLastID = lastID
    End Function

    Public Sub GetExpenses(orgCatID As Integer)
        GetConnectionString()
        Dim i As Integer
        Dim sqlConn = New SqlConnection(connString.ConnectionString)
        sqlConn.Open()

        Dim com As SqlCommand = New SqlCommand("GetExpensesByOrgCategory", sqlConn)
        Dim rs As SqlDataReader
        Dim expense As Expense

        com.CommandType = CommandType.StoredProcedure
        com.Parameters.Add(New SqlParameter("@orgCatID", SqlDbType.Int)).Value = orgCatID
        com.Parameters.Add(New SqlParameter("@rptID", SqlDbType.Int)).Value = ID
        com.Connection = sqlConn
        rs = com.ExecuteReader

        While rs.Read
            expense = New Expense(CInt(rs("EXPENSE_ID")))
            ReDim Preserve Expenses(i)
            Expenses(i) = expense
            i += 1
        End While

        rs.Close()
        com.Dispose()
        sqlConn.Close()

    End Sub
End Class
