Imports System.Data
Imports System.Data.SqlClient

Public Class CurrencyRate
    Private _id As Integer
    Private _periodStart As Date
    Private _periodEnd As Date
    Private _rate As Single

    Public Property Rate() As Single
        Get
            Rate = _rate
        End Get

        Set(ByVal value As Single)
            _rate = value
        End Set
    End Property

    Public Property PeriodStart() As Date
        Get
            PeriodStart = _periodStart
        End Get

        Set(ByVal value As Date)
            _periodStart = value
        End Set
    End Property
    

    Public Property PeriodEnd() As Date
        Get
            PeriodEnd = _periodEnd
        End Get

        Set(ByVal value As Date)
            _periodEnd = value
        End Set
    End Property

    Public Property ID() As Integer
        Get
            ID = _id
        End Get

        Set(ByVal value As Integer)
            _id = value
        End Set
    End Property

    Public Sub New()
    
    End Sub

    Public Sub New(currID As Integer, periodStart As Date, periodEnd As Date)
        GetConnectionString()
        Me.ID = currid
        Me.PeriodStart = periodStart
        Me.PeriodEnd = periodEnd

        Dim sqlConn = New SqlConnection(connString.ConnectionString)
        sqlConn.Open()

        Dim com As SqlCommand = New SqlCommand("GetCurrencyRate", sqlConn)
        Dim rs As SqlDataReader

        com.CommandType = CommandType.StoredProcedure


        com.Parameters.Add(New SqlParameter("@CurrID", SqlDbType.VarChar)).Value = Me.ID
        com.Parameters.Add(New SqlParameter("@PeriodStart", SqlDbType.Date)).Value = Me.PeriodStart
        com.Parameters.Add(New SqlParameter("@PeriodEnd", SqlDbType.Date)).Value = Me.PeriodEnd

        com.Connection = sqlConn
        rs = com.ExecuteReader


        While rs.Read
            Me.ID = rs("CURR_RATE_ID")
            Me.Rate = rs("CURR_RATE")
        End While

        rs.Close()
        com.Dispose()
        sqlConn.Close()
    End Sub


    Public Sub AddRate(rate As Single, periodStart As Date, periodEnd As Date)
        GetConnectionString()
        Dim sqlConn = New SqlConnection(connString.ConnectionString)
        sqlConn.Open()
        Dim com As SqlCommand = New SqlCommand("AddCurrencyRate", sqlConn)


        com.CommandType = CommandType.StoredProcedure

        com.Parameters.Add(New SqlParameter("@CurrID", SqlDbType.Int)).Value = ID
        com.Parameters.Add(New SqlParameter("@Rate", SqlDbType.Money)).Value = rate
        com.Parameters.Add(New SqlParameter("@PeriodStart", SqlDbType.Date)).Value = periodStart
        com.Parameters.Add(New SqlParameter("@PeriodEnd", SqlDbType.Date)).Value = periodEnd

        com.Connection = sqlConn
        com.ExecuteNonQuery()

        com.Dispose()
        sqlConn.Close()


    End Sub
End Class
