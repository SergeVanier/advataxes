Imports Microsoft.VisualBasic
Imports System.Data
Imports System.Data.SqlClient

''' <summary>
''' Interface for a SQLDataProvider not tied to a specific architecture or system
''' </summary>
''' <remarks></remarks>
Public Interface ISQLDataProvider
    Function getDataReader(ByVal sqlStatements As String, ByVal isStoredProcedure As Boolean, ByVal parameterObject As Object) As IDataReader
    Function getDataReader(ByVal sqlStatements As String, ByVal isStoredProcedure As Boolean, ByRef parameters As List(Of SqlParameter)) As IDataReader
    Sub executeNonQuery(ByVal sqlStatements As String, ByVal isStoredProcedure As Boolean, ByVal parameterObject As Object)
    Sub executeNonQuery(ByVal sqlStatements As String, ByVal isStoredProcedure As Boolean, ByRef parameters As List(Of SqlParameter))
    Function getScalar(Of T)(ByVal sqlStatements As String, ByVal isStoredProcedure As Boolean, ByVal parameterObject As Object) As T
    Function getScalar(Of T)(ByVal sqlStatements As String, ByVal isStoredProcedure As Boolean, ByRef parameters As List(Of SqlParameter)) As t
End Interface
