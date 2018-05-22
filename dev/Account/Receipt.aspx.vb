Imports System.Data.SqlClient

Public Class Receipt
    Inherits System.Web.UI.Page

    Private Sub Receipt_Error(sender As Object, e As System.EventArgs) Handles Me.Error
        'If IsNothing(Session("error")) Then Session("error") = GetMessage(273 ) : Session("msgHeight") = 50
        'Response.Redirect("../login.aspx")
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim expense As Expense
        Dim con As SqlConnection
        Dim dataAdapter As SqlDataAdapter
        Dim MyCommandBuilder As SqlCommandBuilder
        Dim dataSet As New DataSet()
        Dim myRow As DataRow
        Dim MyData() As Byte
        Dim employee As Employee

        Try
            GetConnectionString()

            If Not IsNothing(Request.QueryString("id")) Then
                expense = New Expense(CInt(Request.QueryString("id")))
                employee = expense.Rpt.Emp
                con = New SqlConnection(connString.ConnectionString)
                dataAdapter = New SqlDataAdapter("Select * From tblExpense WHERE EXPENSE_ID=" & expense.ID, con)
                MyCommandBuilder = New SqlCommandBuilder(dataAdapter)

                If (Session("emp").id = employee.ID) Or (Session("emp").id = employee.Supervisor) Or (Session("emp").id = employee.DelegatedTo) Or (Session("emp").isadmin And (Session("emp").organization.id = employee.Organization.ID Or Session("emp").organization.parent.id = employee.Organization.Parent.ID)) Then
                    con.Open()
                    dataAdapter.Fill(dataSet, "tblExpense")
                    myRow = dataSet.Tables("tblExpense").Rows(0)
                    MyData = myRow("RECEIPT")
                    Response.Buffer = True
                    Response.ContentType = myRow("RECEIPT_TYPE")
                    Response.BinaryWrite(MyData)
                    con.Close()
                Else
                    Session("error") = "You are not authorized to view this data"
                    Throw New Exception
                End If

            ElseIf Not IsNothing(Request.QueryString("bbCode")) Then
                Dim bulletin As New Bulletin

                bulletin.GetMessagesByBBCode(Request.QueryString("bbCode"))

                con = New SqlConnection(connString.ConnectionString)
                dataAdapter = New SqlDataAdapter("Select * From tblBulletin WHERE BULLETIN_ID=" & CInt(bulletin.Messages(0, 0)), con)
                MyCommandBuilder = New SqlCommandBuilder(dataAdapter)

                If Session("emp").organization.id = CInt(bulletin.Messages(1, 0)) Or Session("emp").organization.parent.id = CInt(bulletin.Messages(1, 0)) Then
                    con.Open()
                    dataAdapter.Fill(dataSet, "tblBulletin")
                    myRow = dataSet.Tables("tblBulletin").Rows(0)
                    MyData = myRow("BB_FILE")
                    Response.Buffer = True
                    Response.ContentType = myRow("BB_FILE_TYPE")
                    Response.BinaryWrite(MyData)
                    con.Close()
                Else
                    Session("error") = "You are not authorized to view this data"
                    Throw New Exception
                End If
            Else
                con = New SqlConnection(connString.ConnectionString)
                dataAdapter = New SqlDataAdapter("Select * From tblUploadedReceipt WHERE ID=" & CInt(Request.QueryString("rID")) & " AND EMP_ID =" & Session("emp").id, con)
                MyCommandBuilder = New SqlCommandBuilder(dataAdapter)

                con.Open()
                dataAdapter.Fill(dataSet, "tblUploadedReceipt")
                myRow = dataSet.Tables("tblUploadedReceipt").Rows(0)
                MyData = myRow("RECEIPT")
                Response.Buffer = True
                Response.ContentType = myRow("RECEIPT_TYPE")
                Response.BinaryWrite(MyData)
                con.Close()

            End If

        Catch ex As Exception
            If IsNothing(Session("error")) Then Session("error") = "Unexpected Error"
            Response.Redirect("../error.aspx")

        Finally
            MyCommandBuilder = Nothing
            dataSet = Nothing
            dataAdapter = Nothing
            con = Nothing
            employee = Nothing
            expense = Nothing
        End Try
    End Sub

End Class