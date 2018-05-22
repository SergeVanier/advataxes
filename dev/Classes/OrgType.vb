Imports System.Data
Imports System.Data.SqlClient

Public Class OrgType
    Private _id As Integer
    Private _name As String
    Private _nameFR As String

    Public Property ID() As Integer
        Get
            Return _id
        End Get
        Set(ByVal value As Integer)
            _id = value
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

    Public Property NameFR() As String
        Get
            Return _nameFR
        End Get
        Set(ByVal value As String)
            _nameFR = value
        End Set
    End Property

    Public Sub New(ID As Integer)
        GetConnectionString()
        Dim sqlConn = New SqlConnection(connString.ConnectionString)
        sqlConn.Open()

        Dim com As SqlCommand = New SqlCommand("GetOrgType", sqlConn)
        Dim rs As SqlDataReader


        com.CommandType = CommandType.StoredProcedure
        com.Parameters.Add(New SqlParameter("@ID", SqlDbType.VarChar)).Value = ID
        com.Connection = sqlConn
        rs = com.ExecuteReader

        While rs.Read
            Name = rs("ORG_TYPE_NAME")
            NameFR = rs("ORG_TYPE_NAME_FR")
            Me.ID = rs("ORG_TYPE_ID")
        End While

        rs.Close()
        com.Dispose()

        sqlConn.Close()

    End Sub

End Class
