Imports System.Data
Imports System.Data.SqlClient
Imports System.Net

Public Class Currency
    Private _id As Integer
    Private _Name As String
    Private _symbol As String

	Public Property ID() As Integer
        Get
            ID = _id
        End Get

        Set(ByVal value As Integer)
            _id = value
        End Set
    End Property

    Public Property Symbol() As String
        Get
            Symbol = _symbol
        End Get

        Set(ByVal value As String)
            _symbol = value
        End Set
    End Property

    Public Property Name() As String
        Get
            Name = _name
        End Get

        Set(ByVal value As String)
            _name = value
        End Set
    End Property

    Public Sub New()

    End Sub

    Public Sub New(ID As Integer)
        GetConnectionString()
        Me.ID = ID
        Dim sqlConn = New SqlConnection(connString.ConnectionString)
        sqlConn.Open()

        Dim com As SqlCommand = New SqlCommand("GetCurrency", sqlConn)
        Dim rs As SqlDataReader

        com.CommandType = CommandType.StoredProcedure
        com.Parameters.Add(New SqlParameter("@CurrID", SqlDbType.VarChar)).Value = ID

        com.Connection = sqlConn
        rs = com.ExecuteReader

        Try
            While rs.Read
                Me.ID = rs("CURR_ID")
                Me.Name = rs("CURR_NAME")
                Me.Symbol = rs("CURR_SYM")
            End While
        Catch ex As Exception

        Finally
            rs.Close()
            com.Dispose()
            sqlConn.Close()
        End Try

    End Sub

	' 2017-04-27 Doesn't work anymore
	Public Function GetExchangeRate(startDate As Date, endDate As Date) As Single
		GetConnectionString()
		Dim s As String
		Dim webClient As New System.Net.WebClient
		Dim result As String
		Dim i As Integer
		Dim con As New SqlConnection(connString.ConnectionString)

		Try
			con.Open()

			s = "http://www.oanda.com/currency/historical-rates/download?quote_currency=" _
				  & Me.Symbol _
				  & "&end_date=" _
				  & Year(endDate) & "-" & Month(endDate) & "-" & Day(endDate) _
				  & "&start_date=" _
				  & Year(startDate) & "-" & Month(startDate) & "-" & Day(startDate) _
				  & "&period=daily&display=absolute&rate=0&data_range=c&price=bid&view=table&base_currency_0=" _
				  & "CAD" _
				  & "&base_currency_1=&base_currency_2=&base_currency_3=&base_currency_4=&download=csv"

			result = webClient.DownloadString(s)

			i = InStr(result, "Period Average")
			result = Right(result, Len(result) - i - 16)
			result = Replace(result, """", "")
			result = Replace(result, ",", "")
			result = Replace(result, "Period Average", "")
			i = InStr(result, "Period Low")
			result = Left(result, i - 2)

			con.Close()
			con = Nothing
			GetExchangeRate = CSng(result)

		Catch ex As Exception
			GetExchangeRate = 1
		End Try

	End Function


	Public Function GetExchangeRateManual(currencyDate As Date, currencyName As String) As Single
		'Populate the table tblCurrencyRateManual manually from www.bankofcanada.ca/rates/exchange

		GetConnectionString()
		Dim con As New SqlConnection(connString.ConnectionString)
		Dim reader As SqlDataReader
		Dim cmd As New SqlCommand("SELECT TOP 1 [" & currencyName & "] FROM tblCurrencyRateManual WHERE date=@dateQuery", con)
		cmd.Parameters.Add("@dateQuery", SqlDbType.Date).Value = currencyDate
		Dim rate As Double

		rate = -1

		Try
			con.Open()

			reader = cmd.ExecuteReader
			While reader.Read()
				rate = reader(0)
			End While

			con.Close()
			con = Nothing

			If rate = -1 Then
				rate = 1
			End If

			GetExchangeRateManual = rate

		Catch ex As Exception
			GetExchangeRateManual = 1
		End Try

	End Function
End Class
