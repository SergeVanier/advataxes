Imports System.Net.Mail

Public Class customFunctions
	Inherits Page

	Public emailFromServer As String

	Sub Page_Load(ByVal Sender As System.Object, ByVal e As System.EventArgs)
		If HttpContext.Current.Request.Url.Host = "www.advataxes.ca" Then
			emailFromServer = "Ad Valorem <info@advataxes.ca>"
		ElseIf HttpContext.Current.Request.Url.Host = "dev.advataxes.ca" Then
			emailFromServer = "Ad Valorem <info@dev.advataxes.ca>"
		End If
	End Sub

	Function sendEmail(ByVal emailFrom As String, ByVal emailSubject As String, ByVal emailMessage As String, Optional ByVal emailTo As String = "info@advalorem.ca") As String
		Dim returnString As String

		Dim smtp = New SmtpClient()
        smtp.Host = "localhost"
        smtp.Port = 25

		Dim mail As New MailMessage()
		mail.BodyEncoding = System.Text.Encoding.UTF8
		mail.IsBodyHtml = True

		mail.From = New MailAddress(emailFromServer)
		mail.To.Add(New MailAddress(emailTo))
		mail.ReplyToList.Add(New MailAddress(emailFrom))
		mail.Subject = emailSubject
		mail.Body = Replace(emailMessage, vbCrLf, "<br>")
	
		Try
			smtp.Send(mail)
			returnString = "1"
		Catch exc As Exception
			returnString = exc.ToString()
		End Try

		mail = Nothing
		smtp = Nothing

		Return returnString
	End Function

End Class
