Imports System.Data
Imports System.Data.SqlClient

Public Class AuditTrail
    Private _tableName As String
    Private _tableAction As String
    Private _fieldID As Integer
    Private _actionDate As Date
    Private _empID As Integer


    Public Property FieldID() As Integer
        Get
            FieldID = _fieldID
        End Get

        Set(ByVal value As Integer)
            _fieldID = value
        End Set
    End Property

    Public Property EmpID() As Integer
        Get
            EmpID = _empID
        End Get

        Set(ByVal value As Integer)
            _empID = value
        End Set
    End Property

    Public Property TableName() As String
        Get
            TableName = _tableName
        End Get

        Set(ByVal value As String)
            _tableName = value
        End Set
    End Property

    Public Property TableAction() As String
        Get
            TableAction = _tableAction
        End Get

        Set(ByVal value As String)
            _tableAction = value
        End Set
    End Property

    Public Property ActionDate() As Date
        Get
            ActionDate = _actionDate
        End Get

        Set(ByVal value As Date)
            _actionDate = value
        End Set
    End Property


    Public Sub New()

    End Sub



End Class
