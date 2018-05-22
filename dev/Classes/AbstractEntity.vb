Imports Microsoft.VisualBasic

Public Class AbstractEntity

    Private _dataStore As IDataStore

    Public Sub New(dataStore As IDataStore)
        _dataStore = dataStore
    End Sub

End Class
