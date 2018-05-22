Imports System.Data
Imports System.Data.SqlClient

Public Class PWC
    Private _ID As Integer
    Private _orgID As Integer
    Private _pwcNumber As String
    Private _pwcDescription As String
    Private _pwcType As String
    Private _active As Boolean

    Public Property Active() As Boolean
        Get
            Return _active
        End Get
        Set(ByVal value As Boolean)
            _active = value
        End Set
    End Property

    Public Property PWCNumber() As String
        Get
            Return _pwcNumber
        End Get
        Set(ByVal value As String)
            _pwcNumber = value
        End Set
    End Property

    Public Property PWCDescription() As String
        Get
            Return _PWCDescription
        End Get
        Set(ByVal value As String)
            _PWCDescription = value
        End Set
    End Property

    Public Property PWCType() As String
        Get
            Return _PWCType
        End Get
        Set(ByVal value As String)
            _PWCType = value
        End Set
    End Property

    Public Property ID() As Integer
        Get
            Return _ID
        End Get
        Set(ByVal value As Integer)
            _ID = value
        End Set
    End Property

    Public Property OrgID() As Integer
        Get
            Return _orgID
        End Get
        Set(ByVal value As Integer)
            _orgID = value
        End Set
    End Property

    Public Sub New()

    End Sub

    Public Sub New(pwcID As Integer)
        GetConnectionString()
        Dim sqlConn = New SqlConnection(connString.ConnectionString)
        sqlConn.Open()
        Dim com As SqlCommand = New SqlCommand("GetPWC", sqlConn)
        Dim rs As SqlDataReader

        Try

            Me.ID = pwcID

            com.CommandType = CommandType.StoredProcedure

            com.Parameters.Add(New SqlParameter("@pwcID", SqlDbType.Int)).Value = pwcID

            com.Connection = sqlConn
            rs = com.ExecuteReader


            While rs.Read
                Me.OrgID = rs("ORG_ID")                
                Me.PWCDescription = rs("PWC_DESCRIPTION")
                Me.PWCNumber = rs("PWC_NUMBER")
                Me.Active = rs("ACTIVE")
                Me.PWCType = rs("PWC_TYPE")
            End While

            
        Catch ex As Exception
            Throw ex

        Finally
            rs.Close()
            com.Dispose()
            sqlConn.Close()

        End Try

    End Sub

    Public Sub New(pwcNum As String, pwcType As String, orgID As Integer)
        GetConnectionString()
        Dim sqlConn = New SqlConnection(connString.ConnectionString)
        sqlConn.Open()
        Dim com As SqlCommand = New SqlCommand("GetPWCByNumTypeOrg", sqlConn)
        Dim rs As SqlDataReader


        Try
            com.CommandType = CommandType.StoredProcedure

            com.Parameters.Add(New SqlParameter("@orgID", SqlDbType.Int)).Value = orgID
            com.Parameters.Add(New SqlParameter("@pwcNum", SqlDbType.VarChar)).Value = pwcNum
            com.Parameters.Add(New SqlParameter("@pwcType", SqlDbType.VarChar)).Value = pwcType

            com.Connection = sqlConn
            rs = com.ExecuteReader

            While rs.Read
                Me.OrgID = rs("ORG_ID")
                Me.ID = rs("PWC_ID")
                Me.PWCDescription = rs("PWC_DESCRIPTION")
                Me.PWCNumber = rs("PWC_NUMBER")
                Me.Active = rs("ACTIVE")
                Me.PWCType = rs("PWC_TYPE")
            End While

        Catch ex As Exception
            Throw ex

        Finally
            rs.Close()
            com.Dispose()
            sqlConn.Close()

        End Try

    End Sub

    Public Sub New(pwcNum As String, orgID As Integer)
        GetConnectionString()
        Dim sqlConn = New SqlConnection(connString.ConnectionString)
        sqlConn.Open()
        Dim com As SqlCommand = New SqlCommand("GetPWCByNumOrg", sqlConn)
        Dim rs As SqlDataReader

        Try            
            com.CommandType = CommandType.StoredProcedure

            com.Parameters.Add(New SqlParameter("@orgID", SqlDbType.Int)).Value = orgID
            com.Parameters.Add(New SqlParameter("@pwcNum", SqlDbType.VarChar)).Value = pwcNum

            com.Connection = sqlConn
            rs = com.ExecuteReader

            While rs.Read
                Me.OrgID = rs("ORG_ID")
                Me.ID = rs("PWC_ID")
                Me.PWCDescription = rs("PWC_DESCRIPTION")
                Me.PWCNumber = rs("PWC_NUMBER")
                Me.Active = rs("ACTIVE")
                Me.PWCType = rs("PWC_TYPE")
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
        Dim com As SqlCommand = New SqlCommand("CreatePWC", sqlConn)

        com.CommandType = CommandType.StoredProcedure

        com.Parameters.Add(New SqlParameter("@OrgID", SqlDbType.Int)).Value = OrgID
        com.Parameters.Add(New SqlParameter("@pwcNumber", SqlDbType.NVarChar)).Value = PWCNumber
        com.Parameters.Add(New SqlParameter("@pwcDescription", SqlDbType.NVarChar)).Value = PWCDescription
        com.Parameters.Add(New SqlParameter("@pwcType", SqlDbType.NVarChar)).Value = PWCType

        com.Connection = sqlConn
        com.ExecuteNonQuery()

        com.Dispose()
        sqlConn.Close()
    End Sub

    Public Sub Update()
        GetConnectionString()
        Dim sqlConn = New SqlConnection(connString.ConnectionString)
        sqlConn.Open()
        Dim com As SqlCommand = New SqlCommand("UpdatePWC", sqlConn)

        com.CommandType = CommandType.StoredProcedure

        com.Parameters.Add(New SqlParameter("@pwcID", SqlDbType.Int)).Value = ID
        com.Parameters.Add(New SqlParameter("@pwcNumber", SqlDbType.NVarChar)).Value = PWCNumber
        com.Parameters.Add(New SqlParameter("@pwcDescription", SqlDbType.NVarChar)).Value = PWCDescription
        com.Parameters.Add(New SqlParameter("@pwcType", SqlDbType.NVarChar)).Value = PWCType
        com.Parameters.Add(New SqlParameter("@Active", SqlDbType.Bit)).Value = Active

        com.Connection = sqlConn
        com.ExecuteNonQuery()

        com.Dispose()
        sqlConn.Close()
    End Sub

End Class
