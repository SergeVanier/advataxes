Imports System.Data
Imports System.Data.SqlClient

Public Class Org

    Public Const iFINALIZED As Integer = 4

    Private _id As Integer
    Private _retention As Integer
    Private _name As String
    Private _orgTypeID As Integer
    Private _jurID As Integer
    Private _GST As Integer
    Private _QST As Integer
    Private _forProfit As Boolean
    Private _GSTReg As Boolean
    Private _QSTReg As Boolean
    Private _orgSizeGST As Integer
    Private _orgSizeQST As Integer
    Private _commercial As Boolean
    Private _exempt As Boolean
    Private _gstRate As Decimal
    Private _qstRate As Decimal
    Private _address1 As String
    Private _address2 As String
    Private _calendarMatch As Boolean
    Private _numberOfPeriods As Integer
    Private _GSTDate As Date
    Private _QSTDate As Date
    Private _acctPayable As String
    Private _itcAcc As String
    Private _itrAcc As String
    Private _ritcONAcc As String
    Private _ritcBCAcc As String
    Private _ritcPEIAcc As String
    Private _firstMonth As Integer
    Private _interestRate As Single
    Private _orgCode As String
    Private _accountStatus As Integer
    Private _createdDate As Date
    Private _showWelcome As Boolean
    Private _active As Boolean
    Private _kmON As Single
    Private _kmBC As Single
    Private _kmPEI As Single
    Private _postal As String
    Private _empNum As Integer
    Private _city As String
    Private _countryID As Integer
    Private _countryName As String
    Private _displayProject As Boolean
    Private _displayWorkOrder As Boolean
    Private _displayCostCenter As Boolean
    Private _displayDivision As Boolean
    Private _accSegment As String
    Private _approvalLevel As Integer
    Private _isHideCurrency As Boolean

    Public ParentOrg As Org
    Public Jur As Jurisdiction
    Public Type As OrgType
    Public Reports As Report()
    Public Expenses As Expense()
    Public Employees As Employee()
    Public ChildOrgs As Org()
    Public Projects As PWC()
    Public CostCenters As PWC()
    Public WorkOrders As PWC()
    Public Divisions As PWC()
    Public Accounts As Account()
    Public Categories As OrgCat()

    'Public Function YearEnd(iYear As Integer) As Date
    '    DBConnect()

    '    Dim com As SqlCommand = New SqlCommand("GetYearEnd", sqlConn)
    '    Dim rs As SqlDataReader

    '    com.CommandType = CommandType.StoredProcedure
    '    com.Parameters.Add(New SqlParameter("@OrgID", SqlDbType.Int)).Value = ID
    '    com.Parameters.Add(New SqlParameter("@Year", SqlDbType.Int)).Value = iYear
    '    com.Connection = sqlConn
    '    rs = com.ExecuteReader


    '    While rs.Read
    '        YearEnd = rs(0)
    '    End While

    '    rs.Close()
    '    com.Dispose()
    '    sqlConn.Close()
    'End Function

    Public Property EmpNum() As Integer
        Get
            Return _empNum

        End Get
        Set(ByVal value As Integer)
            _empNum = value
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


    Public Property InterestRate() As Single
        Get
            Return _interestRate

        End Get
        Set(ByVal value As Single)
            _interestRate = value
        End Set
    End Property

    Public Property kmPEI() As Single
        Get
            Return _kmPEI

        End Get
        Set(ByVal value As Single)
            _kmPEI = value
        End Set
    End Property

    Public Property kmBC() As Single
        Get
            Return _kmBC

        End Get
        Set(ByVal value As Single)
            _kmBC = value
        End Set
    End Property

    Public Property kmON() As Single
        Get
            Return _kmON

        End Get
        Set(ByVal value As Single)
            _kmON = value
        End Set
    End Property

    Public Property AccSegment() As String
        Get
            Return _accSegment

        End Get
        Set(ByVal value As String)
            _accSegment = value
        End Set
    End Property


    Public Property Code() As String
        Get
            Return _orgCode

        End Get
        Set(ByVal value As String)
            _orgCode = value
        End Set
    End Property

    Public Property CountryName() As String
        Get
            Return _countryName

        End Get
        Set(ByVal value As String)
            _countryName = value
        End Set
    End Property


    Public Property Postal() As String
        Get
            Return _postal

        End Get
        Set(ByVal value As String)
            _postal = value
        End Set
    End Property

    Public Property CountryID() As Integer
        Get
            Return _countryID

        End Get
        Set(ByVal value As Integer)
            _countryID = value
        End Set
    End Property


    Public Property AccountStatus() As Integer
        Get
            Return _accountStatus

        End Get
        Set(ByVal value As Integer)
            _accountStatus = value
        End Set
    End Property

    Public Property FirstMonth() As Integer
        Get
            Return _firstMonth

        End Get
        Set(ByVal value As Integer)
            _firstMonth = value
        End Set
    End Property

    Public Property NumberOfPeriods() As Integer
        Get
            Return _numberOfPeriods

        End Get
        Set(ByVal value As Integer)
            _numberOfPeriods = value
        End Set
    End Property

    Public Property QSTDate() As Date
        Get
            Return _QSTDate
        End Get
        Set(ByVal value As Date)
            _QSTDate = value
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

    Public Property GSTDate() As Date
        Get
            Return _GSTDate
        End Get
        Set(ByVal value As Date)
            _GSTDate = value
        End Set
    End Property

    Public Property ritcPEIAccount() As String
        Get
            Return _ritcPEIAcc
        End Get
        Set(ByVal value As String)
            _ritcPEIAcc = value
        End Set
    End Property

    Public Property City() As String
        Get
            Return _city
        End Get
        Set(ByVal value As String)
            _city = value
        End Set
    End Property

    Public Property ritcONAccount() As String
        Get
            Return _ritcONAcc
        End Get
        Set(ByVal value As String)
            _ritcONAcc = value
        End Set
    End Property

    Public Property ritcBCAccount() As String
        Get
            Return _ritcBCAcc
        End Get
        Set(ByVal value As String)
            _ritcBCAcc = value
        End Set
    End Property


    Public Property ITRAccount() As String
        Get
            Return _itrAcc
        End Get
        Set(ByVal value As String)
            _itrAcc = value
        End Set
    End Property

    Public Property ITCAccount() As String
        Get
            Return _itcAcc
        End Get
        Set(ByVal value As String)
            _itcAcc = value
        End Set
    End Property

    Public Property AccountPayable() As String
        Get
            Return _acctPayable
        End Get
        Set(ByVal value As String)
            _acctPayable = value
        End Set
    End Property

    Public Property Address2() As String
        Get
            Return _address2
        End Get
        Set(ByVal value As String)
            _address2 = value
        End Set
    End Property

    Public Property Address1() As String
        Get
            Return _address1
        End Get
        Set(ByVal value As String)
            _address1 = value
        End Set
    End Property

    Public Property QSTRate() As Decimal
        Get
            Return _qstRate
        End Get
        Set(ByVal value As Decimal)
            _qstRate = value
        End Set
    End Property


    Public Property GSTRate() As Decimal
        Get
            Return _gstRate
        End Get
        Set(ByVal value As Decimal)
            _gstRate = value
        End Set
    End Property

    Public Property Exempt() As Boolean
        Get
            Return _exempt
        End Get
        Set(ByVal value As Boolean)
            _exempt = value
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

    Public Property CalendarMatch() As Boolean
        Get
            Return _calendarMatch
        End Get
        Set(ByVal value As Boolean)
            _calendarmatch = value
        End Set
    End Property

    Public Property DisplayProject() As Boolean
        Get
            Return _displayProject
        End Get
        Set(ByVal value As Boolean)
            _displayProject = value
        End Set
    End Property

    Public Property DisplayWorkOrder() As Boolean
        Get
            Return _displayWorkOrder
        End Get
        Set(ByVal value As Boolean)
            _displayWorkOrder = value
        End Set
    End Property

    Public Property DisplayCostCenter() As Boolean
        Get
            Return _displayCostCenter
        End Get
        Set(ByVal value As Boolean)
            _displayCostCenter = value
        End Set
    End Property

    Public Property DisplayDivision() As Boolean
        Get
            Return _displayDivision
        End Get
        Set(ByVal value As Boolean)
            _displayDivision = value
        End Set
    End Property

    Public Property Commercial() As Boolean
        Get
            Return _commercial
        End Get
        Set(ByVal value As Boolean)
            _commercial = value
        End Set
    End Property

    Public Property ShowWelcome() As Boolean
        Get
            Return _showWelcome
        End Get
        Set(ByVal value As Boolean)
            _showWelcome = value
        End Set
    End Property

    Public Property OrgSizeGST() As Integer
        Get
            Return _orgSizeGST
        End Get
        Set(ByVal value As Integer)
            _orgSizeGST = value
        End Set
    End Property

    Public Property OrgSizeQST() As Integer
        Get
            Return _orgSizeQST
        End Get
        Set(ByVal value As Integer)
            _orgSizeQST = value
        End Set
    End Property

    Public Property QSTReg() As Boolean
        Get
            Return _QSTReg
        End Get
        Set(ByVal value As Boolean)
            _QSTReg = value
        End Set
    End Property

    Public Property GSTReg() As Boolean
        Get
            Return _GSTReg
        End Get
        Set(ByVal value As Boolean)
            _GSTReg = value
        End Set
    End Property


    Public Property ForProfit() As Boolean
        Get
            Return _forProfit
        End Get
        Set(ByVal value As Boolean)
            _forProfit = value
        End Set
    End Property


    Public Property QST() As Integer
        Get
            Return _QST
        End Get
        Set(ByVal value As Integer)
            _QST = value
        End Set
    End Property


    Public Property GST() As Integer
        Get
            Return _GST
        End Get
        Set(ByVal value As Integer)
            _GST = value
        End Set
    End Property


    Public Property OrgTypeID() As Integer
        Get
            Return _orgTypeID
        End Get
        Set(ByVal value As Integer)
            _orgTypeID = value
        End Set
    End Property

    Public Property JurID() As Integer
        Get
            Return _jurID
        End Get
        Set(ByVal value As Integer)
            _jurID = value
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


    Public Property Retention() As Integer
        Get
            Return _retention
        End Get
        Set(ByVal value As Integer)
            _retention = value
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


    Public Property Parent() As Org
        Get
            If IsNothing(ParentOrg) Then
                Return Me
            Else
                Return ParentOrg
            End If
        End Get

        Set(ByVal value As Org)
            ParentOrg = value
        End Set

    End Property

    Public Property IsHideCurrency() As Boolean
        Get
            Return _isHideCurrency
        End Get
        Set(ByVal value As Boolean)
            _isHideCurrency = value
        End Set
    End Property


    Public Sub Create()
        GetConnectionString()
        Dim sqlConn = New SqlConnection(connString.ConnectionString)
        Dim parentID As Integer
        sqlConn.Open()

        Dim com As SqlCommand = New SqlCommand("CreateOrg", sqlConn)

        If IsNothing(ParentOrg) Then
            parentID = 0
        Else
            parentID = ParentOrg.ID
        End If

        com.CommandType = CommandType.StoredProcedure

        com.Parameters.Add(New SqlParameter("@Name", SqlDbType.NVarChar)).Value = Name
        com.Parameters.Add(New SqlParameter("@Retention", SqlDbType.Int)).Value = Retention
        com.Parameters.Add(New SqlParameter("@OrgTypeID", SqlDbType.Int)).Value = OrgTypeID
        com.Parameters.Add(New SqlParameter("@Address1", SqlDbType.NVarChar)).Value = Address1
        com.Parameters.Add(New SqlParameter("@Address2", SqlDbType.NVarChar)).Value = Address2
        com.Parameters.Add(New SqlParameter("@JurID", SqlDbType.Int)).Value = JurID
        com.Parameters.Add(New SqlParameter("@ForProfit", SqlDbType.Bit)).Value = ForProfit
        com.Parameters.Add(New SqlParameter("@GSTRegistrant", SqlDbType.Bit)).Value = GSTReg
        com.Parameters.Add(New SqlParameter("@QSTRegistrant", SqlDbType.Bit)).Value = QSTReg
        com.Parameters.Add(New SqlParameter("@GST", SqlDbType.NVarChar)).Value = GST
        com.Parameters.Add(New SqlParameter("@QST", SqlDbType.NVarChar)).Value = QST
        com.Parameters.Add(New SqlParameter("@LargeGST", SqlDbType.SmallInt)).Value = OrgSizeGST
        com.Parameters.Add(New SqlParameter("@LargeQST", SqlDbType.SmallInt)).Value = OrgSizeQST
        com.Parameters.Add(New SqlParameter("@Commercial", SqlDbType.Bit)).Value = Commercial
        com.Parameters.Add(New SqlParameter("@Exempt", SqlDbType.Bit)).Value = Exempt
        com.Parameters.Add(New SqlParameter("@GSTRate", SqlDbType.Float)).Value = IIf(GSTRate > 1, GSTRate / 100, GSTRate)
        com.Parameters.Add(New SqlParameter("@QSTRate", SqlDbType.Float)).Value = IIf(QSTRate > 1, QSTRate / 100, QSTRate)
        com.Parameters.Add(New SqlParameter("@GSTDate", SqlDbType.Date)).Value = GSTDate
        com.Parameters.Add(New SqlParameter("@QSTDate", SqlDbType.Date)).Value = QSTDate
        com.Parameters.Add(New SqlParameter("@ParentOrg", SqlDbType.Int)).Value = parentID
        com.Parameters.Add(New SqlParameter("@FirstMonth", SqlDbType.SmallInt)).Value = FirstMonth
        com.Parameters.Add(New SqlParameter("@NumOfPeriods", SqlDbType.SmallInt)).Value = NumberOfPeriods
        com.Parameters.Add(New SqlParameter("@InterestRate", SqlDbType.Money)).Value = InterestRate
        com.Parameters.Add(New SqlParameter("@OrgCode", SqlDbType.NVarChar)).Value = Code
        com.Parameters.Add(New SqlParameter("@DateCreated", SqlDbType.Date)).Value = Now
        com.Parameters.Add(New SqlParameter("@AccountStatus", SqlDbType.Int)).Value = AccountStatus
        com.Parameters.Add(New SqlParameter("@kmON", SqlDbType.Float)).Value = kmON
        com.Parameters.Add(New SqlParameter("@kmBC", SqlDbType.Float)).Value = kmBC
        com.Parameters.Add(New SqlParameter("@kmPEI", SqlDbType.Float)).Value = kmPEI
        com.Parameters.Add(New SqlParameter("@Postal", SqlDbType.NVarChar)).Value = Postal
        com.Parameters.Add(New SqlParameter("@EmpNum", SqlDbType.Int)).Value = EmpNum
        com.Parameters.Add(New SqlParameter("@City", SqlDbType.NVarChar)).Value = City
        com.Parameters.Add(New SqlParameter("@CountryID", SqlDbType.Int)).Value = CountryID
        com.Connection = sqlConn
        com.ExecuteNonQuery()

        com.Dispose()
        sqlConn.Close()
    End Sub


    Public Sub Update()
        GetConnectionString()
        Dim sqlConn = New SqlConnection(connString.ConnectionString)
        sqlConn.Open()
        Dim com As SqlCommand = New SqlCommand("UpdateOrg", sqlConn)

        com.CommandType = CommandType.StoredProcedure

        com.Parameters.Add(New SqlParameter("@OrgID", SqlDbType.Int)).Value = ID
        com.Parameters.Add(New SqlParameter("@Retention", SqlDbType.Int)).Value = Retention
        com.Parameters.Add(New SqlParameter("@OrgName", SqlDbType.NVarChar)).Value = Name
        com.Parameters.Add(New SqlParameter("@OrgTypeID", SqlDbType.Int)).Value = OrgTypeID
        com.Parameters.Add(New SqlParameter("@Address1", SqlDbType.NVarChar)).Value = Address1
        com.Parameters.Add(New SqlParameter("@Address2", SqlDbType.NVarChar)).Value = Address2
        com.Parameters.Add(New SqlParameter("@JurID", SqlDbType.Int)).Value = JurID
        com.Parameters.Add(New SqlParameter("@ForProfit", SqlDbType.Bit)).Value = ForProfit
        com.Parameters.Add(New SqlParameter("@GSTRegistrant", SqlDbType.Bit)).Value = GSTReg
        com.Parameters.Add(New SqlParameter("@QSTRegistrant", SqlDbType.Bit)).Value = QSTReg
        com.Parameters.Add(New SqlParameter("@GST", SqlDbType.Int)).Value = GST
        com.Parameters.Add(New SqlParameter("@QST", SqlDbType.Int)).Value = QST
        com.Parameters.Add(New SqlParameter("@LargeGST", SqlDbType.Int)).Value = OrgSizeGST
        com.Parameters.Add(New SqlParameter("@LargeQST", SqlDbType.Int)).Value = OrgSizeQST
        com.Parameters.Add(New SqlParameter("@Commercial", SqlDbType.Bit)).Value = Commercial
        com.Parameters.Add(New SqlParameter("@Exempt", SqlDbType.Bit)).Value = Exempt
        com.Parameters.Add(New SqlParameter("@GSTRate", SqlDbType.Float)).Value = IIf(GSTRate > 1, GSTRate / 100, GSTRate)
        com.Parameters.Add(New SqlParameter("@QSTRate", SqlDbType.Float)).Value = IIf(QSTRate > 1, QSTRate / 100, QSTRate)
        com.Parameters.Add(New SqlParameter("@GSTDate", SqlDbType.Date)).Value = GSTDate
        com.Parameters.Add(New SqlParameter("@QSTDate", SqlDbType.Date)).Value = QSTDate
        com.Parameters.Add(New SqlParameter("@AcctPayable", SqlDbType.NVarChar)).Value = AccountPayable
        com.Parameters.Add(New SqlParameter("@ITCAcc", SqlDbType.NVarChar)).Value = ITCAccount
        com.Parameters.Add(New SqlParameter("@ITRAcc", SqlDbType.NVarChar)).Value = ITRAccount
        com.Parameters.Add(New SqlParameter("@RITCBCAcc", SqlDbType.NVarChar)).Value = ritcBCAccount
        com.Parameters.Add(New SqlParameter("@RITCONAcc", SqlDbType.NVarChar)).Value = ritcONAccount
        com.Parameters.Add(New SqlParameter("@RITCPEIAcc", SqlDbType.NVarChar)).Value = ritcPEIAccount
        com.Parameters.Add(New SqlParameter("@FirstMonth", SqlDbType.SmallInt)).Value = FirstMonth
        com.Parameters.Add(New SqlParameter("@NumOfPeriods", SqlDbType.SmallInt)).Value = NumberOfPeriods
        com.Parameters.Add(New SqlParameter("@InterestRate", SqlDbType.Money)).Value = InterestRate
        com.Parameters.Add(New SqlParameter("@OrgCode", SqlDbType.NVarChar)).Value = Code
        com.Parameters.Add(New SqlParameter("@ShowWelcome", SqlDbType.Bit)).Value = ShowWelcome
        com.Parameters.Add(New SqlParameter("@AccountStatus", SqlDbType.Int)).Value = AccountStatus
        com.Parameters.Add(New SqlParameter("@Postal", SqlDbType.NVarChar)).Value = Postal
        com.Parameters.Add(New SqlParameter("@EmpNum", SqlDbType.Int)).Value = EmpNum
        com.Parameters.Add(New SqlParameter("@City", SqlDbType.NVarChar)).Value = City
        com.Parameters.Add(New SqlParameter("@DisplayWorkOrder", SqlDbType.Bit)).Value = DisplayWorkOrder
        com.Parameters.Add(New SqlParameter("@DisplayProject", SqlDbType.Bit)).Value = DisplayProject
        com.Parameters.Add(New SqlParameter("@DisplayCostCenter", SqlDbType.Bit)).Value = DisplayCostCenter
        com.Parameters.Add(New SqlParameter("@DisplayDivision", SqlDbType.Bit)).Value = DisplayDivision
        com.Parameters.Add(New SqlParameter("@AccSeg", SqlDbType.VarChar)).Value = AccSegment
        com.Parameters.Add(New SqlParameter("@kmON", SqlDbType.Float)).Value = kmON
        com.Parameters.Add(New SqlParameter("@kmBC", SqlDbType.Float)).Value = kmBC
        com.Parameters.Add(New SqlParameter("@kmPEI", SqlDbType.Float)).Value = kmPEI
        com.Parameters.Add(New SqlParameter("@CalendarMatch", SqlDbType.Bit)).Value = CalendarMatch
        com.Parameters.Add(New SqlParameter("@ApprovalLevel", SqlDbType.Int)).Value = ApprovalLevel

        com.Connection = sqlConn
        com.ExecuteNonQuery()

        com.Dispose()
        sqlConn.Close()
    End Sub

    Public Sub New()

    End Sub

    Public Sub New(Name As String)
        GetConnectionString()
        Me.Name = Name
        Dim sqlConn = New SqlConnection(connString.ConnectionString)
        sqlConn.Open()

        Dim com As SqlCommand = New SqlCommand("GetOrgByName", sqlConn)
        Dim rs As SqlDataReader

        com.CommandType = CommandType.StoredProcedure
        com.Parameters.Add(New SqlParameter("@Name", SqlDbType.VarChar)).Value = Name
        com.Connection = sqlConn
        rs = com.ExecuteReader

        While rs.Read
            Me.ID = rs("ORG_ID")
            If Not IsDBNull(rs("RETENTION")) Then Retention = rs("RETENTION")
            Me.Name = rs("ORG_NAME")
            If Not IsDBNull(rs("Org_TYPE_ID")) Then
                OrgTypeID = rs("Org_TYPE_ID")
                Type = New OrgType(OrgTypeID)
            End If

            If Not IsDBNull(rs("JUR_ID")) Then
                JurID = rs("JUR_ID")
                Jur = New Jurisdiction(JurID)
            End If

            If rs("PARENT_ORG") <> 0 Then ParentOrg = New Org(CInt(rs("PARENT_ORG")))

            If Not IsDBNull(rs("GST")) Then GST = rs("GST")
            If Not IsDBNull(rs("QST")) Then QST = rs("QST")
            If Not IsDBNull(rs("FOR_PROFIT")) Then ForProfit = rs("FOR_PROFIT")
            If Not IsDBNull(rs("GST_REGISTRANT")) Then GSTReg = rs("GST_REGISTRANT")
            If Not IsDBNull(rs("QST_REGISTRANT")) Then QSTReg = rs("QST_REGISTRANT")
            If Not IsDBNull(rs("ORG_SIZE_GST")) Then OrgSizeGST = rs("ORG_SIZE_GST")
            If Not IsDBNull(rs("ORG_SIZE_QST")) Then OrgSizeQST = rs("ORG_SIZE_QST")
            If Not IsDBNull(rs("COMMERCIAL")) Then Commercial = rs("COMMERCIAL")
            If Not IsDBNull(rs("EXEMPT")) Then Exempt = rs("EXEMPT")
            If Not IsDBNull(rs("GST_RATE")) Then GSTRate = rs("GST_RATE")
            If Not IsDBNull(rs("QST_RATE")) Then QSTRate = rs("QST_RATE")
            If Not IsDBNull(rs("ADDRESS_1")) Then Address1 = rs("ADDRESS_1")
            If Not IsDBNull(rs("ADDRESS_2")) Then Address2 = rs("ADDRESS_2")
            If Not IsDBNull(rs("GST_DATE")) Then GSTDate = rs("GST_DATE")
            If Not IsDBNull(rs("QST_DATE")) Then QSTDate = rs("QST_DATE")
            If Not IsDBNull(rs("DATE_CREATED")) Then CreatedDate = rs("DATE_CREATED")
            If Not IsDBNull(rs("ACCT_PAYABLE")) Then AccountPayable = rs("ACCT_PAYABLE")
            If Not IsDBNull(rs("ITC_ACC")) Then ITCAccount = rs("ITC_ACC")
            If Not IsDBNull(rs("ITR_ACC")) Then ITRAccount = rs("ITR_ACC")
            If Not IsDBNull(rs("RITC_ON_ACC")) Then ritcONAccount = rs("RITC_ON_ACC")
            If Not IsDBNull(rs("RITC_BC_ACC")) Then ritcBCAccount = rs("RITC_BC_ACC")
            If Not IsDBNull(rs("RITC_PEI_ACC")) Then ritcPEIAccount = rs("RITC_PEI_ACC")
            If Not IsDBNull(rs("NUM_OF_PERIODS")) Then NumberOfPeriods = rs("NUM_OF_PERIODS")
            If Not IsDBNull(rs("FIRST_MONTH")) Then FirstMonth = rs("FIRST_MONTH")
            If Not IsDBNull(rs("CALENDAR_MATCH")) Then CalendarMatch = rs("CALENDAR_MATCH")
            If Not IsDBNull(rs("INTEREST_RATE")) Then InterestRate = rs("INTEREST_RATE")
            If Not IsDBNull(rs("ORG_CODE")) Then Code = rs("ORG_CODE")
            If Not IsDBNull(rs("ACCOUNT_STATUS")) Then AccountStatus = rs("ACCOUNT_STATUS")
            If Not IsDBNull(rs("SHOW_WELCOME")) Then ShowWelcome = rs("SHOW_WELCOME") Else ShowWelcome = True
            If Not IsDBNull(rs("ACTIVE")) Then Active = rs("ACTIVE") Else Active = True
            If Not IsDBNull(rs("KM_ON")) Then kmON = rs("KM_ON")
            If Not IsDBNull(rs("KM_BC")) Then kmBC = rs("KM_BC")
            If Not IsDBNull(rs("KM_PEI")) Then kmPEI = rs("KM_PEI")
            If Not IsDBNull(rs("POSTAL")) Then Postal = rs("POSTAL")
            If Not IsDBNull(rs("EMP_NUM")) Then EmpNum = rs("EMP_NUM")
            If Not IsDBNull(rs("CITY")) Then City = rs("CITY")
            If Not IsDBNull(rs("COUNTRY_ID")) Then CountryID = rs("COUNTRY_ID")
            If Not IsDBNull(rs("COUNTRY_NAME")) Then CountryName = rs("COUNTRY_NAME")
            If Not IsDBNull(rs("DISPLAY_WORK_ORDER")) Then DisplayWorkOrder = rs("DISPLAY_WORK_ORDER")
            If Not IsDBNull(rs("DISPLAY_COST_CENTER")) Then DisplayCostCenter = rs("DISPLAY_COST_CENTER")
            If Not IsDBNull(rs("DISPLAY_PROJECT")) Then DisplayProject = rs("DISPLAY_PROJECT")
            If Not IsDBNull(rs("DISPLAY_DIVISION")) Then DisplayDivision = rs("DISPLAY_DIVISION")
            If Not IsDBNull(rs("ACC_SEGMENT")) Then AccSegment = rs("ACC_SEGMENT")
            If Not IsDBNull(rs("APPROVAL_LEVEL")) Then ApprovalLevel = rs("APPROVAL_LEVEL")
            'GetReports()
        End While

        rs.Close()
        com.Dispose()
        sqlConn.Close()
    End Sub

    Public Sub New(OrgID As Integer)
        GetConnectionString()
        Dim sqlConn = New SqlConnection(connString.ConnectionString)
        sqlConn.Open()

        Me.ID = OrgID
        Dim com As SqlCommand = New SqlCommand("GetOrgByID", sqlConn)
        Dim rs As SqlDataReader

        com.CommandType = CommandType.StoredProcedure
        com.Parameters.Add(New SqlParameter("@OrgID", SqlDbType.VarChar)).Value = ID
        com.Connection = sqlConn
        rs = com.ExecuteReader

        While rs.Read
            If Not IsDBNull(rs("RETENTION")) Then Retention = rs("RETENTION")
            Name = rs("ORG_NAME")
            If Not IsDBNull(rs("Org_TYPE_ID")) Then
                OrgTypeID = rs("Org_TYPE_ID")
                Type = New OrgType(OrgTypeID)
            End If

            If Not IsDBNull(rs("JUR_ID")) Then
                JurID = rs("JUR_ID")
                Jur = New Jurisdiction(JurID)
            End If

            If rs("PARENT_ORG") <> 0 Then ParentOrg = New Org(CInt(rs("PARENT_ORG")))

            If Not IsDBNull(rs("GST")) Then GST = rs("GST")
            If Not IsDBNull(rs("QST")) Then QST = rs("QST")
            If Not IsDBNull(rs("FOR_PROFIT")) Then ForProfit = rs("FOR_PROFIT")
            If Not IsDBNull(rs("GST_REGISTRANT")) Then GSTReg = rs("GST_REGISTRANT")
            If Not IsDBNull(rs("QST_REGISTRANT")) Then QSTReg = rs("QST_REGISTRANT")
            If Not IsDBNull(rs("ORG_SIZE_GST")) Then OrgSizeGST = rs("ORG_SIZE_GST")
            If Not IsDBNull(rs("ORG_SIZE_QST")) Then OrgSizeQST = rs("ORG_SIZE_QST")
            If Not IsDBNull(rs("COMMERCIAL")) Then Commercial = rs("COMMERCIAL")
            If Not IsDBNull(rs("EXEMPT")) Then Exempt = rs("EXEMPT")
            If Not IsDBNull(rs("GST_RATE")) Then GSTRate = rs("GST_RATE")
            If Not IsDBNull(rs("QST_RATE")) Then QSTRate = rs("QST_RATE")
            If Not IsDBNull(rs("ADDRESS_1")) Then Address1 = rs("ADDRESS_1")
            If Not IsDBNull(rs("ADDRESS_2")) Then Address2 = rs("ADDRESS_2")
            If Not IsDBNull(rs("GST_DATE")) Then GSTDate = rs("GST_DATE")
            If Not IsDBNull(rs("QST_DATE")) Then QSTDate = rs("QST_DATE")
            If Not IsDBNull(rs("DATE_CREATED")) Then CreatedDate = rs("DATE_CREATED")
            If Not IsDBNull(rs("ACCT_PAYABLE")) Then AccountPayable = rs("ACCT_PAYABLE")
            If Not IsDBNull(rs("ITC_ACC")) Then ITCAccount = rs("ITC_ACC")
            If Not IsDBNull(rs("ITR_ACC")) Then ITRAccount = rs("ITR_ACC")
            If Not IsDBNull(rs("RITC_ON_ACC")) Then ritcONAccount = rs("RITC_ON_ACC")
            If Not IsDBNull(rs("RITC_BC_ACC")) Then ritcBCAccount = rs("RITC_BC_ACC")
            If Not IsDBNull(rs("RITC_PEI_ACC")) Then ritcPEIAccount = rs("RITC_PEI_ACC")
            If Not IsDBNull(rs("NUM_OF_PERIODS")) Then NumberOfPeriods = rs("NUM_OF_PERIODS")
            If Not IsDBNull(rs("FIRST_MONTH")) Then FirstMonth = rs("FIRST_MONTH")
            If Not IsDBNull(rs("CALENDAR_MATCH")) Then CalendarMatch = rs("CALENDAR_MATCH")
            If Not IsDBNull(rs("INTEREST_RATE")) Then InterestRate = rs("INTEREST_RATE")
            If Not IsDBNull(rs("ORG_CODE")) Then Code = rs("ORG_CODE")
            If Not IsDBNull(rs("ACCOUNT_STATUS")) Then AccountStatus = rs("ACCOUNT_STATUS")
            If Not IsDBNull(rs("SHOW_WELCOME")) Then ShowWelcome = rs("SHOW_WELCOME") Else ShowWelcome = True
            If Not IsDBNull(rs("ACTIVE")) Then Active = rs("ACTIVE") Else Active = True
            If Not IsDBNull(rs("KM_ON")) Then kmON = rs("KM_ON")
            If Not IsDBNull(rs("KM_BC")) Then kmBC = rs("KM_BC")
            If Not IsDBNull(rs("KM_PEI")) Then kmPEI = rs("KM_PEI")
            If Not IsDBNull(rs("POSTAL")) Then Postal = rs("POSTAL")
            If Not IsDBNull(rs("EMP_NUM")) Then EmpNum = rs("EMP_NUM")
            If Not IsDBNull(rs("CITY")) Then City = rs("CITY")
            If Not IsDBNull(rs("COUNTRY_ID")) Then CountryID = rs("COUNTRY_ID")
            If Not IsDBNull(rs("COUNTRY_NAME")) Then CountryName = rs("COUNTRY_NAME")
            If Not IsDBNull(rs("DISPLAY_WORK_ORDER")) Then DisplayWorkOrder = rs("DISPLAY_WORK_ORDER")
            If Not IsDBNull(rs("DISPLAY_COST_CENTER")) Then DisplayCostCenter = rs("DISPLAY_COST_CENTER")
            If Not IsDBNull(rs("DISPLAY_PROJECT")) Then DisplayProject = rs("DISPLAY_PROJECT")
            If Not IsDBNull(rs("DISPLAY_DIVISION")) Then DisplayDivision = rs("DISPLAY_DIVISION")
            If Not IsDBNull(rs("ACC_SEGMENT")) Then AccSegment = rs("ACC_SEGMENT")
            If Not IsDBNull(rs("APPROVAL_LEVEL")) Then ApprovalLevel = rs("APPROVAL_LEVEL")

            'GetChildOrgs()
            'GetEmployees()
        End While

        sqlConn.Close()
        com.Dispose()
        rs.Close()
    End Sub

    Public Sub GetChildOrgs()
        GetConnectionString()
        On Error Resume Next
        Dim sqlConn = New SqlConnection(connString.ConnectionString)
        sqlConn.Open()

        Dim com As SqlCommand = New SqlCommand("GetOrgs", sqlConn)
        Dim rs As SqlDataReader
        Dim i As Integer

        com.CommandType = CommandType.StoredProcedure
        com.Parameters.Add(New SqlParameter("@OrgID", SqlDbType.VarChar)).Value = ID
        com.Connection = sqlConn
        rs = com.ExecuteReader

        While rs.Read
            If rs("PARENT_ORG") <> 0 Then
                ReDim Preserve ChildOrgs(i)
                ChildOrgs(i) = New Org(CInt(rs("ORG_ID")))
                i += 1
            End If
        End While

        rs.Close()
        com.Dispose()
        sqlConn.Close()
    End Sub

    Private Sub GetPWC(type As String)
        GetConnectionString()
        On Error Resume Next
        Dim sqlConn = New SqlConnection(connString.ConnectionString)
        sqlConn.Open()

        Dim com As SqlCommand = New SqlCommand("GetPWCByOrg", sqlConn)
        Dim rs As SqlDataReader
        Dim i As Integer

        com.CommandType = CommandType.StoredProcedure
        com.Parameters.Add(New SqlParameter("@OrgID", SqlDbType.VarChar)).Value = ID
        com.Parameters.Add(New SqlParameter("@pwcType", SqlDbType.VarChar)).Value = type

        com.Connection = sqlConn
        rs = com.ExecuteReader

        While rs.Read
            If type = "P" Then 'type is project 
                ReDim Preserve Projects(i)
                Projects(i) = New PWC(CInt(rs("PWC_ID")))
                i += 1

            ElseIf type = "W" Then 'type is workorder
                'to be completed
            ElseIf type = "C" Then 'type is cost center
                'to be completed
            ElseIf type = "D" Then 'type is division
                'to be completed
            End If

        End While

        rs.Close()
        com.Dispose()
        sqlConn.Close()
    End Sub

    Public Sub GetCategories()
        GetConnectionString()
        Dim loggedInUser As New Employee(Membership.GetUser.UserName)
        Dim sqlConn = New SqlConnection(connString.ConnectionString)
        sqlConn.Open()

        Dim com As SqlCommand = New SqlCommand("GetOrgCategories", sqlConn)
        Dim rs As SqlDataReader
        Dim i As Integer

        com.CommandType = CommandType.StoredProcedure
        com.Parameters.Add(New SqlParameter("@OrgID", SqlDbType.VarChar)).Value = ID
        com.Parameters.Add(New SqlParameter("@Language", SqlDbType.VarChar)).Value = loggedInUser.DefaultLanguage

        com.Connection = sqlConn
        rs = com.ExecuteReader

        While rs.Read
            ReDim Preserve Categories(i)
            Categories(i) = New OrgCat(CInt(rs("ORG_CAT_ID")))
            i += 1
        End While

        loggedInUser = Nothing
        rs.Close()
        com.Dispose()
        sqlConn.Close()
    End Sub

    Public Sub GetAccounts()
        GetConnectionString()
        On Error Resume Next
        Dim sqlConn = New SqlConnection(connString.ConnectionString)
        sqlConn.Open()

        Dim com As SqlCommand = New SqlCommand("GetAccounts", sqlConn)
        Dim rs As SqlDataReader
        Dim i As Integer

        com.CommandType = CommandType.StoredProcedure
        com.Parameters.Add(New SqlParameter("@OrgID", SqlDbType.VarChar)).Value = ID
        com.Parameters.Add(New SqlParameter("@IncludeGlobalAccounts", SqlDbType.Bit)).Value = 1

        com.Connection = sqlConn
        rs = com.ExecuteReader

        While rs.Read
            ReDim Preserve Accounts(i)
            Accounts(i) = New Account(CInt(rs("ACC_ID")))
            i += 1
        End While

        rs.Close()
        com.Dispose()
        sqlConn.Close()
    End Sub

    Public Sub GetProjects()
        GetPWC("P") 'p = project
    End Sub

    Public Sub GetWorkOrders()
        GetPWC("W") 'w = workorder
    End Sub

    Public Sub GetCostCenters()
        GetPWC("C") 'c = costcenter
    End Sub

    Public Sub GetDivisions()
        GetPWC("D") 'd = division
    End Sub

    Public Sub GetReports(Optional statusID As Integer = 0)
        GetConnectionString()
        On Error Resume Next
        Dim sqlConn = New SqlConnection(connString.ConnectionString)
        Dim com As SqlCommand

        sqlConn.Open()

        If statusID = iFINALIZED Then
            com = New SqlCommand("GetFinalizedReports", sqlConn)
        Else
            com = New SqlCommand("GetReports", sqlConn)
        End If

        Dim rs As SqlDataReader
        Dim i As Integer

        com.CommandType = CommandType.StoredProcedure
        com.Parameters.Add(New SqlParameter("@OrgID", SqlDbType.VarChar)).Value = ID
        com.Connection = sqlConn
        rs = com.ExecuteReader

        ReDim Reports(i)

        While rs.Read
            ReDim Preserve Reports(i)
            Reports(i) = New Report(rs("REPORT_ID"))
            i += 1
        End While

        rs.Close()
        com.Dispose()
        sqlConn.Close()
    End Sub

    Public Sub GetEmployees()
        GetConnectionString()
        On Error Resume Next
        Dim sqlConn = New SqlConnection(connString.ConnectionString)
        sqlConn.Open()

        Dim com As SqlCommand = New SqlCommand("GetEmployees", sqlConn)
        Dim rs As SqlDataReader
        Dim i As Integer

        com.CommandType = CommandType.StoredProcedure
        com.Parameters.Add(New SqlParameter("@OrgID", SqlDbType.Int)).Value = ID
        com.Connection = sqlConn
        rs = com.ExecuteReader

        ReDim Reports(i)

        While rs.Read
            ReDim Preserve Employees(i)
            Employees(i) = New Employee(CInt(rs("EMP_ID")))
            i += 1
        End While

        rs.Close()
        com.Dispose()
        sqlConn.Close()
    End Sub


    Public Sub GetExpenses(dStartDate As Date, dEndDate As Date, Optional ThirdPartyOnly As Boolean = False, Optional OrderBy As String = "REPORT_NUM")
        GetConnectionString()
        On Error Resume Next
        Dim sqlConn = New SqlConnection(connString.ConnectionString)
        Dim com As SqlCommand
        sqlConn.Open()

        com = New SqlCommand("GetExpensesByDate", sqlConn)

        Dim rs As SqlDataReader
        Dim i As Integer

        com.CommandType = CommandType.StoredProcedure
        com.Parameters.Add(New SqlParameter("@OrgID", SqlDbType.Int)).Value = ID
        com.Parameters.Add(New SqlParameter("@PeriodStart", SqlDbType.Date)).Value = dStartDate.ToString("dd/MM/yyyy")
        com.Parameters.Add(New SqlParameter("@PeriodEnd", SqlDbType.Date)).Value = dEndDate.ToString("dd/MM/yyyy")
        com.Parameters.Add(New SqlParameter("@OrderBy", SqlDbType.NVarChar)).Value = OrderBy
        If ThirdPartyOnly Then com.Parameters.Add(New SqlParameter("@TPOnly", SqlDbType.Bit)).Value = 1

        com.Connection = sqlConn
        rs = com.ExecuteReader

        'ReDim Reports(i)

        While rs.Read
            ReDim Preserve Expenses(i)
            Expenses(i) = New Expense(rs("EXPENSE_ID"))
            i += 1
        End While

        rs.Close()
        com.Dispose()
        sqlConn.Close()
    End Sub

    Public Sub GetExpenses(dStartDate As Date, dEndDate As Date, GL As String)
        GetConnectionString()
        On Error Resume Next
        Dim sqlConn = New SqlConnection(connString.ConnectionString)
        Dim com As SqlCommand
        sqlConn.Open()

        com = New SqlCommand("GetExpensesByDateGL", sqlConn)

        Dim rs As SqlDataReader
        Dim i As Integer

        com.CommandType = CommandType.StoredProcedure
        com.Parameters.Add(New SqlParameter("@OrgID", SqlDbType.Int)).Value = ID
        com.Parameters.Add(New SqlParameter("@PeriodStart", SqlDbType.Date)).Value = dStartDate.ToString("dd/MM/yyyy")
        com.Parameters.Add(New SqlParameter("@PeriodEnd", SqlDbType.Date)).Value = dEndDate.ToString("dd/MM/yyyy")
        com.Parameters.Add(New SqlParameter("@GL", SqlDbType.NVarChar)).Value = GL
        com.Parameters.Add(New SqlParameter("@OrderBy", SqlDbType.NVarChar)).Value = "REPORT_NUM"

        com.Connection = sqlConn
        rs = com.ExecuteReader

        'ReDim Reports(i)

        While rs.Read
            ReDim Preserve Expenses(i)
            Expenses(i) = New Expense(rs("EXPENSE_ID"))
            i += 1
        End While

        rs.Close()
        com.Dispose()
        sqlConn.Close()
    End Sub

    Public Sub GetReports(dStartDate As Date, dEndDate As Date, Optional TPOnly As Boolean = False, Optional orderBy As String = "FINALIZED_DATE")
        GetConnectionString()
        'On Error Resume Next
        Dim sqlConn = New SqlConnection(connString.ConnectionString)
        Dim com As SqlCommand
        sqlConn.Open()

        com = New SqlCommand("GetReportsByDate", sqlConn)

        Dim rs As SqlDataReader
        Dim i As Integer

        com.CommandType = CommandType.StoredProcedure
        com.Parameters.Add(New SqlParameter("@OrgID", SqlDbType.VarChar)).Value = ID
        com.Parameters.Add(New SqlParameter("@PeriodStart", SqlDbType.Date)).Value = dStartDate.ToString("dd/MM/yyyy")
        com.Parameters.Add(New SqlParameter("@PeriodEnd", SqlDbType.Date)).Value = dEndDate.ToString("dd/MM/yyyy")
        com.Parameters.Add(New SqlParameter("@OrderBy", SqlDbType.NVarChar)).Value = orderBy
        com.Connection = sqlConn
        rs = com.ExecuteReader

        Try
            While rs.Read
                ReDim Preserve Reports(i)
                Reports(i) = New Report(rs("REPORT_ID"), , TPOnly)
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

    Public Sub GetReports(dStartDate As Date, dEndDate As Date, statusID As Integer, Optional orderBy As String = "")
        GetConnectionString()
        On Error Resume Next
        Dim sqlConn = New SqlConnection(connString.ConnectionString)
        Dim com As SqlCommand
        sqlConn.Open()

        com = New SqlCommand("GetReportsByDate", sqlConn)

        Dim rs As SqlDataReader
        Dim i As Integer

        com.CommandType = CommandType.StoredProcedure
        com.Parameters.Add(New SqlParameter("@OrgID", SqlDbType.VarChar)).Value = ID
        com.Parameters.Add(New SqlParameter("@PeriodStart", SqlDbType.Date)).Value = dStartDate.ToString("dd/MM/yyyy")
        com.Parameters.Add(New SqlParameter("@PeriodEnd", SqlDbType.Date)).Value = dEndDate.ToString("dd/MM/yyyy")
        com.Parameters.Add(New SqlParameter("@Status", SqlDbType.Int)).Value = statusID
        If orderBy <> "" Then com.Parameters.Add(New SqlParameter("@OrderBy", SqlDbType.NVarChar)).Value = orderBy

        com.Connection = sqlConn
        rs = com.ExecuteReader

        While rs.Read
            ReDim Preserve Reports(i)
            Reports(i) = New Report(rs("REPORT_ID"), True)
            i += 1
        End While

        rs.Close()
        com.Dispose()
        sqlConn.Close()
    End Sub

    Public Function ValidateKMRate(jurID As Integer, kmRate As Single, expDate As Date) As Integer
        GetConnectionString()
        Dim sqlConn = New SqlConnection(connString.ConnectionString)
        sqlConn.Open()

        Dim com As SqlCommand = New SqlCommand("GetKM", sqlConn)
        Dim rs As SqlDataReader
        Dim returnVal As Single

        com.CommandType = CommandType.StoredProcedure
        com.Parameters.Add(New SqlParameter("@JurID", SqlDbType.Int)).Value = jurID
        com.Parameters.Add(New SqlParameter("@expDate", SqlDbType.Date)).Value = expDate
        com.Connection = sqlConn
        rs = com.ExecuteReader

        returnVal = 1

        While rs.Read
            If rs("KM_RATE") < kmRate Then returnVal = 0
        End While

        rs.Close()
        rs = Nothing
        com.Dispose()
        sqlConn.Close()

        ValidateKMRate = returnVal
    End Function


    Public Function GetCRA(sType As String, expDate As Date) As Single
        GetConnectionString()
        Dim sqlConn = New SqlConnection(connString.ConnectionString)
        sqlConn.Open()

        Dim com As SqlCommand = New SqlCommand("GetCRA", sqlConn)
        Dim rs As SqlDataReader
        Dim returnVal As Single

        com.CommandType = CommandType.StoredProcedure
        com.Parameters.Add(New SqlParameter("@OrgID", SqlDbType.VarChar)).Value = ID
        com.Parameters.Add(New SqlParameter("@expDate", SqlDbType.Date)).Value = expDate
        com.Connection = sqlConn
        rs = com.ExecuteReader

        returnVal = 2

        While rs.Read
            If sType = "GST" Then
                returnVal = rs("CRA_GST")
            Else
                returnVal = rs("CRA_QST")
            End If
        End While

        rs.Close()
        rs = Nothing
        com.Dispose()
        sqlConn.Close()

        GetCRA = returnVal
    End Function


    Public Function GetCRAactualRatio(sType As String, expDate As Date, ratio As Decimal) As Single
        GetConnectionString()
        Dim sqlConn = New SqlConnection(connString.ConnectionString)
        sqlConn.Open()
        Dim com = New SqlCommand("GetCRAactualRatio", sqlConn)
        Dim rs As SqlDataReader
        Dim returnVal As Single

        com.CommandType = CommandType.StoredProcedure
        com.Parameters.Add(New SqlParameter("@Ratio", SqlDbType.Int)).Value = ratio * 100
        com.Parameters.Add(New SqlParameter("@OrgType", SqlDbType.Int)).Value = Type.ID
        com.Parameters.Add(New SqlParameter("@TaxID", SqlDbType.Int)).Value = IIf(sType = "GST", 1, 3)
        com.Parameters.Add(New SqlParameter("@expDate", SqlDbType.Date)).Value = expDate
        com.Connection = sqlConn
        rs = com.ExecuteReader

        While rs.Read
            returnVal = rs("RATIO") * ratio
            If returnVal > 1 Then returnVal = 1
        End While

        rs.Close()
        rs = Nothing
        com.Dispose()
        sqlConn.Close()

        GetCRAactualRatio = returnVal
    End Function


    Public Sub CreateCRA(craGST As Single, craQST As Single)
        GetConnectionString()
        Dim sqlConn = New SqlConnection(connString.ConnectionString)
        sqlConn.Open()

        Dim com As SqlCommand = New SqlCommand("CreateCRA", sqlConn)

        com.CommandType = CommandType.StoredProcedure
        com.Parameters.Add(New SqlParameter("@OrgID", SqlDbType.Int)).Value = ID
        com.Parameters.Add(New SqlParameter("@GST", SqlDbType.Money)).Value = craGST / 100
        com.Parameters.Add(New SqlParameter("@QST", SqlDbType.Money)).Value = craQST / 100
        com.Connection = sqlConn
        com.ExecuteNonQuery()

        com.Dispose()
        sqlConn.Close()
    End Sub

    Public Sub Delete()
        GetConnectionString()
        Dim sqlConn = New SqlConnection(connString.ConnectionString)
        sqlConn.Open()

        Dim com As SqlCommand = New SqlCommand("DeleteOrg", sqlConn)

        com.CommandType = CommandType.StoredProcedure
        com.Parameters.Add(New SqlParameter("@OrgID", SqlDbType.Int)).Value = ID

        com.Connection = sqlConn
        com.ExecuteNonQuery()

        com.Dispose()
        sqlConn.Close()

    End Sub

    Public Function GetLastCreated(ParentID As Integer) As Integer
        GetConnectionString()
        Dim sqlConn = New SqlConnection(connString.ConnectionString)
        sqlConn.Open()

        Dim com As SqlCommand = New SqlCommand("GetLastCreatedOrg", sqlConn)
        Dim rs As SqlDataReader

        com.CommandType = CommandType.StoredProcedure
        com.Parameters.Add(New SqlParameter("@ParentOrgID", SqlDbType.VarChar)).Value = ParentID
        com.Connection = sqlConn
        rs = com.ExecuteReader

        While rs.Read
            GetLastCreated = rs("ORG_ID")
        End While

        rs.Close()
        rs = Nothing
        com.Dispose()
        sqlConn.Close()

    End Function

    Public Sub SetActive(active As Boolean)
        GetConnectionString()
        Dim sqlConn = New SqlConnection(connString.ConnectionString)
        sqlConn.Open()
        Dim com As SqlCommand = New SqlCommand("SetActiveOrg", sqlConn)

        com.CommandType = CommandType.StoredProcedure

        com.Parameters.Add(New SqlParameter("@orgID", SqlDbType.Int)).Value = ID
        com.Parameters.Add(New SqlParameter("@active", SqlDbType.Bit)).Value = active

        com.Connection = sqlConn
        com.ExecuteNonQuery()

        com.Dispose()
        sqlConn.Close()
    End Sub
End Class
