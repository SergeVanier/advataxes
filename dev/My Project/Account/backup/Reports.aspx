<%@ Page Language="vb" MasterPageFile="~/Site.Master"  AutoEventWireup="true" CodeBehind="Reports.aspx.vb" Inherits="WebApplication1.Reports" %>

<%@ Register assembly="System.Web.Entity, Version=3.5.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089" namespace="System.Web.UI.WebControls" tagprefix="asp" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="act" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server"  >
        <link type="text/css" href="../../css/sunny/jquery-ui-1.8.23.custom.css" rel="stylesheet" />
        <!--<link type="text/css" href="../../css/redmond/jquery-ui-1.8.18.custom.css" rel="stylesheet" /> -->
        <script type="text/javascript" src="../../js/jquery-1.7.2.min.js"></script>
        <script type="text/javascript" src="../../js/jquery-ui-1.8.18.custom.min.js"> </script>
        <script type="text/javascript" src="../../js/jquery.js"> </script>

        
        <script type="text/javascript">

                $(document).ready(function () {

                    // Dialog			
                    $('#dialog').dialog({
                        autoOpen: false,
                        height: 275,
                        width: 425,
                        modal: true,
                        buttons: {
                            "Close": function () {
                                del = 1;
                                $(this).dialog("close");
                            }
                        }
                    });

                });
         
         </script>


        <asp:ScriptManager id="ScriptManager1" runat="server" /> 
    
        <asp:Label ID="lblError" runat="server" ForeColor="Red" Font-Bold="true" ></asp:Label>
    
        <% If Session("msg") <> "" Then%>
 	        <div class="ui-widget">
		        <div class="ui-state-highlight ui-corner-all" style="margin-top: 20px; padding: 0 .7em;"> 
			        <p><span class="ui-icon ui-icon-info" style="float: left; margin-right: .3em;"></span>
			          <asp:Label ID="lblMsg2" runat="server" ><%=Session("msg")%></asp:Label></p>
		        </div>
	        </div>            <%Session("msg")="" %>        <% End If%>
        
        <%="" %>
        
        <table width="100%" border=0>
        <tr>
            <td style=" color:#cd1e1e; font-size:x-large ;"><asp:Label ID="lbl71" runat="server" Text="Reports"></asp:Label></td>
            <td class="style11" valign="middle">
                <asp:ImageButton ID="dummy" runat="server" visible="false" />
                
                <% If hdnOpenReport.Value = "False" And Request.QueryString("e") <> "1" Then%>
                    <a href="#" class="newRpt" title="New Report" ><img src="../images/new.png" /></a>
                <% End If%>
                                
                <% If txtStatusID.Text = "1" or txtStatusID.Text="5" Then%>
                    &nbsp;&nbsp;&nbsp;<a href="#" class="submitRpt"><img src="../images/submit.png" title="<%=hdnSubmitTooltip.value %>" /></a> 
                <%End If%>
                
                
                <% If 2 = 1 Then%>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="#" class="exportRpt"><img src="../images/export.png" alt="Export" title="Export" /></a>
                <% End If%>
                

                <!--<asp:ImageButton ID="cmdDelete" runat="server"  ImageUrl="../images/cmdDelete.png" Height="33px" Width="87px" Visible="False" CausesValidation="false" />-->
            </td>
            <td>
                
                <%If Request.QueryString("e") <> "1" Then%>
                
                        <span class="labelText"><asp:Label ID="lbl69" runat="server" Text="Reports for:" Visible="true" Font-Size="Small"  ></asp:Label></span>
                        <asp:DropDownList ID="cboDelegate" runat="server"
                            AutoPostBack="True" DataSourceID="sqlDelegate" DataTextField="Name" AppendDataBoundItems="true"  
                            DataValueField="EMP_ID" Height="25px" Width="170px" Visible="true"  >
                        </asp:DropDownList>
                <%Else%>
                        <span class="labelText"><asp:Label ID="lbl73" runat="server" Text="Employee:" Visible="false" Font-Size="Small"  ></asp:Label></span>
                        <asp:DropDownList ID="cboEmp" runat="server"
                            AutoPostBack="True" DataSourceID="sqlEmp" DataTextField="Name" AppendDataBoundItems="true"  
                            DataValueField="EMP_ID" Height="25px" Width="170px" Visible="false"  >
                            <asp:ListItem Value="">All</asp:ListItem>
                        </asp:DropDownList>
                <% End If%>
            </td>
            <td>
                <span class="labelText" style="font-size:small;"><asp:Label ID="lbl70" runat="server" Text="Status:"></asp:Label></span>
                <asp:DropDownList ID="cboStatus" runat="server" AppendDataBoundItems="True" AutoPostBack="True" Height="25px">
                    <asp:ListItem Value="%">All</asp:ListItem>
                    <asp:ListItem Value="Open">Open</asp:ListItem>
                    <asp:ListItem Value="Pending Approval">Pending Approval</asp:ListItem>
                    
                    <asp:ListItem Value="Finalized">Finalized</asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
    </table>
  
 
    <div style="height:960px;">
        <asp:GridView ID="GridView1" runat="server"
            AutoGenerateColumns="False"
            GridLines="None"
            AllowPaging="true"
            CssClass="mGrid"
            PagerStyle-CssClass="pgr"
            AlternatingRowStyle-CssClass="alt" 
            SelectedRowStyle-CssClass="sel"
            AllowSorting="True" 
            CellPadding="4" 
            DataSourceID="SqlDataSource1"  
            HeaderStyle-ForeColor="White" 
            ForeColor="White" 
            BackColor="White" 
            BorderColor="#DEDFDE" 
            BorderStyle="None" 
            BorderWidth="1px" 
            Width="99.5%" 
            DataKeyNames="REPORT_ID" 
            EmptyDataText="No reports to display" 
            ShowHeaderWhenEmpty="True" 
            ViewStateMode="Enabled">

            <AlternatingRowStyle CssClass="alt"></AlternatingRowStyle>
            <Columns>
                <asp:CommandField ItemStyle-ForeColor="Black" ShowSelectButton="true" ButtonType="Image"  SelectImageUrl="../images/select.png" SelectText="<%=hdnSelectTooltip.value %>" ItemStyle-Width="3%"/>                      
                
                <asp:TemplateField ItemStyle-Width="15px" ItemStyle-ForeColor="Black" >
                    <ItemTemplate>
                        <a href="#" id='<%# Eval("REPORT_ID") %>' class="editRpt" title="<%=hdnEditTooltip.value %>"> <%# IIf(Eval("STATUS_ID") = 1 Or (Eval("STATUS_ID") = 2 And Request.QueryString("e") = 1), "<img  border='0' src='../Images/edit.png' alt='Edit' />", "")%></a>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField ItemStyle-Width="50px" ItemStyle-ForeColor="Black">
                    <ItemTemplate>
                        <a href="#" id='<%# Eval("REPORT_ID") %>' class="printRpt" title="<%=hdnViewExpRptTooltip.value %>"> <img  border="0" src="../Images/viewreport.png" alt="View Expense Report" width="22px" height="22px" /></a>
                        <a href="#" id='<%# Eval("REPORT_ID") %>' class="exportRpt" title="<%=hdnExpDataEntryTooltip.value %>"> <img  border="0" src="../Images/export.png" alt="Export Data Entry" width="22px" height="22px" /></a>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField ItemStyle-Width="150px" ItemStyle-ForeColor="Black" HeaderText="70" SortExpression="EMP_NAME">
                    <ItemTemplate>
                        <%If Not IsNothing(Request.QueryString("e")) Then%>
                            <%# Eval("EMP_NAME") %>
                        <%End If%>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:BoundField  ItemStyle-ForeColor="black" DataField="REPORT_NAME" HeaderText="74" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left" />

                <asp:TemplateField ItemStyle-Width="150px" ItemStyle-ForeColor="Black" ItemStyle-HorizontalAlign="Center">
                    <ItemTemplate >
                        <%If Not IsNothing(Request.QueryString("e")) Then%>
                            <%If cboStatus.SelectedIndex = 0 Then%> <%# Eval("CREATED_DATE", "{0:dd/MM/yyyy}")%> <%End If%>
                            <%If cboStatus.SelectedIndex = 1 Then%> <%# Eval("APPROVED_DATE", "{0:dd/MM/yyyy}")%> <%End If%>
                            <%If cboStatus.SelectedIndex = 2 Then%> <%# Eval("FINALIZED_DATE", "{0:dd/MM/yyyy}")%><%End If%>
                        <%Else%>
                            <%# IIf(Eval("STATUS_ID") = 1, Eval("CREATED_DATE", "{0:dd/MM/yyyy}"), "")%>
                            <%# IIf(Eval("STATUS_ID") = 2, Eval("SUBMITTED_DATE", "{0:dd/MM/yyyy}"), "")%>
                            <%# IIf(Eval("STATUS_ID") = 3, Eval("APPROVED_DATE", "{0:dd/MM/yyyy}"), "")%>
                            <%# IIf(Eval("STATUS_ID") = 4, Eval("FINALIZED_DATE", "{0:dd/MM/yyyy}"), "")%>
                        <%End If%>
                                               
                         <%# IIf(Eval("STATUS_ID") > 1, "&nbsp;&nbsp;&nbsp;<a href='#' id='" & Eval("REPORT_ID") & "' class='getDates' title='View other dates'><img  src='../images/calendar1.png' width='20px' height='20px' /></a>", "")%>
                        
                    </ItemTemplate>
                </asp:TemplateField>
                
                <asp:TemplateField ItemStyle-Width="150px" ItemStyle-ForeColor="Black" ItemStyle-HorizontalAlign="Center" HeaderText="70">
                    <ItemTemplate >
                        <%If Session("language") = "English" Then%>
                            <%# Eval("STATUS_NAME")%>
                        <%else %>
                            <%# Eval("STATUS_NAME")%>
                        <%end if %>
                    </ItemTemplate >
                </asp:TemplateField>

                <asp:TemplateField  ItemStyle-Width="15px">
                    <ItemTemplate>
                        <%If Request.QueryString("e") = 1 And (cboStatus.SelectedIndex = 0 Or cboStatus.SelectedIndex = 1) Then%>
                            <a href="#" id='<%# Eval("REPORT_ID")*3 %>' class="rejectRpt" title="Disapprove"> <img  border="0" src="../Images/reject.png" alt="Disapprove" /></a>
                        <%End If%>
                    </ItemTemplate>
                </asp:TemplateField>         

                <asp:TemplateField  ItemStyle-Width="15px">
                    <ItemTemplate>
                        <%If Request.QueryString("e") = 1 And (cboStatus.SelectedIndex = 0) Then%>
                            <a href="#" id='<%# Eval("REPORT_ID")*2 %>' class="approveRpt" title="Approve"> <img  border="0" src="../Images/approve.png" alt="Approve" /></a>
                        <%End If%>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField ItemStyle-HorizontalAlign="Right"  ItemStyle-Width="15px">
                    <ItemTemplate>
                            <a href="#" id='<%# Eval("REPORT_ID")*4 %>' class="delReport"><%# IIf(Eval("STATUS_ID") = 1, "<img  border='0' src='../Images/del.png' alt='Delete' />", "")%> </a>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField  ItemStyle-Width="15px">
                    <ItemTemplate>
                        <%If Request.QueryString("e") = 1 And (cboStatus.SelectedIndex = 0 ) Then%>
                            <a href="#" id='<%# Eval("REPORT_ID") %>' class="finalizeRpt" title="Finalize"> <img  border="0" src="../Images/finalize.png" alt="Finalize" /></a>
                       <%ElseIf Request.QueryString("e") = 1 And cboStatus.SelectedIndex = 2 And 2 = 1 Then%>
                            <a href="#" id='<%# Eval("REPORT_ID") %>' class="unfinalizeRpt" title="Un-finalize"> <img  border="0" src="../Images/unfinalize.png" alt="Un-finalize" /></a>
                       <%End If%>
                    </ItemTemplate>
                </asp:TemplateField>

            </Columns>
        
            <EditRowStyle Height="20px" />
            <EmptyDataRowStyle Height="20px" />
            <HeaderStyle ForeColor="White" Height="20px"></HeaderStyle>
            <RowStyle Height="20px" />
        </asp:GridView>

        <br />
    
        <table >
            <tr>
                <td style=" color:#cd1e1e; font-size:x-large ;"><asp:Label ID="lbl72" runat="server" Text="Expenses"></asp:Label></td>
                <td id="Cell-NewExp">&nbsp;&nbsp;<a id="cmdNewExp" href="#" class="newExp"><img src="../images/new.png"  title="<%=hdnAddExpTooltip.value %>" /></a></td>
                <td id="Cell-ReportTitle" style="color:#cd1e1e; font-weight:bold;"><asp:Label runat="server" ID="labelReportName"></asp:Label></td>
                <td><asp:ImageButton ID="cmdDeleteExp" runat="server"  ImageUrl="../images/cmdDelete.png" Height="33px" Width="87px" Visible="False" CausesValidation="False"/></td>
                <td></td>
            </tr>
        </table>
       
       <div style="overflow:auto;height:850px;width:100%;" >
            <asp:GridView ID="GridView2" runat="server" 
                CssClass="mGrid"
                PagerStyle-CssClass="pgr"
                AlternatingRowStyle-CssClass="alt" 
                SelectedRowStyle-CssClass="sel"
                AutoGenerateColumns="False" 
                BorderColor="#DEDFDE" 
                BorderStyle="None" 
                BorderWidth="1px" 
                CellPadding="4" 
                DataSourceID="SqlDataSource2" 
                ForeColor="Black" 
                GridLines="None" 
                Width="99.5%" AllowSorting="True" 
                EmptyDataText="No expenses to display" 
                ShowHeaderWhenEmpty="True"
                DataKeyNames="EXPENSE_ID">
        
                <Columns>
                    <asp:TemplateField  ItemStyle-Width="10px">
                        <ItemTemplate>
                            <a href="#" id='<%# Eval("EXPENSE_ID") %>' class="expandExp" title="Expand for more details" ><img  border="0" src="../Images/plus<%# iif(EVAL("COMMENT")="","2","") %>.png" alt="Expand to view comment" style="<%# iif(EVAL("COMMENT")="","display:none;","") %>" /></a>
                            <a href="#" id='<%# Eval("EXPENSE_ID")*2 %>' class="collapseExp" title="Collapse"> <img  border="0" src="../Images/minus.png" alt="Collapse" /></a>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField  ItemStyle-Width="15px">
                        <ItemTemplate>
                            <% If txtStatusID.Text = "1" Or txtStatusID.Text = "5" Or (txtStatusID.Text = "2" And Request.QueryString("e") = 1) Then%>
                                <a href="#" id='<%# Eval("EXPENSE_ID")*3 %>' class="editExp" title="<%=hdnEditTooltip.value %>"> <img  border="0" src="../Images/edit.png" alt="Edit" /></a>
                            <% End If%>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField  ItemStyle-Width="15px">
                        <ItemTemplate>
                            <% If cboStatus.SelectedValue = "Open" Or (Not IsNothing(Request.QueryString("e")) And cboStatus.SelectedValue = "Pending Approval") Then%>
                                <%If Session("language") = "English" Then%>
                                    <a href="#" id='<%# iif(isdbnull(EVAL("RECEIPT_TYPE")),EVAL("EXPENSE_ID"),EVAL("EXPENSE_ID")) %>' class="<%# iif(isdbnull(EVAL("RECEIPT_TYPE")),"attachReceipt","viewReceipt")%>" title="<%# iif(isdbnull(EVAL("RECEIPT_TYPE")),"Attach Receipt","View Receipt")%>"> <img  border="0" src="../Images/<%# iif(isdbnull(EVAL("RECEIPT_TYPE")),"attachment1","attachment2")%>.png" alt="<%# iif(isdbnull(EVAL("RECEIPT_TYPE")),"Attach Receipt","View Receipt")%>" /></a>
                                <%Else%>
                                    <a href="#" id='A1' class="<%# iif(isdbnull(EVAL("RECEIPT_TYPE")),"attachReceipt","viewReceipt")%>" title="<%# iif(isdbnull(EVAL("RECEIPT_TYPE")),"Joindre un reçu","Voir reçu")%>"> <img  border="0" src="../Images/<%# iif(isdbnull(EVAL("RECEIPT_TYPE")),"attachment1","attachment2")%>.png" alt="<%# iif(isdbnull(EVAL("RECEIPT_TYPE")),"Joindre un reçu","Voir reçu")%>" /></a>
                       
                                <%end if %>
                            <%Else%>
                                                               
                                <a href="#" id='<%# iif(isdbnull(EVAL("RECEIPT_TYPE")),EVAL("EXPENSE_ID"),EVAL("EXPENSE_ID")) %>' class="<%# iif(isdbnull(EVAL("RECEIPT_TYPE")),"attachReceipt","viewReceipt")%>" title="<%# iif(isdbnull(EVAL("RECEIPT_TYPE")),"Attach Receipt","View Receipt")%>"> <img  border="0" src="../Images/<%# iif(isdbnull(EVAL("RECEIPT_TYPE")),"attachment1","attachment2")%>.png" alt="<%# iif(isdbnull(EVAL("RECEIPT_TYPE")),"Attach Receipt","View Receipt")%>" style="<%# iif(isdbnull(EVAL("RECEIPT_TYPE")),"display:none;","") %>"  /></a>

                            <%end if %>
                        </ItemTemplate>
                    </asp:TemplateField>


                    <asp:BoundField  DataField="EXP_DATE" HeaderText="59" SortExpression="EXP_DATE"  ItemStyle-ForeColor="Black" DataFormatString="{0:dd'/'MM'/'yyyy}" ItemStyle-Width="75px" ItemStyle-HorizontalAlign="Center" />
                    <asp:BoundField  DataField="CAT_NAME" HeaderText="60" ItemStyle-ForeColor="Black" ItemStyle-Width="400px" HeaderStyle-HorizontalAlign="Left" />
                    <asp:BoundField  ItemStyle-Width="100px"  DataField="SUPPLIER_NAME" HeaderText="61"  ItemStyle-ForeColor="Black"  ItemStyle-HorizontalAlign="Center" />            
                    <asp:BoundField ItemStyle-Width="50px"  DataField="JUR_NAME" HeaderText="62" ItemStyle-ForeColor="Black" ItemStyle-HorizontalAlign="Center" />
                    <asp:TemplateField HeaderText="63"  ItemStyle-Width="100px"  ItemStyle-ForeColor="black" ItemStyle-HorizontalAlign="Right">
                        <ItemTemplate>
                            <asp:Label ID="Label1" runat="server" Text='<%# iif(EVAL("GRATUITIES")=0,iif(EVAL("RATE")<1,formatnumber(EVAL("AMOUNT")/EVAL("RATE"),0) & " x " & formatnumber(EVAL("RATE"),2),""), formatnumber(EVAL("GRATUITIES"),2))  %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:BoundField  DataField="AMT_BEFORE_TAX" HeaderText="64" ItemStyle-ForeColor="Black" DataFormatString="{0:F}" ItemStyle-Width="75px" ItemStyle-HorizontalAlign="Right" />
                    <asp:BoundField  DataField="GST_PAID" HeaderText="65" ItemStyle-ForeColor="Black" DataFormatString="{0:F}" ItemStyle-Width="60px" ItemStyle-HorizontalAlign="Right" />
                    <asp:BoundField  DataField="QST_PAID" HeaderText="66" ItemStyle-ForeColor="Black" DataFormatString="{0:F}" ItemStyle-Width="40px" ItemStyle-HorizontalAlign="Right" />
                    <asp:BoundField  DataField="AMOUNT" HeaderText="67" ItemStyle-ForeColor="Black" DataFormatString="{0:F}" ItemStyle-Width="100px" ItemStyle-HorizontalAlign="Right" />
                    <asp:BoundField  DataField="CURR_SYM" HeaderText="68" ItemStyle-ForeColor="Black"  ItemStyle-Width="15px" ItemStyle-HorizontalAlign="Center" />
            
                    <asp:TemplateField  ItemStyle-Width="15px">
                        <ItemTemplate>
                            <% If txtStatusID.Text = "1" Or txtStatusID.Text = "5" Then%>
                                <a href="#" id='<%# Eval("EXPENSE_ID") %>' class="delExpense"> <img  border="0" src="../Images/del.png" alt="Delete" title="Delete" /></a>
                            <%End If%>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>

                <FooterStyle BackColor="#CCCC99" />
                <PagerStyle ForeColor="white" HorizontalAlign="Left" Height="20px" />
                <HeaderStyle BackColor="#6B696B" ForeColor="White" Height="20px" />
                <HeaderStyle Wrap="true" />
                <AlternatingRowStyle BackColor="White" />
                <SelectedRowStyle CssClass="sel"></SelectedRowStyle>
            </asp:GridView>
        </div>
    </div> 
    
    <br />

<!---------------------------------------------------PANELS---------------------------------------------------------------->

    <asp:Panel ID="pnlAttachReceipt" runat="server" CssClass="modalPopup" style="display:none" Width="400px">
            <div style="margin:10px">
                <table width="100%">
                    <tr>
                        <td colspan="10"><table width="100%"><tr><td  style="color:#cd1e1e; font-size:larger; font-size:1.5em;">Attach File</td><td align="right"><img src="../images/av.png" width="50px" height="40px"/></td></tr></table></td>
                    </tr>
                    <tr style=" background-color:#cd1e1e;height:2px;"><td></td></tr>
                    <tr style="height:20px;"><td></td></tr>
                    <tr><td>File:<asp:FileUpload ID="FileUpload2" runat="server" Width="100%" Height="25px" /></td></tr>
                    <tr style="height:40px;"><td align="right"><br /><asp:Button ID="cmdAttachFile" runat="server" Text="Save" Height="30px" class="button1" /><asp:Button ID="cmdCancelAttach" runat="server" Text="Cancel" class="cancelAttach" UseSubmitBehavior="false"  Height="30px" Width="20%" /></td></tr>
                        
                </table>
                     
            </div>
    </asp:Panel>
        
    <asp:Panel ID="pnlCreateReport" runat="server" CssClass="modalPopup" DefaultButton="cmdSaveReport" style="display:none" Width="475px">
                <div style="margin:10px">
                    
                    <table width="60%">
                        <tr style="height:50px;">
                            <td style="color:#cd1e1e; font-size:1.5em; "><asp:Label ID="lbl227" runat="server"></asp:Label></td>
                            <td align="right"><img src="../images/av.png" width="50px" height="40px"/></td>
                        </tr>
                        <tr style=" background-color:#cd1e1e;height:2px;"><td colspan="10"></td></tr>
                        <tr style="height:20px;"><td></td></tr>
                        <tr><td colspan="10"><asp:Label ID="lbl74" runat="server" Text="Report Title:  " class="labelText" /><asp:TextBox ID="txtReportName" runat="server" Width="400px"></asp:TextBox><br /><asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtReportName" ErrorMessage="* Title cannot be blank" ValidationGroup="NewReport" /><br /><br /></td></tr>
                        <tr><td align="right" colspan="10">
                            <asp:Button ID="cmdSaveReport" runat="server" Text="Save" class="button1" CausesValidation="true" Height="30px" />
                            <%If Session("language") = "English" Then%>
                                <input id="Button2" type="button" value="Cancel" class="cancelRpt" style="height:30px;" />
                            <%else %>
                                <input id="Button2" type="button" value="Annuler" class="cancelRpt" style="height:30px;" />
                            <%End If%>
                        </td></tr>
                    </table>
                    
                </div>
    </asp:Panel>
    

    <asp:Panel ID="pnlExport" runat="server" CssClass="modalPopup" style="display:none" Width="400px" Height="210px" >
            <table  width="100%">
                <tr style="height:50px;"><td colspan="10" ><table width="100%"><tr><td><asp:Label ID="lbl75" runat="server" Text="Export Data Entry" style="color:#cd1e1e;font-size:1.5em;"></asp:Label></td><td align="right"><img src="../images/av.png" width="50px" height="40px"/></td></tr></table></td></tr>
                <tr style=" background-color:#cd1e1e;height:2px;"><td colspan="10"></td></tr>
                <tr style="height:20px;"><td></td></tr>

                <tr id="Row-ReportType">
                    <td valign="top"><asp:Label ID="lbl76" runat="server" Text="Type of Report:" class="labelText" /></td>
                    <td>
                        <asp:DropDownList ID="cboReportType" runat="server" Height="25px" Width="200px">
                            <asp:ListItem Value="PDF">Data Entry Report</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                
                </tr>
                <tr>
                    <td valign="top"><asp:Label ID="lbl36" runat="server" Text="Send To:" class="labelText" /></td>
                    <td>
                        <asp:DropDownList ID="cboExport" runat="server" Height="25px" Width="100px">
                            <asp:ListItem Value="Excel">Excel</asp:ListItem>
                            <asp:ListItem Value="PDF">PDF</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                </tr>
           
            </table>
            <br /><br />
            <table width="95%">
                <tr>
                    <td align="right" valign="bottom"><asp:Button ID="cmdExport" runat="server" Text="Export" Height="30px" class="button1" UseSubmitBehavior="true" />&nbsp;&nbsp;&nbsp;<input id="Button1" type="button" value="Close" class="cancelExport" style="Height:30px;Width:80px;" /></td>
                </tr>
            </table>
            
    </asp:Panel> 
    
    <asp:Panel ID="pnlCreateExpense" runat="server" CssClass="modalPopup" DefaultButton="cmdSaveExpense" style="display:none"  Width="575px" Height="560px" >
        <br />
        <div style="position:relative;left:15px;">
            <div style="height:475px;">
            <table width="95%">

                <tr id="Row-ExpID"><td><asp:TextBox ID="txtExpenseID" runat="server" Visible="true" Width="81px" Text="0" Height="0px" BorderStyle="None" /></td></tr>
                <tr id="Row-TitleAddExp">
                    <td colspan="10"><table width="100%"><tr><td style="color:#cd1e1e; font-size:larger; font-size:1.5em;"><asp:Label ID="lbl131" runat="server" Text="Label"></asp:Label>&nbsp;<%=labelReportName.Text%></td><td align="right"><img src="../images/av.png" width="50px" height="40px"/></td></tr></table></td>
                </tr>

                <tr id="Row-TitleEditExp">
                    <td colspan="10" ><table width="100%"><tr><td style="color:#cd1e1e; font-size:larger; font-size:1.5em;"><asp:Label ID="lbl109" runat="server" Text="Label"></asp:Label>&nbsp;<%=labelReportName.Text%></td><td align="right"><img src="../images/av.png" width="50px" height="40px"/></td></tr></table></td>
                </tr>
                <tr><td colspan="10" style=" background-image:url(../images/redline.png); background-repeat:repeat-x;"></td></tr>
                    <tr id="Row-ExpMsg">
                        <td colspan="3">
 	                        <div class="ui-widget">
		                        <div class="ui-state-highlight ui-corner-all" style="margin-top: 0px; padding: 0em;height:50px;"> 
			                        <p><span class="ui-icon ui-icon-info" style="float: left; margin-right: .3em;"></span>
			                          <asp:Label ID="lblExpMsg" runat="server" Text="" ></asp:Label></p>
		                        </div>
                            </div>
                        </td>
                    </tr>
                    <tr><td>&nbsp;</td></tr>
                    <tr  height="30px">
                        <td width="20%" align="left">
                            <asp:Label ID="lbl37" runat="server" Text="Expense Type:" class="labelText" /></td>
                        <td width="50%">
                            <asp:DropDownList ID="cboCat" class="cboCat" runat="server" DataSourceID="SqlDataSource4" DataTextField="CAT_NAME" DataValueField="ORG_CAT_ID" Height="25px" Width="292px" >
                            
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="cboCat" ErrorMessage="*"  ValidationGroup="NewExpense"  />
                            
                        </td>
                    </tr>

                    <tr  height="30px">
                        <td align="left">
                            <asp:Label ID="lbl38" runat="server" Text="Expense Date:" class="labelText" />
                        </td>
                        <td align="left">
                            <asp:TextBox ID="txtExpDate" runat="server" Width="100px"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtExpDate" ErrorMessage="*"  ValidationGroup="NewExpense" />
                        </td>
                    </tr>

                    <tr id="Row-TaxRate"  height="30px">
                        <td align="left"><asp:Label ID="lbl39" runat="server" Text="Is your expense subject to:" class="labelText" /></td>
                        <td>
                            <asp:DropDownList ID="cboTaxRate" runat="server"  Height="25px" DataSourceID="sqlGetAirTaxRates" DataTextField="TR_DESCRIPTION" DataValueField="JUR_ID">
                             </asp:DropDownList>

                        </td>
                    </tr>

                    <tr id="Row-Rate"  height="30px">
                        <td align="left">
                            <asp:Label ID="lbl40" runat="server" Text="Rate:" class="labelText" />
                        </td>
                        <td>
                            <%-- <asp:TextBox ID="txtRate" runat="server" class="numberinput"></asp:TextBox> --%>
                            <asp:DropDownList ID="cboRate" runat="server"  Height="25px">
                                <asp:ListItem></asp:ListItem>
                             </asp:DropDownList>

                        </td>
                    </tr>

                    <tr id="Row-KM"  height="30px">
                        <td align="left">
                            <asp:Label ID="lbl41" runat="server" Text="# of KM:" class="labelText" />
                        </td>
                        <td>
                            <asp:TextBox ID="txtKM" runat="server" class="numberinput-nodecimal"></asp:TextBox>
                        </td>
                    </tr>

                    <tr id="Row-Supplier" height="30px">
                        <td align="left">
                            <asp:Label ID="lbl42" runat="server" Text="Supplier Name:" class="labelText" />
                        </td>
                        <td>
                            <asp:TextBox ID="txtSupplier" runat="server" Width="287px" Height="20px"></asp:TextBox>
                        </td>
                    </tr>
                
                    <tr id="Row-Jur" height="30px">
                        <td align="left">
                            <asp:Label ID="lbl43" runat="server" Text="Jurisdiction:" class="labelText" />
                        </td>
                        <td>
                            <asp:DropDownList ID="cboJur" runat="server" DataSourceID="SqlDataSource5" 
                                DataTextField="JUR_NAME" DataValueField="JUR_ID" Height="25px" Width="214px">
                            </asp:DropDownList>
                        </td>
                    </tr>
                
                    <tr id="Row-TaxStatus" height="30px">
                        <td align="left">
                            <asp:Label ID="lbl44" runat="server" Text="Tax Status:" class="labelText" />
                        </td>
                        <td>
                            <asp:DropDownList ID="cboTaxStatus" runat="server">
                                <asp:ListItem Text="Taxable" Value="Taxable"></asp:ListItem>
                                <asp:ListItem Text="Non-Taxable" Value="Non-Taxable"></asp:ListItem>
                            </asp:DropDownList>
                        </td>
                    </tr>
                
                    <tr id="Row-Amt" height="30px">
                        <td align="left">
                            <asp:Label ID="lbl45" runat="server" Text="Amount:" class="labelText" />
                        </td>
                        <td>
                            <asp:TextBox ID="txtAmt" runat="server" Width="75px"  Height="20px" class="numberinput" MaxLength="8"></asp:TextBox>
                            <asp:DropDownList ID="cboTaxIE" runat="server" Height="25px">
                                <asp:ListItem Value="1">Tax Included</asp:ListItem>
                                <asp:ListItem Value="2">Before Tax</asp:ListItem>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="AmtRequired" runat="server" ControlToValidate="txtAmt" ErrorMessage="* required"  ValidationGroup="NewExpense" />
                        </td>
                    </tr>

                    <tr id="Row-Grat" height="30px">
                        <td align="left">
                            <asp:Label ID="lbl46" runat="server" Text="Tip:" class="labelText" />
                        </td>
                        <td valign="middle">
                            <asp:TextBox ID="txtGrat" runat="server" class="numberinput" />&nbsp;&nbsp;<a id="24" href="#" class="popUpWin"><img src="../images/question.png" width="18px" height="18px" /></a>
                        </td>
                    </tr>

                    <tr height="30px">
                        <td align="left">
                            <asp:Label ID="lbl47" runat="server" Text="Currency:" class="labelText" />
                        </td>
                        <td>
                            <asp:DropDownList ID="cboCurr" runat="server" DataSourceID="SqlDataSource3" 
                                DataTextField="CURRENCY" DataValueField="CURR_ID" Height="25px"
                                style="margin-left: 0px" Width="197px">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    
                    <tr id="Row-DontReimburse">
                        <td align="left" valign="middle">
                        
                        </td>
                        <td class="labelText">
                            <asp:CheckBox ID="chkDontReimburse" runat="server" /><asp:Label ID="lbl51" runat="server" Text="Do not reimburse"></asp:Label> <a id="23" href="#" class="popUpWin"><img src="../images/question.png" width="17px" height="17px" /></a> 
                        </td>
                    
                    </tr>
                                    
                    <tr height="30px">
                        <td align="left" valign="top" >
                            <asp:Label ID="lbl48" runat="server" Text="Comment:" class="labelText" />
                        </td>
                        <td>
                            <asp:TextBox ID="txtComment" runat="server" Height="54px" Width="299px" TextMode="MultiLine" ></asp:TextBox>
                        </td>
                    </tr>
                    <tr><td></td></tr>

                    <tr>
                        <td align="left" valign="middle">
                            <asp:Label ID="lbl49" runat="server" Text="Attach Receipt:" class="labelText" />
                        </td>
                        <td valign="middle">
                            <asp:FileUpload ID="FileUpload1" runat="server" Width="300px" Height="23px"  />
                            <table>
                                <tr><td id="Cell-RemoveAttachment"><a href="#" class="delReceipt">Delete Receipt</a></td></tr>
                            </table>
                        </td>
                    
                    </tr>

                    <tr id="Row-GST" >
                        <td align="left" valign="middle"><asp:Label ID="lbl50" runat="server" Text="GST/HST paid:" class="labelText" /></td><td><asp:TextBox ID="txtGST" runat="server" Width="75px" BorderStyle="Solid" BorderWidth="1px" Enabled="false"  class="numberinput" style=" text-align:right;"></asp:TextBox><asp:Label ID="lblGST" runat="server" Text=""></asp:Label>&nbsp;&nbsp;&nbsp;<a href="#"><img id="imgUnlockGST" src="../images/lock.png" title="Unlock Field" class="unlockGST" width="12px" height="16px" /></a></td>
                    </tr>
                
                    <tr id="Row-HST" >
                        <td align="left"><asp:Label ID="lblHSTpaid" runat="server" Text="HST paid:" class="labelText" /></td><td><asp:TextBox ID="txtHST" runat="server" Width="75px" BorderStyle="Solid" BorderWidth="1px" Enabled="true"  class="numberinput" style=" text-align:right;"></asp:TextBox><asp:Label ID="lblHST" runat="server" Text=""></asp:Label></td>
                    </tr>

                    <tr id="Row-QST" >
                        <td align="left" valign="middle"><asp:Label ID="lbl66" runat="server" Text="QST paid:" class="labelText" /></td><td><asp:TextBox ID="txtQST" runat="server" Width="75px" BorderStyle="Solid" BorderWidth="1px" Enabled="false" ForeColor="Black"  class="numberinput" style=" text-align:right;"></asp:TextBox><asp:Label ID="lblQST" runat="server" Text=""></asp:Label>&nbsp;&nbsp;&nbsp;<a href="#"><img id="imgUnlockQST" src="../images/lock.png" title="Unlock Field" class="unlockQST"  width="12px" height="16px"/></a></td>
                    </tr>

                    <tr id="Row-Total" >
                        <td align="left" valign="middle" style="  font-size:larger ; color:Green;"><asp:Label ID="lbl67" runat="server" Text="Total paid:" class="labelText" /></td><td><asp:TextBox  ID="txtTotal" runat="server" Width="75px" BorderStyle="Solid" BorderWidth="1px" Enabled="false" ForeColor="Green" style=" text-align:right;" /></td>
                    </tr>
                </table>
             </div> 
             <div style="position:relative;width:95%;">
                <table width="100%">
                    <tr>
                        <td>&nbsp;</td>
                        <td align="right" >
                            <asp:Button ID="cmdSaveExpense" runat="server" Text="Save" height="30px" tooltip="Save and close" width="60px" CausesValidation="true" ValidationGroup="NewExpense" />
                            <asp:Button ID="cmdSaveExpense2" runat="server" Text="Save +"  height="30px" ToolTip="Save and add another expense"  width="60px"  CausesValidation="true" ValidationGroup="NewExpense"  />
                            <asp:Button ID="cmdCancel" class="cancelExp" runat="server" Text="Cancel"  height="30px" UseSubmitBehavior="false" width="80px" />
                        </td>
                    </tr>
                </table>

            </div>
        </div>
        
        <br />
        <br />
        <br />
        <br />      
        <br />
        <br />
        <br />
    
    </asp:Panel>

    <asp:Panel ID="pnlProcessing" runat="server" CssClass="modalPopup" Width="300px">
            <div class="labelText" style="margin:10px">
                <table width="100%"><tr><td><img src="../images/busy.gif" /></td><td align="center" class="labelText"><asp:Label ID="lbl285" runat="server" Text=""></asp:Label></td></tr></table>
            </div>
    </asp:Panel>


<!-----------------------------------------------HIDDEN FIELDS------------------------------------------------------------------->
    <asp:TextBox ID="txtEmpID" runat="server" Visible="False" Width="81px"></asp:TextBox>
    <asp:TextBox ID="txtSuperID" runat="server" Visible="False" Width="81px"></asp:TextBox>
    <asp:TextBox ID="txtStatusID" runat="server" Visible="false" value="0"></asp:TextBox>
    <asp:HiddenField id="hdnOrgID" runat="server" />
    <asp:HiddenField id="hdnReportID" runat="server" />
    <asp:HiddenField id="hdnExpenseID" runat="server" />
    <asp:HiddenField id="hdnOrgCatID" runat="server" Value="0" />
    <asp:HiddenField id="hdnOpenReport" runat="server" Value="False" />
    <asp:HiddenField id="hdnReportDate" runat="server" Value="01/01/2012" />
    <asp:HiddenField id="hdnDefaultJur" runat="server" Value="1" />
    <asp:HiddenField id="hdnLanguage" runat="server" />
    <asp:HiddenField id="hdnSubmitMessage" runat="server" />
    <asp:HiddenField id="hdnSubmitTitle" runat="server" />
    <asp:HiddenField id="hdnDeleteRptMsg" runat="server" />
    <asp:HiddenField id="hdnDeleteRptTitle" runat="server" />
    <asp:HiddenField id="hdnDeleteExpMsg" runat="server" />
    <asp:HiddenField id="hdnDeleteExpTitle" runat="server" />
    <asp:HiddenField id="hdnSubmitTooltip" runat="server" />
    <asp:HiddenField id="hdnAddExpTooltip" runat="server" />
    <asp:HiddenField id="hdnEditTooltip" runat="server" />
    <asp:HiddenField id="hdnSelectTooltip" runat="server" />
    <asp:HiddenField id="hdnViewExpRptTooltip" runat="server" />
    <asp:HiddenField id="hdnExpDataEntryTooltip" runat="server" />
    <asp:HiddenField id="hdnUnlockGST" runat="server" Value="No" />
    <asp:HiddenField id="hdnUnlockQST" runat="server" Value="No" />
    <asp:HiddenField id="hdnFinalizeMessage" runat="server" />
    <asp:HiddenField id="hdnFinalizeTitle" runat="server" />
    <asp:HiddenField id="hdnCancelText" runat="server" />
    <asp:HiddenField ID="hdnGST" runat="server" />
    <asp:HiddenField ID="hdnQST" runat="server" />
    <asp:HiddenField ID="hdnReportIDEdit" runat="server" />
    <asp:HiddenField ID="hdnCatID" runat="server" Value="0"  />

<!-----------------------------------------------MODAL POPUP EXTENDERS----------------------------------------------------------->
    <act:ModalPopupExtender ID="modalProcessing" runat="server"
                TargetControlID="cmddummy"
                PopupControlID="pnlProcessing"
                PopupDragHandleControlID="pnlProcessing"
                DropShadow="false"
                BackgroundCssClass="modalBackground"
                BehaviorID="modalProcessing" />

    <act:ModalPopupExtender ID="ModalPopupExtender2" runat="server"
                TargetControlID="cmddummy"
                PopupControlID="pnlCreateReport"
                PopupDragHandleControlID="pnlCreateReport"
                DropShadow="false"
                BackgroundCssClass="modalBackground"
                BehaviorID="ModalPopupExtender2" />
                    
    <act:ModalPopupExtender ID="modalExport" runat="server"
                TargetControlID="cmddummy"
                PopupControlID="pnlExport"
                PopupDragHandleControlID="pnlExport"
                DropShadow="false"
                BackgroundCssClass="modalBackground" 
                BehaviorID="modalExport" />

    <act:ModalPopupExtender ID="ModalPopupExtender4" runat="server"
                TargetControlID="cmdDummy"
                PopupControlID="pnlCreateExpense"
                PopupDragHandleControlID="pnlCreateExpense"
                DropShadow="false"
                BackgroundCssClass="modalBackground" 
                BehaviorID="MPE4" />
    
     <act:ModalPopupExtender ID="modalAttachReceipt" runat="server"
                TargetControlID="cmdDummy"
                PopupControlID="pnlAttachReceipt"
                PopupDragHandleControlID="pnlAttachReceipt"
                DropShadow="false"
                BackgroundCssClass="modalBackground" 
                BehaviorID="modalAttachReceipt" />

<!-----------------------------------------------DATA SOURCES------------------------------------------------------------------->
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:dbadvaloremConnStr %>" 
                    SelectCommand="GetReportsByEmpID" SelectCommandType="StoredProcedure"
                    FilterExpression="STATUS_NAME like'{0}%'">
             
                 <SelectParameters>
                     <asp:ControlParameter ControlID="cboDelegate" DefaultValue="0" Name="EmpID" 
                         PropertyName="SelectedValue" Type="Int32" />
                 </SelectParameters>
         
                 <FilterParameters>
                    <asp:ControlParameter Name="STATUS_NAME" ControlID="cboStatus" PropertyName="SelectedValue" />
                 </FilterParameters>

            </asp:SqlDataSource>
    
            <asp:SqlDataSource ID="SqlDataSource6" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:dbadvaloremConnStr %>" 
                    SelectCommand="GetReportsBySuperID" SelectCommandType="StoredProcedure"
                    FilterExpression="STATUS_NAME like'{0}%'">
             
                <SelectParameters>
                     <asp:ControlParameter ControlID="txtSuperID" DefaultValue="0" Name="SuperID" 
                         PropertyName="Text" Type="Int32" />
                 </SelectParameters>
                 <FilterParameters>
                    <asp:ControlParameter Name="STATUS_NAME" ControlID="cboStatus" PropertyName="SelectedValue" />
                 </FilterParameters>
            </asp:SqlDataSource>

            <asp:SqlDataSource ID="SqlDataSource7" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:dbadvaloremConnStr %>" 
                    SelectCommand="GetReportsBySuperID" SelectCommandType="StoredProcedure"
                    FilterExpression="STATUS_NAME like'{0}%' AND EMP_ID = {1}">
             
                 <SelectParameters>
                     <asp:ControlParameter ControlID="txtSuperID" DefaultValue="0" Name="SuperID" 
                         PropertyName="Text" Type="Int32" />
                 </SelectParameters>
                 <FilterParameters>
                    <asp:ControlParameter Name="STATUS_NAME" ControlID="cboStatus" PropertyName="SelectedValue" />
                 </FilterParameters>
                 <FilterParameters>
                    <asp:ControlParameter Name="EMP_ID" ControlID="cboEmp" PropertyName="SelectedValue" />
                 </FilterParameters>
            </asp:SqlDataSource>

            <asp:SqlDataSource ID="sqlEmp" runat="server" 
                ConnectionString="<%$ ConnectionStrings:dbadvaloremConnStr %>" 
                SelectCommand="SELECT * FROM [vEmployees] WHERE ([SUPERVISOR_EMP_ID] = @SUPERVISOR_EMP_ID)">
                <SelectParameters>
                    <asp:ControlParameter ControlID="txtSuperID" Name="SUPERVISOR_EMP_ID" 
                        PropertyName="Text" Type="Decimal" />
                </SelectParameters>
            </asp:SqlDataSource>
     
            <asp:SqlDataSource ID="sqlDelegate" runat="server" 
                ConnectionString="<%$ ConnectionStrings:dbadvaloremConnStr %>" 
                SelectCommand="SELECT * FROM [vEmployees] WHERE ([DELEGATE_EMP_ID] = @EmpID)">
                 <SelectParameters>
                     <asp:ControlParameter ControlID="txtEmpID" DefaultValue="0" Name="EmpID" 
                         PropertyName="Text" Type="Int32" />
                 </SelectParameters>
            </asp:SqlDataSource>

            <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
                ConnectionString="<%$ ConnectionStrings:dbadvaloremConnStr %>" 
                SelectCommand="GetExpenses2"
                 SelectCommandType="StoredProcedure">

                <SelectParameters>
                    <asp:ControlParameter ControlID="GridView1" Name="ReportID" 
                        PropertyName="SelectedValue" Type="Decimal" />
                </SelectParameters>

                <SelectParameters>
                     <asp:SessionParameter SessionField="language" Name="language" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>

            <asp:SqlDataSource ID="SqlDataSource3" runat="server" 
                ConnectionString="<%$ ConnectionStrings:dbadvaloremConnStr %>" 
                SelectCommand="GetCurrencies" SelectCommandType="StoredProcedure">
            </asp:SqlDataSource>
             
            <asp:SqlDataSource ID="SqlDataSource4" runat="server" 
                ConnectionString="<%$ ConnectionStrings:dbadvaloremConnStr %>" 
                SelectCommand="GetActiveOrgCategories" SelectCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:ControlParameter ControlID="hdnOrgID" DefaultValue="0" Name="OrgID" 
                        PropertyName="Value" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>
        
            <asp:SqlDataSource ID="SqlDataSource5" runat="server" 
                ConnectionString="<%$ ConnectionStrings:dbadvaloremConnStr %>" 
                SelectCommand="GetJurisdictions" SelectCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:SessionParameter SessionField="language" Name="language" Type="String" />
                </SelectParameters>
            
            </asp:SqlDataSource>

            <asp:SqlDataSource ID="sqlGetAirTaxRates" runat="server" 
                ConnectionString="<%$ ConnectionStrings:dbadvaloremConnStr %>" 
                SelectCommand="GetAirTaxRates" SelectCommandType="StoredProcedure">
            </asp:SqlDataSource>
        
<!----------------------------------------------------------------------------------------------------------------------------->
    
    <div id="dialog" title="Dates" />
        
    <table>
        <tr id="dummytable">
            <td>
                <asp:Button ID="cmdDummy" runat="server" Text="Button"  />
                <asp:ImageButton ID="cmdEditExp" runat="server"  ImageUrl="../images/cmdEdit.png" Height="33px" Width="87px" Visible="true" CausesValidation="False"  style="opacity:0;" />
                <div style="opacity:0;"><asp:ImageButton ID="cmdEdit" runat="server" ImageUrl="../images/cmdEdit.png" Height="0px" Width="87px" Visible="false"  CausesValidation ="false"  />
                    <asp:ImageButton ID="cmdApprove" runat="server"  ImageUrl="../images/cmdApprove.png" Height="33px" Width="87px" Visible="False" CausesValidation="false" />
                </div> 
            </td>
        </tr>
    </table>

    







































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































                <script type="text/javascript">
                    // Popup window code
                    function popup(url) {                  
                        var iMyWidth;
                        var iMyHeight;
                        //half the screen width minus half the new window width (plus 5 pixel borders).
                        iMyWidth = (window.screen.width / 2) - (500 + 10);
                        //half the screen height minus half the new window height (plus title and status bars).
                        iMyHeight = (window.screen.height / 2) - (300 + 50);
                        //Open the window.

                        var popupWindow = window.open(url, 'popUpWindow',  "status=no,height=600,width=1000,resizable=yes,left=" + iMyWidth + ",top=" + iMyHeight + ",screenX=" + iMyWidth + ",screenY=" + iMyHeight + ",toolbar=no,menubar=no,scrollbars=yes,location=no,directories=no");
                        popupWindow.focus(); 
                    }

                    function promptReason(okFunc, dialogTitle) {
                        $('<div style="padding: 10px; max-width: 500px; word-wrap: break-word;"><textarea id="txtReason" cols="40" rows="5" /></div>').dialog({
                            draggable: false,
                            modal: true,
                            resizable: false,
                            width: '400',
                            title: dialogTitle || 'Reason',
                            minHeight: 75,
                            buttons: {
                                OK: function () {
                                    if (typeof (okFunc) == 'function') { setTimeout(okFunc, 50); }
                                    $(this).dialog('destroy');
                                }
                            }
                        });
                    }

                    function myConfirm(dialogText, okFunc, cancelFunc, dialogTitle) {
                        var buttons = {};
                        var ok = 'OK';
                        var c = $("#<%=hdnCancelText.ClientID %>").val();
                        
                        
                        buttons[ok] = function () { if (typeof (okFunc) == 'function') { setTimeout(okFunc, 50); } $(this).dialog('destroy'); }
                        buttons[c] = function () { if (typeof (cancelFunc) == 'function') { setTimeout(cancelFunc, 50); } $(this).dialog('close'); }

                        $('<div style="padding: 10px; max-width: 500px; word-wrap: break-word;"><span class="labelText" style="font-size:0.9em;">' + dialogText + '</span></div>').dialog({
                            draggable: false,
                            modal: true,
                            resizable: false,
                            width: '400',
                            title: dialogTitle || 'Confirm',
                            minHeight: 75,
                            show: "fade",
                            hide: "fade",
                            buttons: buttons
                        });
                    }


                    function myMsg(dialogText, okFunc, dialogTitle) {
                        $('<div style="padding: 10px; max-width: 500px; word-wrap: break-word;"><span class="labelText" style="font-size:0.9em;">' + dialogText + '</span></div>').dialog({
                            draggable: false,
                            modal: true,
                            resizable: false,
                            width: 400,
                            title: dialogTitle || 'Confirm',
                            minHeight: 75,
                            buttons: {
                                OK: function () {
                                    if (typeof (okFunc) == 'function') { setTimeout(okFunc, 50); }
                                    $(this).dialog('destroy');
                                }
                            }
                        });
                    }

                    $(document).ready(function () {

                        if ($("#<%= hdnOpenReport.ClientID %>").val() == "True" && $("#<%= cboStatus.ClientID %>").val() == "Open")
                            $("td:#Cell-NewExp").show();
                        else
                            $("td:#Cell-NewExp").hide();

                        $("#<%=txtGrat.ClientID %>").val(0);
                        $("#<%= txtExpDate.ClientID %>").datepicker({ dateFormat: "dd/mm/yy", minDate: "01/07/2010", maxDate: getMaxDate() });

                        if ($("#<%=cboTaxIE.ClientID %>").val() == 1) {
                            document.getElementById("imgUnlockGST").style.display = "none";
                            document.getElementById("imgUnlockQST").style.display = "none";
                        } else {
                            document.getElementById("imgUnlockGST").style.display = "inline";
                            document.getElementById("imgUnlockQST").style.display = "inline";
                        }

                        $("tr:#Row-ReportType").hide();
                        $("tr:#Row-ExpMsg").hide();
                        //$("tr:#Row-GST").hide();
                        $("tr:#Row-HST").hide();
                        $("tr:#Row-QST").hide();
                        //$("tr:#Row-Total").hide();
                        $("tr:#Row-TaxStatus").hide();
                        $("tr:#dummytable").hide();
                        $("tr:#Row-ExpID").hide();
                        $("tr:#Row-TitleEditExp").hide();
                        $("tr:#Row-Supplier").hide();
                        $("tr:#Row-Jur").hide();
                        $("td:#Cell-RemoveAttachment").hide();
                        $("tr:#Row-TaxRate").hide();
                        $("tr:#Row-Rate").hide();
                        $("tr:#Row-KM").hide();
                        $("tr:#Row-Grat").hide();
                        $("#<%=cboCat.ClientID %>").val('');
                        $("#<%=txtKM.ClientID %>").val('');
                        $("#<%=cboRate.ClientID %>").val('');
                        $("#<%=txtAmt.ClientID %>").val('');
                        $("#<%=cboCat.ClientID %>").val('');


                        //var buttonID = '<%= cmdEdit.ClientID %>';
                        //var button = document.getElementById(buttonID);
                        //if (button) { $("td:#Cell-NewExp").show(); } else { $("td:#Cell-NewExp").hide(); };

                        $(".popUpWin").click(function () {
                            var iMyWidth;
                            var iMyHeight;
                            //half the screen width minus half the new window width (plus 5 pixel borders).
                            iMyWidth = (window.screen.width / 2) - (350 + 10);
                            //half the screen height minus half the new window height (plus title and status bars).
                            iMyHeight = (window.screen.height / 2) - (150 + 50);
                            //Open the window.
                            var win2 = window.open("../info.aspx?id=" + $(this).attr("id"), "Info", "status=no,height=300,width=700,resizable=yes,left=" + iMyWidth + ",top=" + iMyHeight + ",screenX=" + iMyWidth + ",screenY=" + iMyHeight + ",toolbar=no,menubar=no,scrollbars=no,location=no,directories=no");
                            win2.focus();
                        });

                        function getMaxDate() {
                            var today = new Date();
                            var maxDate = new Date();

                            if ($("#<%=cboTaxRate.ClientID %>").val() == 10 && $("#<%=hdnCatID.ClientID %>").val() == 5) {
                                maxDate = new Date("March 31, 2013");
                            }

                            if (today > maxDate) today = maxDate;

                            return today;
                        }


                        $(".mGrid a.collapseExp").each(function () {
                            $(this).hide();
                        });


                        //                $(".mGrid a.delReport").each(function () {

                        //                    var record_id = $(this).attr("id") / 4;
                        //                    var delRpt = $(this);
                        //                    delRpt.hide();

                        //                    $.ajax({
                        //                        type: "POST",
                        //                        //GridViewDelete.aspx is the page name and DeleteUser is the server side method to delete records in GridViewDelete.aspx.cs
                        //                        url: "Reports.aspx/GetReport",
                        //                        //Pass the selected record id
                        //                        data: "{'rptID': '" + record_id + "'}",
                        //                        contentType: "application/json; charset=utf-8",
                        //                        dataType: "json",
                        //                        success: function (returnVal) {
                        //                            if (returnVal.d[1] == 1 || returnVal.d[1] == 5) //status=open or rejected
                        //                                delRpt.show();
                        //                            else
                        //                                delRpt.hide();
                        //                        }
                        //                    });
                        //                });

                        $("#<%=txtKM.ClientID %>").keyup(function () {

                            $("#<%=txtAmt.ClientID %>").val(($("#<%=cboRate.ClientID %>").val() * $("#<%=txtKM.ClientID %>").val()));

                            $("#<%=txtAmt.ClientID %>").keyup();
                        });

                        $("#<%=txtGST.ClientID %>").keyup(function () {
                            if ($("#<%=cboTaxIE.ClientID %>").val() == 2) {
                                var num = $("#<%=txtAmt.ClientID %>").val() * 1;
                                num = num + $("#<%=txtGrat.ClientID %>").val() * 1;

                                if ($("#<%=cboTaxIE.ClientID %>").val() == 2) {
                                    num = num + $("#<%=txtGST.ClientID %>").val() * 1;
                                    num = num + $("#<%=txtQST.ClientID %>").val() * 1;
                                }

                                $("#<%=txtTotal.ClientID %>").val(num.toFixed(2));

                            }
                        });

                        $("#<%=txtQST.ClientID %>").keyup(function () {
                            var num = $("#<%=txtAmt.ClientID %>").val() * 1;
                            num = num + $("#<%=txtGrat.ClientID %>").val() * 1;

                            if ($("#<%=cboTaxIE.ClientID %>").val() == 2) {
                                num = num + $("#<%=txtGST.ClientID %>").val() * 1;
                                num = num + $("#<%=txtQST.ClientID %>").val() * 1;
                            }

                            $("#<%=txtTotal.ClientID %>").val(num.toFixed(2));
                        });


                        $("#<%=txtAmt.ClientID %>").blur(function () {
                            if ($("#<%=txtTotal.ClientID %>").val() == "NaN") {
                                alert("You entered an invalid amount");
                                $("#<%=cmdSaveExpense.ClientID %>").prop("disabled", "disabled");
                                $("#<%=cmdSaveExpense2.ClientID %>").prop("disabled", "disabled");
                            } else {
                                $("#<%=cmdSaveExpense.ClientID %>").removeAttr("disabled");
                                $("#<%=cmdSaveExpense2.ClientID %>").removeAttr("disabled");
                            }

                        });

                        //                    var jur_id = $("#<%=cboJur.ClientID %>").val();
                        //                    var exp_date = $("#<%=txtExpDate.ClientID %>").val();
                        //                    var cat_id = $("#<%=hdnCatID.ClientID %>").val();
                        //                    var tax_inc_exc = $("#<%=cboTaxIE.ClientID %>").val();


                        //                    $.ajax({
                        //                        type: "POST",
                        //                        //GridViewDelete.aspx is the page name and DeleteUser is the server side method to delete records in GridViewDelete.aspx.cs
                        //                        url: "Reports.aspx/GetTaxRates",
                        //                        //Pass the selected record id
                        //                        data: "{'jurID': '" + jur_id + "','expDate': '" + exp_date + "','catID': '" + cat_id + "','taxIncExc': '" + tax_inc_exc + "'}",
                        //                        contentType: "application/json; charset=utf-8",
                        //                        dataType: "json",
                        //                        success: function (returnVal) {
                        //                            var num;

                        //                            num = $("#<%=txtAmt.ClientID %>").val() * returnVal.d[0];
                        //                            $("#<%=txtGST.ClientID %>").val(num.toFixed(2));
                        //                            $("#<%=hdnGST.ClientID %>").val(num.toFixed(2));
                        //                            num = $("#<%=txtAmt.ClientID %>").val() * returnVal.d[1];
                        //                            $("#<%=txtQST.ClientID %>").val(num.toFixed(2));
                        //                            $("#<%=hdnQST.ClientID %>").val(num.toFixed(2));
                        //                            //num = $("#<%=txtAmt.ClientID %>").val() * returnVal.d[2];
                        //                            //$("#<%=txtHST.ClientID %>").val(num.toFixed(2));

                        //                            if (returnVal.d[0] != '0') { $("tr:#Row-GST").fadeIn(1000); } else { $("tr:#Row-GST").hide(); };
                        //                            if (returnVal.d[1] != '0') { $("tr:#Row-QST").fadeIn(1000); } else { $("tr:#Row-QST").hide(); };
                        //                            //if (returnVal.d[2] != '0') { $("tr:#Row-HST").fadeIn(1000); } else { $("tr:#Row-HST").hide(); };
                        //                        }
                        //                    });
                        //                });

                        $("#<%=txtExpDate.ClientID %>").change(function () {
                            $("#<%=txtAmt.ClientID %>").keyup();

                        });

                        $("#<%=txtAmt.ClientID %>").keyup(function () {

                            var jur_id;
                            var exp_date = $("#<%=txtExpDate.ClientID %>").val();
                            var cat_id = $("#<%=hdnCatID.ClientID %>").val();
                            var org_id = $("#<%=hdnOrgID.ClientID %>").val();
                            var tax_inc_exc = $("#<%=cboTaxIE.ClientID %>").val();
                            var kmRate = $("#<%=cboRate.ClientID %>").val();

                            if (kmRate == '') kmRate = 0;
                            if (kmRate == null) kmRate = 0;

                            if (cat_id == 5)
                                jur_id = $("#<%=cboTaxRate.ClientID %>").val();
                            else
                                jur_id = $("#<%=cboJur.ClientID %>").val();

                            $.ajax({
                                type: "POST",
                                //GridViewDelete.aspx is the page name and DeleteUser is the server side method to delete records in GridViewDelete.aspx.cs
                                url: "Reports.aspx/GetTaxRates",
                                //Pass the selected record id
                                data: "{'jurID': '" + jur_id + "','expDate': '" + exp_date + "','catID': '" + cat_id + "','taxIncExc': '" + tax_inc_exc + "','orgID': '" + org_id + "','kmRate': '" + kmRate + "'}",
                                contentType: "application/json; charset=utf-8",
                                dataType: "json",
                                success: function (returnVal) {
                                    var num;
                                    var total;

                                    num = $("#<%=txtAmt.ClientID %>").val() * returnVal.d[0];

                                    //if ($("#<%=cboTaxRate.ClientID %>").val() == 0) num = 0;

                                    $("#<%=txtGST.ClientID %>").val(num.toFixed(2));
                                    $("#<%=hdnGST.ClientID %>").val(num.toFixed(2));
                                    num = $("#<%=txtAmt.ClientID %>").val() * returnVal.d[1];
                                    //if ($("#<%=cboTaxRate.ClientID %>").val() == 0) num = 0;
                                    $("#<%=txtQST.ClientID %>").val(num.toFixed(2));
                                    $("#<%=hdnQST.ClientID %>").val(num.toFixed(2));


                                    num = $("#<%=txtAmt.ClientID %>").val() * 1;
                                    num = num + $("#<%=txtGrat.ClientID %>").val() * 1;

                                    if ($("#<%=cboTaxIE.ClientID %>").val() == 2) {
                                        num = num + $("#<%=txtGST.ClientID %>").val() * 1;
                                        num = num + $("#<%=txtQST.ClientID %>").val() * 1;
                                    }
                                    $("#<%=txtTotal.ClientID %>").val(num.toFixed(2));
                                    $("tr:#Row-Total").show();

                                    //num = $("#<%=txtAmt.ClientID %>").val() * returnVal.d[2];
                                    //$("#<%=txtHST.ClientID %>").val(num.toFixed(2));

                                    //if (returnVal.d[2] != '0') { $("tr:#Row-HST").fadeIn(1000); } else { $("tr:#Row-HST").hide(); };

                                    if ($("#<%=cboTaxRate.ClientID %>").val() == 20) {
                                        $(".unlockGST").mousedown();
                                        $(".unlockQST").mousedown();
                                        //$("tr:#Row-GST").fadeIn(300);

                                        if ($("#<%=txtAmt.ClientID %>").val() == 1) $("tr:#Row-QST").fadeIn(300);

                                    } else {

                                        //$("tr:#Row-GST").fadeIn(1000); 
                                        //$("tr:#Row-QST").fadeIn(1000); 

                                    }

                                    if (returnVal.d[2] == 0) {
                                        $("#<%=lblExpMsg.ClientID %>").text('KM rate selected exceeds the allowable rate for the selected jurisdiction. Taxes will not be calculated.');
                                        $("tr:#Row-ExpMsg").fadeIn(300);
                                    } else {
                                        if (cat_id != 44 && cat_id != 15) $("tr:#Row-ExpMsg").hide();
                                    }

                                }

                            });



                        });


                        $("#<%=cboTaxIE.ClientID %>").change(function () {

                            if ($("#<%=cboTaxIE.ClientID %>").val() == '2') {
                                document.getElementById("imgUnlockGST").style.display = "inline";
                                document.getElementById("imgUnlockQST").style.display = "inline";
                            } else {
                                document.getElementById("imgUnlockGST").style.display = "none";
                                document.getElementById("imgUnlockQST").style.display = "none";
                            }

                            $("#<%=txtAmt.ClientID %>").keyup();
                        });

                        $("#<%=cboJur.ClientID %>").change(function () {

                            if ($("#<%=cboJur.ClientID %>").val() == 1)
                                $("tr:#Row-QST").fadeIn(300);
                            else
                                $("tr:#Row-QST").fadeOut(300);

                            if ($("#<%=cboJur.ClientID %>").val() == 14)
                                $("tr:#Row-GST").fadeOut(300);
                            else
                                $("tr:#Row-GST").fadeIn(300);

                            $("#<%=txtAmt.ClientID %>").keyup();
                        });

                        $("#<%=cboRate.ClientID %>").change(function () {
                            $("#<%=txtKM.ClientID %>").keyup();
                        });

                        //                $("#<%=cboCat.ClientID %>").blur(function () {
                        //                    $("#<%=cboCat.ClientID %>").change();
                        //                });



                        //$("#<%=cboCat.ClientID %>").click(function () {
                        //    $("#<%=cboCat.ClientID %>").keyup()
                        //});


                        $("#<%=cboCat.ClientID %>").blur(function () {
                            $("#<%=cboCat.ClientID %>").keyup();
                        });

                        $("#<%=cboCat.ClientID %>").change(function () {
                            $("#<%=txtAmt.ClientID %>").val('');
                            $("#<%=txtSupplier.ClientID %>").val('');
                            $("#<%=txtComment.ClientID %>").val('');
                            $("#<%=txtGrat.ClientID %>").val('0.00');
                            $("#<%=txtTotal.ClientID %>").val('0.00');
                            $("#<%=txtGST.ClientID %>").val('0.00');
                            $("#<%=txtQST.ClientID %>").val('0.00');
                            $("#<%=hdnGST.ClientID %>").val(0);
                            $("#<%=hdnQST.ClientID %>").val(0);
                            //$("tr:#Row-GST").hide();

                            if ($("#<%=cboJur.ClientID %>").val() == 1)
                                $("tr:#Row-QST").fadeIn(300);
                            else
                                $("tr:#Row-QST").fadeOut(300);

                            if ($("#<%=cboJur.ClientID %>").val() == 14)
                                $("tr:#Row-GST").fadeOut(300);
                            else
                                $("tr:#Row-GST").fadeIn(300);

                            $("tr:#Row-HST").hide();
                            $("tr:#Row-ExpMsg").hide();
                            $("#<%=cboCat.ClientID %>").keyup();

                        });


                        $("#<%=cboCat.ClientID %>").keyup(function () {
                            var org_cat_id = $(this).val();
                            $("#<%=hdnOrgCatID.ClientID %>").val(org_cat_id);
                            //$("tr:#Row-Total").hide();
                            $("tr:#Row-ExpMsg").hide();

                            $.ajax({
                                type: "POST",
                                url: "Reports.aspx/GetAllows",
                                data: "{'orgCatID': '" + org_cat_id + "'}",
                                contentType: "application/json; charset=utf-8",
                                dataType: "json",
                                success: function (returnVal) {
                                    if (returnVal.d[0] == 1) $("tr:#Row-Supplier").show(); else { $("tr:#Row-Supplier").hide(); $("#<%=txtSupplier.ClientID %>").val(''); }
                                    //if (returnVal.d[0] == 1) $("tr:#Row-Supplier").fadeIn(1000); else { $("tr:#Row-Supplier").hide(); $("#<%=txtSupplier.ClientID %>").val(''); }
                                    if (returnVal.d[1] == 1) $("tr:#Row-Rate").show(); else { $("tr:#Row-Rate").hide(); $("#<%=cboRate.ClientID %>").val(''); }
                                    if (returnVal.d[2] == 1) {
                                        $("tr:#Row-Grat").show();
                                        //$("tr:#Row-Total").show();
                                    }
                                    else {
                                        $("tr:#Row-Grat").hide();
                                        //$("tr:#Row-Total").hide();
                                    }
                                    if (returnVal.d[3] == 1) $("tr:#Row-Jur").show(); else $("tr:#Row-Jur").hide();
                                    if (returnVal.d[4] == 1) $("tr:#Row-KM").show(); else { $("tr:#Row-KM").hide(); $("#<%=txtKM.ClientID %>").val(0); }
                                    if (returnVal.d[5] == 1) $("tr:#Row-Amt").show(); else $("tr:#Row-Amt").hide();
                                    if (returnVal.d[6] == 1) $("tr:#Row-TaxRate").show(); else { $("tr:#Row-TaxRate").hide(); $("#<%=cboTaxRate.ClientID %>").val(''); }
                                    if (returnVal.d[8] == 1) $("#<%=cboTaxIE.ClientID %>").show(); else { $("#<%=cboTaxIE.ClientID %>").hide(); $("#<%=cboTaxIE.ClientID %>").val(1); }
                                    if (returnVal.d[9] == 1) $("tr:#Row-DontReimburse").show(); else { $("tr:#Row-DontReimburse").hide(); $('#<%=chkDontReimburse.ClientID %>').attr('checked', false); }

                                    //if (returnVal.d[8] == 1) $("#<%=cboTaxIE.ClientID %>").prop('invisible', 'display'); else { $("#<%=cboTaxIE.ClientID %>").prop('invisible', 'none'); $("#<%=cboTaxIE.ClientID %>").val(0); }

                                    //       if (returnVal.d[7] == 4 || returnVal.d[7] == 2 || returnVal.d[7] == 1 || returnVal.d[7] == 6 || returnVal.d[7] == 7 || returnVal.d[7] == 8 || returnVal.d[7] == 12 || returnVal.d[7] == 13 || returnVal.d[7] == 14 || returnVal.d[7] == 47 || returnVal.d[7] == 41) {
                                    //           $("#<%=cboTaxIE.ClientID %>").val(1);
                                    //           $("#<%=cboTaxIE.ClientID %>").prop('visible',false);
                                    //       } else {
                                    //           $("#<%=cboTaxIE.ClientID %>").val(1);
                                    //           $("#<%=cboTaxIE.ClientID %>").prop('visible', true);
                                    //        }

                                    $("#<%=hdnCatID.ClientID %>").val(returnVal.d[7]);
                                    var num = returnVal.d[10] * 1;

                                    if (returnVal.d[7] == "4") {
                                        $("#<%=cboRate.ClientID %>").val(num.toFixed(2));

                                    } else {
                                        $("#<%=txtAmt.ClientID %>").val(num.toFixed(2));
                                    }

                                    if (returnVal.d[10] > 0) {
                                        $("#<%=cboRate.ClientID %>").prop("disabled", "disabled");
                                        $("#<%=txtAmt.ClientID %>").prop("disabled", "disabled");
                                        $("#<%=txtAmt.ClientID %>").keyup();
                                    } else {
                                        $("#<%=cboRate.ClientID %>").removeAttr("disabled");
                                        $("#<%=txtAmt.ClientID %>").removeAttr("disabled");
                                    }


                                    if (returnVal.d[7] == "44") {
                                        $("#<%=lblExpMsg.ClientID %>").text("Taxes, if any, are not calculated on expenses incurred for personal use");
                                        $("tr:#Row-ExpMsg").fadeIn(300);

                                    } else if (returnVal.d[7] == "15") {
                                        $("#<%=lblExpMsg.ClientID %>").text("Provincial insurance tax, if any, (i.e. Ont 8%, Qc 5% or 9%) are not recoverable and should be included in the amount");
                                        $("tr:#Row-ExpMsg").fadeIn(300);
                                    }
                                }
                            });
                        });


                        $(".editExp").click(function () {
                            var record_id = $(this).attr("id") / 3;
                            document.body.style.cursor = "wait";

                            $("tr:#Row-TitleAddExp").hide();
                            $("tr:#Row-TitleEditExp").show();
                            $("tr:#Row-Msg").hide();

                            //$("tr:#Row-Total").hide();
                            $("#<%=txtTotal.ClientID %>").val('0.00');
                            //$("tr:#Row-GST").hide();
                            $("tr:#Row-HST").hide();
                            $("tr:#Row-QST").hide();
                            $("#<%=txtGST.ClientID %>").prop('disabled', true);
                            $("#<%=txtQST.ClientID %>").prop('disabled', true);

                            $("#<%=txtExpenseID.ClientID %>").val(record_id);
                            //$("#<%=cmdEditExp.ClientID %>")[0].click();

                            $.ajax({
                                type: "POST",
                                url: "Reports.aspx/GetExpense",
                                data: "{'expID': '" + record_id + "'}",
                                contentType: "application/json; charset=utf-8",
                                dataType: "json",
                                async: true,
                                cache: false,
                                success: function (msg) {
                                    var num;
                                    num = msg.d[1] * 1;  //mulitply by 1 to convert num to numeric value
                                    //var d1 = new Date(msg.d[4]);


                                    $("#<%=cboCat.ClientID %>").val(msg.d[20]);
                                    $("#<%=hdnCatID.ClientID %>").val(msg.d[0]);
                                    $("#<%=hdnOrgCatID.ClientID %>").val(msg.d[20]);
                                    $("#<%=txtAmt.ClientID %>").val(num.toFixed(2));
                                    $("#<%=txtComment.ClientID %>").val(msg.d[2]);
                                    $("#<%=cboCurr.ClientID %>").val(msg.d[3]);
                                    $("#<%=txtExpDate.ClientID %>").val(msg.d[4]);
                                    $("#<%=txtGrat.ClientID %>").val(msg.d[5]);
                                    $("#<%=cboJur.ClientID %>").val(msg.d[6]);
                                    num = msg.d[7] * 1;
                                    $("#<%=cboRate.ClientID %>").val(num.toFixed(2));
                                    $("#<%=txtSupplier.ClientID %>").val(msg.d[8]);

                                    $("#<%=txtGST.ClientID %>").val(msg.d[18]);
                                    $("#<%=txtQST.ClientID %>").val(msg.d[19]);
                                    $("#<%=hdnGST.ClientID %>").val(msg.d[18]);
                                    $("#<%=hdnQST.ClientID %>").val(msg.d[19]);

                                    //alert(msg.d[22]);

                                    if (msg.d[22] == '0') {
                                        $('#<%=chkDontReimburse.ClientID %>').attr('checked', false);
                                    }
                                    else {
                                        $('#<%=chkDontReimburse.ClientID %>').attr('checked', true);
                                    }


                                    $("#<%=cboTaxIE.ClientID %>").val(msg.d[9]);
                                    if (msg.d[21] != "")
                                        $("td:#Cell-RemoveAttachment").show();
                                    else
                                        $("td:#Cell-RemoveAttachment").hide();

                                    var mpe = $find('MPE4');

                                    if (mpe) { mpe.show(); }

                                    $("#<%=cboCat.ClientID %>").prop('disabled', true);

                                    if (msg.d[0] == 4) {
                                        $("#<%=txtAmt.ClientID %>").val(msg.d[1]);
                                        $("#<%=txtKM.ClientID %>").val(msg.d[1] / msg.d[7]);


                                    }

                                    $("#<%=txtTotal.ClientID %>").val(msg.d[23]);

                                    //if (msg.d[18] > 0)
                                    //    $("tr:#Row-GST").show();

                                    //if (msg.d[19] > 0)
                                    //    $("tr:#Row-QST").show();


                                    if (msg.d[10] == 1)
                                        $("tr:#Row-Amt").show();
                                    else
                                        $("tr:#Row-Amt").hide();

                                    if (msg.d[11] == 1)
                                        $("tr:#Row-Supplier").show();
                                    else
                                        $("tr:#Row-Supplier").hide();

                                    if (msg.d[12] == 1) {
                                        $("tr:#Row-Grat").show();
                                    }
                                    else {
                                        $("tr:#Row-Grat").hide();

                                    }

                                    if (msg.d[13] == 1)
                                        $("tr:#Row-Jur").show();
                                    else
                                        $("tr:#Row-Jur").hide();

                                    if (msg.d[14] == 1)
                                        $("tr:#Row-KM").show();
                                    else
                                        $("tr:#Row-KM").hide();

                                    if (msg.d[15] == 1)
                                        $("tr:#Row-Note").show();
                                    else
                                        $("tr:#Row-Note").hide();

                                    if (msg.d[16] == 1)
                                        $("tr:#Row-Rate").show();
                                    else
                                        $("tr:#Row-Rate").hide();

                                    if (msg.d[17] == 1) {
                                        $("tr:#Row-TaxRate").show();
                                        $("#<%=cboTaxRate.ClientID %>").val(msg.d[6]);
                                    }
                                    else
                                        $("tr:#Row-TaxRate").hide();

                                    document.body.style.cursor = "default";
                                    //$("#<%=txtAmt.ClientID %>").keyup();
                                    $("tr:#Row-Total").show();

                                    num = $("#<%=txtTotal.ClientID %>").val() * 1;
                                    $("#<%=txtTotal.ClientID %>").val(num.toFixed(2));

                                }
                            });

                        });

                        $("#<%=cboTaxRate.ClientID %>").change(function () {
                            var record_id = $(this).val();
                            $("#<%=cboJur.ClientID %>").val(record_id);
                            $("#<%=txtExpDate.ClientID %>").datepicker("option", "maxDate", getMaxDate());
                            $("#<%=txtAmt.ClientID %>").keyup();
                        });

                        $("#<%=txtGrat.ClientID %>").keyup(function () {
                            $("#<%=txtAmt.ClientID %>").keyup();
                        });

                        $("#<%=txtGST.ClientID %>").keyup(function () {
                            $("#<%=hdnGST.ClientID %>").val($("#<%=txtGST.ClientID %>").val());
                        });

                        $("#<%=txtQST.ClientID %>").keyup(function () {
                            $("#<%=hdnQST.ClientID %>").val($("#<%=txtQST.ClientID %>").val());
                        });

                        $(".expandExp").click(function () {
                            var record_id = $(this).attr("id");
                            $(this).hide();
                            $("#" + record_id * 2).show();
                            $("#<%=txtExpenseID.ClientID %>").val(record_id);

                            var row = $(this).parent("td").parent('tr');

                            $.ajax({
                                type: "POST",
                                url: "Reports.aspx/GetOtherExpenseDetails",
                                data: "{'expID': '" + record_id + "'}",
                                contentType: "application/json; charset=utf-8",
                                dataType: "json",
                                async: true,
                                cache: false,
                                success: function (msg) {
                                    row.after(msg.d);
                                    var newRow = row.next();
                                    newRow.hide();
                                    newRow.fadeIn(1000);

                                }
                            });

                            return false;

                        });

                        $(".collapseExp").click(function () {
                            $(this).hide();

                            var record_id = $(this).attr("id") / 2;
                            $("#" + record_id).show();
                            var row = $(this).parents('tr').next();
                            //row.fadeOut(slow);
                            row.fadeOut(1000, function () {
                                //Remove GridView row
                                row.remove();
                            });

                        });


                        $(".delExpense").click(function () {
                            //Get the Id of the record to delete
                            var record_id = $(this).attr("id");

                            //Get the GridView Row reference
                            var tr_id = $(this).parents("#.record");
                            var row = $(this).parent("td").parent('tr');

                            myConfirm("Do you want to delete this expense?",
                                function () {
                                    $.ajax({
                                        type: "POST",
                                        //GridViewDelete.aspx is the page name and DeleteUser is the server side method to delete records in GridViewDelete.aspx.cs
                                        url: "Reports.aspx/DeleteExpense",
                                        //Pass the selected record id
                                        data: "{'expID': '" + record_id + "'}",
                                        contentType: "application/json; charset=utf-8",
                                        dataType: "json",
                                        success: function () {
                                            // Change the back color of the Row before deleting
                                            row.css("background-color", "red");
                                            // Do some animation effect
                                            row.fadeOut(1000, function () {
                                                //Remove GridView row
                                                row.remove();
                                            });
                                            $("#<%=lblMsg2.ClientID %>").text("Expense was deleted successfully");
                                        }
                                    });
                                },
                                function () { return false; }, "Delete");
                        });


                        $(".delReport").click(function () {
                            //Get the Id of the record to delete
                            var record_id = $(this).attr("id") / 4;

                            //Get the GridView Row reference
                            var tr_id = $(this).parents("#.record");
                            var row = $(this).parent("td").parent('tr');

                            // Ask user's confirmation before delete records

                            myConfirm($("#<%=hdnDeleteRptMsg.ClientID %>").val(), function () {
                                $.ajax({
                                    type: "POST",
                                    //GridViewDelete.aspx is the page name and DeleteUser is the server side method to delete records in GridViewDelete.aspx.cs
                                    url: "Reports.aspx/DeleteReport",
                                    //Pass the selected record id
                                    data: "{'rptID': '" + record_id + "'}",
                                    contentType: "application/json; charset=utf-8",
                                    dataType: "json",
                                    success: function () {
                                        window.location = "reports.aspx";
                                        // Change the back color of the Row before deleting
                                        //row.css("background-color", "red");
                                        // Do some animation effect
                                        //row.fadeOut(1000, function () {
                                        //Remove GridView row
                                        //    row.remove();
                                        // });


                                    }
                                });

                            },
                            function () { return false; }, $("#<%=hdnDeleteRptTitle.ClientID %>").val());

                        });


                        $(".approveRpt").click(function () {
                            //Get the Id of the record to delete
                            var record_id = $(this).attr("id") / 2;

                            //Get the GridView Row reference
                            var tr_id = $(this).parents("#.record");
                            var row = $(this).parent("td").parent('tr');
                            var lang = $("#<%=hdnLanguage.ClientID %>").val();

                            // Ask user's confirmation before delete records

                            myConfirm("Do you want to approve this report?", function () {
                                var mpe = $find('modalProcessing');
                                if (mpe) { mpe.show(); }

                                $.ajax({
                                    type: "POST",
                                    //GridViewDelete.aspx is the page name and DeleteUser is the server side method to delete records in GridViewDelete.aspx.cs
                                    url: "Reports.aspx/ApproveReport",
                                    //Pass the selected record id
                                    data: "{'rptID': '" + record_id + "','lang': '" + lang + "'}",
                                    contentType: "application/json; charset=utf-8",
                                    dataType: "json",
                                    success: function () {
                                        if (mpe) { mpe.hide(); }
                                        // Change the back color of the Row before deleting
                                        row.css("background-color", "green");
                                        row.fadeOut(1000);
                                        row.remove();

                                        $("#<%=GridView2.ClientID %> tr").each(function () {
                                            $(this).remove();
                                        });
                                    }
                                });
                            },
                            function () { return false; }, "Approve");

                        });

                        $(".rejectRpt").click(function () {
                            //Get the Id of the record to delete
                            var record_id = $(this).attr("id") / 3;
                            var lang = $("#<%=hdnLanguage.ClientID %>").val();
                            //Get the GridView Row reference
                            var tr_id = $(this).parents("#.record");
                            var row = $(this).parent("td").parent('tr');
                            var answer;
                            // Ask user's confirmation before delete records


                            myConfirm('Do you want to reject this report?',
                                function () {
                                    promptReason(function () {
                                        answer = $("#txtReason").val();
                                        var mpe = $find('modalProcessing');
                                        if (mpe) { mpe.show(); }

                                        document.body.style.cursor = "wait";
                                        $.ajax({
                                            type: "POST",
                                            //GridViewDelete.aspx is the page name and DeleteUser is the server side method to delete records in GridViewDelete.aspx.cs
                                            url: "Reports.aspx/RejectReport",
                                            //Pass the selected record id
                                            data: "{'rptID': '" + record_id + "','reason': '" + answer + "','lang': '" + lang + "'}",
                                            contentType: "application/json; charset=utf-8",
                                            dataType: "json",
                                            success: function () {
                                                if (mpe) { mpe.hide(); }
                                                // Change the back color of the Row before deleting
                                                row.css("background-color", "red");
                                                row.fadeOut(1000);
                                                row.remove();

                                                $("#<%=GridView2.ClientID %> tr").each(function () {
                                                    $(this).remove();
                                                });
                                            }
                                        });
                                        document.body.style.cursor = "default";
                                    },
                                     'Reason');
                                },
                                function () {
                                    return false;
                                },
                                'Confirm Reject');

                        });

                        $(".finalizeRpt").click(function () {
                            //Get the Id of the record to delete
                            var record_id = $(this).attr("id");
                            //alert('sdsd');
                            //Get the GridView Row reference
                            var tr_id = $(this).parents("#.record");
                            var row = $(this).parent("td").parent('tr');
                            var lang = $("#<%=hdnLanguage.ClientID %>").val();
                            var msg = $("#<%=hdnFinalizeMessage.ClientID %>").val();
                            var msgTitle = $("#<%=hdnFinalizeTitle.ClientID %>").val();


                            // Ask user's confirmation before delete records

                            myMsg('text', function () { return true; }, function () { return false; });


                            myConfirm(msg , function () {
                                var mpe = $find('modalProcessing');
                                if (mpe) { mpe.show(); }

                                $.ajax({
                                    type: "POST",
                                    //GridViewDelete.aspx is the page name and DeleteUser is the server side method to delete records in GridViewDelete.aspx.cs
                                    url: "Reports.aspx/FinalizeReport",
                                    //Pass the selected record id
                                    data: "{'rptID': '" + record_id + "','lang': '" + lang + "'}",
                                    contentType: "application/json; charset=utf-8",
                                    dataType: "json",
                                    success: function () {
                                        if (mpe) { mpe.hide(); }
                                        // Change the back color of the Row before deleting
                                        row.css("background-color", "green");
                                        row.fadeOut(1000);
                                        row.remove();

                                        $("#<%=GridView2.ClientID %> tr").each(function () {
                                            $(this).remove();
                                        });
                                    }
                                });
                            },
                            function () { return false; }, msgTitle);

                        });


                        $(".unfinalizeRpt").click(function () {
                            //Get the Id of the record to delete
                            var record_id = $(this).attr("id");

                            //Get the GridView Row reference
                            var tr_id = $(this).parents("#.record");
                            var row = $(this).parent("td").parent('tr');

                            // Ask user's confirmation before delete records

                            if (confirm("Do you want to un-finalize this report?")) {
                                $.ajax({
                                    type: "POST",
                                    //GridViewDelete.aspx is the page name and DeleteUser is the server side method to delete records in GridViewDelete.aspx.cs
                                    url: "Reports.aspx/UnfinalizeReport",
                                    //Pass the selected record id
                                    data: "{'rptID': '" + record_id + "'}",
                                    contentType: "application/json; charset=utf-8",
                                    dataType: "json",
                                    success: function () {
                                        // Change the back color of the Row before deleting
                                        row.css("background-color", "green");
                                        row.fadeOut(1000);
                                        row.remove();
                                    }
                                });
                            }
                            return false;
                        });

                        $(".submitRpt").click(function () {
                            //Get the Id of the record to delete
                            var record_id = $("#<%=hdnReportID.ClientID %>").val();
                            var lang = $("#<%=hdnLanguage.ClientID %>").val();

                            myConfirm($("#<%=hdnSubmitMessage.ClientID %>").val(), function () {
                                var mpe = $find('modalProcessing');
                                if (mpe) { mpe.show(); }

                                $.ajax({
                                    type: "POST",
                                    url: "Reports.aspx/SubmitReport",
                                    //Pass the selected record id
                                    data: "{'rptID': '" + record_id + "','lang': '" + lang + "'}",
                                    contentType: "application/json; charset=utf-8",
                                    dataType: "json",
                                    success: function (returnVal) {
                                        if (mpe) { mpe.hide(); }

                                        if (returnVal.d[0] == "") {
                                            window.location.href = "Reports.aspx?s=submitted";
                                        }
                                        else
                                            myMsg(returnVal.d[0], function () { return true; }, returnVal.d[2]);
                                    }

                                });

                            },
                                function () { return false; }, $("#<%=hdnSubmitTitle.ClientID %>").val())

                        });


                        $(".newExp").click(function () {

                            var record_id = $("#<%=hdnReportID.ClientID %>").val();
                            document.body.style.cursor = "wait";

                            $("tr:#Row-TitleAddExp").show();
                            $("tr:#Row-TitleEditExp").hide();
                            $("tr:#Row-Msg").hide();
                            $("tr:#Row-ExpMsg").hide();

                            $("#<%=txtExpenseID.ClientID %>").val(0);
                            $("#<%=cboCat.ClientID %>").prop('disabled', false);
                            $("#<%=txtGST.ClientID %>").prop('disabled', true);
                            $("#<%=txtQST.ClientID %>").prop('disabled', true);
                            $("td:#Cell-RemoveAttachment").hide();

                            //$("tr:#Row-Total").hide();
                            $("#<%=txtTotal.ClientID %>").val('0.00');
                            $("#<%=txtGST.ClientID %>").val('0.00');
                            $("#<%=txtQST.ClientID %>").val('0.00');
                            //$("tr:#Row-GST").hide();
                            $("tr:#Row-HST").hide();
                            $("tr:#Row-QST").hide();
                            $("tr:#Row-Rate").hide();
                            $("tr:#Row-KM").hide();
                            $("tr:#Row-Supplier").hide();
                            $("tr:#Row-Grat").hide();
                            $("tr:#Row-TaxRate").hide();
                            //$("tr:#Row-Amt").hide();
                            $("tr:#Row-Jur").hide();
                            $("tr:#Row-Grat").hide();
                            $("tr:#Row-KM").hide();
                            $("tr:#Row-Rate").hide();

                            $.ajax({
                                type: "POST",
                                //GridViewDelete.aspx is the page name and DeleteUser is the server side method to delete records in GridViewDelete.aspx.cs
                                url: "Reports.aspx/GetReport",
                                //Pass the selected record id
                                data: "{'rptID': '" + record_id + "'}",
                                contentType: "application/json; charset=utf-8",
                                dataType: "json",
                                success: function (rpt) {
                                    //$("#<%=txtExpDate.ClientID %>").val($("#<%=hdnReportDate.ClientID %>").val());
                                    $("#<%=txtExpDate.ClientID %>").val(rpt.d[2]);
                                    $("#<%=txtReportName.ClientID %>").val(rpt.d[0]);
                                    $("#<%=cboJur.ClientID %>").val(rpt.d[3]);
                                    $("#<%=cboCat.ClientID %>").prop('selectedIndex', 0);
                                    $("#<%=txtAmt.ClientID %>").val('');
                                    $("#<%=txtKM.ClientID %>").val('');
                                    $("#<%=cboRate.ClientID %>").val('');
                                    $("#<%=txtComment.ClientID %>").val('');
                                    $("#<%=cboCurr.ClientID %>").prop('selectedIndex', 24);
                                    //$("#<%=txtExpDate.ClientID %>").val();
                                    $("#<%=txtGrat.ClientID %>").val('');
                                    //$("#<%=cboJur.ClientID %>").val([6]);

                                    $("#<%=txtSupplier.ClientID %>").val('');

                                    var mpe = $find('MPE4');
                                    if (mpe) { mpe.show(); }
                                    document.body.style.cursor = "default";
                                }
                            });

                        });

                        $(".printRpt").click(function () {
                            popup("ExpenseReport.aspx?id=" + $(this).attr("id"));

                        });

                        $(".exportRpt").click(function () {
                            var record_id = $(this).attr("id");

                            $("#<%=hdnReportID.ClientID %>").val(record_id);
                            var mpe = $find('modalExport');
                            if (mpe) {
                                mpe.show();
                            }
                        });


                        $(".cancelExport").click(function () {
                            var mpe = $find('modalExport');
                            if (mpe) { mpe.hide(); }
                        });

                        $(".editRpt").click(function () {
                            var mpe = $find('ModalPopupExtender2');
                            var record_id = $(this).attr("id");
                            $("#<%=hdnReportIDEdit.ClientID %>").val(record_id);

                            $.ajax({
                                type: "POST",
                                //GridViewDelete.aspx is the page name and DeleteUser is the server side method to delete records in GridViewDelete.aspx.cs
                                url: "Reports.aspx/GetReport",
                                //Pass the selected record id
                                data: "{'rptID': '" + record_id + "'}",
                                contentType: "application/json; charset=utf-8",
                                dataType: "json",
                                success: function (rpt) {
                                    $("#<%=txtReportName.ClientID %>").val(rpt.d[0]);
                                    if (mpe) { mpe.show(); }
                                }
                            });


                        });

                        $(".newRpt").click(function () {

                            var mpe = $find('ModalPopupExtender2');

                            $("#<%=hdnReportIDEdit.ClientID %>").val('0');

                            if (mpe) { mpe.show(); }
                        });


                        $(".cancelRpt").click(function () {
                            var mpe = $find('ModalPopupExtender2');
                            $("#<%=txtReportName.ClientID %>").val('');
                            if (mpe) { mpe.hide(); }
                        });

                        $(".cancelExp").mousedown(function () {
                            var mpe = $find('MPE4');
                            if (mpe) { mpe.hide(); }
                        });

                        //                $(window).load(function () {
                        //                    var row = $("tr:#Totals")
                        //                    
                        //                    $.ajax({
                        //                        type: "POST",
                        //                        url: "Reports.aspx/GetReportTotalsEmp",
                        //                        data: "{}",
                        //                        contentType: "application/json; charset=utf-8",
                        //                        dataType: "json",
                        //                        async: true,
                        //                        cache: false,
                        //                        success: function (msg) {
                        //                            row.after('<tr><td>Open: ' + msg.d[0] + ' |</td><td>Pending: ' + msg.d[1] + ' |</td><td>Approved: ' + msg.d[2] + ' |</td><td>Finalized: ' + msg.d[3] + ' |</td><td>Rejected: ' + msg.d[4] + '</td></tr>');
                        //                            var newRow = row.next();
                        //                            newRow.hide();
                        //                            newRow.fadeIn(1000);
                        //                        }
                        //                    });
                        //                });




                        $(".viewReceipt").mousedown(function () {
                            var id = $(this).attr("id");
                            window.open("Receipt.aspx?id=" + id, "Receipt", "width=1000,height=600,toolbar=yes,scrollbars=yes");
                        });

                        $(".attachReceipt").mousedown(function () {
                            $("#<%=hdnExpenseID.ClientID %>").val($(this).attr("id"));

                            var mpe = $find('modalAttachReceipt');
                            if (mpe) { mpe.show(); }
                        });

                        $(".cancelAttach").mousedown(function () {
                            var mpe = $find('modalAttachReceipt');
                            if (mpe) { mpe.hide(); }
                        });


                        $(".delReceipt").click(function () {
                            var record_id = $("#<%=txtExpenseID.ClientID %>").val();


                            myConfirm("Do you want to delete the receipt?", function () {
                                $.ajax({
                                    type: "POST",
                                    //GridViewDelete.aspx is the page name and DeleteUser is the server side method to delete records in GridViewDelete.aspx.cs
                                    url: "Reports.aspx/DeleteReceipt",
                                    //Pass the selected record id
                                    data: "{'expID': '" + record_id + "'}",
                                    contentType: "application/json; charset=utf-8",
                                    dataType: "json",
                                    success: function () {
                                        alert("Receipt was deleted successfully");
                                        window.location = "Reports.aspx";

                                    }
                                });

                            },
                            function () { return false; }, "Delete");
                        });


                        $(".getDates").click(function () {
                            var record_id = $(this).attr("id");


                            $.ajax({
                                type: "POST",
                                url: "Reports.aspx/getDates",
                                //Pass the selected record id
                                data: "{'rptID': '" + record_id + "'}",
                                contentType: "application/json; charset=utf-8",
                                dataType: "json",
                                success: function (returnVal) {
                                    if (document.getElementById("test")) {
                                        var vChild = document.getElementById("test");
                                        document.getElementById("dialog").removeChild(vChild);
                                    }

                                    $("<div id='test'>" + returnVal.d + "</div>").appendTo("#dialog");
                                    $("#dialog").dialog("open");
                                }
                            });


                        });

                        $(".unlockGST").mousedown(function () {
                            $("#<%=txtGST.ClientID %>").prop('disabled', false);
                            $("#<%=hdnUnlockGST.ClientID %>").val('Yes');
                        });

                        $(".unlockQST").mousedown(function () {
                            $("#<%=txtQST.ClientID %>").prop('disabled', false);
                            $("#<%=hdnUnlockQST.ClientID %>").val('Yes');
                        });



                        $(".selected").click(function () {
                            alert('selected');

                        });



                        $("#<%=Fileupload2.ClientID %>").change(function () {

                            var ext = $("#<%=Fileupload2.ClientID %>").val().substr($("#<%=Fileupload2.ClientID %>").val().length - 3, 3);

                            if (ext != "txt" && ext != "pdf" && ext != "jpg" && ext != "bmp" && ext != "gif" && ext != "htm" && ext != "html") {
                                alert("File type not supported. Supported files include: pdf, jpg, bmp, gif, txt and html.");
                                $("#<%=cmdAttachFile.ClientID %>").attr('disabled', 'disabled');
                            } else
                                $("#<%=cmdAttachFile.ClientID %>").removeAttr('disabled');
                        });



                    });
        </script>
</asp:Content>


<asp:Content ID="Content2" runat="server" contentplaceholderid="head">

    <style type="text/css">
        .style9
        {
            font-family: Arial, Helvetica, sans-serif;
            font-size: x-large;
            font-weight: bold;
            color: #black;
        }
        .style10
        {
            font-size: medium;
        }
        .style11
        {
            width: 646px;
        }
        .style12
        {
            width: 188px;
        }
    </style>





















































































































































































































</asp:Content>



