Imports System.Configuration
Imports System.Data.SqlClient
Imports System.Data

Public Class ExcelReport
    Inherits System.Web.UI.Page


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        GetConnectionString()
        Dim dt = New DataTable()

        Dim queryStr As String = "SELECT * from tblExpense"
        Dim sda = New SqlDataAdapter(queryStr, connString.ToString)
        sda.Fill(dt)
        ExportTableData(dt)
    End Sub



    Public Sub ExportTableData(dtdata As DataTable)
        Dim dc As DataColumn
        Dim dr As DataRow
        Dim i As Integer
        Dim attach As String = "attachment;filename=journal.xls"

        Response.ClearContent()
        Response.AddHeader("content-disposition", attach)
        Response.ContentType = "application/ms-excel"
        If Not IsNothing(dtdata) Then

            For Each dc In dtdata.Columns
                Response.Write(dc.ColumnName & "\t")
            Next

            Response.Write(System.Environment.NewLine)

            For Each dr In dtdata.Rows
                For i = 0 To dtdata.Columns.Count - 1 Step 1
                    Response.Write(dr(i).ToString() + ",")
                    'Response.Write("\n")
                Next
                Response.Write(System.Environment.NewLine)
            Next
        End If
        Response.Write("<table><tr><td>col1</td><td>col2</td></tr></table>")

        Response.End()
    End Sub
End Class