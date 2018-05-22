Imports System.Collections
Imports System.Collections.Generic

Public Class ValidationResults
    Private _validationErrors As List(Of ValidationError)

    Public ReadOnly Property IsValid() As Boolean
        Get
            Return _validationErrors.Count = 0
        End Get
    End Property

    Public ReadOnly Property Errors() As List(Of ValidationError)
        Get
            Return _validationErrors
        End Get
    End Property

    Public Sub New()
        _validationErrors = New List(Of ValidationError)
    End Sub

    Public Sub AddValidationError(key As String, errorMessage As String)
        _validationErrors.Add(New ValidationError(key, errorMessage))
    End Sub
End Class
