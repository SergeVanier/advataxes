Public Class ValidationError
    Private _errorMessage As String
    Private _key As String

    Public Property ErrorMessage() As String
        Get
            Return _errorMessage
        End Get
        Set(value As String)
            _errorMessage = value
        End Set
    End Property

    Public Property Key() As String
        Get
            Return _key
        End Get
        Set(value As String)
            _key = value
        End Set
    End Property

    Public Sub New(key As String, errorMessage As String)
        Me.Key = key
        Me.ErrorMessage = errorMessage
    End Sub
End Class
