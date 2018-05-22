Imports System.Data.Sql
Imports System.Data.SqlClient
Imports System.Reflection
Imports System.Collections.Generic
Imports System.Linq
Imports System.Data

Public Class SqlHelper

    Private Shared _instance As SqlHelper

    Public Shared ReadOnly Property Instance As SqlHelper
        Get
            If IsNothing(_instance) Then
                Dim connectionString = System.Web.Configuration.WebConfigurationManager.ConnectionStrings("dbadvaloremconnstr").ConnectionString
                _instance = New SqlHelper(connectionString)
            End If

            Return _instance
        End Get
    End Property


    Private _connection As SqlConnection



    Public Sub New(connectionString As String)
        _connection = New SqlConnection(connectionString)
    End Sub

    Public Sub ExecuteNonQuery(storedProcedure As String, parameters As Object)
        Dim sqlCommand As New SqlCommand(storedProcedure, _connection)
        sqlCommand.CommandType = CommandType.StoredProcedure
        _connection.Open()



        For Each SqlParameter In GetSqlParameterCollectionFromObject(parameters)
            sqlCommand.Parameters.Add(SqlParameter)
        Next

        Try
            sqlCommand.ExecuteNonQuery()
        Catch ex As Exception
            Throw
        Finally
            _connection.Close()
        End Try





        Return
    End Sub

    Private Function GetSqlParameterCollectionFromObject(objectParameters As Object) As IEnumerable(Of SqlParameter)
        If (IsNothing(objectParameters)) Then
            Throw New ArgumentException("objectParameters cannot be null")
        End If

        Dim sqlParameterCollection As New List(Of SqlParameter)

        For Each prop As PropertyInfo In objectParameters.GetType().GetProperties()
            sqlParameterCollection.Add(New SqlParameter("@" + prop.Name + "_IN", prop.GetValue(objectParameters, Nothing)))
        Next

        Return sqlParameterCollection
    End Function


End Class
