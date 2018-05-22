Public Class feedback
    Inherits System.Web.UI.Page


    ''' <summary>
    ''' On page load, translate controls
    ''' </summary>
    ''' <param name="sender"></param>
    ''' <param name="e"></param>
    ''' <remarks></remarks>
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Translate()

        cboTopic.Items(0).Text = IIf(Session("emp").defaultlanguage = "English", "Report a problem", "Problème rencontré")
        cboTopic.Items(1).Text = IIf(Session("emp").defaultlanguage = "English", "General inquiry", "Question générale")
        cboTopic.Items(2).Text = IIf(Session("emp").defaultlanguage = "English", "Submit a comment", "Soumettre un commentaire")
        cboTopic.Items(3).Text = IIf(Session("emp").defaultlanguage = "English", "Other", "Autre")

    End Sub

    ''' <summary>
    ''' Called when user clicks the submit button when contacting Advalorem about a question or a problem with the website
    ''' </summary>
    ''' <param name="sender"></param>
    ''' <param name="e"></param>
    ''' <remarks></remarks>
    Private Sub cmdSubmit_Click(sender As Object, e As System.EventArgs) Handles cmdSubmit.Click
        SendComment(Session("emp").email, UCase(cboTopic.SelectedItem.Text) & " - " & txtSubject.Text, txtComment.Text)

        Select cboTopic.SelectedValue
            Case 0 : lblMsg.Text = GetMessage(471)
            Case 1 : lblMsg.Text = "Someone will be contacting you in response to your inquiry. Thank you."
            Case 2 : lblMsg.Text = GetMessage(479)
            Case 3 : lblMsg.Text = GetMessage(479)

        End Select
        Session("contactus") = GetMessage(479)
    End Sub

    ''' <summary>
    ''' Cycles through the controls on the page to translate the controls that have a prefix of lbl followed by an integer.
    ''' the integer is the table ID found in tblDescription
    ''' </summary>
    ''' <remarks></remarks>
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
                                End If

                            ElseIf TypeOf childccc Is Panel Then
                                For Each childcccc In childccc.controls
                                    If TypeOf childcccc Is Label Then

                                        If childcccc.id Like "lbl*" Then
                                            id = Replace(childcccc.id, "_", "")
                                            childcccc.text = d.GetDescription(CInt(Replace(id, "lbl", "")), Left(Session("emp").defaultlanguage, 1))
                                        End If

                                    ElseIf TypeOf childcccc Is Button Then
                                        id = Replace(childcccc.text, "_", "")
                                        childcccc.text = d.GetDescription(CInt(Replace(id, "lbl", "")), Left(Session("emp").defaultlanguage, 1))
                                    End If
                                Next

                            ElseIf TypeOf childccc Is GridView Then
                                For Each col In childccc.columns
                                    col.headertext = d.GetDescription(CInt(col.headertext), Left(Session("emp").defaultlanguage, 1))
                                Next

                            ElseIf TypeOf childccc Is Button Then
                                id = Replace(childccc.text, "_", "")
                                childccc.text = d.GetDescription(CInt(Replace(id, "lbl", "")), Left(Session("emp").defaultlanguage, 1))

                            End If
                        Next
                    End If
                Next
            Next
        Next

    End Sub
End Class