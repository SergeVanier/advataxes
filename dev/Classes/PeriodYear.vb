Imports System.Data
Imports System.Data.SqlClient


Public Class PeriodYear


    Private _orgid As Integer
    Private _financialYR As Integer
    Private _financialYREnd As Date
    Private _eof As Boolean
    Private _matchCalendar As Integer


    Public Property MatchCalendar() As Integer
        Get
            Return _matchCalendar
        End Get
        Set(ByVal value As Integer)
            _matchCalendar = value
        End Set
    End Property



    Public Property OrgID() As Integer
        Get
            Return _orgid
        End Get
        Set(ByVal value As Integer)
            _orgid = value
        End Set
    End Property


    Public Property FinancialYear() As Integer
        Get
            Return _financialYR
        End Get
        Set(ByVal value As Integer)
            _financialYR = value
        End Set
    End Property


    Public Property YearEnd() As Date
        Get
            Return _financialYREnd
        End Get
        Set(ByVal value As Date)
            _financialYREnd = value
        End Set
    End Property

    Public Property EOF() As Boolean
        Get
            Return _eof
        End Get
        Set(ByVal value As Boolean)
            _eof = value
        End Set
    End Property


    Public Sub New()

    End Sub

    Public Sub New(iOrgID As Integer, iFinancialYear As Integer)
        GetConnectionString()
        Dim sqlConn = New SqlConnection(connString.ConnectionString)
        sqlConn.Open()

        Try
            OrgID = iOrgID
            FinancialYear = iFinancialYear

            Dim com As SqlCommand = New SqlCommand("GetPeriodYear", sqlConn)
            Dim rs As SqlDataReader

            com.CommandType = CommandType.StoredProcedure
            com.Parameters.Add(New SqlParameter("@OrgID", SqlDbType.Int)).Value = OrgID
            com.Parameters.Add(New SqlParameter("@FinancialYear", SqlDbType.Int)).Value = FinancialYear
            com.Connection = sqlConn
            rs = com.ExecuteReader
            EOF = True

            While rs.Read
                YearEnd = rs("YR_END")
                MatchCalendar = rs("MATCH_CALENDAR")
                EOF = False
            End While

            rs.Close()
            com.Dispose()
            sqlConn.Close()

        Catch ex As Exception
            Throw New Exception

        End Try

        sqlConn.Close()
    End Sub



    Public Sub Create()
        GetConnectionString()
        Dim sqlConn = New SqlConnection(connString.ConnectionString)
        sqlConn.Open()

        Dim com As SqlCommand = New SqlCommand("CreatePeriodYear", sqlConn)

        com.CommandType = CommandType.StoredProcedure

        com.Parameters.Add(New SqlParameter("@OrgID", SqlDbType.Int)).Value = OrgID
        com.Parameters.Add(New SqlParameter("@FinancialYR", SqlDbType.Int)).Value = FinancialYear
        com.Parameters.Add(New SqlParameter("@FinancialYREnd", SqlDbType.Date)).Value = YearEnd
        com.Parameters.Add(New SqlParameter("@MatchCalendar", SqlDbType.Int)).Value = MatchCalendar

        com.Connection = sqlConn
        com.ExecuteNonQuery()

        com.Dispose()
        sqlConn.Close()

    End Sub

    Public Sub Delete()
        GetConnectionString()
        Dim sqlConn = New SqlConnection(connString.ConnectionString)
        sqlConn.Open()

        Dim com As SqlCommand = New SqlCommand("DeletePeriodYear", sqlConn)

        com.CommandType = CommandType.StoredProcedure

        com.Parameters.Add(New SqlParameter("@OrgID", SqlDbType.Int)).Value = OrgID
        com.Parameters.Add(New SqlParameter("@FinancialYear", SqlDbType.Int)).Value = FinancialYear

        com.Connection = sqlConn
        com.ExecuteNonQuery()

        com.Dispose()
        sqlConn.Close()

    End Sub



End Class
