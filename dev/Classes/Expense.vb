Imports System.Data
Imports System.Data.SqlClient

Public Class Expense
    Implements IValidatable
    Private _id As Integer
    Private _reportID As Integer
    Private _catID As Integer
    Private _orgCatID As Integer
    Private _JurID As Integer
    Private _CurrID As Integer
    Private _TaxStatus As Integer
    Private _SuppName As String
    Private _Rate As Single
    Private _Grat As Single
    Private _Amt As Double
    Private _cdnAmt As Double
    Private _Comment As String
    Private _ExpenseID As Integer
    Private _expDate As Date
    Private _gstPaid As Single
    Private _hstPaid As Single
    Private _qstPaid As Single
    Private _itc As Single
    Private _itr As Single
    Private _ritc As Single
    Private _receiptImage As Byte()
    Private _receiptType As String
    Private _receiptName As String
    Private _receiptDate As Date
    Private _costCenter As String
    Private _workOrder As String
    Private _project As String
    Private _TPNum As String
    Private _TPName As String
    Private _accountNumber As String
    Private _attendees As String

    Private _reimburse As Boolean
    'Public Category As New Category
    Public Rpt As Report
    Public OrgCategory As New OrgCat
    Public Jurisdiction As New Jurisdiction
    Public Currency As New Currency
    Public Account As New Account

    Public Property ReceiptImage() As Byte()
        Get
            Return _receiptImage
        End Get
        Set(ByVal value As Byte())
            _receiptImage = value
        End Set
    End Property

    Public Property Reimburse() As Boolean
        Get
            Return _reimburse
        End Get
        Set(ByVal value As Boolean)
            _reimburse = value
        End Set
    End Property

    Public Property AccountNumber() As String
        Get
            Return _accountNumber
        End Get
        Set(ByVal value As String)
            _accountNumber = value
        End Set
    End Property

    Public Property TPNum() As String
        Get
            Return _TPNum
        End Get
        Set(ByVal value As String)
            _TPNum = value
        End Set
    End Property

    Public Property Attendees() As String
        Get
            Return _attendees
        End Get
        Set(ByVal value As String)
            _attendees = value
        End Set
    End Property

    Public Property TPName() As String
        Get
            Return _TPName
        End Get
        Set(ByVal value As String)
            _TPName = value
        End Set
    End Property


    Public Property RITC() As Single
        Get
            Return _ritc
        End Get
        Set(ByVal value As Single)
            _ritc = value
        End Set
    End Property

    Public Property ITR() As Single
        Get
            Return _itr
        End Get
        Set(ByVal value As Single)
            _itr = value
        End Set
    End Property

    Public Property ITC() As Single
        Get
            Return _itc
        End Get
        Set(ByVal value As Single)
            _itc = value
        End Set
    End Property

    Public Property CostCenter() As String
        Get
            Return _costCenter
        End Get
        Set(ByVal value As String)
            _costCenter = value
        End Set
    End Property

    Public Property WorkOrder() As String
        Get
            Return _workOrder
        End Get
        Set(ByVal value As String)
            _workOrder = value
        End Set
    End Property

    Public Property Project() As String
        Get
            Return _project
        End Get
        Set(ByVal value As String)
            _project = value
        End Set
    End Property

    Public Property ReceiptName() As String
        Get
            Return _receiptName
        End Get
        Set(ByVal value As String)
            _receiptName = value
        End Set
    End Property

    Public Property ReceiptType() As String
        Get
            Return _receiptType
        End Get
        Set(ByVal value As String)
            _receiptType = value
        End Set
    End Property


    Public Property DateOfExpense() As Date
        Get
            Return _expDate
        End Get
        Set(ByVal value As Date)
            _expDate = value
        End Set
    End Property

    Public Property ReceiptDate() As Date
        Get
            Return _receiptDate
        End Get
        Set(ByVal value As Date)
            _receiptDate = value
        End Set
    End Property

    Public Property GSTPaid() As Single
        Get
            Return _gstPaid
        End Get
        Set(ByVal value As Single)
            _gstPaid = value
        End Set
    End Property

    Public Property HSTPaid() As Single
        Get
            Return _hstPaid
        End Get
        Set(ByVal value As Single)
            _hstPaid = value
        End Set
    End Property

    Public Property QSTPaid() As Single
        Get
            Return _qstPaid
        End Get
        Set(ByVal value As Single)
            _qstPaid = value
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

    Public Property ReportID() As Integer
        Get
            Return _reportID
        End Get
        Set(ByVal value As Integer)
            _reportID = value
        End Set
    End Property


    'Public Property JurID() As Integer
    '    Get
    '        Return _JurID
    '    End Get
    '    Set(ByVal value As Integer)
    '        _JurID = value
    '    End Set
    'End Property

    Public Property CurrID() As Integer
        Get
            Return _CurrID
        End Get
        Set(ByVal value As Integer)
            _CurrID = value
        End Set
    End Property

    Public Property TaxStatus() As Integer
        Get
            Return _TaxStatus
        End Get
        Set(ByVal value As Integer)
            _TaxStatus = value
        End Set
    End Property

    Public Property SupplierName() As String
        Get
            Return _SuppName
        End Get
        Set(ByVal value As String)
            _SuppName = value
        End Set
    End Property

    Public Property Rate() As Single
        Get
            Return _Rate
        End Get
        Set(ByVal value As Single)
            _Rate = value
        End Set
    End Property

    Public Property Gratuities() As Single
        Get
            Return _Grat
        End Get
        Set(ByVal value As Single)
            _Grat = value
        End Set
    End Property

	Public Property AmountCDN() As Decimal
		Get
			Return _cdnAmt
		End Get
		Set(ByVal value As Decimal)
			_cdnAmt = value
		End Set
	End Property

	Public Property Amount() As Double
        Get
            Return _Amt
        End Get
        Set(ByVal value As Double)
            _Amt = value
        End Set
    End Property

    Public Property Comment() As String
        Get
            Return _Comment
        End Get
        Set(ByVal value As String)
            _Comment = value
        End Set
    End Property


    Public Sub Create()
        GetConnectionString()
        Dim sqlConn = New SqlConnection(connString.ConnectionString)
        sqlConn.Open()
        Dim com As SqlCommand = New SqlCommand("CreateExpense", sqlConn)
        'Dim o As New Org(OrgCategory.OrgID)

        com.CommandType = CommandType.StoredProcedure
        com.Parameters.Add(New SqlParameter("@ReportID", SqlDbType.Int)).Value = ReportID
        com.Parameters.Add(New SqlParameter("@CatID", SqlDbType.Int)).Value = OrgCategory.Category.ID

        com.Parameters.Add(New SqlParameter("@OrgCatID", SqlDbType.Int)).Value = OrgCategory.ID
        com.Parameters.Add(New SqlParameter("@JurID", SqlDbType.Int)).Value = Jurisdiction.ID
        com.Parameters.Add(New SqlParameter("@CurrID", SqlDbType.Int)).Value = CurrID
        com.Parameters.Add(New SqlParameter("@TaxStatus", SqlDbType.Int)).Value = TaxStatus
        com.Parameters.Add(New SqlParameter("@SupplierName", SqlDbType.NVarChar)).Value = SupplierName
        com.Parameters.Add(New SqlParameter("@Rate", SqlDbType.Money)).Value = Rate
        com.Parameters.Add(New SqlParameter("@Grat", SqlDbType.Money)).Value = Gratuities
        com.Parameters.Add(New SqlParameter("@Amt", SqlDbType.Money)).Value = Amount
        com.Parameters.Add(New SqlParameter("@Comment", SqlDbType.NVarChar)).Value = Comment
        com.Parameters.Add(New SqlParameter("@ExpDate", SqlDbType.Date)).Value = DateOfExpense
        com.Parameters.Add(New SqlParameter("@GSTPaid", SqlDbType.Money)).Value = GSTPaid
        'com.Parameters.Add(New SqlParameter("@HSTPaid", SqlDbType.Money)).Value = HSTPaid
        com.Parameters.Add(New SqlParameter("@QSTPaid", SqlDbType.Money)).Value = QSTPaid
        com.Parameters.Add(New SqlParameter("@ITC", SqlDbType.Money)).Value = ITC
        com.Parameters.Add(New SqlParameter("@ITR", SqlDbType.Money)).Value = ITR
        com.Parameters.Add(New SqlParameter("@RITC", SqlDbType.Money)).Value = RITC
        com.Parameters.Add(New SqlParameter("@CdnAmt", SqlDbType.Money)).Value = AmountCDN
        com.Parameters.Add(New SqlParameter("@Reimburse", SqlDbType.Bit)).Value = Reimburse
        com.Parameters.Add(New SqlParameter("@CostCenter", SqlDbType.NVarChar)).Value = CostCenter
        com.Parameters.Add(New SqlParameter("@WorkOrder", SqlDbType.NVarChar)).Value = WorkOrder
        com.Parameters.Add(New SqlParameter("@Project", SqlDbType.NVarChar)).Value = Project
        com.Parameters.Add(New SqlParameter("@ThirdParty", SqlDbType.NVarChar)).Value = TPNum
        com.Parameters.Add(New SqlParameter("@Attendees", SqlDbType.NVarChar)).Value = Attendees

        com.Connection = sqlConn
        com.ExecuteNonQuery()

        com.Dispose()
        sqlConn.Close()
    End Sub

    Public Sub Update()
        GetConnectionString()
        Dim sqlConn = New SqlConnection(connString.ConnectionString)
        sqlConn.Open()
        Dim com As SqlCommand = New SqlCommand("UpdateExpense", sqlConn)

        com.CommandType = CommandType.StoredProcedure

        com.Parameters.Add(New SqlParameter("@ExpenseID", SqlDbType.Int)).Value = Me.ID
        com.Parameters.Add(New SqlParameter("@CatID", SqlDbType.Int)).Value = OrgCategory.Category.ID
        com.Parameters.Add(New SqlParameter("@OrgCatID", SqlDbType.Int)).Value = OrgCategory.ID
        com.Parameters.Add(New SqlParameter("@JurID", SqlDbType.Int)).Value = Jurisdiction.ID
        com.Parameters.Add(New SqlParameter("@CurrID", SqlDbType.Int)).Value = CurrID
        com.Parameters.Add(New SqlParameter("@TaxStatus", SqlDbType.NVarChar)).Value = TaxStatus
        com.Parameters.Add(New SqlParameter("@SupplierName", SqlDbType.NVarChar)).Value = SupplierName
        com.Parameters.Add(New SqlParameter("@Rate", SqlDbType.Money)).Value = Rate
        com.Parameters.Add(New SqlParameter("@Grat", SqlDbType.Money)).Value = Gratuities
        com.Parameters.Add(New SqlParameter("@Amt", SqlDbType.Money)).Value = Amount
        com.Parameters.Add(New SqlParameter("@Comment", SqlDbType.NVarChar)).Value = Comment
        com.Parameters.Add(New SqlParameter("@ExpDate", SqlDbType.Date)).Value = DateOfExpense
        com.Parameters.Add(New SqlParameter("@GSTPaid", SqlDbType.Money)).Value = GSTPaid
        'com.Parameters.Add(New SqlParameter("@HSTPaid", SqlDbType.Money)).Value = HSTPaid
        com.Parameters.Add(New SqlParameter("@QSTPaid", SqlDbType.Money)).Value = QSTPaid
        com.Parameters.Add(New SqlParameter("@ITC", SqlDbType.Money)).Value = ITC
        com.Parameters.Add(New SqlParameter("@ITR", SqlDbType.Money)).Value = ITR
        com.Parameters.Add(New SqlParameter("@RITC", SqlDbType.Money)).Value = RITC
        com.Parameters.Add(New SqlParameter("@CdnAmt", SqlDbType.Money)).Value = AmountCDN
        com.Parameters.Add(New SqlParameter("@Reimburse", SqlDbType.Bit)).Value = Reimburse
        com.Parameters.Add(New SqlParameter("@CostCenter", SqlDbType.NVarChar)).Value = CostCenter
        com.Parameters.Add(New SqlParameter("@WorkOrder", SqlDbType.NVarChar)).Value = WorkOrder
        com.Parameters.Add(New SqlParameter("@Project", SqlDbType.NVarChar)).Value = Project
        com.Parameters.Add(New SqlParameter("@ThirdParty", SqlDbType.NVarChar)).Value = TPNum
        com.Parameters.Add(New SqlParameter("@Attendees", SqlDbType.NVarChar)).Value = Attendees
        'If ReceiptName <> "" Then
        '    com.Parameters.Add(New SqlParameter("@ReceiptImage", SqlDbType.Binary)).Value = ReceiptImage
        '    com.Parameters.Add(New SqlParameter("@ReceiptName", SqlDbType.NVarChar)).Value = ReceiptName
        '    com.Parameters.Add(New SqlParameter("@ReceiptType", SqlDbType.NVarChar)).Value = ReceiptType
        'End If

        com.Connection = sqlConn
        com.ExecuteNonQuery()

        com.Dispose()
        sqlConn.Close()
    End Sub


    Public Function Delete(puk As String) As Integer
        GetConnectionString()
        Dim sqlConn = New SqlConnection(connString.ConnectionString)
        sqlConn.Open()

        Dim com As SqlCommand = New SqlCommand("DeleteExpense", sqlConn)

        com.CommandType = CommandType.StoredProcedure
        com.Parameters.Add(New SqlParameter("@ExpenseID", SqlDbType.Int)).Value = _id

        com.Connection = sqlConn

        Dim report As New Report(ReportID)
        Dim loggedInUser As Employee
        Dim reportOwner As New Employee(Rpt.EmpID)
        Dim refresh As Integer
        System.Diagnostics.Debug.WriteLine(puk)
        System.Diagnostics.Debug.WriteLine(Membership.GetUser.ProviderUserKey.ToString)
        System.Diagnostics.Debug.WriteLine(reportOwner.Supervisor)

        Try
            'check if guid passed is the same as the guid of the logged in user
            If puk = Membership.GetUser.ProviderUserKey.ToString Then
                loggedInUser = New Employee(Membership.GetUser.UserName)
                System.Diagnostics.Debug.WriteLine(loggedInUser.ID)
                'check if employee who is deleting is the same employee who created the expense or 
                'if the employee deleting is the supervisor of the employee who created expense
                If loggedInUser.ID = reportOwner.ID Or loggedInUser.ID = reportOwner.Supervisor Or loggedInUser.ID = reportOwner.Finalizer Or loggedInUser.ID = reportOwner.DelegatedTo Then
                    com.ExecuteNonQuery()
                    If report.Expenses.Count = 25 Then refresh = 1
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
            reportOwner = Nothing
            report = Nothing

            com.Dispose()
            sqlConn.Close()
        End Try

        Return refresh

    End Function

    Public Sub New()

    End Sub

    Public Sub New(ID As Integer)
        GetConnectionString()
        Me.ID = ID
        Dim sqlConn = New SqlConnection(connString.ConnectionString)
        sqlConn.Open()

        Dim com As SqlCommand = New SqlCommand("GetExpense", sqlConn)
        Dim rs As SqlDataReader

        com.CommandType = CommandType.StoredProcedure
        com.Parameters.Add(New SqlParameter("@ExpenseID", SqlDbType.Int)).Value = Me.ID

        com.Connection = sqlConn
        rs = com.ExecuteReader

        Try
            While rs.Read
                Me.Amount = rs("AMOUNT")
                Me.AmountCDN = rs("CDN_AMOUNT")
                Rpt = New Report(CInt(rs("REPORT_ID")), False)
                OrgCategory = New OrgCat(CInt(rs("ORG_CAT_ID")))
                Me.Comment = rs("COMMENT")
                Me.CurrID = rs("CURR_ID")
                If Not IsDBNull(rs("GRATUITIES")) Then Me.Gratuities = rs("GRATUITIES")
                Jurisdiction = New Jurisdiction(CInt(rs("JUR_ID")))
                If OrgCategory.Category.ID = 5 Then Jurisdiction.Abbreviation = "ZZ"
                Currency = New Currency(CInt(rs("CURR_ID")))
                If Not IsDBNull(rs("RATE")) Then Me.Rate = rs("RATE")
                Me.ReportID = rs("REPORT_ID")
                Me.SupplierName = rs("SUPPLIER_NAME")
                Me.TaxStatus = rs("TAX_STATUS")
                Me.DateOfExpense = rs("EXP_DATE")
                Me.GSTPaid = rs("GST_PAID")
                Me.QSTPaid = rs("QST_PAID")

                Me.ITC = rs("ITC")
                Me.ITR = rs("ITR")
                Me.RITC = rs("RITC")

                Me.Reimburse = rs("REIMBURSE")
                If Not IsDBNull(rs("RECEIPT")) Then Me.ReceiptImage = rs("RECEIPT")
                If Not IsDBNull(rs("RECEIPT_TYPE")) Then Me.ReceiptType = rs("RECEIPT_TYPE")
                If Not IsDBNull(rs("RECEIPT_NAME")) Then Me.ReceiptName = rs("RECEIPT_NAME")
                If Not IsDBNull(rs("RECEIPT_DATE")) Then Me.ReceiptDate = rs("RECEIPT_DATE")
                If Not IsDBNull(rs("PROJECT")) Then Me.Project = rs("PROJECT")
                If Not IsDBNull(rs("WORK_ORDER")) Then Me.WorkOrder = rs("WORK_ORDER")
                If Not IsDBNull(rs("COST_CENTER")) Then Me.CostCenter = rs("COST_CENTER")
                If Not IsDBNull(rs("THIRD_PARTY")) Then Me.TPNum = rs("THIRD_PARTY")
                If Not IsDBNull(rs("ACC_NAME")) Then Me.TPName = rs("ACC_NAME")
                If Not IsDBNull(rs("ACC_NUMBER")) Then Me.Account = New Account(rs("ACC_NUMBER"), OrgCategory.OrgID)
                If Not IsDBNull(rs("ATTENDEES")) Then Me.Attendees = rs("ATTENDEES")
            End While

        Catch ex As Exception
            Throw ex

        Finally
            rs.Close()
            com.Dispose()
            sqlConn.Close()
        End Try

    End Sub

    Public Function GetLastID(rptID As Integer) As Integer
        GetConnectionString()
        Dim sqlConn = New SqlConnection(connString.ConnectionString)
        Dim lastID As Integer

        sqlConn.Open()

        Dim com As SqlCommand = New SqlCommand("GetLastExpenseID", sqlConn)
        Dim rs As SqlDataReader

        com.CommandType = CommandType.StoredProcedure
        com.Parameters.Add(New SqlParameter("@ReportID", SqlDbType.Int)).Value = rptID
        com.Connection = sqlConn
        rs = com.ExecuteReader

        While rs.Read
            lastID = rs("LAST_EXP_ID")
        End While

        rs.Close()
        com.Dispose()
        sqlConn.Close()
        sqlConn = Nothing
        rs = Nothing

        GetLastID = lastID
    End Function


    Public Sub DeleteReceipt(expID As Integer)
        GetConnectionString()
        Dim sqlConn = New SqlConnection(connString.ConnectionString)
        sqlConn.Open()

        Dim com As SqlCommand = New SqlCommand("DeleteReceipt", sqlConn)

        com.CommandType = CommandType.StoredProcedure
        com.Parameters.Add(New SqlParameter("@ExpenseID", SqlDbType.Int)).Value = expID

        com.Connection = sqlConn
        com.ExecuteNonQuery()

        com.Dispose()
        sqlConn.Close()
    End Sub

    Public Function Validate() As ValidationResults Implements IValidatable.Validate
        Dim results As New ValidationResults()

        If Amount < QSTPaid Then
            results.AddValidationError("QSTPaid", AdvataxesResources.My.Resources.Expenses.QSTPaidHigherThanAmount)
        ElseIf Amount < GSTPaid Then
            results.AddValidationError("GST", AdvataxesResources.My.Resources.Expenses.GSTPaidHigherThanAmount)
        ElseIf Amount < HSTPaid Then
            results.AddValidationError("HST", AdvataxesResources.My.Resources.Expenses.HSTPaidHigherThanAmount)
        ElseIf Amount < GSTPaid + HSTPaid + QSTPaid Then
			results.AddValidationError("Amount", AdvataxesResources.My.Resources.Expenses.TaxesPaidHigherThanAmount)
		End If

        Return results
    End Function
End Class


