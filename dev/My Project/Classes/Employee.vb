Imports System.Data
Imports System.Data.SqlClient

Public Class Employee

    Private _firstname As String
    Private _lastname As String
    Private _isAdmin As Boolean
    Private _isAdvalorem As Boolean
    Private _isSupervisor As Boolean
    Private _isAccountant As Boolean
    Private _tagEntry As Boolean
    Private _notifyFinalized As Boolean
    Private _active As Boolean
    Private _username As String
    Private _email As String
    Private _phone As String
    Private _supervisorID As Integer
    Private _finalizerID As Integer
    Private _approvalLevel As Integer
    Private _delegateID As Integer
    Private _id As Integer
    Private _orgID As Integer
    Private _title As String
    Private _empnum As String
    Private _divcode As String
    Private _createdDate As Date
    Private _activated As Boolean
    Private _defaultLang As String
    Private _pwdToken As String
    Private _hasUploadedReceipts As Boolean
    Private _lockDefaultProject As Boolean
    Private _loginMessageIDs As String
    Public Organization As Org
    Public Reports() As Report
    Public Receipts As New Dictionary(Of Integer, String)
    Public LoginMessages As New Dictionary(Of Integer, String)
    Public DefaultProject As New PWC

    Public Property LoginMessageIDs() As String
        Get
            Return _loginMessageIDs
        End Get
        Set(ByVal value As String)
            _loginMessageIDs = value
        End Set
    End Property

    Public Property PwdToken() As String
        Get
            Return _pwdToken
        End Get
        Set(ByVal value As String)
            _pwdToken = value
        End Set
    End Property

    Public Property HasUploadedReceipts() As Boolean
        Get
            Return _hasUploadedReceipts
        End Get
        Set(ByVal value As Boolean)
            _hasUploadedReceipts = value
        End Set
    End Property

    Public Property LockDefaultProject As Boolean
        Get
            Return _lockDefaultProject
        End Get
        Set(ByVal value As Boolean)
            _lockDefaultProject = value
        End Set
    End Property

    Public Property Activated() As Boolean
        Get
            Return _activated
        End Get
        Set(ByVal value As Boolean)
            _activated = value
        End Set
    End Property

    Public Property TagEntry() As Boolean
        Get
            Return _tagEntry
        End Get
        Set(ByVal value As Boolean)
            _tagEntry = value
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


    Public Property DivCode() As String
        Get
            Return _divcode
        End Get
        Set(ByVal value As String)
            _divcode = value
        End Set
    End Property

    Public Property EmpNum() As String
        Get
            Return _empnum
        End Get
        Set(ByVal value As String)
            _empnum = value
        End Set
    End Property


    Public Property Email() As String
        Get
            Return _email
        End Get
        Set(ByVal value As String)
            _email = value
        End Set
    End Property


    Public Property Phone() As String
        Get
            Return _phone
        End Get
        Set(ByVal value As String)
            _phone = value
        End Set
    End Property


    Public Property DefaultLanguage() As String
        Get
            Return _defaultLang
        End Get
        Set(ByVal value As String)
            _defaultLang = value
        End Set
    End Property

    Public Property ApprovalLevel() As Integer
        Get
            Return _approvalLevel
        End Get
        Set(ByVal value As Integer)
            _approvalLevel = value
        End Set
    End Property

    Public Property Supervisor() As Integer
        Get
            Return _supervisorID
        End Get
        Set(ByVal value As Integer)
            _supervisorID = value
        End Set
    End Property

    Public Property Finalizer() As Integer
        Get
            Return _FinalizerID
        End Get
        Set(ByVal value As Integer)
            _finalizerID = value
        End Set
    End Property

    Public Property DelegatedTo() As Integer
        Get
            Return _delegateID
        End Get
        Set(ByVal value As Integer)
            _delegateID = value
        End Set
    End Property

    Public Property OrgID() As Integer
        Get
            Return _orgID
        End Get
        Set(ByVal value As Integer)
            _orgID = value
        End Set
    End Property

    Public Property ID() As Integer
        Get
            Return _id
        End Get
        Set(ByVal value As Integer)
            _id = value
        End Set
    End Property

    Public Property Title() As String
        Get
            Return _title
        End Get
        Set(ByVal value As String)
            _title = value
        End Set
    End Property

    Public Property IsAdvalorem() As Boolean
        Get
            Return _isAdvalorem
        End Get
        Set(ByVal value As Boolean)
            _isAdvalorem = value
        End Set
    End Property

    Public Property IsAdmin() As Boolean
        Get
            Return _isAdmin
        End Get
        Set(ByVal value As Boolean)
            _isAdmin = value
        End Set
    End Property

    Public Property Active() As Boolean
        Get
            Return _active
        End Get
        Set(ByVal value As Boolean)
            _active = value
        End Set
    End Property

    Public Property NotifyFinalized() As Boolean
        Get
            Return _notifyFinalized
        End Get
        Set(ByVal value As Boolean)
            _notifyFinalized = value
        End Set
    End Property

    Public Property IsSupervisor() As Boolean
        Get
            Return _isSupervisor
        End Get
        Set(ByVal value As Boolean)
            _isSupervisor = value
        End Set
    End Property

    Public Property IsAccountant() As Boolean
        Get
            Return _isAccountant
        End Get
        Set(ByVal value As Boolean)
            _isAccountant = value
        End Set
    End Property

    Public Property Username() As String
        Get
            Return _username
        End Get
        Set(ByVal value As String)
            _username = value
        End Set
    End Property

    Public Property FirstName() As String
        Get
            Return _firstname
        End Get
        Set(ByVal value As String)
            _firstname = value
        End Set
    End Property

    Public Property LastName() As String
        Get
            Return _lastname
        End Get
        Set(ByVal value As String)
            _lastname = value
        End Set
    End Property

    Public Sub New()
        Organization = New Org()
    End Sub

    Public Sub New(ID As Integer)
        GetConnectionString()
        Dim sqlConn = New SqlConnection(connString.ConnectionString)
        sqlConn.Open()

        Dim com As SqlCommand = New SqlCommand("GetEmployee", sqlConn)
        Dim rs As SqlDataReader

        com.CommandType = CommandType.StoredProcedure
        com.Parameters.Add(New SqlParameter("@ID", SqlDbType.VarChar)).Value = ID
        com.Connection = sqlConn
        rs = com.ExecuteReader

        Try
            While rs.Read
                Username = rs("USERNAME")
                IsAdmin = rs("IS_ADMIN")
                IsAdvalorem = rs("IS_ADVALOREM")
                IsSupervisor = rs("IS_SUPERVISOR")
                IsAccountant = rs("IS_ACCOUNTANT")
                TagEntry = rs("TAG_ENTRY")
                NotifyFinalized = rs("NOTIFY_FINALIZED")
                Active = rs("ACTIVE")
                Me.ID = rs("EMP_ID")
                Organization = New Org(CInt(rs("ORG_ID")))
                OrgID = rs("ORG_ID")
                FirstName = IIf(Not IsDBNull(rs("FIRST_NAME")), rs("FIRST_NAME"), "")
                LastName = rs("LAST_NAME")
                Email = rs("EMAIL")
                Title = IIf(Not IsDBNull(rs("TITLE")), rs("TITLE"), "")
                EmpNum = IIf(Not IsDBNull(rs("EMP_NUM")), rs("EMP_NUM"), "null")
                DivCode = IIf(Not IsDBNull(rs("DIV_CODE")), rs("DIV_CODE"), "null")
                Activated = rs("ACTIVATED")
                DefaultLanguage = rs("DEFAULT_LANG")
                LockDefaultProject = rs("LOCK_DEFAULT_PROJECT")

                If Not IsDBNull(rs("LOGIN_MESSAGE_IDS")) Then LoginMessageIDs = rs("LOGIN_MESSAGE_IDS")
                If Not IsDBNull(rs("DEFAULT_PROJECT_ID")) Then DefaultProject = New PWC(rs("DEFAULT_PROJECT_ID"))
                If Not IsDBNull(rs("SUPERVISOR_EMP_ID")) Then Supervisor = rs("SUPERVISOR_EMP_ID")
                If Not IsDBNull(rs("FINALIZER_EMP_ID")) Then Finalizer = rs("FINALIZER_EMP_ID")
                If Not IsDBNull(rs("DELEGATE_EMP_ID")) Then DelegatedTo = rs("DELEGATE_EMP_ID") Else DelegatedTo = 0
                If Not IsDBNull(rs("CREATED_DATE")) Then CreatedDate = rs("CREATED_DATE")
                ApprovalLevel = rs("APPROVAL_LEVEL")
            End While
        Catch ex As Exception
            Throw ex
        Finally
            rs.Close()
            com.Dispose()
            sqlConn.Close()
        End Try

        'GetReports()
        'GetReceipts()
        'HasUploadedReceipts = Receipts.Count > 0

    End Sub


    'Public Function GetUserByEmpNum(empNum As String, orgID As Integer) As Integer
    Public Function GetUserByEmpNum(empNum As String, orgID As Integer) As Integer
        Dim id As Integer = 0

        GetConnectionString()
        Dim sqlConn = New SqlConnection(connString.ConnectionString)
        sqlConn.Open()

        Dim com As SqlCommand = New SqlCommand("GetEmployeeByEmpNum", sqlConn)
        Dim rs As SqlDataReader

        com.CommandType = CommandType.StoredProcedure
        com.Parameters.Add(New SqlParameter("@OrgID", SqlDbType.Int)).Value = orgID
        com.Parameters.Add(New SqlParameter("@EmpNum", SqlDbType.NVarChar)).Value = empNum
        com.Connection = sqlConn
        rs = com.ExecuteReader

        While rs.Read
            id = rs("EMP_ID")
        End While

        rs.Close()
        com.Dispose()
        sqlConn.Close()

        Return id

    End Function


    Public Function GetUserIDByPwdToken(token As String) As Integer
        GetConnectionString()
        Dim sqlConn = New SqlConnection(connString.ConnectionString)
        sqlConn.Open()

        Dim com As SqlCommand = New SqlCommand("GetEmployeeByPwdToken", sqlConn)
        Dim rs As SqlDataReader

        com.CommandType = CommandType.StoredProcedure
        com.Parameters.Add(New SqlParameter("@token", SqlDbType.VarChar)).Value = token
        com.Connection = sqlConn
        rs = com.ExecuteReader

        While rs.Read
            Return rs("EMP_ID")
        End While

        rs.Close()
        com.Dispose()
        sqlConn.Close()
        com = Nothing
        sqlConn = Nothing
        rs = Nothing

    End Function


    Public Sub GetReports(Optional FinalizedOnly = False)
        GetConnectionString()
        On Error Resume Next
        Dim sqlConn = New SqlConnection(connString.ConnectionString)
        sqlConn.Open()

        Dim com As SqlCommand = New SqlCommand("GetReportsByEmpID", sqlConn)
        Dim rs As SqlDataReader
        Dim i As Integer

        com.CommandType = CommandType.StoredProcedure
        com.Parameters.Add(New SqlParameter("@EmpID", SqlDbType.VarChar)).Value = ID
        com.Connection = sqlConn
        rs = com.ExecuteReader

        While rs.Read
            ReDim Preserve Reports(i)
            Reports(i) = New Report(rs("REPORT_ID"))
            i = i + 1
        End While

        rs.Close()
        com.Dispose()
        sqlConn.Close()
    End Sub

    Public Sub New(ByVal username As String)
        GetConnectionString()
        Dim sqlConn = New SqlConnection(connString.ConnectionString)

        sqlConn.Open()

        Dim com As SqlCommand = New SqlCommand("GetEmployee", sqlConn)
        Dim rs As SqlDataReader

        com.CommandType = CommandType.StoredProcedure
        com.Parameters.Add(New SqlParameter("@Username", SqlDbType.VarChar)).Value = username
        com.Connection = sqlConn
        rs = com.ExecuteReader

        Try
            While rs.Read
                Me.Username = rs("USERNAME")
                IsAdmin = rs("IS_ADMIN")
                IsAdvalorem = rs("IS_ADVALOREM")
                IsSupervisor = rs("IS_SUPERVISOR")
                IsAccountant = rs("IS_ACCOUNTANT")
                TagEntry = rs("TAG_ENTRY")
                NotifyFinalized = rs("NOTIFY_FINALIZED")
                Active = rs("ACTIVE")
                Me.ID = rs("EMP_ID")
                Organization = New Org(CInt(rs("ORG_ID")))
                OrgID = rs("ORG_ID")
                FirstName = IIf(Not IsDBNull(rs("FIRST_NAME")), rs("FIRST_NAME"), "")
                LastName = rs("LAST_NAME")
                Email = rs("EMAIL")
                Title = IIf(Not IsDBNull(rs("TITLE")), rs("TITLE"), "")
                'Supervisor = rs("SUPERVISOR_EMP_ID")
                Activated = rs("ACTIVATED")
                DefaultLanguage = rs("DEFAULT_LANG")
                EmpNum = IIf(Not IsDBNull(rs("EMP_NUM")), rs("EMP_NUM"), "null")
                DivCode = IIf(Not IsDBNull(rs("DIV_CODE")), rs("DIV_CODE"), "null")
                If Not IsDBNull(rs("SUPERVISOR_EMP_ID")) Then Supervisor = rs("SUPERVISOR_EMP_ID")
                LockDefaultProject = rs("LOCK_DEFAULT_PROJECT")
                If Not IsDBNull(rs("LOGIN_MESSAGE_IDS")) Then LoginMessageIDs = rs("LOGIN_MESSAGE_IDS")
                If Not IsDBNull(rs("DEFAULT_PROJECT_ID")) Then DefaultProject = New PWC(rs("DEFAULT_PROJECT_ID"))
                If Not IsDBNull(rs("FINALIZER_EMP_ID")) Then Finalizer = rs("FINALIZER_EMP_ID")
                If Not IsDBNull(rs("DELEGATE_EMP_ID")) Then DelegatedTo = rs("DELEGATE_EMP_ID") Else DelegatedTo = 0
                If Not IsDBNull(rs("CREATED_DATE")) Then CreatedDate = rs("CREATED_DATE")
                ApprovalLevel = rs("APPROVAL_LEVEL")
            End While

        Catch ex As Exception
            Throw ex
        Finally
            rs.Close()            
            com.Dispose()
            sqlConn.Close()
            com = Nothing
            sqlConn = Nothing
            rs = Nothing
        End Try

        'GetReceipts()
        'HasUploadedReceipts = Receipts.Count > 0
    End Sub

    Public Sub SearchByUsername()

    End Sub


    Public Sub Create()
        GetConnectionString()
        Dim sqlConn = New SqlConnection(connString.ConnectionString)
        sqlConn.Open()
        Dim com As SqlCommand = New SqlCommand("CreateEmployee", sqlConn)

        com.CommandType = CommandType.StoredProcedure

        com.Parameters.Add(New SqlParameter("@FirstName", SqlDbType.NVarChar)).Value = FirstName
        com.Parameters.Add(New SqlParameter("@LastName", SqlDbType.NVarChar)).Value = LastName
        com.Parameters.Add(New SqlParameter("@OrgID", SqlDbType.Int)).Value = OrgID
        com.Parameters.Add(New SqlParameter("@Title", SqlDbType.NVarChar)).Value = Title
        com.Parameters.Add(New SqlParameter("@UserName", SqlDbType.NVarChar)).Value = Username
        com.Parameters.Add(New SqlParameter("@Email", SqlDbType.NVarChar)).Value = Email
        com.Parameters.Add(New SqlParameter("@Phone", SqlDbType.NVarChar)).Value = Phone
        com.Parameters.Add(New SqlParameter("@IsAdmin", SqlDbType.Bit)).Value = IsAdmin
        com.Parameters.Add(New SqlParameter("@IsAccountant", SqlDbType.Bit)).Value = 0
        com.Parameters.Add(New SqlParameter("@IsSupervisor", SqlDbType.Bit)).Value = IsSupervisor
        com.Parameters.Add(New SqlParameter("@IsAdvalorem", SqlDbType.Bit)).Value = IsAdvalorem
        com.Parameters.Add(New SqlParameter("@Notify", SqlDbType.Bit)).Value = NotifyFinalized
        com.Parameters.Add(New SqlParameter("@Supervisor", SqlDbType.Int)).Value = Supervisor
        com.Parameters.Add(New SqlParameter("@Finalizer", SqlDbType.Int)).Value = Finalizer
        com.Parameters.Add(New SqlParameter("@Delegate", SqlDbType.Int)).Value = DelegatedTo
        com.Parameters.Add(New SqlParameter("@EmpNum", SqlDbType.NVarChar)).Value = EmpNum
        com.Parameters.Add(New SqlParameter("@DivCode", SqlDbType.NVarChar)).Value = DivCode
        com.Parameters.Add(New SqlParameter("@CreatedDate", SqlDbType.Date)).Value = Now
        com.Parameters.Add(New SqlParameter("@Active", SqlDbType.Bit)).Value = True
        com.Parameters.Add(New SqlParameter("@TagEntry", SqlDbType.Bit)).Value = TagEntry
        com.Parameters.Add(New SqlParameter("@ApprovalLevel", SqlDbType.SmallInt)).Value = ApprovalLevel
        com.Parameters.Add(New SqlParameter("@LockDefaultProject", SqlDbType.Bit)).Value = LockDefaultProject
        If DefaultProject.ID <> 0 Then com.Parameters.Add(New SqlParameter("@DefaultProjectID", SqlDbType.Int)).Value = DefaultProject.ID

        com.Connection = sqlConn
        com.ExecuteNonQuery()

        com.Dispose()
        sqlConn.Close()
    End Sub

    Public Sub Update()
        GetConnectionString()
        Dim sqlConn = New SqlConnection(connString.ConnectionString)
        sqlConn.Open()
        Dim com As SqlCommand = New SqlCommand("UpdateEmployee", sqlConn)

        com.CommandType = CommandType.StoredProcedure

        com.Parameters.Add(New SqlParameter("@EmpID", SqlDbType.Int)).Value = ID
        com.Parameters.Add(New SqlParameter("@FirstName", SqlDbType.NVarChar)).Value = FirstName
        com.Parameters.Add(New SqlParameter("@LastName", SqlDbType.NVarChar)).Value = LastName
        com.Parameters.Add(New SqlParameter("@OrgID", SqlDbType.Int)).Value = OrgID
        com.Parameters.Add(New SqlParameter("@Title", SqlDbType.NVarChar)).Value = Title
        com.Parameters.Add(New SqlParameter("@Username", SqlDbType.NVarChar)).Value = Username
        com.Parameters.Add(New SqlParameter("@Email", SqlDbType.NVarChar)).Value = Email
        com.Parameters.Add(New SqlParameter("@Phone", SqlDbType.NVarChar)).Value = Phone
        com.Parameters.Add(New SqlParameter("@IsAdmin", SqlDbType.Bit)).Value = IsAdmin
        com.Parameters.Add(New SqlParameter("@IsAccountant", SqlDbType.Bit)).Value = IsAccountant
        com.Parameters.Add(New SqlParameter("@IsSupervisor", SqlDbType.Bit)).Value = IsSupervisor
        com.Parameters.Add(New SqlParameter("@Notify", SqlDbType.Bit)).Value = NotifyFinalized
        com.Parameters.Add(New SqlParameter("@Supervisor", SqlDbType.Int)).Value = Supervisor
        com.Parameters.Add(New SqlParameter("@Finalizer", SqlDbType.Int)).Value = Finalizer
        com.Parameters.Add(New SqlParameter("@Delegate", SqlDbType.Int)).Value = DelegatedTo
        com.Parameters.Add(New SqlParameter("@EmpNum", SqlDbType.NVarChar)).Value = EmpNum
        com.Parameters.Add(New SqlParameter("@DivCode", SqlDbType.NVarChar)).Value = DivCode
        com.Parameters.Add(New SqlParameter("@Activated", SqlDbType.Bit)).Value = Activated
        com.Parameters.Add(New SqlParameter("@PwdToken", SqlDbType.VarChar)).Value = PwdToken
        com.Parameters.Add(New SqlParameter("@DefaultLang", SqlDbType.VarChar)).Value = DefaultLanguage
        com.Parameters.Add(New SqlParameter("@TagEntry", SqlDbType.Bit)).Value = TagEntry
        com.Parameters.Add(New SqlParameter("@ApprovalLevel", SqlDbType.SmallInt)).Value = ApprovalLevel
        com.Parameters.Add(New SqlParameter("@LockDefaultProject", SqlDbType.Bit)).Value = LockDefaultProject
        If DefaultProject.ID <> 0 Then com.Parameters.Add(New SqlParameter("@DefaultProjectID", SqlDbType.Int)).Value = DefaultProject.ID
        com.Parameters.Add(New SqlParameter("@LoginMessageIDs", SqlDbType.VarChar)).Value = LoginMessageIDs

        com.Connection = sqlConn
        com.ExecuteNonQuery()

        com.Dispose()
        sqlConn.Close()
    End Sub


    Public Sub SetNotifyFinalized(notify As Boolean)
        GetConnectionString()
        Dim sqlConn = New SqlConnection(connString.ConnectionString)
        sqlConn.Open()
        Dim com As SqlCommand = New SqlCommand("SetNotifyFinalized", sqlConn)

        com.CommandType = CommandType.StoredProcedure

        com.Parameters.Add(New SqlParameter("@EmpID", SqlDbType.Int)).Value = ID
        com.Parameters.Add(New SqlParameter("@notify", SqlDbType.Bit)).Value = notify

        com.Connection = sqlConn
        com.ExecuteNonQuery()

        com.Dispose()
        sqlConn.Close()
    End Sub

    Public Sub SetActive(active As Boolean)
        GetConnectionString()
        Dim sqlConn = New SqlConnection(connString.ConnectionString)
        sqlConn.Open()
        Dim com As SqlCommand = New SqlCommand("SetActive", sqlConn)

        com.CommandType = CommandType.StoredProcedure

        com.Parameters.Add(New SqlParameter("@EmpID", SqlDbType.Int)).Value = ID
        com.Parameters.Add(New SqlParameter("@active", SqlDbType.Bit)).Value = active

        com.Connection = sqlConn
        com.ExecuteNonQuery()

        com.Dispose()
        sqlConn.Close()
    End Sub

    Public Sub SetSupervisor(isSuper As Boolean)
        GetConnectionString()
        Dim sqlConn = New SqlConnection(connString.ConnectionString)
        sqlConn.Open()
        Dim com As SqlCommand = New SqlCommand("SetSupervisor", sqlConn)

        com.CommandType = CommandType.StoredProcedure

        com.Parameters.Add(New SqlParameter("@EmpID", SqlDbType.Int)).Value = ID
        com.Parameters.Add(New SqlParameter("@IsSuper", SqlDbType.Bit)).Value = isSuper

        com.Connection = sqlConn
        com.ExecuteNonQuery()

        com.Dispose()
        sqlConn.Close()
    End Sub

    Public Sub SetFinalizer(ApprovalLevel As Integer)
        GetConnectionString()
        Dim sqlConn = New SqlConnection(connString.ConnectionString)
        sqlConn.Open()
        Dim com As SqlCommand = New SqlCommand("SetFinalizer", sqlConn)

        com.CommandType = CommandType.StoredProcedure

        com.Parameters.Add(New SqlParameter("@EmpID", SqlDbType.Int)).Value = ID
        com.Parameters.Add(New SqlParameter("@ApprovalLevel", SqlDbType.SmallInt)).Value = ApprovalLevel

        com.Connection = sqlConn
        com.ExecuteNonQuery()

        com.Dispose()
        sqlConn.Close()
    End Sub

    Public Sub SetAdmin(isAdmin As Boolean)
        GetConnectionString()
        Dim sqlConn = New SqlConnection(connString.ConnectionString)
        sqlConn.Open()
        Dim com As SqlCommand = New SqlCommand("SetAdmin", sqlConn)

        com.CommandType = CommandType.StoredProcedure

        com.Parameters.Add(New SqlParameter("@EmpID", SqlDbType.Int)).Value = ID
        com.Parameters.Add(New SqlParameter("@IsAdmin", SqlDbType.Bit)).Value = isAdmin

        com.Connection = sqlConn
        com.ExecuteNonQuery()

        com.Dispose()
        sqlConn.Close()
    End Sub

    Public Sub SetAccountant(isAcc As Boolean)
        GetConnectionString()
        Dim sqlConn = New SqlConnection(connString.ConnectionString)
        sqlConn.Open()
        Dim com As SqlCommand = New SqlCommand("SetAccountant", sqlConn)

        com.CommandType = CommandType.StoredProcedure

        com.Parameters.Add(New SqlParameter("@EmpID", SqlDbType.Int)).Value = ID
        com.Parameters.Add(New SqlParameter("@IsAcc", SqlDbType.Bit)).Value = isAcc

        com.Connection = sqlConn
        com.ExecuteNonQuery()

        com.Dispose()
        sqlConn.Close()
    End Sub

    Public Sub Delete()
        GetConnectionString()
        Dim sqlConn = New SqlConnection(connString.ConnectionString)
        sqlConn.Open()

        Dim com As SqlCommand = New SqlCommand("DeleteEmployee", sqlConn)

        com.CommandType = CommandType.StoredProcedure

        com.Parameters.Add(New SqlParameter("@EmpID", SqlDbType.Int)).Value = ID

        com.Connection = sqlConn
        com.ExecuteNonQuery()

        com.Dispose()
        sqlConn.Close()

    End Sub

    Public Sub GetLoginMessages()
        Dim iStart As Integer = 0
        Dim msgID As Integer

        LoginMessages.Clear()

        If _loginMessageIDs <> "" Then
            Do
                msgID = CInt(_loginMessageIDs.Substring(iStart, 4))

                LoginMessages.Add(msgID, "<span style='color:#cd1e1e;font-weight:bold;'>" & GetMessageTitle(msgID) & "</span> - " & GetMessage(msgID))
                iStart += 5
            Loop Until iStart > _loginMessageIDs.Length
        End If

    End Sub


    Public Sub GetReceipts()
        GetConnectionString()
        Dim sqlConn = New SqlConnection(connString.ConnectionString)
        Dim com As SqlCommand
        sqlConn.Open()

        com = New SqlCommand("GetReceipts", sqlConn)

        Dim rs As SqlDataReader
        Dim i As Integer = 1

        com.CommandType = CommandType.StoredProcedure
        com.Parameters.Add(New SqlParameter("@EmpID", SqlDbType.VarChar)).Value = ID
        com.Connection = sqlConn
        rs = com.ExecuteReader

        While rs.Read
            Receipts.Add(rs("ID"), "Receipt #" & i)
            i = i + 1
        End While

        rs.Close()
        com.Dispose()
        sqlConn.Close()
    End Sub
End Class
