
Imports System.Data
Imports System.Data.SqlClient



Public Class OrgCat
    Private _id As Integer
    Private _orgid As Integer
    Private _catid As Integer
    Private _active As Boolean
    Private _glAccount As String
    Private _allowanceAmt As Single
    Private _factorMethod As Boolean

    Private _note As String
    Private _reqSeg As String
    Public Category As New Category
    Public DefaultCostCenter As New PWC

    Public Property FactorMethod() As Boolean
        Get
            Return _factorMethod
        End Get
        Set(ByVal value As Boolean)
            _factorMethod = value
        End Set
    End Property

    Public Property Active() As Boolean
        Get
            Return _active
        End Get
        Set(ByVal value As Boolean)
            _active = value
        End Set
    End Property


    Public Property ID() As Integer
        Get
            Return _id
        End Get
        Set(ByVal value As Integer)
            _id = value
        End Set
    End Property

    Public Property AllowanceAmt() As Single
        Get
            Return _allowanceAmt
        End Get
        Set(ByVal value As Single)
            _allowanceAmt = value
        End Set
    End Property

    Public Property CatID() As Integer
        Get
            Return _catid
        End Get
        Set(ByVal value As Integer)
            _catid = value
        End Set
    End Property

    Public Property OrgID() As Integer
        Get
            Return _orgid
        End Get
        Set(ByVal value As Integer)
            _orgid = value
        End Set
    End Property

    Public Property GLAccount() As String
        Get
            Return _glAccount
        End Get
        Set(ByVal value As String)
            _glAccount = value
        End Set
    End Property

    Public Property RequiredSegments() As String
        Get
            Return _reqSeg
        End Get
        Set(ByVal value As String)
            _reqSeg = value
        End Set
    End Property


    Public Property Note() As String
        Get
            Return _note
        End Get
        Set(ByVal value As String)
            _note = value
        End Set
    End Property

    Public Sub New()

    End Sub

    Public Sub New(OrgCatID As Integer)
        GetConnectionString()

        Dim sqlConn = New SqlConnection(connString.ConnectionString)
        sqlConn.Open()
        Dim com As SqlCommand = New SqlCommand("GetOrgCat", sqlConn)
        Dim rs As SqlDataReader

        Try

            Me.ID = OrgCatID

            com.CommandType = CommandType.StoredProcedure

            com.Parameters.Add(New SqlParameter("@OrgCatID", SqlDbType.VarChar)).Value = OrgCatID

            com.Connection = sqlConn
            rs = com.ExecuteReader

            While rs.Read
                Me.OrgID = rs("ORG_ID")
                Category = New Category(CInt(rs("CAT_ID")))
                If Not IsDBNull(rs("DEFAULT_CC_ID")) Then DefaultCostCenter = New PWC(rs("DEFAULT_CC_ID"))
                Me.CatID = rs("CAT_ID")
                Me.GLAccount = rs("GL_ACCOUNT")
                Me.Note = rs("NOTE")
                Me.Active = rs("ACTIVE")
                Me.AllowanceAmt = rs("ALLOWANCE_AMT")
                Me.RequiredSegments = rs("REQ_SEG")
                FactorMethod = rs("FACTOR_METHOD")
            End While

            
        Catch ex As Exception

            Throw New Exception

        Finally
            rs.Close()
            com.Dispose()
            sqlConn.Close()
        End Try
    End Sub


    Public Sub New(CatID As Integer, OrgID As Integer)
        GetConnectionString()
        Dim sqlConn = New SqlConnection(connString.ConnectionString)
        sqlConn.Open()

        Dim com As SqlCommand = New SqlCommand("GetOrgCategory", sqlConn)
        Dim rs As SqlDataReader

        com.CommandType = CommandType.StoredProcedure

        com.Parameters.Add(New SqlParameter("@OrgID", SqlDbType.Int)).Value = OrgID
        com.Parameters.Add(New SqlParameter("@CatID", SqlDbType.Int)).Value = CatID

        com.Connection = sqlConn
        rs = com.ExecuteReader

        While rs.Read
            Me.ID = rs("ORG_CAT_ID")
            Me.OrgID = rs("ORG_ID")
            Me.CatID = rs("CAT_ID")
            Category = New Category(CatID)
            If Not IsDBNull(rs("DEFAULT_CC_ID")) Then DefaultCostCenter = New PWC("DEFAULT_CC_ID")
            Me.GLAccount = rs("GL_ACCOUNT")
            Me.Active = rs("ACTIVE")
            Me.AllowanceAmt = rs("ALLOWANCE_AMT")
            Me.RequiredSegments = rs("REQ_SEG")
            FactorMethod = rs("FACTOR_METHOD")
        End While

        rs.Close()
        com.Dispose()
        sqlConn.Close()
    End Sub



    'Public Sub New(CatName As String, OrgID As Integer)
    '    GetConnectionString()
    '    Dim sqlConn = New SqlConnection(connString.ConnectionString)
    '    sqlConn.Open()
    '     

    '    Dim com As SqlCommand = New SqlCommand("GetOrgCategory", sqlConn)
    '    Dim rs As SqlDataReader

    '    com.CommandType = CommandType.StoredProcedure

    '    com.Parameters.Add(New SqlParameter("@OrgID", SqlDbType.VarChar)).Value = OrgID
    '    com.Parameters.Add(New SqlParameter("@CatName", SqlDbType.VarChar)).Value = CatName

    '    com.Connection = sqlConn
    '    rs = com.ExecuteReader


    '    While rs.Read
    '        Me.OrgID = rs("ORG_ID")
    '        Me.CatID = rs("CAT_ID")
    '        Me.GLAccount = rs("GL_ACCOUNT")
    '        Me.Active = rs("ACTIVE")

    '    End While

    '    rs.Close()
    '    com.Dispose()
    '    sqlConn.Close()
    'End Sub

    Public Sub Create()
        GetConnectionString()
        Dim sqlConn = New SqlConnection(connString.ConnectionString)
        sqlConn.Open()
        Dim com As SqlCommand = New SqlCommand("CreateOrgCat", sqlConn)

        com.CommandType = CommandType.StoredProcedure

        com.Parameters.Add(New SqlParameter("@OrgID", SqlDbType.Int)).Value = OrgID
        com.Parameters.Add(New SqlParameter("@CatID", SqlDbType.Int)).Value = CatID
        com.Parameters.Add(New SqlParameter("@GLAccount", SqlDbType.NVarChar)).Value = GLAccount
        com.Parameters.Add(New SqlParameter("@Note", SqlDbType.NVarChar)).Value = Note
        com.Parameters.Add(New SqlParameter("@AllowanceAmt", SqlDbType.Money)).Value = AllowanceAmt
        com.Parameters.Add(New SqlParameter("@ReqSeg", SqlDbType.NVarChar)).Value = RequiredSegments
        com.Parameters.Add(New SqlParameter("@FactorMethod", SqlDbType.Bit)).Value = FactorMethod
        If DefaultCostCenter.ID <> 0 Then com.Parameters.Add(New SqlParameter("@DefaultCCID", SqlDbType.Int)).Value = DefaultCostCenter.ID


        com.Connection = sqlConn
        com.ExecuteNonQuery()

        com.Dispose()
        sqlConn.Close()
    End Sub

    Public Sub Update()
        GetConnectionString()
        Dim sqlConn = New SqlConnection(connString.ConnectionString)
        sqlConn.Open()

        Dim com As SqlCommand = New SqlCommand("UpdateOrgCat", sqlConn)

        com.CommandType = CommandType.StoredProcedure

        com.Parameters.Add(New SqlParameter("@OrgCatID", SqlDbType.Int)).Value = ID
        com.Parameters.Add(New SqlParameter("@GLAccount", SqlDbType.NVarChar)).Value = GLAccount
        com.Parameters.Add(New SqlParameter("@Note", SqlDbType.NVarChar)).Value = Note
        com.Parameters.Add(New SqlParameter("@AllowanceAmt", SqlDbType.Money)).Value = AllowanceAmt
        com.Parameters.Add(New SqlParameter("@ReqSeg", SqlDbType.NVarChar)).Value = RequiredSegments
        If DefaultCostCenter.ID <> 0 Then com.Parameters.Add(New SqlParameter("@DefaultCCID", SqlDbType.Int)).Value = DefaultCostCenter.ID

        com.Connection = sqlConn
        com.ExecuteNonQuery()

        com.Dispose()
        sqlConn.Close()
    End Sub

    Public Sub Delete()
        GetConnectionString()
        Dim sqlConn = New SqlConnection(connString.ConnectionString)
        sqlConn.Open()
        Dim com As SqlCommand = New SqlCommand("DeleteOrgCat", sqlConn)

        com.CommandType = CommandType.StoredProcedure

        com.Parameters.Add(New SqlParameter("@ORG_CAT_ID", SqlDbType.Int)).Value = ID

        com.Connection = sqlConn
        com.ExecuteNonQuery()

        com.Dispose()
        sqlConn.Close()
    End Sub

    Public Function GetGLAccountTotals(OrgID As Integer, dPeriodStart As Date, dPeriodEnd As Date, Optional AccSegment As String = "ANNN") As Array
        GetConnectionString()
        Dim aTotals(7, 0) As String
        Dim i As Integer
        Dim sqlConn = New SqlConnection(connString.ConnectionString)
        Dim com As SqlCommand
        sqlConn.Open()
        com = New SqlCommand("GetGLAccountTotals", sqlConn)
        Dim rs As SqlDataReader

        com.CommandType = CommandType.StoredProcedure

        com.Parameters.Add(New SqlParameter("@OrgID", SqlDbType.Int)).Value = OrgID
        com.Parameters.Add(New SqlParameter("@PeriodStart", SqlDbType.Date)).Value = dPeriodStart
        com.Parameters.Add(New SqlParameter("@PeriodEnd", SqlDbType.Date)).Value = dPeriodEnd
        com.Parameters.Add(New SqlParameter("@AccSeg", SqlDbType.VarChar)).Value = AccSegment

        com.Connection = sqlConn
        rs = com.ExecuteReader

        While rs.Read
            ReDim Preserve aTotals(7, i)

            aTotals(0, i) = rs("GL_ACCOUNT")
            aTotals(1, i) = rs("GLSum")
            aTotals(2, i) = rs("ITCSum")
            aTotals(3, i) = rs("ITRSum")
            aTotals(4, i) = rs("RITCSum")

            If AccSegment.Contains("D") Then aTotals(5, i) = IIf(Not IsDBNull(rs("DIV_CODE")), rs("DIV_CODE"), "")
            If AccSegment.Contains("P") Then aTotals(6, i) = IIf(Not IsDBNull(rs("PROJECT")), rs("PROJECT"), "")
            If AccSegment.Contains("C") Then aTotals(7, i) = IIf(Not IsDBNull(rs("COST_CENTER")), rs("COST_CENTER"), "")

            i += 1
        End While

        rs.Close()
        com.Dispose()
        sqlConn.Close()

        Return aTotals

    End Function

    Public Function GetRITCTotals(OrgID As Integer, jurID As Integer, dPeriodStart As Date, dPeriodEnd As Date) As Decimal
        GetConnectionString()
        Dim ritc As Decimal
        Dim i As Integer
        Dim sqlConn = New SqlConnection(connString.ConnectionString)
        sqlConn.Open()


        Dim com As SqlCommand = New SqlCommand("GetRITCTotals", sqlConn)
        Dim rs As SqlDataReader

        com.CommandType = CommandType.StoredProcedure

        com.Parameters.Add(New SqlParameter("@OrgID", SqlDbType.Int)).Value = OrgID
        com.Parameters.Add(New SqlParameter("@JurID", SqlDbType.Int)).Value = jurID
        com.Parameters.Add(New SqlParameter("@PeriodStart", SqlDbType.Date)).Value = dPeriodStart
        com.Parameters.Add(New SqlParameter("@PeriodEnd", SqlDbType.Date)).Value = dPeriodEnd

        com.Connection = sqlConn
        rs = com.ExecuteReader

        While rs.Read
            ritc += rs("RITCSum")
            i += 1
        End While

        rs.Close()
        com.Dispose()
        sqlConn.Close()

        Return ritc

    End Function

    Public Function GetRITCTotals(RptID As Integer, jurID As Integer) As Decimal
        GetConnectionString()
        Dim ritc As Decimal
        Dim i As Integer
        Dim sqlConn = New SqlConnection(connString.ConnectionString)
        sqlConn.Open()


        Dim com As SqlCommand = New SqlCommand("GetRITCTotalsByReport", sqlConn)
        Dim rs As SqlDataReader

        com.CommandType = CommandType.StoredProcedure

        com.Parameters.Add(New SqlParameter("@RptID", SqlDbType.Int)).Value = RptID
        com.Parameters.Add(New SqlParameter("@JurID", SqlDbType.Int)).Value = jurID

        com.Connection = sqlConn
        rs = com.ExecuteReader

        While rs.Read
            ritc = rs("RITCSum")
            i += 1
        End While

        rs.Close()
        com.Dispose()
        sqlConn.Close()

        Return ritc

    End Function

    Public Function GetGLAccountTotals(RptID As Integer, Optional AccSegment As String = "NNN") As Array
        GetConnectionString()
        Dim aTotals(7, 0) As String
        Dim i As Integer
        Dim sqlConn = New SqlConnection(connString.ConnectionString)
        sqlConn.Open()


        Dim com As SqlCommand = New SqlCommand("GetGLAccountTotalsByReport", sqlConn)
        Dim rs As SqlDataReader

        com.CommandType = CommandType.StoredProcedure

        com.Parameters.Add(New SqlParameter("@RptID", SqlDbType.Int)).Value = RptID
        com.Parameters.Add(New SqlParameter("@AccSeg", SqlDbType.VarChar)).Value = AccSegment
        com.Connection = sqlConn
        rs = com.ExecuteReader

        While rs.Read
            ReDim Preserve aTotals(7, i)

            aTotals(0, i) = rs("GL_ACCOUNT")
            aTotals(1, i) = rs("GLSum")
            aTotals(2, i) = rs("ITCSum")
            aTotals(3, i) = rs("ITRSum")
            aTotals(4, i) = rs("RITCSum")

            If AccSegment.Contains("D") Then aTotals(5, i) = IIf(Not IsDBNull(rs("DIV_CODE")), rs("DIV_CODE"), "")
            If AccSegment.Contains("P") Then aTotals(6, i) = IIf(Not IsDBNull(rs("PROJECT")), rs("PROJECT"), "")
            If AccSegment.Contains("C") Then aTotals(7, i) = IIf(Not IsDBNull(rs("COST_CENTER")), rs("COST_CENTER"), "")

            i += 1
        End While

        rs.Close()
        com.Dispose()
        sqlConn.Close()

        Return aTotals

    End Function


    Public Function GetCategoryTotals(OrgID As Integer, dPeriodStart As Date, dPeriodEnd As Date) As Array
        GetConnectionString()
        Dim aTotals(5, 0) As String
        Dim i As Integer
        Dim sqlConn = New SqlConnection(connString.ConnectionString)
        sqlConn.Open()


        Dim com As SqlCommand = New SqlCommand("GetCategoryTotals", sqlConn)
        Dim rs As SqlDataReader

        com.CommandType = CommandType.StoredProcedure

        com.Parameters.Add(New SqlParameter("@OrgID", SqlDbType.Int)).Value = OrgID
        com.Parameters.Add(New SqlParameter("@PeriodStart", SqlDbType.Date)).Value = dPeriodStart
        com.Parameters.Add(New SqlParameter("@PeriodEnd", SqlDbType.Date)).Value = dPeriodEnd

        com.Connection = sqlConn
        rs = com.ExecuteReader

        While rs.Read
            ReDim Preserve aTotals(5, i)

            aTotals(0, i) = rs("CAT_NAME")
            aTotals(1, i) = rs("CatSum")
            aTotals(2, i) = rs("ITCSum")
            aTotals(3, i) = rs("ITRSum")
            aTotals(4, i) = rs("RITCSum")
            aTotals(5, i) = rs("CAT_NAME_FR")
            i += 1
        End While

        rs.Close()
        com.Dispose()
        sqlConn.Close()

        Return aTotals

    End Function


    Public Sub SetActive(active As Boolean)
        GetConnectionString()
        Dim sqlConn = New SqlConnection(connString.ConnectionString)
        sqlConn.Open()

        Dim com As SqlCommand = New SqlCommand("SetActiveOC", sqlConn)

        com.CommandType = CommandType.StoredProcedure

        com.Parameters.Add(New SqlParameter("@orgCatID", SqlDbType.Int)).Value = ID
        com.Parameters.Add(New SqlParameter("@active", SqlDbType.Bit)).Value = active

        com.Connection = sqlConn
        com.ExecuteNonQuery()

        com.Dispose()
        sqlConn.Close()
    End Sub

    Public Function GetCategoryTotals(RptID As Integer) As Array
        GetConnectionString()
        Dim aTotals(5, 0) As String
        Dim i As Integer
        Dim sqlConn = New SqlConnection(connString.ConnectionString)
        sqlConn.Open()


        Dim com As SqlCommand = New SqlCommand("GetCategoryTotalsByReport", sqlConn)
        Dim rs As SqlDataReader

        com.CommandType = CommandType.StoredProcedure

        com.Parameters.Add(New SqlParameter("@RptID", SqlDbType.Int)).Value = RptID

        com.Connection = sqlConn
        rs = com.ExecuteReader

        Try
            While rs.Read
                ReDim Preserve aTotals(5, i)

                aTotals(0, i) = rs("CAT_NAME")
                aTotals(1, i) = rs("CatSum")
                aTotals(2, i) = rs("ITCSum")
                aTotals(3, i) = rs("ITRSum")
                aTotals(4, i) = rs("RITCSum")
                aTotals(5, i) = rs("CAT_NAME_FR")
                i += 1
            End While

        Catch ex As Exception
            Throw ex

        Finally
            rs.Close()
            com.Dispose()
            sqlConn.Close()

        End Try

        Return aTotals

    End Function
End Class
