Imports System.Data
Imports System.Data.SqlClient

Public Class UploadedReceipt
    Dim _id As Integer
    Dim _owner As Employee
    Dim _receiptType As String
    Dim _receiptDate As Date

    Public Property ID() As Integer
        Get
            Return _id
        End Get
        Set(ByVal value As Integer)
            _id = value
        End Set
    End Property


    Public Property ReceiptType() As String
        Get
            Return _receiptType
        End Get
        Set(ByVal value As String)
            _receiptType = value
        End Set
    End Property

    Public Property ReceiptDate() As Date
        Get
            Return _receiptDate
        End Get
        Set(ByVal value As Date)
            _receiptDate = value
        End Set
    End Property

    Public Property Owner() As Employee
        Get
            Return _owner
        End Get
        Set(ByVal value As Employee)
            _owner = value
        End Set
    End Property


    Public Sub New(ID As Integer)
        GetConnectionString()
        Dim sqlConn = New SqlConnection(connString.ConnectionString)
        sqlConn.Open()

        Dim com As SqlCommand = New SqlCommand("GetReceipt", sqlConn)
        Dim rs As SqlDataReader

        com.CommandType = CommandType.StoredProcedure
        com.Parameters.Add(New SqlParameter("@ID", SqlDbType.VarChar)).Value = ID
        com.Connection = sqlConn
        rs = com.ExecuteReader

        _id = ID

        While rs.Read
            Owner = New Employee(CInt(rs("emp_id")))
            ReceiptDate = rs("receipt_date")
            ReceiptType = rs("receipt_type")
        End While
        
        rs.Close()
        com.Dispose()
        sqlConn.Close()
        sqlConn = Nothing
        rs = Nothing
        com = Nothing

    End Sub

    Public Sub Delete()
        GetConnectionString()
        Dim sqlConn = New SqlConnection(connString.ConnectionString)
        sqlConn.Open()

        Dim com As SqlCommand = New SqlCommand("DeleteUploadedReceipt", sqlConn)

        com.CommandType = CommandType.StoredProcedure

        com.Parameters.Add(New SqlParameter("@ID", SqlDbType.Int)).Value = ID

        com.Connection = sqlConn
        com.ExecuteNonQuery()

        com.Dispose()
        sqlConn.Close()

    End Sub
End Class
