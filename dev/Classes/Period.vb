Imports System.Data
Imports System.Data.SqlClient

Public Class Period

    Private _id As Integer
    Private _periodnum As Integer
    Private _orgid As Integer
    Private _periodMonth As Integer
    Private _subtractYear As Integer


    Public Property ID() As Integer
        Get
            Return _id
        End Get
        Set(ByVal value As Integer)
            _id = value
        End Set
    End Property

    Public Property PeriodMonth() As Integer
        Get
            Return _periodMonth
        End Get
        Set(ByVal value As Integer)
            _periodMonth = value
        End Set
    End Property


    Public Property SubtractYear() As Integer
        Get
            Return _subtractYear
        End Get
        Set(ByVal value As Integer)
            _subtractYear = value
        End Set
    End Property


    Public Property PeriodNum() As Integer
        Get
            Return _periodnum
        End Get
        Set(ByVal value As Integer)
            _periodnum = value
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


    Public Sub Create()
        GetConnectionString()
        Dim sqlConn = New SqlConnection(connString.ConnectionString)
        sqlConn.Open()

        Dim com As SqlCommand = New SqlCommand("CreatePeriod", sqlConn)
        com.CommandType = CommandType.StoredProcedure

        com.Parameters.Add(New SqlParameter("@OrgID", SqlDbType.Int)).Value = OrgID
        com.Parameters.Add(New SqlParameter("@PeriodNum", SqlDbType.Int)).Value = PeriodNum
        com.Parameters.Add(New SqlParameter("@PeriodMonth", SqlDbType.Int)).Value = PeriodMonth
        com.Parameters.Add(New SqlParameter("@SubtractYear", SqlDbType.Int)).Value = SubtractYear

        com.Connection = sqlConn
        com.ExecuteNonQuery()

        com.Dispose()
        sqlConn.Close()

    End Sub


    Public Sub New()

    End Sub

    Public Sub New(orgID As Integer, periodNum As Integer, sEndOrStart As String)
        GetConnectionString()
        Dim sqlConn = New SqlConnection(connString.ConnectionString)
        sqlConn.Open()

        Dim com As SqlCommand = New SqlCommand("GetPeriod" & sEndOrStart, sqlConn)
        Dim rs As SqlDataReader

        Me.PeriodNum = periodNum
        Me.OrgID = orgID

        com.CommandType = CommandType.StoredProcedure
        com.Parameters.Add(New SqlParameter("@PeriodNum", SqlDbType.Int)).Value = periodNum
        com.Parameters.Add(New SqlParameter("@OrgID", SqlDbType.Int)).Value = orgID

        com.Connection = sqlConn
        rs = com.ExecuteReader
        Me.ID = 0

        While rs.Read
            Me.ID = rs("PERIOD_ID")
            Me.SubtractYear = rs("SUBTRACT_YEAR")
            Me.PeriodMonth = rs("PERIOD_MONTH")
        End While

        rs.Close()
        com.Dispose()
        sqlConn.Close()
    End Sub

    Public Sub New(orgID As Integer, periodMonth As Integer)
        GetConnectionString()
        Dim sqlConn = New SqlConnection(connString.ConnectionString)
        Dim o As New Org(orgID)

        sqlConn.Open()

        Dim com As SqlCommand = New SqlCommand("GetPeriodByMonth", sqlConn)
        Dim rs As SqlDataReader
        Me.PeriodNum = PeriodNum

        Me.OrgID = o.Parent.ID

        com.CommandType = CommandType.StoredProcedure
        com.Parameters.Add(New SqlParameter("@PeriodMonth", SqlDbType.Int)).Value = periodMonth
        com.Parameters.Add(New SqlParameter("@OrgID", SqlDbType.Int)).Value = Me.OrgID

        com.Connection = sqlConn
        rs = com.ExecuteReader
        Me.ID = 0
        Try
            While rs.Read
                Me.ID = rs("PERIOD_ID")
                Me.SubtractYear = rs("SUBTRACT_YEAR")
                Me.PeriodMonth = rs("PERIOD_MONTH")
                Me.PeriodNum = rs("PERIOD_NUM")
            End While
        Catch ex As Exception
            Throw ex

        Finally
            rs.Close()
            com.Dispose()
            sqlConn.Close()
        End Try
    End Sub

End Class
