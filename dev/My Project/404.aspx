<%

If InStr(Request.QueryString("aspxerrorpath"), "/en/") > 0 Then
  Response.Redirect("/en/404.aspx")
ElseIf InStr(Request.QueryString("aspxerrorpath"), "/fr/") > 0 Then
  Response.Redirect("/fr/404.aspx")
Else
  Response.Redirect("/en/404.aspx")
End If

%>