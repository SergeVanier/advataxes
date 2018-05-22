Imports Microsoft.VisualBasic
Imports System.Data
Imports System.Data.SqlClient
Imports System.Reflection

''' <summary>
''' Singleton Class to provide a central access point to an SQL Server Database
''' </summary>
''' <remarks></remarks>
Public Class SQLServerDataProvider
    Implements ISQLDataProvider

    Private Shared objSingleton As SQLServerDataProvider

    ' Make the only constructor private 
    ' to prevent initialization outside of 
    ' the class.
    Private Sub New()
        setConnectionStringSettings()

    End Sub



    ''' <summary>
    ''' Single access point for the object responsible of providing data from SQL Server
    ''' </summary>
    ''' <returns>The single instance of SQLServerDataProvider</returns>
    ''' <remarks></remarks>
    Public Shared Function getInstance() As SQLServerDataProvider

        ' Initialize singleton through lazy 
        ' initialization to prevent unused 
        ' singleton from taking up program 
        ' memory
        If (objSingleton Is Nothing) Then
            objSingleton = New SQLServerDataProvider()
        End If
        Return objSingleton

    End Function

    Private _connectionStringSettings As System.Configuration.ConnectionStringSettings

    Private Function openDatabaseConnection() As SqlConnection
        If String.IsNullOrEmpty(_connectionStringSettings.ConnectionString) Then
            Throw New Exception("No connection string configured")
        End If

        Return New SqlConnection(_connectionStringSettings.ConnectionString)
    End Function


    Private Function getParameterCollectionFromObject(ByVal parametersObject As Object) As List(Of SqlParameter)
        Dim sqlParameters As List(Of SqlParameter) = New List(Of SqlParameter)()

        Dim objectType As Type = parametersObject.GetType()

        Dim propertiesInfo As PropertyInfo() = objectType.GetProperties(BindingFlags.Instance Or BindingFlags.Public)
        For Each prop As PropertyInfo In propertiesInfo
            sqlParameters.Add(New SqlParameter("@" + prop.Name, prop.GetValue(parametersObject, Nothing)))
        Next

        Return sqlParameters
    End Function

    ''' <summary>
    ''' Sets the connection string for the SQLServerDataProviderInstance using the /Webapplication1 configurationPath and the dbadvaloremconnstr connection string
    ''' </summary>
    ''' <remarks></remarks>
    Public Sub setConnectionStringSettings()
        setConnectionStringSettings("dbadvaloremconnstr", "/Webapplication1")
    End Sub

    ''' <summary>
    ''' Sets the connection string for the SQLServerDataProviderInstance using the /Webapplication1 configurationPath
    ''' </summary>
    ''' <param name="connectionStringName">the connection string name in the configuration file</param>
    ''' <remarks></remarks>
    Public Sub setConnectionStringSettings(ByVal connectionStringName As String)
        setConnectionStringSettings(connectionStringName, "/Webapplication1")
    End Sub

    ''' <summary>
    ''' Sets the connection string for the SQLServerDataProviderInstance
    ''' </summary>
    ''' <param name="connectionStringName">name of the connection string</param>
    ''' <param name="configurationPath">path in the configuration file of the connection string</param>
    ''' <remarks></remarks>
    Public Sub setConnectionStringSettings(ByVal connectionStringName As String, ByVal configurationPath As String)
        Dim config As System.Configuration.Configuration = System.Web.Configuration.WebConfigurationManager.OpenWebConfiguration(configurationPath)

        If (config.ConnectionStrings.ConnectionStrings.Count > 0) Then
            _connectionStringSettings = config.ConnectionStrings.ConnectionStrings(connectionStringName)
        End If
    End Sub

    ''' <summary>
    ''' Open a dataReader
    ''' </summary>
    ''' <param name="sqlStatements">Either some SQL statements or a stored procedure</param>
    ''' <param name="isStoredProcedure">Wether sqlStatements is a stored procedure or not</param>
    ''' <param name="parameterObject">An object where every public property will be transformed in a SQLParameter</param>
    ''' <returns>a DataReader, through the IDataReader interface</returns>
    ''' <remarks>no exception handling done in this rountine, watch out for exceptions in the calling code</remarks>
    Public Function getDataReader(ByVal sqlStatements As String, ByVal isStoredProcedure As Boolean, ByVal parameterObject As Object) As IDataReader Implements ISQLDataProvider.getDataReader
        Return Me.getDataReader(sqlStatements, isStoredProcedure, Me.getParameterCollectionFromObject(parameterObject))
    End Function

    ''' <summary>
    ''' Open a dataReader
    ''' </summary>
    ''' <param name="sqlStatements">Either some SQL statements or a stored procedure</param>
    ''' <param name="isStoredProcedure">Wether sqlStatements is a stored procedure or not</param>
    ''' <param name="parameters">The list of SQL parameters</param>
    ''' <returns>a DataReader, through the IDataReader interface</returns>
    ''' <remarks>no exception handling done in this rountine, watch out for exceptions in the calling code</remarks>
    Public Function getDataReader(ByVal sqlStatements As String, ByVal isStoredProcedure As Boolean, ByRef parameters As List(Of SqlParameter)) As IDataReader Implements ISQLDataProvider.getDataReader
        Dim sqlCommand As SqlCommand = New SqlCommand(sqlStatements, openDatabaseConnection())
        sqlCommand.CommandType = If(isStoredProcedure, CommandType.StoredProcedure, CommandType.Text)

        For Each parameter As SqlParameter In parameters
            sqlCommand.Parameters.Add(parameter)
        Next

        Return sqlCommand.ExecuteReader()
    End Function

    ''' <summary>
    ''' Executes an SQL query discarding the results
    ''' </summary>
    ''' <param name="sqlStatements">Either some SQL statements or a stored procedure</param>
    ''' <param name="isStoredProcedure">Wether sqlStatements is a stored procedure or not</param>
    ''' <param name="parameterObject">An object where every public property will be transformed in a SQLParameter</param>
    ''' <remarks>no exception handling done in this rountine, watch out for exceptions in the calling code</remarks>
    Public Sub executeNonQuery(ByVal sqlStatements As String, ByVal isStoredProcedure As Boolean, ByVal parameterObject As Object) Implements ISQLDataProvider.executeNonQuery
        executeNonQuery(sqlStatements, isStoredProcedure, Me.getParameterCollectionFromObject(parameterObject))
    End Sub

    ''' <summary>
    ''' Executes an SQL query discarding the results
    ''' </summary>
    ''' <param name="sqlStatements">Either some SQL statements or a stored procedure</param>
    ''' <param name="isStoredProcedure">Wether sqlStatements is a stored procedure or not</param>
    ''' <param name="parameters">An object where every public property will be transformed in a SQLParameter</param>
    ''' <remarks>no exception handling done in this rountine, watch out for exceptions in the calling code</remarks>
    Public Sub executeNonQuery(ByVal sqlStatements As String, ByVal isStoredProcedure As Boolean, ByRef parameters As List(Of SqlParameter)) Implements ISQLDataProvider.executeNonQuery
        Dim sqlCommand As SqlCommand = New SqlCommand(sqlStatements, openDatabaseConnection())
        sqlCommand.CommandType = If(isStoredProcedure, CommandType.StoredProcedure, CommandType.Text)

        For Each parameter As SqlParameter In parameters
            sqlCommand.Parameters.Add(parameter)
        Next

        sqlCommand.ExecuteNonQuery()
    End Sub

    ''' <summary>
    ''' Executes an SQL query and returns only the first result (or first row first column)
    ''' </summary>
    ''' <typeparam name="T">The type in which to cast the SQL result</typeparam>
    ''' <param name="sqlStatements">Either some SQL statements or a stored procedure</param>
    ''' <param name="isStoredProcedure">Wether sqlStatements is a stored procedure or not</param>
    ''' <param name="parameterObject">An object where every public property will be transformed in a SQLParameter</param>
    ''' <remarks>no exception handling done in this rountine, watch out for exceptions in the calling code</remarks>
    Public Function getScalar(Of T)(ByVal sqlStatements As String, ByVal isStoredProcedure As Boolean, ByVal parameterObject As Object) As T Implements ISQLDataProvider.getScalar
        Return getScalar(Of T)(sqlStatements, isStoredProcedure, Me.getParameterCollectionFromObject(parameterObject))
    End Function
    ''' <summary>
    ''' Executes an SQL query and returns only the first result (or first row first column)
    ''' </summary>
    ''' <typeparam name="T">The type in which to cast the SQL result</typeparam>
    ''' <param name="sqlStatements">Either some SQL statements or a stored procedure</param>
    ''' <param name="isStoredProcedure">Wether sqlStatements is a stored procedure or not</param>
    ''' <param name="parameters">An object where every public property will be transformed in a SQLParameter</param>
    ''' <remarks>no exception handling done in this rountine, watch out for exceptions in the calling code</remarks>
    Public Function getScalar(Of T)(ByVal sqlStatements As String, ByVal isStoredProcedure As Boolean, ByRef parameters As List(Of SqlParameter)) As T Implements ISQLDataProvider.getScalar
        Dim sqlCommand As SqlCommand = New SqlCommand(sqlStatements, openDatabaseConnection())
        sqlCommand.CommandType = If(isStoredProcedure, CommandType.StoredProcedure, CommandType.Text)

        For Each parameter As SqlParameter In parameters
            sqlCommand.Parameters.Add(parameter)
        Next

        Dim result As T
        Dim resultType As Type = result.GetType()

        Return Convert.ChangeType(sqlCommand.ExecuteScalar(), resultType)
    End Function
End Class
