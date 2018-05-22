
Imports System.Data
Imports System.Data.SqlClient

Public Class Category

    Public Const iGST As Integer = 1
    Public Const iHST As Integer = 2
    Public Const iQST As Integer = 3

    Private _id As Integer
    Private _Name As String
    Private _NameFR As String
    Private _allowSupplier As Boolean
    Private _allowRate As Boolean
    Private _allowGrat As Boolean
    Private _allowJur As Boolean
    Private _allowTaxRate As Boolean
    Private _allowAmt As Boolean
    Private _allowKM As Boolean
    Private _allowNote As Boolean
    Private _allowTaxIE As Boolean
    Private _allowReimburse As Boolean
    Private _allowAttendees As Boolean
    Private _isAllowance As Boolean
    Private _desc As String
    Private _descFR As String


    Public Property ID() As Integer
        Get
            ID = _id
        End Get

        Set(ByVal value As Integer)
            _id = value
        End Set
    End Property


    Public Property Description() As String
        Get
            Description = _desc
        End Get

        Set(ByVal value As String)
            _desc = value
        End Set
    End Property

    Public Property DescriptionFR() As String
        Get
            DescriptionFR = _descFR
        End Get

        Set(ByVal value As String)
            _descFR = value
        End Set
    End Property

    Public Property NameFR() As String
        Get
            NameFR = _NameFR
        End Get

        Set(ByVal value As String)
            _NameFR = value
        End Set
    End Property

    Public Property Name() As String
        Get
            Name = _Name
        End Get

        Set(ByVal value As String)
            _Name = value
        End Set
    End Property

    Public Property IsAllowance() As Boolean
        Get
            Return _isAllowance
        End Get
        Set(ByVal value As Boolean)
            _isAllowance = value
        End Set
    End Property


    Public Property AllowReimburse() As Boolean
        Get
            Return _allowReimburse
        End Get
        Set(ByVal value As Boolean)
            _allowReimburse = value
        End Set
    End Property

    Public Property AllowAttendees() As Boolean
        Get
            Return _allowAttendees
        End Get
        Set(ByVal value As Boolean)
            _allowAttendees = value
        End Set
    End Property

    Public Property AllowNote() As Boolean
        Get
            Return _allowNote
        End Get
        Set(ByVal value As Boolean)
            _allowNote = value
        End Set
    End Property


    Public Property AllowTaxIE() As Boolean
        Get
            Return _allowTaxIE
        End Get
        Set(ByVal value As Boolean)
            _allowTaxIE = value
        End Set
    End Property


    Public Property AllowTaxRate() As Boolean
        Get
            Return _allowTaxRate
        End Get
        Set(ByVal value As Boolean)
            _allowTaxRate = value
        End Set
    End Property


    Public Property AllowAmt() As Boolean
        Get
            Return _allowAmt
        End Get
        Set(ByVal value As Boolean)
            _allowAmt = value
        End Set
    End Property


    Public Property AllowKM() As Boolean
        Get
            Return _allowKM
        End Get
        Set(ByVal value As Boolean)
            _allowKM = value
        End Set
    End Property



    Public Property AllowJur() As Boolean
        Get
            Return _allowJur
        End Get
        Set(ByVal value As Boolean)
            _allowJur = value
        End Set
    End Property



    Public Property AllowSupplier() As Boolean
        Get
            Return _allowSupplier
        End Get
        Set(ByVal value As Boolean)
            _allowSupplier = value
        End Set
    End Property

    Public Property AllowRate() As Boolean
        Get
            Return _allowRate
        End Get
        Set(ByVal value As Boolean)
            _allowRate = value
        End Set
    End Property

    Public Property AllowGratuity() As Boolean
        Get
            Return _allowGrat
        End Get
        Set(ByVal value As Boolean)
            _allowGrat = value
        End Set
    End Property

    Public Sub New()

    End Sub

    Public Sub New(ID As Integer)
        GetConnectionString()
        Me.ID = ID
        Dim sqlConn = New SqlConnection(connString.ConnectionString)
        sqlConn.Open()

        Dim com As SqlCommand = New SqlCommand("GetCategory", sqlConn)
        Dim rs As SqlDataReader

        Try
            com.CommandType = CommandType.StoredProcedure
            com.Parameters.Add(New SqlParameter("@CatID", SqlDbType.Int)).Value = ID
            com.Connection = sqlConn
            rs = com.ExecuteReader

            While rs.Read
                Me.Name = rs("CAT_NAME")
                Me.NameFR = IIf(Not IsDBNull(rs("CAT_NAME_FR")), rs("CAT_NAME_FR"), "")
                Me.AllowAmt = rs("ALLOW_AMT")
                Me.AllowKM = rs("ALLOW_KM")
                Me.AllowJur = rs("ALLOW_JUR")
                Me.AllowTaxRate = rs("ALLOW_TAX_RATE")
                Me.AllowSupplier = rs("ALLOW_CAT")
                Me.AllowRate = rs("ALLOW_RATE")
                Me.AllowGratuity = rs("ALLOW_GRAT")
                Me.AllowNote = rs("ALLOW_NOTE")
                Me._allowTaxIE = rs("ALLOW_TAX_IE")
                Me._allowReimburse = rs("ALLOW_REIMBURSE")
                Me._allowAttendees = rs("ALLOW_ATTENDEES")
                Me.Description = IIf(Not IsDBNull(rs("CAT_DESC")), rs("CAT_DESC"), "")
                Me.DescriptionFR = IIf(Not IsDBNull(rs("CAT_DESC_FR")), rs("CAT_DESC_FR"), "")
                Me.IsAllowance = rs("IS_ALLOWANCE")
            End While

            rs.Close()
            com.Dispose()
            sqlConn.Close()

        Catch ex As Exception
        End Try
    End Sub


    Public Function GetITC(jurID As Integer, orgSize As Integer, rptDate As Date) As Decimal
        GetConnectionString()
        Dim sqlConn = New SqlConnection(connString.ConnectionString)
        sqlConn.Open()

        Dim com As SqlCommand = New SqlCommand("GetITC", sqlConn)
        Dim rs As SqlDataReader

        com.Parameters.Add(New SqlParameter("@CatID", SqlDbType.Int)).Value = ID
        com.Parameters.Add(New SqlParameter("@JurID", SqlDbType.Int)).Value = jurID
        com.Parameters.Add(New SqlParameter("@orgSize", SqlDbType.Int)).Value = orgSize
        com.Parameters.Add(New SqlParameter("@rptDate", SqlDbType.Date)).Value = rptDate

        com.CommandType = CommandType.StoredProcedure
        com.Connection = sqlConn
        rs = com.ExecuteReader

        While rs.Read
            GetITC = rs(0)
        End While

        rs.Close()
        rs = Nothing
        com.Dispose()
        com = Nothing
        sqlConn.Close()
    End Function

    Public Function GetFM(fmType As String, jurID As Integer, orgSize As Integer, fmDate As Date) As Decimal
        GetConnectionString()
        Dim sqlConn = New SqlConnection(connString.ConnectionString)
        sqlConn.Open()

        Dim com As SqlCommand = New SqlCommand("GetFM", sqlConn)
        Dim rs As SqlDataReader

        com.Parameters.Add(New SqlParameter("@CatID", SqlDbType.Int)).Value = ID
        com.Parameters.Add(New SqlParameter("@fmType", SqlDbType.NVarChar)).Value = fmType
        com.Parameters.Add(New SqlParameter("@JurID", SqlDbType.Int)).Value = jurID
        If fmType = "QST" Then com.Parameters.Add(New SqlParameter("@orgSize", SqlDbType.Int)).Value = orgSize
        com.Parameters.Add(New SqlParameter("@fmDate", SqlDbType.Date)).Value = fmDate

        com.CommandType = CommandType.StoredProcedure
        com.Connection = sqlConn
        rs = com.ExecuteReader

        While rs.Read
            GetFM = rs(0)
        End While

        rs.Close()
        rs = Nothing
        com.Dispose()
        com = Nothing
        sqlConn.Close()
    End Function


    Public Function GetRITC(jurID As Integer, orgSize As Integer, rptDate As Date) As Decimal
        GetConnectionString()
        Dim sqlConn = New SqlConnection(connString.ConnectionString)
        sqlConn.Open()

        Dim com As SqlCommand = New SqlCommand("GetRITC", sqlConn)
        Dim rs As SqlDataReader

        com.Parameters.Add(New SqlParameter("@CatID", SqlDbType.Int)).Value = ID
        com.Parameters.Add(New SqlParameter("@JurID", SqlDbType.Int)).Value = jurID
        com.Parameters.Add(New SqlParameter("@orgSize", SqlDbType.Int)).Value = orgSize
        com.Parameters.Add(New SqlParameter("@rptDate", SqlDbType.Date)).Value = rptDate

        com.CommandType = CommandType.StoredProcedure

        com.Connection = sqlConn

        rs = com.ExecuteReader


        While rs.Read
            GetRITC = rs(0)
        End While

        rs.Close()
        rs = Nothing
        com.Dispose()
        com = Nothing
        sqlConn.Close()
    End Function

    Public Function GetITR(jurID As Integer, orgSize As Integer, rptDate As Date) As Decimal
        GetConnectionString()
        Dim sqlConn = New SqlConnection(connString.ConnectionString)
        sqlConn.Open()
        Dim com As SqlCommand = New SqlCommand("GetITR", sqlConn)
        Dim rs As SqlDataReader

        com.Parameters.Add(New SqlParameter("@CatID", SqlDbType.Int)).Value = ID
        com.Parameters.Add(New SqlParameter("@JurID", SqlDbType.Int)).Value = jurID
        com.Parameters.Add(New SqlParameter("@orgSize", SqlDbType.Int)).Value = orgSize
        com.Parameters.Add(New SqlParameter("@rptDate", SqlDbType.Date)).Value = rptDate
        com.CommandType = CommandType.StoredProcedure
        com.Connection = sqlConn

        rs = com.ExecuteReader

        While rs.Read
            GetITR = rs(0)
        End While

        rs.Close()
        rs = Nothing
        com.Dispose()
        com = Nothing
        sqlConn.Close()
    End Function

    Public Sub New(Name As String)
        GetConnectionString()
        Dim sqlConn = New SqlConnection(connString.ConnectionString)
        sqlConn.Open()

        Dim com As SqlCommand = New SqlCommand("GetCategory", sqlConn)
        Dim rs As SqlDataReader

        com.CommandType = CommandType.StoredProcedure
        com.Parameters.Add(New SqlParameter("@CatName", SqlDbType.VarChar)).Value = Name
        com.Connection = sqlConn
        rs = com.ExecuteReader

        While rs.Read
            Me.ID = rs("CAT_ID")
            Me.Name = rs("CAT_NAME")
            Me.NameFR = IIf(Not IsDBNull(rs("CAT_NAME_FR")), rs("CAT_NAME_FR"), "")
            Me.AllowAmt = rs("ALLOW_AMT")
            Me.AllowKM = rs("ALLOW_KM")
            Me.AllowJur = rs("ALLOW_JUR")
            Me.AllowTaxRate = rs("ALLOW_TAX_RATE")
            Me.AllowSupplier = rs("ALLOW_CAT")
            Me.AllowRate = rs("ALLOW_RATE")
            Me.AllowGratuity = rs("ALLOW_GRAT")
            Me.AllowNote = rs("ALLOW_NOTE")
            Me._allowTaxIE = rs("ALLOW_TAX_IE")
            Me._allowReimburse = rs("ALLOW_REIMBURSE")
            Me._allowAttendees = rs("ALLOW_ATTENDEES")
            Me.Description = IIf(Not IsDBNull(rs("CAT_DESC")), rs("CAT_DESC"), "")
            Me.IsAllowance = rs("IS_ALLOWANCE")
        End While

        rs.Close()
        com.Dispose()
        sqlConn.Close()

    End Sub

    Public Function GetTaxEx(jurID As Integer, catID As Integer, taxID As Integer, expDate As Date, taxIncExc As Integer) As Single
        GetConnectionString()
        Dim sqlConn = New SqlConnection(connString.ConnectionString)
        sqlConn.Open()

        Dim com = New SqlCommand("GetTaxEx", sqlConn)
        Dim rs As SqlDataReader
        Dim returnVal As Single

        com.CommandType = CommandType.StoredProcedure
        com.Parameters.Add(New SqlParameter("@CatID", SqlDbType.Int)).Value = catID
        com.Parameters.Add(New SqlParameter("@JurID", SqlDbType.Int)).Value = jurID
        com.Parameters.Add(New SqlParameter("@ExpDate", SqlDbType.Date)).Value = expDate
        com.Parameters.Add(New SqlParameter("@TaxID", SqlDbType.Int)).Value = taxID

        com.Connection = sqlConn
        rs = com.ExecuteReader
        returnVal = 0

        While rs.Read

            If taxIncExc = 1 Then
                If rs("TAX_RATE_INCLUDED") = 0 Then
                    returnVal = 1  'tax exception is no tax applicable
                Else
                    returnVal = rs("TAX_RATE_INCLUDED")
                End If
            Else
                If rs("TAX_RATE_BEFORE") = 0 Then
                    returnVal = 1  'tax exception is no tax applicable
                Else
                    returnVal = rs("TAX_RATE_BEFORE")
                End If
            End If

        End While

        rs.Close()
        com.Dispose()
        sqlConn.Close()
        rs = Nothing
        com = Nothing

        GetTaxEx = returnVal

    End Function



    Public Function GetGST(jurID As Integer, catID As Integer, expDate As String, Optional taxIncExc As Integer = 0) As Single
        GetConnectionString()
        Dim GST As Single
        Dim sqlConn = New SqlConnection(connString.ConnectionString)
        sqlConn.Open()
        Dim dExpDate As New Date(Right(expDate, 4), Mid(expDate, 4, 2), Left(expDate, 2))

        Dim com As New SqlCommand("GetTax", sqlConn)
        Dim rs As SqlDataReader

        com.CommandType = CommandType.StoredProcedure
        com.Parameters.Add(New SqlParameter("@JurID", SqlDbType.Int)).Value = jurID
        com.Parameters.Add(New SqlParameter("@TaxID", SqlDbType.Int)).Value = iGST
        com.Parameters.Add(New SqlParameter("@ExpDate", SqlDbType.Date)).Value = dExpDate
        com.Parameters.Add(New SqlParameter("@CatID", SqlDbType.Int)).Value = catID

        com.Connection = sqlConn
        rs = com.ExecuteReader

        While rs.Read
            If taxIncExc = 1 Then
                'tax = rs("TAX_RATE") * 100
                'GST = tax / (100 + tax)
                GST = rs("TAX_INCLUDED")
            Else
                GST = rs("BEFORE_TAX")
            End If
        End While

        rs.Close()
        rs = Nothing
        com = Nothing
        sqlConn.Close()

        GetGST = GST

    End Function

    Public Function GetQST(jurID As Integer, catID As Integer, expDate As String, Optional taxIncExc As Integer = 0) As Single
        GetConnectionString()
        Dim QST As Single
        Dim sqlConn = New SqlConnection(connString.ConnectionString)
        sqlConn.Open()
        Dim dExpDate As New Date(Right(expDate, 4), Mid(expDate, 4, 2), Left(expDate, 2))

        Dim com As SqlCommand = New SqlCommand("GetTax", sqlConn)
        Dim rs As SqlDataReader

        com.CommandType = CommandType.StoredProcedure
        com.Parameters.Add(New SqlParameter("@JurID", SqlDbType.Int)).Value = jurID
        com.Parameters.Add(New SqlParameter("@TaxID", SqlDbType.Int)).Value = iQST
        com.Parameters.Add(New SqlParameter("@CatID", SqlDbType.Int)).Value = catID
        com.Parameters.Add(New SqlParameter("@ExpDate", SqlDbType.Date)).Value = dExpDate


        com.Connection = sqlConn
        rs = com.ExecuteReader

        While rs.Read
            If taxIncExc = 1 Then
                'tax = rs("TAX_RATE") * 100
                QST = rs("TAX_INCLUDED")
            Else
                QST = rs("BEFORE_TAX")
            End If
        End While

        rs.Close()
        com.Dispose()
        sqlConn.Close()

        GetQST = QST
    End Function

    Public Function GetHST(jurID As Integer, catID As Integer, expDate As String, Optional taxIncExc As Integer = 0) As Single
        GetConnectionString()
        Dim HST As Single
        Dim sqlConn = New SqlConnection(connString.ConnectionString)
        Dim dExpDate As New Date(Right(expDate, 4), Mid(expDate, 4, 2), Left(expDate, 2))
        sqlConn.Open()

        Dim com As SqlCommand = New SqlCommand("GetTax", sqlConn)
        Dim rs As SqlDataReader

        com.CommandType = CommandType.StoredProcedure
        com.Parameters.Add(New SqlParameter("@JurID", SqlDbType.Int)).Value = jurID
        com.Parameters.Add(New SqlParameter("@TaxID", SqlDbType.Int)).Value = iHST
        com.Parameters.Add(New SqlParameter("@CatID", SqlDbType.Int)).Value = catID
        com.Parameters.Add(New SqlParameter("@ExpDate", SqlDbType.Date)).Value = dExpDate

        com.Connection = sqlConn
        rs = com.ExecuteReader

        While rs.Read
            If taxIncExc = 1 Then
                'tax = rs("TAX_RATE") * 100
                HST = rs("TAX_INCLUDED")
            Else
                HST = rs("BEFORE_TAX")
            End If
        End While

        rs.Close()
        com.Dispose()
        sqlConn.Close()

        GetHST = HST

    End Function

End Class
