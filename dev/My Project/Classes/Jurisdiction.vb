
Imports System.Data
Imports System.Data.SqlClient

Public Class Jurisdiction
    Private _id As Integer
    Private _Name As String
    Private _NameFR As String
    Private _abbrFR As String
    Private _abbr As String


    Public Property ID() As Integer
        Get
            ID = _id
        End Get

        Set(ByVal value As Integer)
            _id = value
        End Set
    End Property

    Public Property AbbreviationFR() As String
        Get
            AbbreviationFR = _abbrFR
        End Get

        Set(ByVal value As String)
            _abbrFR = value
        End Set
    End Property

    Public Property NameFR() As String
        Get
            NameFR = _NameFR
        End Get

        Set(ByVal value As String)
            _NameFR = value
        End Set
    End Property

    Public Property Abbreviation() As String
        Get
            Abbreviation = _abbr
        End Get

        Set(ByVal value As String)
            _abbr = value
        End Set
    End Property

    Public Property Name() As String
        Get
            Name = _name
        End Get

        Set(ByVal value As String)
            _name = value
        End Set
    End Property

    Public Sub New()

    End Sub
    Public Sub New(ID As Integer)
        GetConnectionString()
        Me.ID = ID
        Dim sqlConn = New SqlConnection(connString.ConnectionString)
        sqlConn.Open()

        Dim com As SqlCommand = New SqlCommand("GetJurisdiction", sqlConn)
        Dim rs As SqlDataReader

        com.CommandType = CommandType.StoredProcedure
        com.Parameters.Add(New SqlParameter("@JurID", SqlDbType.VarChar)).Value = ID

        com.Connection = sqlConn
        rs = com.ExecuteReader

        Try
            While rs.Read
                Me.Name = rs("JUR_NAME")
                Abbreviation = rs("JUR_ABBR")
                NameFR = rs("JUR_NAME_FR")
                AbbreviationFR = rs("JUR_ABBR_FR")
            End While

        Catch ex As Exception
            Throw New Exception

        Finally
            rs.Close()
            com.Dispose()
            sqlConn.Close()
        End Try

    End Sub

    Public Sub New(Name As String)
        GetConnectionString()
        Me.Name = Name
        Dim sqlConn = New SqlConnection(connString.ConnectionString)
        sqlConn.Open()

        Dim com As SqlCommand = New SqlCommand("GetJurisdiction", sqlConn)
        Dim rs As SqlDataReader

        com.CommandType = CommandType.StoredProcedure
        com.Parameters.Add(New SqlParameter("@JurName", SqlDbType.VarChar)).Value = Name

        com.Connection = sqlConn
        rs = com.ExecuteReader


        While rs.Read
            Me.ID = rs("JUR_ID")
            Abbreviation = rs("JUR_ABBR")
            Name = rs("JUR_NAME")
            NameFR = rs("JUR_NAME_FR")
            AbbreviationFR = rs("JUR_ABBR_FR")
        End While

        rs.Close()
        com.Dispose()
        sqlConn.Close()
    End Sub
End Class
