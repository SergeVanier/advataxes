Imports Microsoft.VisualBasic

<AttributeUsage(AttributeTargets.Property Or AttributeTargets.Class)>
Public Class DataStoreNameAttribute
    Inherits Attribute

    Private _dataStoreName As String
    Public Property DataStoreName() As String
        Get
            Return _dataStoreName
        End Get
        Set(ByVal value As String)
            _dataStoreName = value
        End Set
    End Property

    Public Sub New(ByVal dataStoreName As String)
        _dataStoreName = dataStoreName
    End Sub


End Class
