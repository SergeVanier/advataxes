
<%
    Response.ContentType = "application/vnd.ms-excel"
    Response.AddHeader("Content-Disposition", "filename=excelfile.xls")
%>
<head>
</head>
<html>
<table>
<tr>
<td>Category Name</td>
<td>Category Description</td>
</tr>
<tr>
<td>Software</td>
<td>Holds data for software</td>
</tr>
<tr>
<td>Hardware</td>
<td>Hardware related data</td>
</tr>
</table>
</html>
