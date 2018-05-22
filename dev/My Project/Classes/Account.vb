
Imports System.Data
Imports System.Data.SqlClient

Public Class Account
    Private _accID As Integer
    Private _accNumber As String
    Private _accName As String
    Private _vendorNumber As String
    Private _type As String
    Private _orgID As Integer
    Private _active As Boolean
    Public Organization As Org

    Public Property ID() As Integer
        Get
            ID = _accID
        End Get

        Set(ByVal value As Integer)
            _accID = value
        End Set
    End Property

    Public Property OrgID() As Integer
        Get
            OrgID = _orgID
        End Get

        Set(ByVal value As Integer)
            _orgID = value
        End Set
    End Property

    Public Property Type() As String
        Get
            Type = _type
        End Get

        Set(ByVal value As String)
            _type = value
        End Set
    End Property

    Public Property VendorNumber() As String
        Get
            VendorNumber = _vendorNumber
        End Get

        Set(ByVal value As String)
            _vendorNumber = value
        End Set
    End Property

    Public Property Number() As String
        Get
            Number = _accNumber
        End Get

        Set(ByVal value As String)
            _accNumber = value
        End Set
    End Property

    Public Property Name() As String
        Get
            Name = _accName
        End Get

        Set(ByVal value As String)
            _accName = value
        End Set
    End Property

    Public Property Active() As Boolean
        Get
            Active = _active
        End Get

        Set(ByVal value As Boolean)
            _active = value
        End Set
    End Property


    Public Sub New()

    End Sub

    Public Sub New(id As Integer)
        GetConnectionString()
        Me.ID = id
        Dim sqlConn = New SqlConnection(connString.ConnectionString)
        sqlConn.Open()

        Dim com As SqlCommand = New SqlCommand("GetAccount", sqlConn)
        Dim rs As SqlDataReader

        Try
            com.CommandType = CommandType.StoredProcedure
            com.Parameters.Add(New SqlParameter("@accID", SqlDbType.Int)).Value = id
            com.Connection = sqlConn
            rs = com.ExecuteReader

            While rs.Read
                Me.ID = id                
                Me.Organization = New Org(CInt(rs("ORG_ID")))
                Me.Name = rs("ACC_NAME")
                Me.Number = rs("ACC_NUMBER")
                Me.Active = rs("ACTIVE")
                Me.Type = rs("ACCOUNT_TYPE")
                If Not IsDBNull(rs("VENDOR_NUMBER")) Then Me.VendorNumber = rs("VENDOR_NUMBER")
            End While


        Catch ex As Exception
            Throw ex
        Finally
            rs.Close()
            com.Dispose()
            sqlConn.Close()
        End Try

    End Sub

    Public Sub New(orgID As Integer, TPNum As String)
        GetConnectionString()
        Me.ID = ID
        Dim sqlConn = New SqlConnection(connString.ConnectionString)
        sqlConn.Open()

        Dim com As SqlCommand = New SqlCommand("GetAccount", sqlConn)
        Dim rs As SqlDataReader

        Try
            com.CommandType = CommandType.StoredProcedure
            com.Parameters.Add(New SqlParameter("@TPNum", SqlDbType.NVarChar)).Value = TPNum
            com.Parameters.Add(New SqlParameter("@OrgID", SqlDbType.Int)).Value = orgID
            com.Connection = sqlConn
            rs = com.ExecuteReader

            While rs.Read
                Me.ID = rs("ACC_ID")
                Me.Organization = New Org(CInt(rs("ORG_ID")))
                Me.Name = rs("ACC_NAME")
                Me.Number = rs("ACC_NUMBER")
                Me.Active = rs("ACTIVE")
                Me.Type = rs("ACCOUNT_TYPE")
                If Not IsDBNull(rs("VENDOR_NUMBER")) Then Me.VendorNumber = rs("VENDOR_NUMBER")
            End While

        Catch ex As Exception
            Throw ex

        Finally
            rs.Close()
            com.Dispose()
            sqlConn.Close()
        End Try

    End Sub

    Public Sub New(GLNum As String, orgID As Integer)
        GetConnectionString()
        Me.ID = ID
        Dim sqlConn = New SqlConnection(connString.ConnectionString)
        sqlConn.Open()

        Dim com As SqlCommand = New SqlCommand("GetAccount", sqlConn)
        Dim rs As SqlDataReader

        Try
            com.CommandType = CommandType.StoredProcedure
            com.Parameters.Add(New SqlParameter("@GLNum", SqlDbType.NVarChar)).Value = GLNum
            com.Parameters.Add(New SqlParameter("@OrgID", SqlDbType.Int)).Value = orgID
            com.Connection = sqlConn
            rs = com.ExecuteReader

            While rs.Read
                Me.ID = rs("ACC_ID")
                Me.Organization = New Org(CInt(rs("ORG_ID")))
                Me.Name = rs("ACC_NAME")
                Me.Number = rs("ACC_NUMBER")
                Me.Active = rs("ACTIVE")
                Me.Type = rs("ACCOUNT_TYPE")
                If Not IsDBNull(rs("VENDOR_NUMBER")) Then Me.VendorNumber = rs("VENDOR_NUMBER")
            End While


        Catch ex As Exception
            Throw ex

        Finally
            rs.Close()
            com.Dispose()
            sqlConn.Close()

        End Try

    End Sub

    Public Sub Create()
        GetConnectionString()
        Dim sqlConn = New SqlConnection(connString.ConnectionString)
        sqlConn.Open()
        Dim com As SqlCommand = New SqlCommand("CreateAccount", sqlConn)

        com.CommandType = CommandType.StoredProcedure

        com.Parameters.Add(New SqlParameter("@AccName", SqlDbType.NVarChar)).Value = Name
        com.Parameters.Add(New SqlParameter("@AccNumber", SqlDbType.NVarChar)).Value = Number
        com.Parameters.Add(New SqlParameter("@Type", SqlDbType.NVarChar)).Value = Me.Type
        If Me.Type = "TP" Or Me.Type = "Advance" Then com.Parameters.Add(New SqlParameter("@Vendor", SqlDbType.NVarChar)).Value = Me.VendorNumber
        com.Parameters.Add(New SqlParameter("@OrgID", SqlDbType.Int)).Value = OrgID

        com.Connection = sqlConn
        com.ExecuteNonQuery()

        com.Dispose()
        sqlConn.Close()
    End Sub


    Public Function CheckVendorExists(vendorNum As String, orgID As Integer) As Integer
        GetConnectionString()
        Dim sqlConn = New SqlConnection(connString.ConnectionString)
        Dim accountID As Integer
        sqlConn.Open()


        Dim com As SqlCommand = New SqlCommand("CheckVendorExists", sqlConn)
        Dim rs As SqlDataReader

        Try
            com.CommandType = CommandType.StoredProcedure
            com.Parameters.Add(New SqlParameter("@VendorNum", SqlDbType.NVarChar)).Value = vendorNum
            com.Parameters.Add(New SqlParameter("@OrgID", SqlDbType.Int)).Value = orgID
            com.Connection = sqlConn
            rs = com.ExecuteReader

            While rs.Read
                accountID = rs("ACC_ID")
            End While

        Catch ex As Exception
            Throw ex

        Finally
            rs.Close()
            sqlConn.Close()
            com.Dispose()
            rs = Nothing
            sqlConn = Nothing
            com = Nothing
        End Try

        Return accountID

    End Function

    Public Sub Update()
        GetConnectionString()
        Dim sqlConn = New SqlConnection(connString.ConnectionString)
        sqlConn.Open()
        Dim com As SqlCommand = New SqlCommand("UpdateAccount", sqlConn)

        com.CommandType = CommandType.StoredProcedure

        com.Parameters.Add(New SqlParameter("@AccID", SqlDbType.NVarChar)).Value = ID
        com.Parameters.Add(New SqlParameter("@Active", SqlDbType.NVarChar)).Value = Active

        com.Connection = sqlConn
        com.ExecuteNonQuery()

        com.Dispose()
        sqlConn.Close()
    End Sub

End Class
