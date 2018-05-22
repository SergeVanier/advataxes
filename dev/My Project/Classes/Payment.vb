Imports System.Data
Imports System.Data.SqlClient

Public Class Payment

    Private _txnID As String
    Private _PAYMENT_DATE As Date
    Private _USER_NAME As String
    Private _FIRST_NAME As String
    Private _LAST_NAME As String
    Private _PAYER_EMAIL As String
    Private _PAYER_BUSINESS_NAME As String
    Private _ADDRESS_NAME As String
    Private _ADDRESS_STREET As String
    Private _ADDRESS_CITY As String
    Private _ADDRESS_STATE As String
    Private _ADDRESS_ZIP As String
    Private _ADDRESS_COUNTRY As String
    Private _MC_GROSS As Double
    Private _PAYMENT_TYPE As String
    Private _invnum As Integer

    Public Property InvNum() As Integer
        Get
            Return _invnum
        End Get
        Set(ByVal value As Integer)
            _invnum = value
        End Set
    End Property


    Public Property txnID() As String
        Get
            Return _txnID
        End Get
        Set(ByVal value As String)
            _txnID = value
        End Set
    End Property

    Public Property PaymentDate() As Date
        Get
            Return _PAYMENT_DATE
        End Get
        Set(ByVal value As Date)
            _PAYMENT_DATE = value
        End Set
    End Property

    Public Property UserName() As String
        Get
            Return _USER_NAME
        End Get
        Set(ByVal value As String)
            _USER_NAME = value
        End Set
    End Property

    Public Property FirstName() As String
        Get
            Return _FIRST_NAME
        End Get
        Set(ByVal value As String)
            _FIRST_NAME = value
        End Set
    End Property

    Public Property LastName() As String
        Get
            Return _LAST_NAME
        End Get
        Set(ByVal value As String)
            _LAST_NAME = value
        End Set
    End Property


    Public Property PayerEmail() As String
        Get
            Return _PAYER_EMAIL
        End Get
        Set(ByVal value As String)
            _PAYER_EMAIL = value
        End Set
    End Property

    Public Property PayerBusinessName() As String
        Get
            Return _PAYER_BUSINESS_NAME
        End Get
        Set(ByVal value As String)
            _PAYER_BUSINESS_NAME = value
        End Set
    End Property

    Public Property AddressName() As String
        Get
            Return _ADDRESS_NAME
        End Get
        Set(ByVal value As String)
            _ADDRESS_NAME = value
        End Set
    End Property

    Public Property AddressStreet() As String
        Get
            Return _ADDRESS_STREET
        End Get
        Set(ByVal value As String)
            _ADDRESS_STREET = value
        End Set
    End Property

    Public Property AddressCity() As String
        Get
            Return _ADDRESS_CITY
        End Get
        Set(ByVal value As String)
            _ADDRESS_CITY = value
        End Set
    End Property

    Public Property AddressState() As String
        Get
            Return _ADDRESS_STATE
        End Get
        Set(ByVal value As String)
            _ADDRESS_STATE = value
        End Set
    End Property

    Public Property AddressZip() As String
        Get
            Return _ADDRESS_ZIP
        End Get
        Set(ByVal value As String)
            _ADDRESS_ZIP = value
        End Set
    End Property


    Public Property AddressCountry() As String
        Get
            Return _ADDRESS_COUNTRY
        End Get
        Set(ByVal value As String)
            _ADDRESS_COUNTRY = value
        End Set
    End Property

    Public Property MCGross() As Double
        Get
            Return _MC_GROSS
        End Get
        Set(ByVal value As Double)
            _MC_GROSS = value
        End Set
    End Property

    Public Property PaymentType() As String
        Get
            Return _PAYMENT_TYPE
        End Get
        Set(ByVal value As String)
            _PAYMENT_TYPE = value
        End Set
    End Property

    Public Sub New()

    End Sub

    Public Sub New(txn_ID As String)
        GetConnectionString()

        Dim sqlConn = New SqlConnection(connString.ConnectionString)
        sqlConn.Open()

        Dim com As SqlCommand = New SqlCommand("GetPayment", sqlConn)
        Dim rs As SqlDataReader

        com.CommandType = CommandType.StoredProcedure
        com.Parameters.Add(New SqlParameter("@txnID", SqlDbType.VarChar)).Value = txn_ID
        com.Connection = sqlConn
        rs = com.ExecuteReader

        txnID = ""
        While rs.Read
            txnID = rs("TXN_ID")
            InvNum = rs("INV_NUM")
        End While

        rs.Close()
        com.Dispose()
        sqlConn.Close()
    End Sub

    Public Function GetNextInvNum()
        Dim invnum As Integer
        GetConnectionString()

        Dim sqlConn = New SqlConnection(connString.ConnectionString)
        sqlConn.Open()

        Dim com As SqlCommand = New SqlCommand("GetLastInvNum", sqlConn)
        Dim rs As SqlDataReader

        com.CommandType = CommandType.StoredProcedure
        com.Connection = sqlConn
        rs = com.ExecuteReader

        While rs.Read
            invnum = rs("INV_NUM") + 1
        End While

        rs.Close()
        com.Dispose()
        sqlConn.Close()
        GetNextInvNum = invnum
    End Function


    Public Sub Create()
        GetConnectionString()
        Dim sqlConn = New SqlConnection(connString.ConnectionString)
        sqlConn.Open()
        Dim com As SqlCommand = New SqlCommand("CreatePayment", sqlConn)

        com.CommandType = CommandType.StoredProcedure

        com.Parameters.Add(New SqlParameter("@userName", SqlDbType.NVarChar)).Value = UserName
        com.Parameters.Add(New SqlParameter("@firstName", SqlDbType.NVarChar)).Value = FirstName
        com.Parameters.Add(New SqlParameter("@lastName", SqlDbType.NVarChar)).Value = LastName
        com.Parameters.Add(New SqlParameter("@txnID", SqlDbType.NVarChar)).Value = txnID
        'com.Parameters.Add(New SqlParameter("@paymentDate", SqlDbType.Date)).Value = Now
        com.Parameters.Add(New SqlParameter("@payerEmail", SqlDbType.NVarChar)).Value = PayerEmail
        'com.Parameters.Add(New SqlParameter("@payerBusinessName", SqlDbType.NVarChar)).Value = PayerBusinessName
        com.Parameters.Add(New SqlParameter("@addressName", SqlDbType.NVarChar)).Value = AddressName
        com.Parameters.Add(New SqlParameter("@addressStreet", SqlDbType.NVarChar)).Value = AddressStreet
        com.Parameters.Add(New SqlParameter("@addressCity", SqlDbType.NVarChar)).Value = AddressCity
        com.Parameters.Add(New SqlParameter("@addressState", SqlDbType.NVarChar)).Value = AddressState
        com.Parameters.Add(New SqlParameter("@addressZip", SqlDbType.NVarChar)).Value = AddressZip
        com.Parameters.Add(New SqlParameter("@addressCountry", SqlDbType.NVarChar)).Value = AddressCountry
        com.Parameters.Add(New SqlParameter("@mcGross", SqlDbType.Money)).Value = MCGross
        com.Parameters.Add(New SqlParameter("@InvNum", SqlDbType.Int)).Value = GetNextInvNum()
        'com.Parameters.Add(New SqlParameter("@paymentType", SqlDbType.NVarChar)).Value = PaymentType

        com.Connection = sqlConn
        com.ExecuteNonQuery()

        com.Dispose()
        sqlConn.Close()
    End Sub
End Class
