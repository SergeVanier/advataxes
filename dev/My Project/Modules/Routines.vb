Imports System.Data
Imports System.Data.SqlClient
Imports System.Configuration
Imports System.IO
Imports System.Net.Mail
Imports System.Net.Mime
Imports aspNetEmail
Imports System.Linq



Module Routines

    Private rootWebConfig As System.Configuration.Configuration
    Public connString As New System.Configuration.ConnectionStringSettings
    Public AppError As String

    Public Const iALLOWANCE As Integer = 1
    Public Const iDONATION As Integer = 12
    Public Const iFIXED_CAR_ALLOWANCE As Integer = 41
    Public Const iINSURANCE_PREMIUM As Integer = 15
    Public Const iKM_ALLOWANCE As Integer = 4
    Public Const iLODGING_ALLOWANCE As Integer = 6
    Public Const iMEAL_ALLOWANCE As Integer = 2
    Public Const iMEAL_ALLOWANCE_LONG_HAUL_TRUCK As Integer = 8
    Public Const iPERSONAL_USE As Integer = 44
    Public Const iTOLLS As Integer = 27
    Public Const iSELECTABLE_RATE As Integer = 5
    Public Const iOPEN As Integer = 1
    Public Const iSUBMITTED As Integer = 2
    Public Const iAPPROVED As Integer = 3
    Public Const iFINALIZED As Integer = 4
    Public Const iREJECTED As Integer = 5
    Public Const iREVERSED As Integer = 99
    Public Const iGST As Integer = 1
    Public Const iHST As Integer = 2
    Public Const iQST As Integer = 3


    Public Sub main()
    End Sub

    ''' <summary>
    ''' Used to get descriptions in english or french from tblDescription for translation
    ''' </summary>
    ''' <param name="msgID">table ID of description to retrieve</param>
    ''' <param name="lang">language of description to retrieve, french or english</param>
    ''' <returns>a description in french or english</returns>
    ''' <remarks></remarks>

    Public Function GetMessage(msgID As Integer, Optional lang As String = "default") As String

        GetConnectionString()
        Dim employee As Employee
        Dim description = New Description(msgID)
        Dim allUsers = Membership.GetAllUsers()
        Dim applicationName As String = Membership.ApplicationName

        'Dim paul03 = Membership.GetAllUsers.Item("Paul03")
        'employee = New Employee("Paul03")


        If lang = "default" And Not IsNothing(Membership.GetUser()) Then
            employee = New Employee(Membership.GetUser.UserName)
            GetMessage = IIf(employee.DefaultLanguage = "English", description.EnglishDescription, description.FrenchDescription)
        Else
            GetMessage = IIf(lang = "English", description.EnglishDescription, description.FrenchDescription)
        End If

        description = Nothing
        employee = Nothing
    End Function


    ''' <summary>
    ''' Gets message title from tblDescription, in french or english
    ''' </summary>
    ''' <param name="msgID">table ID of title to retrieve</param>
    ''' <param name="lang">language of title to retrieve, french or english</param>
    ''' <returns>a title in french or english</returns>
    ''' <remarks></remarks>
    Public Function GetMessageTitle(msgID As Integer, Optional lang As String = "default") As String
        GetConnectionString()
        Dim employee As Employee
        Dim description = New Description(msgID)

        If lang = "default" Then
            employee = New Employee(Membership.GetUser.UserName)
            GetMessageTitle = IIf(employee.DefaultLanguage = "English", description.EnglishTitle, description.FrenchTitle)
        Else
            GetMessageTitle = IIf(lang = "English", description.EnglishTitle, description.FrenchTitle)
        End If

        employee = Nothing
        description = Nothing
    End Function


    ''' <summary>
    ''' Attaches a file from the users computer to an expense
    ''' </summary>
    ''' <param name="fu">file upload object</param>
    ''' <param name="expID">expense ID</param>
    ''' <returns>0 if upload failed, 1 if succeeded, 2 if file was larger than 5MB</returns>
    ''' <remarks></remarks>
    Public Function UploadFile(fu As FileUpload, expID As Integer) As Integer
        GetConnectionString()
        Dim con As New SqlConnection(connString.ConnectionString)
        Dim dataAdapter As New SqlDataAdapter
        Dim myCommandBuilder As SqlCommandBuilder
        Dim dataSet As New DataSet
        Dim memoryStream As MemoryStream
        Dim bData As Byte()
        Dim reader As BinaryReader
        Dim expense As New Expense(expID)
        Dim loggedInUser As New Employee(Membership.GetUser.UserName)

        Try
            UploadFile = 1
            'check that the logged in user has the right to attach a file to the current expense
            If loggedInUser.ID = expense.Rpt.Emp.ID Or loggedInUser.ID = expense.Rpt.Emp.Supervisor Or loggedInUser.ID = expense.Rpt.Emp.Finalizer Or loggedInUser.ID = expense.Rpt.Emp.DelegatedTo Then
                If fu.HasFile Then
                    If fu.FileContent.Length < 5000000 Then
                        dataAdapter = New SqlDataAdapter("SELECT * FROM tblExpense WHERE EXPENSE_ID=" & expID, con)
                        myCommandBuilder = New SqlCommandBuilder(dataAdapter)
                        dataAdapter.MissingSchemaAction = MissingSchemaAction.AddWithKey
                        con.Open()
                        dataAdapter.Fill(dataSet, "tblExpense")

                        reader = New BinaryReader(fu.FileContent)
                        bData = reader.ReadBytes(reader.BaseStream.Length)
                        memoryStream = New MemoryStream(bData, 0, bData.Length)
                        memoryStream.Close()

                        dataSet.Tables("tblExpense").Rows(0)("RECEIPT") = bData

                        Select Case UCase(Right(fu.PostedFile.FileName, 3))
                            Case "JPG" : dataSet.Tables("tblExpense").Rows(0)("RECEIPT_TYPE") = "image/jpeg"
                            Case "PNG" : dataSet.Tables("tblExpense").Rows(0)("RECEIPT_TYPE") = "image/png"
                            Case "GIF" : dataSet.Tables("tblExpense").Rows(0)("RECEIPT_TYPE") = "image/gif"
                            Case "PDF" : dataSet.Tables("tblExpense").Rows(0)("RECEIPT_TYPE") = "application/pdf"
                            Case "TXT" : dataSet.Tables("tblExpense").Rows(0)("RECEIPT_TYPE") = "text/plain"
                            Case "HTM" : dataSet.Tables("tblExpense").Rows(0)("RECEIPT_TYPE") = "text/html"
                            Case "HTML" : dataSet.Tables("tblExpense").Rows(0)("RECEIPT_TYPE") = "text/html"
                            Case Else : dataSet.Tables("tblExpense").Rows(0)("RECEIPT_TYPE") = "image/jpeg"
                        End Select
                        dataSet.Tables("tblExpense").Rows(0)("RECEIPT_NAME") = expense.Rpt.Emp.EmpNum & "-" & expense.Rpt.Name & "-" & expense.ID
                        dataSet.Tables("tblExpense").Rows(0)("RECEIPT_DATE") = Now
                        dataAdapter.Update(dataSet, "tblExpense")

                    Else
                        UploadFile = 2
                    End If
                End If
            Else
                Throw New Exception
            End If

        Catch ex As Exception
            UploadFile = 0

        Finally
            con.Close()
            con = Nothing
            memoryStream = Nothing
            bData = Nothing
            reader = Nothing
            myCommandBuilder = Nothing
            dataSet = Nothing
            dataAdapter = Nothing
            loggedInUser = Nothing
            expense = Nothing
        End Try
    End Function


    ''' <summary>
    ''' Attaches a file that was previously uploaded in MyReceipts to an expense
    ''' </summary>
    ''' <param name="image">image file that was retrieved from tblUploadedReceipt</param>
    ''' <param name="type">file type of image that was uploaded</param>
    ''' <param name="receiptDate">date receipt was uploaded to tblUploadedReceipt</param>
    ''' <param name="expID">expense ID of the expense we are attaching the image to</param>
    ''' <returns>0 if action failed, 1 if succeeded </returns>
    ''' <remarks></remarks>

    Public Function UploadFile(image As Byte(), type As String, receiptDate As String, expID As Integer) As Integer
        GetConnectionString()
        Dim con As New SqlConnection(connString.ConnectionString)
        Dim dataAdapter As SqlDataAdapter
        Dim myCommandBuilder As SqlCommandBuilder
        Dim dataSet As New DataSet
        Dim expense As New Expense(expID)
        Dim loggedInUser As New Employee(Membership.GetUser.UserName)

        Try
            UploadFile = 1
            'check that the logged in user has the right to attach a file to the current expense
            If loggedInUser.ID = expense.Rpt.Emp.ID Or loggedInUser.ID = expense.Rpt.Emp.Supervisor Or loggedInUser.ID = expense.Rpt.Emp.Finalizer Or loggedInUser.ID = expense.Rpt.Emp.DelegatedTo Then

                dataAdapter = New SqlDataAdapter("SELECT * FROM tblExpense WHERE EXPENSE_ID=" & expID, con)
                myCommandBuilder = New SqlCommandBuilder(dataAdapter)
                'Dim exp As New Expense(hdnExpenseID.Value)
                dataAdapter.MissingSchemaAction = MissingSchemaAction.AddWithKey
                con.Open()
                dataAdapter.Fill(dataSet, "tblExpense")

                dataSet.Tables("tblExpense").Rows(0)("RECEIPT") = image

                If UCase(Right(type, 4)) = "JPEG" Then dataSet.Tables("tblExpense").Rows(0)("RECEIPT_TYPE") = "image/jpeg"
                If UCase(Right(type, 3)) = "JPG" Then dataSet.Tables("tblExpense").Rows(0)("RECEIPT_TYPE") = "image/jpeg"
                If UCase(Right(type, 3)) = "PNG" Then dataSet.Tables("tblExpense").Rows(0)("RECEIPT_TYPE") = "image/png"
                If UCase(Right(type, 3)) = "GIF" Then dataSet.Tables("tblExpense").Rows(0)("RECEIPT_TYPE") = "image/gif"
                If UCase(Right(type, 3)) = "PDF" Then dataSet.Tables("tblExpense").Rows(0)("RECEIPT_TYPE") = "application/pdf"
                If UCase(Right(type, 3)) = "TXT" Then dataSet.Tables("tblExpense").Rows(0)("RECEIPT_TYPE") = "text/plain"
                If UCase(Right(type, 3)) = "HTM" Then dataSet.Tables("tblExpense").Rows(0)("RECEIPT_TYPE") = "text/html"
                If UCase(Right(type, 3)) = "HTML" Then dataSet.Tables("tblExpense").Rows(0)("RECEIPT_TYPE") = "text/html"
                dataSet.Tables("tblExpense").Rows(0)("RECEIPT_NAME") = expense.Rpt.Emp.EmpNum & "-" & expense.Rpt.Name & "-" & expense.ID
                dataSet.Tables("tblExpense").Rows(0)("RECEIPT_DATE") = receiptDate
                dataAdapter.Update(dataSet, "tblExpense")
            Else
                Throw New Exception
            End If

        Catch ex As Exception
            UploadFile = 0

        Finally
            con.Close()
            con = Nothing
            myCommandBuilder = Nothing
            dataSet = Nothing
            dataAdapter = Nothing
            loggedInUser = Nothing
            expense = Nothing
        End Try
    End Function

    ''' <summary>
    ''' uploads a file to the bulletin board
    ''' </summary>
    ''' <param name="fu">fileupload object</param>
    ''' <param name="BBID">bulletin ID</param>
    ''' <returns>0 if action failed, 1 if succeeded, 2 if file is over 5MB</returns>
    ''' <remarks></remarks>
    Public Function UploadBBFile(fu As FileUpload, BBID As Integer) As String
        GetConnectionString()
        Dim con As New SqlConnection(connString.ConnectionString)
        Dim dataAdapter As SqlDataAdapter
        Dim myCommandBuilder As SqlCommandBuilder
        Dim dataSet As New DataSet
        Dim memoryStream As MemoryStream
        Dim bData As Byte()
        Dim reader As BinaryReader


        Try
            UploadBBFile = 1
            con.Open()

            If fu.HasFile Then
                If fu.FileContent.Length < 5000000 Then
                    dataAdapter = New SqlDataAdapter("SELECT * FROM tblBulletin WHERE BULLETIN_ID=" & BBID, con)
                    myCommandBuilder = New SqlCommandBuilder(dataAdapter)
                    'Dim exp As New Expense(hdnExpenseID.Value)
                    dataAdapter.MissingSchemaAction = MissingSchemaAction.AddWithKey
                    dataAdapter.Fill(dataSet, "tblBulletin")

                    reader = New BinaryReader(fu.FileContent)
                    bData = reader.ReadBytes(reader.BaseStream.Length)
                    memoryStream = New MemoryStream(bData, 0, bData.Length)
                    memoryStream.Close()

                    dataSet.Tables("tblBulletin").Rows(0)("BB_FILE") = bData

                    Select Case UCase(Right(fu.PostedFile.FileName, 3))
                        Case "JPG" : dataSet.Tables("tblBulletin").Rows(0)("BB_FILE_TYPE") = "image/jpeg"
                        Case "PNG" : dataSet.Tables("tblBulletin").Rows(0)("BB_FILE_TYPE") = "image/png"
                        Case "GIF" : dataSet.Tables("tblBulletin").Rows(0)("BB_FILE_TYPE") = "image/gif"
                        Case "PDF" : dataSet.Tables("tblBulletin").Rows(0)("BB_FILE_TYPE") = "application/pdf"
                        Case "TXT" : dataSet.Tables("tblBulletin").Rows(0)("BB_FILE_TYPE") = "text/plain"
                        Case "HTM" : dataSet.Tables("tblBulletin").Rows(0)("BB_FILE_TYPE") = "text/html"
                        Case "HTML" : dataSet.Tables("tblBulletin").Rows(0)("BB_FILE_TYPE") = "text/html"
                        Case "OCX" : dataSet.Tables("tblBulletin").Rows(0)("BB_FILE_TYPE") = "application/vnd.openxmlformats-officedocument.wordprocessingml.document"
                        Case "DOC" : dataSet.Tables("tblBulletin").Rows(0)("BB_FILE_TYPE") = "application/msword"
                        Case "XLS" : dataSet.Tables("tblBulletin").Rows(0)("BB_FILE_TYPE") = "application/vnd.ms-excel"
                        Case "LSX" : dataSet.Tables("tblBulletin").Rows(0)("BB_FILE_TYPE") = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
                        Case Else : dataSet.Tables("tblBulletin").Rows(0)("BB_FILE_TYPE") = "image/jpeg"
                    End Select

                    dataAdapter.Update(dataSet, "tblBulletin")
                Else
                    UploadBBFile = 2
                End If
            End If

        Catch ex As Exception
            UploadBBFile = 0

        Finally
            con.Close()
            con = Nothing
            memoryStream = Nothing
            bData = Nothing
            reader = Nothing
            myCommandBuilder = Nothing
            dataSet = Nothing
            dataAdapter = Nothing
        End Try
    End Function


    ''' <summary>
    ''' Gets the ID of the last receipt that was uploaded by the specified employee
    ''' </summary>
    ''' <param name="empID">employee ID</param>
    ''' <returns>receipt ID</returns>
    ''' <remarks></remarks>
    Public Function GetLastReceiptID(empID As Integer) As Integer
        GetConnectionString()
        Dim sqlConn = New SqlConnection(connString.ConnectionString)
        Dim lastID As Integer

        sqlConn.Open()

        Dim com As SqlCommand = New SqlCommand("GetLastReceiptID", sqlConn)
        Dim rs As SqlDataReader

        com.CommandType = CommandType.StoredProcedure
        com.Parameters.Add(New SqlParameter("@EmpID", SqlDbType.Int)).Value = empID
        com.Connection = sqlConn
        rs = com.ExecuteReader

        While rs.Read
            lastID = rs("LAST_RECEIPT_ID")
        End While

        rs.Close()
        com.Dispose()
        sqlConn.Close()
        sqlConn = Nothing
        rs = Nothing

        GetLastReceiptID = lastID
    End Function


    ''' <summary>
    ''' Saves custom tags. only available to a user who is defined as IsAdvalorem = True
    ''' </summary>
    ''' <param name="create">true = create table entries, false = update existing table values</param>
    ''' <param name="tagType">type of tag we are updating or creating</param>
    ''' <param name="tagNameEN">english tag term</param>
    ''' <param name="tagNameFR">french tag term</param>
    ''' <remarks></remarks>
    Public Sub SaveCustomTag(create As Boolean, tagType As String, tagNameEN As String, tagNameFR As String)
        GetConnectionString()
        Dim employee As New Employee(Membership.GetUser.UserName)
        Dim sqlConn = New SqlConnection(connString.ConnectionString)
        sqlConn.Open()
        Dim com As SqlCommand

        If create Then
            com = New SqlCommand("CreateCustomTag", sqlConn)
        Else
            com = New SqlCommand("UpdateCustomTag", sqlConn)
        End If

        com.CommandType = CommandType.StoredProcedure
        com.Parameters.Add(New SqlParameter("@OrgID", SqlDbType.Int)).Value = employee.Organization.Parent.ID
        com.Parameters.Add(New SqlParameter("@TagType", SqlDbType.NVarChar)).Value = tagType
        com.Parameters.Add(New SqlParameter("@TagNameEN", SqlDbType.NVarChar)).Value = tagNameEN
        com.Parameters.Add(New SqlParameter("@TagNameFR", SqlDbType.NVarChar)).Value = tagNameFR

        com.Connection = sqlConn
        com.ExecuteNonQuery()

        com.Dispose()
        sqlConn.Close()
        employee = Nothing
    End Sub


    ''' <summary>
    ''' Gets custom tags from tblCustomTag
    ''' </summary>
    ''' <param name="TagType">Type of tag</param>
    ''' <param name="Language">language to retrieve</param>
    ''' <returns>custom tag string value, custom_tag_en or custom_tag_fr from tblCustomTag</returns>
    ''' <remarks></remarks>

    Public Function GetCustomTag(TagType As String, Optional Language As String = "default") As String
        GetConnectionString()
        Dim sqlConn = New SqlConnection(connString.ConnectionString)
        Dim tag As String = ""
        Dim e As New Employee(Membership.GetUser.UserName)

        sqlConn.Open()

        Dim com As SqlCommand = New SqlCommand("GetCustomTag", sqlConn)
        Dim rs As SqlDataReader

        com.CommandType = CommandType.StoredProcedure
        com.Parameters.Add(New SqlParameter("@TagType", SqlDbType.NVarChar)).Value = TagType
        com.Parameters.Add(New SqlParameter("@OrgID", SqlDbType.Int)).Value = e.Organization.Parent.ID

        com.Connection = sqlConn
        rs = com.ExecuteReader

        While rs.Read
            If Language = "default" Then
                tag = IIf(e.DefaultLanguage = "French", rs("TAG_NAME_FR"), rs("TAG_NAME_EN"))
            Else
                tag = IIf(Language = "French", rs("TAG_NAME_FR"), rs("TAG_NAME_EN"))
            End If

        End While

        rs.Close()
        com.Dispose()
        sqlConn.Close()
        sqlConn = Nothing
        rs = Nothing

        GetCustomTag = tag
    End Function


    ''' <summary>
    ''' uploads a file to tblUploadedReceipt. called from the mobile section when someone uses their phone or tablet to take a picture and 
    ''' upload that picture straight from their phone or tablet
    ''' </summary>
    ''' <param name="empID">employee ID of the employee who is uploading the file</param>
    ''' <param name="fu">fileupload object</param>
    ''' <returns>0 if upload failed, 1 if succeeded, 2 if the file was larger than 5MB</returns>
    ''' <remarks></remarks>
    Public Function UploadFile(empID As Integer, fu As FileUpload) As Integer
        GetConnectionString()
        Dim con As New SqlConnection(connString.ConnectionString)
        Dim dataAdapter As SqlDataAdapter
        Dim myCommandBuilder As SqlCommandBuilder
        Dim dataSet As New DataSet
        Dim memoryStream As MemoryStream
        Dim bData As Byte()
        Dim reader As BinaryReader
        Dim loggedInUser As New Employee(Membership.GetUser.UserName)

        Try
            UploadFile = 1

            'check to make sure the logged in user is the same ID as the one being passed
            If loggedInUser.ID = empID Then
                If fu.HasFile Then
                    If fu.FileContent.Length < 5000000 Then
                        con.Open()
                        Dim com As SqlCommand = New SqlCommand("CreateReceipt", con)
                        com.CommandType = CommandType.StoredProcedure
                        com.Parameters.Add(New SqlParameter("@EmpID", SqlDbType.Int)).Value = empID
                        com.Connection = con
                        com.ExecuteNonQuery()
                        com.Dispose()
                        con.Close()

                        dataAdapter = New SqlDataAdapter("SELECT * FROM tblUploadedReceipt WHERE ID=" & GetLastReceiptID(empID), con)
                        myCommandBuilder = New SqlCommandBuilder(dataAdapter)
                        dataAdapter.MissingSchemaAction = MissingSchemaAction.AddWithKey
                        con.Open()
                        dataAdapter.Fill(dataSet, "tblUploadedReceipt")

                        reader = New BinaryReader(fu.FileContent)
                        bData = reader.ReadBytes(reader.BaseStream.Length)
                        memoryStream = New MemoryStream(bData, 0, bData.Length)
                        memoryStream.Close()

                        dataSet.Tables("tblUploadedReceipt").Rows(0)("RECEIPT") = bData
                        dataSet.Tables("tblUploadedReceipt").Rows(0)("RECEIPT_TYPE") = "image/jpeg"
                        dataAdapter.Update(dataSet, "tblUploadedReceipt")
                    Else
                        UploadFile = 2
                    End If
                End If
            Else
                Throw New Exception
            End If

        Catch ex As Exception
            Throw New Exception

        Finally
            con.Close()
            con = Nothing
            memoryStream = Nothing
            bData = Nothing
            reader = Nothing
            myCommandBuilder = Nothing
            dataSet = Nothing
            dataAdapter = Nothing
            loggedInUser = Nothing
        End Try
    End Function


    ''' <summary>
    ''' gets connection string of sql server from the webconfig file
    ''' </summary>
    ''' <remarks></remarks>

    Public Sub GetConnectionString()

        If Not IsNothing(connString) And connString.ConnectionString = "" Then
            rootWebConfig = System.Web.Configuration.WebConfigurationManager.OpenWebConfiguration("/Webapplication1")

            If (rootWebConfig.ConnectionStrings.ConnectionStrings.Count > 0) Then
                connString = rootWebConfig.ConnectionStrings.ConnectionStrings("dbadvaloremconnstr")
            End If
        End If

    End Sub

    Public Function GetErrorMessage(status As MembershipCreateStatus) As String
        Select Case status
            Case MembershipCreateStatus.DuplicateUserName
                Return "Username already exists. Please enter a different user name."

            Case MembershipCreateStatus.DuplicateEmail
                Return "A username for that e-mail address already exists. Please enter a different e-mail address."

            Case MembershipCreateStatus.InvalidPassword
                Return "The password provided is invalid. Please enter a valid password value."

            Case MembershipCreateStatus.InvalidEmail
                Return "The e-mail address provided is invalid. Please check the value and try again."

            Case MembershipCreateStatus.InvalidAnswer
                Return "The password retrieval answer provided is invalid. Please check the value and try again."

            Case MembershipCreateStatus.InvalidQuestion
                Return "The password retrieval question provided is invalid. Please check the value and try again."

            Case MembershipCreateStatus.InvalidUserName
                Return "The user name provided is invalid. Please check the value and try again."

            Case MembershipCreateStatus.ProviderError
                Return "The authentication provider Returned an error. Please verify your entry and try again. If the problem persists, please contact your system administrator."

            Case MembershipCreateStatus.UserRejected
                Return "The user creation request has been canceled. Please verify your entry and try again. If the problem persists, please contact your system administrator."

            Case Else
                Return "An unknown error occurred. Please verify your entry and try again. If the problem persists, please contact your system administrator."
        End Select
    End Function

    ''' <summary>
    ''' function to send various automated emails, when a report is submitted or finalized etc
    ''' </summary>
    ''' <param name="sTo">recipient</param>
    ''' <param name="sSubject">subject of email</param>
    ''' <param name="sBody">body text</param>
    ''' <param name="lang">language of email</param>
    ''' <returns>false if sendemail failed, true if succeeded</returns>
    ''' <remarks></remarks>
    Public Function SendEmail(sTo As String, sSubject As String, sBody As String, Optional lang As String = "default") As Boolean
        Dim message = New System.Net.Mail.MailMessage()
        Dim client = New System.Net.Mail.SmtpClient()
        rootWebConfig = System.Web.Configuration.WebConfigurationManager.OpenWebConfiguration("/Webapplication1")

        Try
            Dim mailSettings As System.Net.Configuration.MailSettingsSectionGroup = rootWebConfig.GetSectionGroup("system.net/mailSettings")
            Dim emailFooter = GetMessage(27, lang)
            emailFooter = Replace(emailFooter, "(copyright)", Now.Year)
            sBody = "<img src=cid:companylogo ><br><hr>" & sBody & emailFooter
            Dim htmlView As AlternateView = AlternateView.CreateAlternateViewFromString(sBody, Nothing, "text/html")

            Dim logo As New LinkedResource(ConfigurationManager.AppSettings("LogoPath"))

            logo.ContentId = "companylogo"
            htmlView.LinkedResources.Add(logo)

            message.From = New System.Net.Mail.MailAddress("no-reply@advataxes.ca")
            message.To.Add(New System.Net.Mail.MailAddress(sTo))
            message.Subject = sSubject
            message.AlternateViews.Add(htmlView)
            message.IsBodyHtml = True

            client.Port = mailSettings.Smtp.Network.Port
            client.Host = mailSettings.Smtp.Network.Host
            client.EnableSsl = mailSettings.Smtp.Network.EnableSsl
            client.UseDefaultCredentials = False
            client.Credentials = New System.Net.NetworkCredential(mailSettings.Smtp.Network.UserName, mailSettings.Smtp.Network.Password)
            client.Send(message)

            SendEmail = True

        Catch ex As Exception
            SendEmail = False

        Finally
            client = Nothing
            message = Nothing
        End Try
    End Function

    ''' <summary>
    ''' called when someone uses the contactus.aspx to send a comment or report a bug
    ''' </summary>
    ''' <param name="sFrom">email address of the person currently logged in</param>
    ''' <param name="sSubject">subject of email</param>
    ''' <param name="sBody">body text</param>
    ''' <remarks></remarks>
    Public Sub SendComment(sFrom As String, sSubject As String, sBody As String)
        Dim message = New System.Net.Mail.MailMessage()

        message.From = New System.Net.Mail.MailAddress(sFrom)
        message.To.Add(New System.Net.Mail.MailAddress("support@advalorem.ca"))

        message.Subject = sSubject
        message.Body = sBody

        Dim client = New System.Net.Mail.SmtpClient()

        client.Send(message)

        client = Nothing
        message = Nothing
    End Sub

    ''' <summary>
    ''' Used to track changes throughout the application. Data is displayed in the dashboard screen in the admin section
    ''' </summary>
    ''' <param name="rowID">ID of the record being modified</param>
    ''' <param name="empID">ID of employee making the change</param>
    ''' <param name="tableName">table that the change affects</param>
    ''' <param name="fieldName">field that was changed</param>
    ''' <param name="action">action that was performed at the time of the change</param>
    ''' <param name="oldValue">old value</param>
    ''' <param name="newValue">new value</param>
    ''' <param name="modifiedRecord">description of what was modified</param>
    ''' <remarks></remarks>
    Public Sub CreateAuditTrail(rowID As Integer, empID As Integer, tableName As String, fieldName As String, action As String, oldValue As String, newValue As String, modifiedRecord As String)
        On Error Resume Next
        GetConnectionString()
        Dim sqlConn = New SqlConnection(connString.ConnectionString)
        sqlConn.Open()
        Dim com As SqlCommand = New SqlCommand("CreateAuditTrail", sqlConn)
        com.CommandType = CommandType.StoredProcedure

        com.Parameters.Add(New SqlParameter("@rowID", SqlDbType.Int)).Value = rowID
        com.Parameters.Add(New SqlParameter("@empID", SqlDbType.Int)).Value = empID
        com.Parameters.Add(New SqlParameter("@tableName", SqlDbType.NVarChar)).Value = tableName
        com.Parameters.Add(New SqlParameter("@fieldName", SqlDbType.NVarChar)).Value = fieldName
        com.Parameters.Add(New SqlParameter("@tableAction", SqlDbType.NVarChar)).Value = action
        com.Parameters.Add(New SqlParameter("@modifiedRecord", SqlDbType.NVarChar)).Value = modifiedRecord
        com.Parameters.Add(New SqlParameter("@oldValue", SqlDbType.NVarChar)).Value = oldValue
        com.Parameters.Add(New SqlParameter("@newValue", SqlDbType.NVarChar)).Value = newValue
        com.Parameters.Add(New SqlParameter("@actionDate", SqlDbType.DateTime)).Value = Now

        com.Connection = sqlConn
        com.ExecuteNonQuery()

        com.Dispose()
        sqlConn.Close()
    End Sub

    ''' <summary>
    ''' Gets a random token ID. Used for password reset
    ''' </summary>
    ''' <param name="len">length of token </param>
    ''' <returns>a random token of a specified length</returns>
    ''' <remarks></remarks>
    Public Function GetToken(len As Integer) As String
        Dim randomString As New Random()
        Dim allowableChars() As Char = "abcdefghijklmnopqrstuvwxyz0123456789".ToCharArray()
        Dim token As String = String.Empty

        For i As Integer = 0 To len - 1
            token += allowableChars(randomString.Next(allowableChars.Length - 1))
        Next

        Return token

    End Function

    ''' <summary>
    ''' preliminary design to test functionality of doing a batch retrieve of files 
    ''' that have been attached to expenses and saving them to disk 
    ''' </summary>
    ''' <remarks></remarks>

    Public Sub SaveReceipts()
        GetConnectionString()

        Dim dStartDate As New Date(2014, 1, 1)
        Dim dEndDate As New Date(2014, 5, 30)
        Dim i As Integer = 1
        Dim expense As Expense
        Dim organization As New Org(1)

        organization.GetExpenses(dStartDate, dEndDate)

        For Each expense In organization.Expenses
            If Not IsNothing(expense.ReceiptImage) Then
                System.IO.File.WriteAllBytes("C:\temp\" & expense.ReceiptName & "." & IIf(Right(expense.ReceiptType, 4) = "jpeg", "jpg", Right(expense.ReceiptType, 3)), expense.ReceiptImage)
            End If

        Next

        organization = Nothing
    End Sub
End Module
