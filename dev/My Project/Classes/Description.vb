
Imports System.Data
Imports System.Data.SqlClient

Public Class Description
    Private _id As Integer
    Private _engDescription As String
    Private _frDescription As String
    Private _engTitle As String
    Private _frTitle As String


    Public Property ID() As Integer
        Get
            ID = _id
        End Get

        Set(ByVal value As Integer)
            _id = value
        End Set
    End Property

    Public Property EnglishDescription() As String
        Get
            EnglishDescription = _engDescription
        End Get

        Set(ByVal value As String)
            _engDescription = value
        End Set
    End Property

    Public Property FrenchDescription() As String
        Get
            FrenchDescription = _frDescription
        End Get

        Set(ByVal value As String)
            _frDescription = value
        End Set
    End Property

    Public Property EnglishTitle() As String
        Get
            EnglishTitle = _engTitle
        End Get

        Set(ByVal value As String)
            _engTitle = value
        End Set
    End Property

    Public Property FrenchTitle() As String
        Get
            FrenchTitle = _frTitle
        End Get

        Set(ByVal value As String)
            _frTitle = value
        End Set
    End Property


    Public Sub New()

    End Sub

    Public Sub New(id As Integer)
        If connString.ConnectionString = "" Then GetConnectionString()
        Me.ID = id
        Dim sqlConn = New SqlConnection(connString.ConnectionString)
        sqlConn.Open()

        Dim com As SqlCommand = New SqlCommand("GetDescription", sqlConn)
        Dim rs As SqlDataReader

        Try
            com.CommandType = CommandType.StoredProcedure
            com.Parameters.Add(New SqlParameter("@DescID", SqlDbType.Int)).Value = id
            com.Connection = sqlConn
            rs = com.ExecuteReader

            While rs.Read
                If Not IsDBNull(rs("ENG_TITLE")) Then EnglishTitle = rs("ENG_TITLE")
                If Not IsDBNull(rs("FR_TITLE")) Then FrenchTitle = rs("FR_TITLE")
                If Not IsDBNull(rs("ENG_DESC")) Then EnglishDescription = rs("ENG_DESC")
                If Not IsDBNull(rs("FR_DESC")) Then FrenchDescription = rs("FR_DESC")
            End While

        Catch ex As Exception
            Throw ex
        Finally
            rs.Close()
            com.Dispose()
            sqlConn.Close()
            com = Nothing
            rs = Nothing
            sqlConn = Nothing
        End Try
    End Sub


    Public Function GetDescription(ID As Integer, lang As String) As String

        If connString.ConnectionString = "" Then GetConnectionString()
        Me.ID = ID
        Dim sqlConn = New SqlConnection(connString.ConnectionString)
        sqlConn.Open()

        Dim com As SqlCommand = New SqlCommand("GetDescription", sqlConn)
        Dim rs As SqlDataReader

        Try
            com.CommandType = CommandType.StoredProcedure
            com.Parameters.Add(New SqlParameter("@DescID", SqlDbType.Int)).Value = ID
            com.Connection = sqlConn
            rs = com.ExecuteReader

            While rs.Read
                If Not IsDBNull(rs("ENG_TITLE")) Then EnglishTitle = rs("ENG_TITLE")
                If Not IsDBNull(rs("FR_TITLE")) Then FrenchTitle = rs("FR_TITLE")
                If Not IsDBNull(rs("ENG_DESC")) Then EnglishDescription = rs("ENG_DESC")
                If Not IsDBNull(rs("FR_DESC")) Then FrenchDescription = rs("FR_DESC")
            End While

            rs.Close()
            com.Dispose()
            sqlConn.Close()

        Catch ex As Exception
        End Try

        GetDescription = IIf(UCase(lang) = "E", EnglishDescription, FrenchDescription)
    End Function


End Class
