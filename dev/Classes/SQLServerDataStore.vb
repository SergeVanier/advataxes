Imports Microsoft.VisualBasic
Imports System.Reflection
Imports System.Data
Imports System.Data.SqlClient
Imports System.Linq

Public Class SQLServerDataStore
    Implements IDataStore

    Private Shared objSingleton As SQLServerDataStore

    ' Make the only constructor private 
    ' to prevent initialization outside of 
    ' the class.
    Private Sub New()
        'TODO -> Invoke dependency injection mechanism to obtain the correct ISQLDataProvider
        _sqlDataProvider = SQLServerDataProvider.GetInstance()
    End Sub



    ''' <summary>
    ''' Single access point for the object responsible of doing data access using SQL as a backing store
    ''' </summary>
    ''' <returns>The single instance of SQLServerDataStore</returns>
    ''' <remarks></remarks>
    Public Shared Function getInstance() As SQLServerDataStore

        ' Initialize singleton through lazy initialization to prevent unused singleton from taking up program memory
        If (objSingleton Is Nothing) Then
            objSingleton = New SQLServerDataStore()
        End If
        Return objSingleton

    End Function

    Private _sqlDataProvider As ISQLDataProvider

    'Naming conventions fields
    Private _columnNamePrefix As String
    Private _columnNameSuffix As String
    Private _storedProcedurePrefix As String
    Private _getProcedurePrefix As String
    Private _addProcedurePrefix As String
    Private _setProcedurePrefix As String
    Private _delProcedurePrefix As String

    Public Function addEntity(Of T As New)(ByRef entity As T) As T
        Dim sqlParameters As List(Of Tuple(Of String, Object)) = New List(Of Tuple(Of String, Object))()

        Dim objectType As Type = entity.GetType()

        Dim storedProcedureName As String = _addProcedurePrefix + objectType.Name
        Dim typeCustomAttributes As Object() = objectType.GetCustomAttributes(False)

        For Each customAttribute As Object In typeCustomAttributes
            If TypeOf customAttribute Is DataStoreNameAttribute Then
                storedProcedureName = _addProcedurePrefix + CType(customAttribute, DataStoreNameAttribute).DataStoreName
                Exit For
            End If
        Next

        _sqlDataProvider.executeNonQuery(storedProcedureName, True, Me.getParameterCollectionFromObject(entity))

    End Function

    ''' <summary>
    ''' Calls the ISQLDataStore to save the entity using the naming conventions to determine the stored procedure
    ''' </summary>
    ''' <typeparam name="T">Type of the entity to save</typeparam>
    ''' <param name="entity">The entity to save</param>
    ''' <returns>the entity</returns>
    ''' <remarks></remarks>
    Public Function setEntity(Of T As New)(ByRef entity As T) As T

        Dim objectType As Type = entity.GetType()

        Dim storedProcedureName As String = _addProcedurePrefix + objectType.Name
        Dim typeCustomAttributes As Object() = objectType.GetCustomAttributes(False)

        For Each customAttribute As Object In typeCustomAttributes
            If TypeOf customAttribute Is DataStoreNameAttribute Then
                storedProcedureName = _setProcedurePrefix + CType(customAttribute, DataStoreNameAttribute).DataStoreName
                Exit For
            End If
        Next

        Return Me.loadEntityFromDataReader(Of T)(_sqlDataProvider.getDataReader(storedProcedureName, True, Me.getParameterCollectionFromObject(entity)))

    End Function

    Public Sub delEntity(Of T As New)(ByVal entityID As Integer)
        Dim objectType As Type = TypeOf(T)

        Dim storedProcedureName As String = _addProcedurePrefix + objectType.Name
        Dim typeCustomAttributes As Object() = objectType.GetCustomAttributes(False)

        For Each customAttribute As Object In typeCustomAttributes
            If TypeOf customAttribute Is DataStoreNameAttribute Then
                storedProcedureName = _setProcedurePrefix + CType(customAttribute, DataStoreNameAttribute).DataStoreName
                Exit For
            End If
        Next

        _sqlDataProvider.executeNonQuery(storedProcedureName, New (ID = entityID))
    End Sub

    ''' <summary>
    ''' Inspects all the public properties of an object and instantiates a SQL parameter using the naming conventions setuped
    ''' </summary>
    ''' <param name="parametersObject">The object from which to build the SQL parameters</param>
    ''' <returns>A list of SQL parameters</returns>
    ''' <remarks></remarks>
    Private Function getParameterCollectionFromObject(ByVal parametersObject As Object) As List(Of SqlParameter)
        Dim sqlParameters As List(Of SqlParameter) = New List(Of SqlParameter)()

        Dim objectType As Type = parametersObject.GetType()

        Dim propertiesInfo As PropertyInfo() = objectType.GetProperties(BindingFlags.Instance Or BindingFlags.Public)
        For Each prop As PropertyInfo In propertiesInfo

            Dim propName As String = _columnNamePrefix + prop.Name + _columnNameSuffix

            Dim customAttributes As Object() = prop.GetCustomAttributes(False)
            For Each customAttribute As Object In customAttributes
                If TypeOf customAttribute Is DataStoreNameAttribute Then
                    propName = CType(customAttribute, DataStoreNameAttribute).DataStoreName
                    Exit For
                End If
            Next
            sqlParameters.Add(New SqlParameter(_columnNamePrefix + prop.Name + _columnNameSuffix, prop.GetValue(parametersObject, Nothing)))
        Next

        Return sqlParameters
    End Function

    ''' <summary>
    ''' Tries to load all properties from an object by looking for a matching column name in a dataReader
    ''' </summary>
    ''' <typeparam name="T">The type of the entity to load and return</typeparam>
    ''' <param name="dataReader">the data reader from which to get the data</param>
    ''' <returns>an object of type T</returns>
    ''' <remarks></remarks>
    Private Function loadEntityFromDataReader(Of T As New)(ByRef dataReader As IDataReader) As T
        Dim entity As New T()

        Dim propertiesInfo As PropertyInfo() = entity.GetType().GetProperties(BindingFlags.Instance Or BindingFlags.Public)
        For Each prop As PropertyInfo In propertiesInfo
            If dataReader(prop.Name) <> Nothing Then
                If dataReader(prop.Name) = Convert.DBNull Then
                    If prop.PropertyType.IsPrimitive Then
                        'Do we set default values different than the ones already present in the types (i.e. int = 0, string = null, etc)?

                    Else
                        'Not a primitive, we can safely set Nothing inside the property
                        prop.SetValue(entity, Nothing, Nothing)
                    End If
                Else 'We have a value
                    prop.SetValue(entity, Convert.ChangeType(dataReader(prop.Name), prop.PropertyType), Nothing)
                End If
            Else 'Hmm no columns in the dataReader with that property's name
            End If
        Next

        'We've loaded all the properties, lets return the entity
        Return entity

    End Function

    ''' <summary>
    ''' Loads a list of entity by loading all properties of the entity with the matching column by name, for every record in the dataReader
    ''' </summary>
    ''' <typeparam name="T">the type of Entity</typeparam>
    ''' <param name="dataReader">the dataReader</param>
    ''' <returns>A list(Of Entity)</returns>
    ''' <remarks></remarks>
    Private Function loadEntityListFromDataReader(Of T As New)(ByRef dataReader As IDataReader) As List(Of T)
        Dim listOfEntity As New List(Of T)

        While dataReader.Read()
            listOfEntity.Add(Me.loadEntityFromDataReader(Of T)(dataReader))
        End While

        Return listOfEntity

    End Function

End Class
