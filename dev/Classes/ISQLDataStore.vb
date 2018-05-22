Imports Microsoft.VisualBasic
Imports System.Data
Imports System.Data.SqlClient

Public Interface IDataStore
    Function addEntity(Of T As New)(ByRef entity As T) As T
    Function setEntity(Of T As New)(ByRef entity As T) As T
End Interface
