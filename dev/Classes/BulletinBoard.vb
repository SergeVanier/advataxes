Imports System.Data
Imports System.Data.SqlClient

Public Class Bulletin
    Private _id As Integer
    Private _orgID As Integer
    Private _date As Date
    Private _msg As String
    Private _title As String
    Private _postedByEmp As Integer
    Private _postedByOrg As Integer
    Private _code As String
    Public Messages(7, 0) As String

    Public Property ID() As Integer

        Get
            Return _id
        End Get
        Set(ByVal value As Integer)
            _id = value
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

    Public Property PostedByEmp() As Integer

        Get
            Return _postedByEmp
        End Get
        Set(ByVal value As Integer)
            _postedByEmp = value
        End Set
    End Property

    Public Property PostedByOrg() As Integer

        Get
            Return _postedByOrg
        End Get
        Set(ByVal value As Integer)
            _postedByOrg = value
        End Set
    End Property

    Public Property Message() As String

        Get
            Return _msg
        End Get
        Set(ByVal value As String)
            _msg = value
        End Set
    End Property

    Public Property Code() As String

        Get
            Return _code
        End Get
        Set(ByVal value As String)
            _code = value
        End Set
    End Property


    Public Property Title() As String

        Get
            Return _title
        End Get
        Set(ByVal value As String)
            _title = value
        End Set
    End Property

    Public Property BBDate() As Date

        Get
            Return _date
        End Get
        Set(ByVal value As Date)
            _date = value
        End Set
    End Property

    Public Sub New()

    End Sub

    Public Sub New(orgID As Integer)
        GetConnectionString()
        Dim sqlConn = New SqlConnection(connString.ConnectionString)
        sqlConn.Open()

        Dim com As SqlCommand = New SqlCommand("GetBB", sqlConn)
        Dim rs As SqlDataReader
        Dim i As Integer

        com.CommandType = CommandType.StoredProcedure
        com.Parameters.Add(New SqlParameter("@OrgID", SqlDbType.Int)).Value = orgID

        com.Connection = sqlConn
        rs = com.ExecuteReader


        While rs.Read

            ReDim Preserve Messages(7, i)

            Messages(0, i) = rs("BULLETIN_ID")
            Messages(1, i) = rs("ORG_ID")
            Messages(2, i) = rs("BULLETIN_DATE")
            Messages(3, i) = rs("BULLETIN_MSG")
            Messages(4, i) = rs("POSTED_BY_EMP")
            Messages(5, i) = rs("BULLETIN_TITLE")
            Messages(6, i) = rs("POSTED_BY_ORG")
            Messages(7, i) = IIf(Not IsDBNull(rs("BULLETIN_CODE")), rs("BULLETIN_CODE"), "")

            i += 1

        End While

        rs.Close()
        com.Dispose()
        sqlConn.Close()
    End Sub


    Public Sub GetMessagesByBBCode(BBCode As String)
        GetConnectionString()
        Dim sqlConn = New SqlConnection(connString.ConnectionString)
        sqlConn.Open()

        Dim com As SqlCommand = New SqlCommand("GetBBByCode", sqlConn)
        Dim rs As SqlDataReader
        Dim i As Integer

        com.CommandType = CommandType.StoredProcedure
        com.Parameters.Add(New SqlParameter("@BBCode", SqlDbType.NVarChar)).Value = BBCode

        com.Connection = sqlConn
        rs = com.ExecuteReader

        While rs.Read
            ReDim Preserve Messages(7, i)

            Messages(0, i) = rs("BULLETIN_ID")
            Messages(1, i) = rs("ORG_ID")
            Messages(2, i) = rs("BULLETIN_DATE")
            Messages(3, i) = rs("BULLETIN_MSG")
            Messages(4, i) = rs("POSTED_BY_EMP")
            Messages(5, i) = rs("BULLETIN_TITLE")
            Messages(6, i) = rs("POSTED_BY_ORG")
            Messages(7, i) = rs("BULLETIN_CODE")

            i += 1

        End While

        rs.Close()
        com.Dispose()
        sqlConn.Close()
    End Sub

    Public Sub Create()
        GetConnectionString()
        Dim sqlConn = New SqlConnection(connString.ConnectionString)
        sqlConn.Open()
        Dim com As SqlCommand = New SqlCommand("CreateBBMessage", sqlConn)

        com.CommandType = CommandType.StoredProcedure

        com.Parameters.Add(New SqlParameter("@OrgID", SqlDbType.NVarChar)).Value = OrgID
        com.Parameters.Add(New SqlParameter("@BulletinMsg", SqlDbType.NVarChar)).Value = Message
        com.Parameters.Add(New SqlParameter("@BulletinTitle", SqlDbType.NVarChar)).Value = Title
        com.Parameters.Add(New SqlParameter("@BulletinDate", SqlDbType.Date)).Value = Now
        com.Parameters.Add(New SqlParameter("@PostedByEmp", SqlDbType.Int)).Value = PostedByEmp
        com.Parameters.Add(New SqlParameter("@PostedByOrg", SqlDbType.Int)).Value = PostedByOrg
        com.Parameters.Add(New SqlParameter("@Code", SqlDbType.NVarChar)).Value = Code

        com.Connection = sqlConn
        com.ExecuteNonQuery()

        com.Dispose()
        sqlConn.Close()
    End Sub

    Public Sub Delete(code As String)
        GetConnectionString()
        Dim sqlConn = New SqlConnection(connString.ConnectionString)
        sqlConn.Open()

        Dim com As SqlCommand = New SqlCommand("DeleteBBMessage", sqlConn)

        com.CommandType = CommandType.StoredProcedure

        com.Parameters.Add(New SqlParameter("@Code", SqlDbType.NVarChar)).Value = code

        com.Connection = sqlConn
        com.ExecuteNonQuery()

        com.Dispose()
        sqlConn.Close()
    End Sub


    Public Sub DeleteFile(bbCode As String)
        GetConnectionString()
        Dim sqlConn = New SqlConnection(connString.ConnectionString)
        sqlConn.Open()

        Dim com As SqlCommand = New SqlCommand("DeleteBBFile", sqlConn)

        com.CommandType = CommandType.StoredProcedure
        com.Parameters.Add(New SqlParameter("@BBCode", SqlDbType.NVarChar)).Value = bbCode

        com.Connection = sqlConn
        com.ExecuteNonQuery()

        com.Dispose()
        sqlConn.Close()
    End Sub
End Class
