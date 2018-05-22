Imports System.Net
Imports System.IO

Public Class ipn

    Inherits System.Web.UI.Page

    ' dim some variables
    Dim Item_name, Item_number, Payment_status, Payment_amount
    Dim Txn_id, Receiver_email, Payer_email
    Dim objHttp, str

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'Post back to either sandbox or live
        Dim strSandbox As String = "https://www.sandbox.paypal.com/cgi-bin/webscr"
        Dim strLive As String = "https://www.paypal.com/cgi-bin/webscr"
        Dim req As HttpWebRequest = CType(WebRequest.Create(strLive), HttpWebRequest)
        Dim s As String

        If IsNothing(Session("language")) Then Session("language") = "English"

        'Set values for the request back
        req.Method = "POST"
        req.ContentType = "application/x-www-form-urlencoded"
        Dim Param() As Byte = Request.BinaryRead(HttpContext.Current.Request.ContentLength)
        Dim strRequest As String = Encoding.ASCII.GetString(Param)
        s = strRequest
        strRequest = strRequest + "&cmd=_notify-validate"
        req.ContentLength = strRequest.Length

        'for proxy
        'Dim proxy As New WebProxy(New System.Uri("http://url:port#"))
        'req.Proxy = proxy

        'Send the request to PayPal and get the response
        Dim streamOut As StreamWriter = New StreamWriter(req.GetRequestStream(), Encoding.ASCII)
        streamOut.Write(strRequest)
        streamOut.Close()
        Dim streamIn As StreamReader = New StreamReader(req.GetResponse().GetResponseStream())
        Dim strResponse As String = streamIn.ReadToEnd()
        streamIn.Close()

        If strResponse = "VERIFIED" Then

            If Request.Form("payment_status") = "Completed" Then ' Request.Form("receiver_email") = "paypal@advalorem.ca"
                Try
                    Dim p = New Payment(Request.Form("txn_id").ToString)

                    If p.txnID = "" Then
                        If Not IsNothing(Request.Form("txn_id")) Then p.txnID = Request.Form("txn_id")
                        If Not IsNothing(Request.Form("address_city")) Then p.AddressCity = Request.Form("address_city") Else p.AddressCity = ""
                        If Not IsNothing(Request.Form("address_country")) Then p.AddressCountry = Request.Form("address_country") Else p.AddressCountry = ""
                        If Not IsNothing(Request.Form("address_name")) Then p.AddressName = Request.Form("address_name") Else p.AddressName = ""
                        If Not IsNothing(Request.Form("address_state")) Then p.AddressState = Request.Form("address_state") Else p.AddressState = ""
                        If Not IsNothing(Request.Form("address_street")) Then p.AddressStreet = Request.Form("address_street") Else p.AddressStreet = ""
                        If Not IsNothing(Request.Form("address_zip")) Then p.AddressZip = Request.Form("address_zip") Else p.AddressZip = ""
                        If Not IsNothing(Request.Form("custom")) Then p.UserName = Request.Form("custom") Else p.UserName = ""
                        If Not IsNothing(Request.Form("first_name")) Then p.FirstName = Request.Form("first_name") Else p.FirstName = ""
                        If Not IsNothing(Request.Form("last_name")) Then p.LastName = Request.Form("last_name") Else p.LastName = ""
                        If Not IsNothing(Request.Form("mc_gross")) Then p.MCGross = Request.Form("mc_gross") Else p.MCGross = 0
                        If Not IsNothing(Request.Form("payer_email")) Then p.PayerEmail = Request.Form("payer_email") Else p.PayerEmail = ""
                        'If Not IsNothing(Request.Form("payment_date")) Then p.PaymentDate = Request.Form("payment_date")
                        'If Not IsNothing(Request.Form("payment_type")) Then p.PaymentType = Request.Form("payment_type") Else p.PaymentType = ""
                        'If Not IsNothing(Request.Form("payer_business_name")) Then p.PayerBusinessName = Request.Form("payer_business_name") Else p.PayerBusinessName = ""

                        p.Create()

                        Dim emp As New Employee(p.UserName)
                        Dim o As Org = emp.Organization.Parent
                        o.AccountStatus = 2
                        o.EmpNum = CInt(Request.Form("option_selection1").ToString)
                        o.Update()

                        Dim gst As Double
                        Dim qst As Double
                        Dim c As New Category(29)
                        gst = FormatNumber(CDbl(Request.Form("mc_gross").ToString) * c.GetGST(o.Jur.ID, 29, Format(Now, "dd/MM/yyyy"), 1), 2)
                        qst = FormatNumber(CDbl(Request.Form("mc_gross").ToString) * c.GetQST(o.Jur.ID, 29, Format(Now, "dd/MM/yyyy"), 1), 2)
                        If gst = 0 Then gst = c.GetHST(o.Jur.ID, 29, Format(Now, "dd/MM/yyyy"), 1)

                        c = Nothing

                        s = GetMessage(277)
                        s = Replace(s, "(Date)", IIf(Session("language") = "English", Now.ToString(Globalization.CultureInfo.CreateSpecificCulture("en-US")), Now.ToString(Globalization.CultureInfo.CreateSpecificCulture("fr-FR"))))
                        s = Replace(s, "(inv#)", p.GetNextInvNum)
                        s = Replace(s, "(clientname)", emp.FirstName & " " & emp.LastName)
                        s = Replace(s, "(clientaddress1)", o.Address1)
                        s = Replace(s, "(clientaddress2)", o.Address2)
                        s = Replace(s, "(city)", o.City)
                        s = Replace(s, "(jur)", o.Jur.Name)
                        s = Replace(s, "(country)", o.CountryName)
                        s = Replace(s, "(postal)", o.Postal)
                        s = Replace(s, "(startdate)", Format(Now, "MMM dd, yyyy"))
                        s = Replace(s, "(emp#)", Request.Form("option_selection1"))
                        s = Replace(s, "(amt)", FormatNumber(CDbl(Request.Form("mc_gross")) - gst - qst, 2))
                        s = Replace(s, "(gstamt)", gst)
                        If o.Jur.ID = 1 Then
                            s = Replace(s, "(qstamt)", qst)
                        Else
                            s = Replace(s, "<tr><td>QST</td><td align='right'>(qstamt)</td></tr>", "")
                        End If

                        s = Replace(s, "(total)", Request.Form("mc_gross"))

                        SendEmail(emp.Email, GetMessageTitle(277), s, emp.DefaultLanguage)

                        o = Nothing
                        emp = Nothing
                    End If

                    p = Nothing

                Catch ex As Exception
                    Session("Error") = GetMessage(273)
                    SendEmail("sholdaway@advalorem.ca", "error", ex.Message, "English")

                Finally
                    If Not IsNothing(Session("error")) Then
                        If Session("error") <> "" Then Response.Redirect("error.aspx")
                    Else
                        Session("message") = "THANK YOU"
                        Response.Redirect("message.aspx")
                    End If

                End Try
            End If

        ElseIf strResponse = "INVALID" Then
            'o.AccountStatus = 0
            'o.Name = Request.Form("payment_status") & s
            'o.Update()
            'o = Nothing

        Else
            'o.AccountStatus = 4
            'o.Name = s
            'o.Update()
            'o = Nothing
        End If
    End Sub


    'Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
    '    'Post back to either sandbox or live
    '    Dim strSandbox As String = "https://www.sandbox.paypal.com/cgi-bin/webscr"
    '    Dim strLive As String = "https://www.paypal.com/cgi-bin/webscr"
    '    Dim req As HttpWebRequest = CType(WebRequest.Create(strLive), HttpWebRequest)
    '    Dim s As String

    '    'Set values for the request back
    '    req.Method = "POST"
    '    req.ContentType = "application/x-www-form-urlencoded"
    '    Dim Param() As Byte = Request.BinaryRead(HttpContext.Current.Request.ContentLength)
    '    Dim strRequest As String = Encoding.ASCII.GetString(Param)
    '    s = strRequest
    '    strRequest = strRequest + "&cmd=_notify-validate"
    '    req.ContentLength = strRequest.Length

    '    'for proxy
    '    'Dim proxy As New WebProxy(New System.Uri("http://url:port#"))
    '    'req.Proxy = proxy

    '    'Send the request to PayPal and get the response
    '    Dim streamOut As StreamWriter = New StreamWriter(req.GetRequestStream(), Encoding.ASCII)
    '    streamOut.Write(strRequest)
    '    streamOut.Close()
    '    Dim streamIn As StreamReader = New StreamReader(req.GetResponse().GetResponseStream())
    '    Dim strResponse As String = streamIn.ReadToEnd()
    '    streamIn.Close()

    '    'Dim o As New Org(1122)
    '    'Dim oo As New Org(1101)

    '    'oo.Name = strResponse & strRequest

    '    If strResponse = "VERIFIED" Then

    '        If Request.Form("payment_status") = "Completed" Then ' Request.Form("receiver_email") = "paypal@advalorem.ca"
    '            Try
    '                Dim p As New Payment(Request.Form("txn_id").ToString)

    '                If p.txnID = "0" Then
    '                    If Not IsNothing(Request.Form("txn_id")) Then p.txnID = Request.Form("txn_id")
    '                    If Not IsNothing(Request.Form("address_city")) Then p.AddressCity = Request.Form("address_city") Else p.AddressCity = ""
    '                    If Not IsNothing(Request.Form("address_country")) Then p.AddressCountry = Request.Form("address_country") Else p.AddressCountry = ""
    '                    If Not IsNothing(Request.Form("address_name")) Then p.AddressName = Request.Form("address_name") Else p.AddressName = ""
    '                    If Not IsNothing(Request.Form("address_state")) Then p.AddressState = Request.Form("address_state") Else p.AddressState = ""
    '                    If Not IsNothing(Request.Form("address_street")) Then p.AddressStreet = Request.Form("address_street") Else p.AddressStreet = ""
    '                    If Not IsNothing(Request.Form("address_zip")) Then p.AddressZip = Request.Form("address_zip") Else p.AddressZip = ""
    '                    If Not IsNothing(Request.Form("custom")) Then p.UserName = Request.Form("custom") Else p.UserName = ""
    '                    If Not IsNothing(Request.Form("first_name")) Then p.FirstName = Request.Form("first_name") Else p.FirstName = ""
    '                    If Not IsNothing(Request.Form("last_name")) Then p.LastName = Request.Form("last_name") Else p.LastName = ""
    '                    If Not IsNothing(Request.Form("mc_gross")) Then p.MCGross = Request.Form("mc_gross") Else p.MCGross = 0
    '                    'If Not IsNothing(Request.Form("payer_business_name")) Then p.PayerBusinessName = Request.Form("payer_business_name") Else p.PayerBusinessName = ""
    '                    If Not IsNothing(Request.Form("payer_email")) Then p.PayerEmail = Request.Form("payer_email") Else p.PayerEmail = ""
    '                    'If Not IsNothing(Request.Form("payment_date")) Then p.PaymentDate = Request.Form("payment_date")
    '                    'If Not IsNothing(Request.Form("payment_type")) Then p.PaymentType = Request.Form("payment_type") Else p.PaymentType = ""

    '                    p.Create()
    '                    p = Nothing

    '                    Dim status As MembershipCreateStatus
    '                    Dim emp As New Employee
    '                    Dim d As New Description(25)

    '                    Membership.CreateUser( _
    '                        Session("username").ToString, _
    '                        Session("pwd").ToString, _
    '                        Session("email").ToString, _
    '                        "question", _
    '                        "answer", _
    '                        True, _
    '                        status)

    '                    SendEmail("sholdaway@advalorem.ca", "error", Session("username").ToString & Session("pwd").ToString & Session("email").ToString & status.ToString)

    '                    If status.ToString = "Success" Then
    '                        Dim o As New Org
    '                        o.GSTRate = 1
    '                        o.QSTRate = 1

    '                        o.AccountStatus = 2
    '                        o.Name = Session("Org").ToString
    '                        o.jurID = CInt(Session("jurID").ToString)
    '                        o.Address1 = Session("address1").ToString
    '                        o.Address2 = Session("address2").ToString
    '                        o.Active = 1
    '                        o.OrgTypeID = CInt(Session("orgType").ToString)

    '                        o.Create()
    '                        o = Nothing
    '                        o = New Org(Session("Org").ToString)

    '                        emp.Username = Session("username").ToString
    '                        emp.OrgID = o.ID
    '                        emp.FirstName = Session("firstname").ToString
    '                        emp.LastName = Session("lastname").ToString
    '                        emp.Title = Session("title").ToString
    '                        emp.IsAdmin = True
    '                        emp.IsSupervisor = True
    '                        emp.IsAccountant = False
    '                        emp.Email = Session("email").ToString
    '                        emp.Phone = Session("phone").ToString

    '                        emp.Create()

    '                        Roles.AddUserToRole(emp.Username, "Admin")

    '                        Dim u As MembershipUser

    '                        u = Membership.GetUser(emp.Username)

    '                        s = d.EnglishDescription
    '                        s = (Replace(s, "(name)", emp.FirstName & " " & emp.LastName))
    '                        s = (Replace(s, "(OrgName)", o.Name))
    '                        s = (Replace(s, "(username)", emp.Username))
    '                        s = Replace(s, "you must activate your account", "you must <a href='https://www.advataxes.ca/login.aspx?action=activate&id=" + u.ProviderUserKey.ToString + "&username=" + u.UserName + "'>activate your account</a>")

    '                        d = Nothing

    '                        SendEmail(u.Email, "Advataxes: Account created ", s)

    '                        Session("msg") = "<p style='font-size:1.3em;'>Your account was created.</p><br><p>An email was sent to " & u.Email & ".</p><br><p>Click the link in the email to activate your account.</p>"
    '                        Session("msgTitle") = "Account Created"

    '                        u = Nothing

    '                        o = Nothing
    '                        emp = Nothing
    '                        d = Nothing
    '                        'Response.Redirect("message.aspx")
    '                    Else
    '                        Session("error") = status.ToString
    '                    End If

    '                End If

    '                p = Nothing

    '            Catch ex As Exception
    '                Session("error") = ex.Message
    '                SendEmail("sholdaway@advalorem.ca", "error", ex.Message)

    '            Finally
    '                If Not IsNothing(Session("error")) Then
    '                    If Session("error") <> "" Then Response.Redirect("error.aspx")
    '                End If

    '            End Try
    '        End If

    '    ElseIf strResponse = "INVALID" Then
    '        'o.AccountStatus = 0
    '        'o.Name = Request.Form("payment_status") & s
    '        'o.Update()
    '        'o = Nothing

    '    Else
    '        'o.AccountStatus = 4
    '        'o.Name = s
    '        'o.Update()
    '        'o = Nothing
    '    End If
    'End Sub









    '================================================================================================================================================================================

    'Public Sub test()
    '    'begin IPN handling
    '    ' read post from PayPal system and add 'cmd'
    '    str = Request.Form & "&cmd=_notify-validate"

    '    ' post back to PayPal system to validate
    '    objHttp = Server.CreateObject("Msxml2.ServerXMLHTTP")
    '    ' set objHttp = Server.CreateObject("Msxml2.ServerXMLHTTP.4.0")
    '    ' set objHttp = Server.CreateObject("Microsoft.XMLHTTP")
    '    objHttp.open("POST", "https://www.sandbox.paypal.com/cgi-bin/webscr", False)
    '    objHttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded")
    '    objHttp.Send(str)

    '    ' assign posted variables to local variables
    '    item_name = Request.Form("item_name")
    '    item_number = Request.Form("item_number")
    '    payment_status = Request.Form("payment_status")
    '    txn_id = Request.Form("txn_id")
    '    Dim parent_txn_id = Request.Form("parent_txn_id")
    '    receiver_email = Request.Form("receiver_email")
    '    payer_email = Request.Form("payer_email")
    '    Dim reason_code = Request.Form("reason_code")
    '    Dim business = Request.Form("business")
    '    Dim quantity = Request.Form("quantity")
    '    Dim invoice = Request.Form("invoice")
    '    Dim custom = Request.Form("custom")
    '    Dim tax = Request.Form("tax")
    '    Dim option_name1 = Request.Form("option_name1")
    '    Dim option_selection1 = Request.Form("option_selection1")
    '    Dim option_name2 = Request.Form("option_name2")
    '    Dim option_selection2 = Request.Form("option_selection2")
    '    Dim num_cart_items = Request.Form("num_cart_items")
    '    Dim pending_reason = Request.Form("pending_reason")
    '    Dim payment_date = Request.Form("payment_date")
    '    Dim mc_gross = Request.Form("mc_gross")
    '    Dim mc_fee = Request.Form("mc_fee")
    '    Dim mc_currency = Request.Form("mc_currency")
    '    Dim settle_amount = Request.Form("settle_amount")
    '    Dim settle_currency = Request.Form("settle_currency")
    '    Dim exchange_rate = Request.Form("exchange_rate")
    '    Dim txn_type = Request.Form("txn_type")
    '    Dim first_name = Request.Form("first_name")
    '    Dim last_name = Request.Form("last_name")
    '    Dim payer_business_name = Request.Form("payer_business_name")
    '    Dim address_name = Request.Form("address_name")
    '    Dim address_street = Request.Form("address_street")
    '    Dim address_city = Request.Form("address_city")
    '    Dim address_state = Request.Form("address_state")
    '    Dim address_zip = Request.Form("address_zip")
    '    Dim address_country = Request.Form("address_country")
    '    Dim address_status = Request.Form("address_status")
    '    payer_email = Request.Form("payer_email")
    '    Dim payer_id = Request.Form("payer_id")
    '    Dim payer_status = Request.Form("payer_status")
    '    Dim payment_type = Request.Form("payment_type")
    '    Dim notify_version = Request.Form("notify_version")
    '    Dim verify_sign = Request.Form("verify_sign")

    '    'subscription information
    '    Dim subscr_date = Request.Form("subscr_date")
    '    Dim period1 = Request.Form("period1")
    '    Dim period2 = Request.Form("period2")
    '    Dim period3 = Request.Form("period3")
    '    Dim amount1 = Request.Form("mc_amount1")
    '    Dim amount2 = Request.Form("mc_amount2")
    '    Dim amount3 = Request.Form("mc_amount3")
    '    Dim recurring = Request.Form("recurring")
    '    Dim reattempt = Request.Form("reattempt")
    '    Dim retry_at = Request.Form("retry_at")
    '    Dim recur_times = Request.Form("recur_times")
    '    Dim username = Request.Form("username")
    '    Dim password = Request.Form("password")
    '    Dim subscr_id = Request.Form("subscr_id")

    '    'auction information
    '    Dim for_auction = Request.Form("for_auction")
    '    Dim auction_buyer_id = Request.Form("auction_buyer_id")
    '    Dim auction_closing_date = Request.Form("auction_closing_date")


    '    ' Check notification validation
    '    If (objHttp.status <> 200) Then
    '        ' HTTP error handling
    '    ElseIf (objHttp.responseText = "VERIFIED") Then
    '        ' check that Payment_status=Completed
    '        ' check that Txn_id has not been previously processed
    '        ' check that Receiver_email is your Primary PayPal email
    '        ' check that Payment_amount/Payment_currency are correct
    '        ' process payment


    '        'implement IPN handling logic for DB insertion '#########################################################


    '        'decide what to do based on txn_type - using Select Case

    '        Select Case txn_type
    '            Case "subscr_signup"

    '            Case "subscr_payment"

    '            Case "subscr_modify"

    '            Case "subscr_failed"

    '            Case "subscr_cancel"

    '            Case "subscr_eot"

    '            Case Else

    '        End Select


    '    ElseIf (objHttp.responseText = "INVALID") Then
    '        ' log for manual investigation
    '        ' add code to handle the INVALID scenario

    '    Else
    '        ' error
    '    End If
    '    objHttp = Nothing

    'End Sub
End Class

