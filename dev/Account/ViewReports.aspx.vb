Public Class ViewReports
    Inherits System.Web.UI.Page

    Private Sub ViewReports_Error(sender As Object, e As System.EventArgs) Handles Me.Error
        If IsNothing(Session("error")) Then Session("error") = GetMessage(273) : Session("msgHeight") = 50
        Response.Redirect("../login.aspx")
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim organization As New Org(CInt(Session("emp").organization.id))
        Dim i As Integer
        Dim firstyear As Integer = 2013
        Dim orgCat As OrgCat

        Translate()
        hdnOrgID.Value = Session("emp").organization.id
        hdnAccSeg.Value = Session("emp").organization.parent.accsegment
        hdnITR.Value = organization.ITRAccount
        hdnITC.Value = organization.ITCAccount
        hdnRITCBC.Value = organization.ritcBCAccount
        hdnRITCON.Value = organization.ritcONAccount
        hdnRITCPEI.Value = organization.ritcPEIAccount

        cboPeriod.Items.Clear()
        For i = 1 To organization.NumberOfPeriods
            cboPeriod.Items.Add(i)
        Next

        Do Until firstyear = Now.Year + 2
            cboFinancialYear.Items.Add(firstyear)
            firstyear += 1
        Loop

        cboFinancialYear.SelectedValue = Now.Year

        i = 0
        txtFrom.Text = Format("01/01/2018")
        txtTo.Text = Format(Now, "dd/MM/yyyy")
        cboReportType.Items(i).Text = GetMessage(216) : i += 1   'account summary
        cboReportType.Items(i).Text = GetMessage(361) : i += 1   'expense report detailed
        cboReportType.Items(i).Text = GetMessage(551) : i += 1   'advance detailed
        cboReportType.Items(i).Text = GetMessage(339) : i += 1   'payable to employees
        'cboReportType.Items(i).Text = GetMessage(365) : i += 1
        cboReportType.Items(i).Text = GetMessage(547) : i += 1   'employee credit card payable
        cboReportType.Items(i).Text = GetMessage(341) : i += 1   'detailed itc
        cboReportType.Items(i).Text = GetMessage(342) : i += 1   'detailed itr
        cboReportType.Items(i).Text = GetMessage(343) : i += 1   'detailed ritc ontario
        cboReportType.Items(i).Text = GetMessage(344) : i += 1   'detailed ritc pei
        cboReportType.Items(i).Text = GetMessage(217) : i += 1   'detailed posting by employee
        cboReportType.Items(i).Text = GetMessage(235) : i += 1   'expense report
        cboReportType.Items(i).Text = GetMessage(545) : i += 1   'expense account
        cboReportType.Items(i).Text = GetMessage(219) : i += 1   'category
        cboReportType.Items(i).Text = GetMessage(345) : i += 1   'category summary
        cboReportType.Items(i).Text = GetMessage(340) : i += 1   'detailed by category
        cboReportType.Items(i).Text = GetMessage(298) : i += 1   'jurisdiction
        cboReportType.Items(i).Text = GetMessage(443) : i += 1   'GST/HST/QST paid
        cboReportType.Items(i).Text = GetMessage(558) : i += 1   'duplicate expenses

        If Not IsPostBack Then
            If organization.DisplayWorkOrder Then
                Dim li As New ListItem
                li.Value = 11
                li.Text = GetCustomTag("W")
                cboReportType.Items.Insert(i, li)
                i += 1
            End If

        End If

        organization.GetCategories()

        For Each orgCat In organization.Categories
            If orgCat.FactorMethod Then
                Dim li As New ListItem
                li.Value = 26
                li.Text = GetMessage(554)
                cboReportType.Items.Insert(i, li)
                Exit For
            End If
        Next

        cboReportRange.Items(0).Text = GetMessage(211)
        cboReportRange.Items(1).Text = GetMessage(213)
        lblFrom.Text = GetMessage(379)
        lblTo.Text = GetMessage(380)
        organization = Nothing
    End Sub


    Public Sub Translate()
        On Error Resume Next
        Dim d As New Description
        Dim c As Object
        Dim col As Object
        Dim childc As Object, childcc As Object, childccc As Object, childcccc As Object
        Dim id As String


        For Each c In Page.Controls
            For Each childc In c.controls
                For Each childcc In childc.controls
                    If TypeOf childcc Is ContentPlaceHolder Then
                        For Each childccc In childcc.controls
                            If TypeOf childccc Is Label Then
                                If childccc.id Like "lbl*" Then
                                    id = Replace(childccc.id, "_", "")
                                    childccc.text = d.GetDescription(CInt(Replace(id, "lbl", "")), Left(Session("emp").defaultlanguage, 1))

                                ElseIf childccc.id Like "CT*" Then
                                    childccc.text = GetCustomTag(Right(childccc.id, 1))
                                End If

                            ElseIf TypeOf childccc Is Panel Then
                                For Each childcccc In childccc.controls
                                    If TypeOf childcccc Is Label Then

                                        If childcccc.id Like "lbl*" Then
                                            id = Replace(childcccc.id, "_", "")
                                            childcccc.text = d.GetDescription(CInt(Replace(id, "lbl", "")), Left(Session("emp").defaultlanguage, 1))

                                        ElseIf childcccc.id Like "CT*" Then
                                            childcccc.text = GetCustomTag(Right(childcccc.id, 1))
                                        End If

                                    ElseIf TypeOf childcccc Is Button Then
                                        id = Replace(childcccc.text, "_", "")
                                        childcccc.text = d.GetDescription(CInt(Replace(id, "lbl", "")), Left(Session("emp").defaultlanguage, 1))
                                    End If
                                Next

                            ElseIf TypeOf childccc Is GridView Then
                                For Each col In childccc.columns
                                    If col.headertext Like "CT*" Then
                                        col.headertext = GetCustomTag(Right(col.headertext, 1))
                                    Else
                                        col.headertext = d.GetDescription(CInt(col.headertext), Left(Session("emp").defaultlanguage, 1))
                                    End If

                                Next
                            End If
                        Next
                    End If
                Next
            Next
        Next

    End Sub

    Private Sub cboJur_DataBound(sender As Object, e As System.EventArgs) Handles cboJur.DataBound
        Dim li As New ListItem

        li.Value = 0
        li.Text = GetMessage(104) 'add All option
        cboJur.Items.Insert(0, li)
    End Sub

    Private Sub cboOrgCategory_DataBound(sender As Object, e As System.EventArgs) Handles cboOrgCategory.DataBound
        Dim li As New ListItem
        li.Value = 0
        li.Text = GetMessage(104) 'add All option
        cboOrgCategory.Items.Insert(0, li)
        li = Nothing

    End Sub

    Private Sub cboGL_DataBound(sender As Object, e As System.EventArgs) Handles cboGL.DataBound
        Dim li As New ListItem
        li.Value = 0
        li.Text = GetMessage(104) 'add All option
        cboGL.Items.Insert(0, li)
        li = Nothing
    End Sub

    Private Sub ViewReports_LoadComplete(sender As Object, e As System.EventArgs) Handles Me.LoadComplete
        Dim li As ListItem

        If Not Session("emp").organization.GSTReg Then
            li = cboReportType.Items.FindByValue(13)
            li.Enabled = False
        End If

        If Not Session("emp").organization.QSTReg Then
            li = cboReportType.Items.FindByValue(14)
            li.Enabled = False
        End If

        If Session("emp").organization.OrgSizeGST = 1 Then
            li = cboReportType.Items.FindByValue(15)
            li.Enabled = False
            li = cboReportType.Items.FindByValue(16)
            li.Enabled = False
        End If
    End Sub

    Private Sub cboWorkOrder_DataBound(sender As Object, e As System.EventArgs) Handles cboWorkOrder.DataBound
        Dim li As New ListItem

        li.Value = 0
        li.Text = GetMessage(104) 'add All option
        cboWorkOrder.Items.Insert(0, li)
    End Sub

    Private Sub cboEmp_DataBound(sender As Object, e As System.EventArgs) Handles cboEmp.DataBound
        Dim li As New ListItem

        li.Value = 0
        li.Text = GetMessage(104) 'add All option
        cboEmp.Items.Insert(0, li)
    End Sub
End Class