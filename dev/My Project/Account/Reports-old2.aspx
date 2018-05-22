<%@ Page Language="vb" MasterPageFile="~/Site.Master"  AutoEventWireup="true" CodeBehind="Reports.aspx.vb" Inherits="WebApplication1.Reports" %>

<%@ Register assembly="System.Web.Entity, Version=3.5.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089" namespace="System.Web.UI.WebControls" tagprefix="asp" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="act" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server"  > 
        
        <link href="../css/tourist.css" rel="stylesheet" type="text/css" />
        
        <asp:ScriptManager id="ScriptManager1" runat="server" /> 

 	    <div id="msg" class="ui-widget">
		    <div class="ui-state-highlight ui-corner-all" style="margin-top: 20px; padding: 0 .7em;"> 
			    <p><span class="ui-icon ui-icon-info" style="float: left; margin-right: .3em;"></span>
                    <input id="txtMsg" type="text" style="width:300px;border:none;background-color:transparent;" /></p>
		    </div>
	    </div>               
                
        <% If Not IsNothing(Session("msg")) And Session("msg") <> "" Then%>
 	        <div id="msg2" class="ui-widget">
		        <div class="ui-state-highlight ui-corner-all" style="margin-top: 20px; padding: 0 .7em;"> 
			        <p><span class="ui-icon ui-icon-info" style="float: left; margin-right: .3em;"></span>
			          <asp:Label ID="lblMsg2" runat="server" ><%=Session("msg")%></asp:Label></p>
		        </div>
	        </div>
            <%Session("msg") = Nothing%>
        <% End If%>
        
        <% If Not IsNothing(Session("alert")) Then%>
 	        <div id="alert" class="ui-widget">
		        <div class="ui-state-error ui-corner-all" style="margin-top: 20px; padding: 0 .7em;"> 
			        <p><span class="ui-icon ui-icon-alert" style="float: left; margin-right: .3em;"></span>
			          <asp:Label ID="lblAlert" runat="server" ><%= Session("alert")%></asp:Label> </p>
		        </div>
	        </div>
        
            <%Session("alert") = Nothing%>
        <% End If%>

        <%=""%>

        <table width="100%" border=0>
        <tr>
            <td width="50px" style=" color:#cd1e1e; font-size:x-large ;"><asp:Label ID="lbl71" runat="server" Text="Reports"></asp:Label></td>
            <td class="style11" valign="middle">
                <asp:ImageButton ID="dummy" runat="server" visible="false" />
                
                <a id="btnNewReport" href="#" class="newRpt" title="New Report" ><img src="../images/new.png" /></a>
                &nbsp;&nbsp;&nbsp;<a id="btnSubmit" href="#" class="submitRpt"><img src="../images/submit.png" title="<%=hdnSubmitTooltip.value %>" /></a> 
                <!--<asp:ImageButton ID="cmdDelete" runat="server"  ImageUrl="../images/cmdDelete.png" Height="33px" Width="87px" Visible="False" CausesValidation="false" />-->
            </td>
            
            <td valign="bottom" ><asp:Label ID="lblFrom" runat="server" Text="From" CssClass="labelText"></asp:Label><br /><asp:TextBox ID="txtFrom" runat="server" Width="100px"></asp:TextBox></td>
            <td valign="bottom" ></td>
            <td valign="bottom" ><asp:Label ID="lblTo" runat="server" Text="To" CssClass="labelText"></asp:Label><br /><asp:TextBox ID="txtTo" runat="server" Width="100px"></asp:TextBox></td>
            <td align="left" valign="bottom" ></td>                                                                                                                                                
            <td align="left" valign="bottom" width="200px"><asp:ImageButton ID="cmdRefreshGrid" runat="server" ImageUrl="../images/refresh.png" ToolTip="Refresh Grid" Width="30px" /></td>
            

            <td>                
                <%If Request.QueryString("submitted") <> "1" Then%>
                    <span class="labelText"><asp:Label ID="lbl69" runat="server" Text="Reports for:" Visible="true" Font-Size="Small"  ></asp:Label></span>
                    <asp:DropDownList ID="cboDelegate" runat="server" AutoPostBack="True" DataSourceID="sqlDelegate" DataTextField="Name" AppendDataBoundItems="true" DataValueField="EMP_ID" Height="25px" Width="170px" Visible="true"  />
                        
                <%Else%>
                        <span class="labelText"><asp:Label ID="lbl73" runat="server" Text="Employee:" Visible="false" Font-Size="Small"  ></asp:Label></span>
                        <asp:DropDownList ID="cboEmp" runat="server" AutoPostBack="True" DataSourceID="sqlListOfEmployeesBySupervisor" DataTextField="Name" AppendDataBoundItems="true" DataValueField="EMP_ID" Height="25px" Width="170px" Visible="false"  >
                            <asp:ListItem Value="">All</asp:ListItem>
                        </asp:DropDownList>
                <% End If%>
            </td>
            
            <td width="50px">
                <span class="labelText" style="font-size:small;"><asp:Label ID="lbl70" runat="server" Text="Status:"></asp:Label></span>
                <asp:DropDownList ID="cboStatus" runat="server" AppendDataBoundItems="True" AutoPostBack="True" Height="25px">
                    <asp:ListItem Value="%">All</asp:ListItem>
                    <asp:ListItem Value="Open">Open</asp:ListItem>
                    <asp:ListItem Value="Pending Approval">Pending Approval</asp:ListItem>                    
                    <asp:ListItem Value="Approved">Approved</asp:ListItem>                                        
                    <asp:ListItem Value="Finalized">Finalized</asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
    </table>
 
    <div style="height:960px;">
        <asp:GridView ID="gridViewReports" runat="server"
            AutoGenerateColumns="False"
            GridLines="None"
            AllowPaging="true"
            CssClass="mGrid"
            PagerStyle-CssClass="pgr"
            AlternatingRowStyle-CssClass="alt" 
            SelectedRowStyle-CssClass="sel"
            AllowSorting="True" 
            CellPadding="4" 
            DataSourceID="sqlReportsByEmpID"  
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
            ViewStateMode="Enabled" Font-Size="Small" PagerStyle-Font-Size="large">

            <AlternatingRowStyle CssClass="alt"></AlternatingRowStyle>
            <Columns>
                <asp:CommandField ItemStyle-ForeColor="Black" ShowSelectButton="true" ButtonType="Image"  SelectImageUrl="../images/select.png" SelectText="<%=hdnSelectTooltip.value %>" ItemStyle-Width="3%" HeaderStyle-CssClass="SelectColumnHeader"/>                      
                
                <asp:TemplateField ItemStyle-Width="15px" ItemStyle-ForeColor="Black" >
                    <HeaderStyle CssClass="EditColumnHeader" />
                    <ItemTemplate><a href="#" id='<%# Eval("REPORT_ID") %>' class="editRpt" title="<%=hdnEditTooltip.value %>"> <%# IIf(Eval("STATUS_ID") = 1 Or (Eval("STATUS_ID") = 2 And Request.QueryString("submitted") = 1), "<img  border='0' src='../Images/edit.png' alt='Edit' />", "")%></a></ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField ItemStyle-Width="15px" ItemStyle-ForeColor="Black">
                    <HeaderStyle CssClass="ViewReportColumnHeader" />
                    <ItemTemplate>
                        <a href="#" id='<%# Eval("REPORT_ID") %>' class="printRpt" title="<%=hdnViewExpRptTooltip.value %>"> <img  border="0" src="../Images/viewreport.png" alt="View Expense Report" width="22px" height="22px" /></a>
                        <!--<a href="#" id='<%# Eval("REPORT_ID") %>' class="exportRpt" title="<%=hdnExpDataEntryTooltip.value %>"> <img  border="0" src="../Images/export.png" alt="Export Data Entry" width="22px" height="22px" /></a>-->
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField ItemStyle-Width="150px" ItemStyle-ForeColor="Black" HeaderText="73" SortExpression="EMP_NAME">
                    <ItemTemplate>
                        <%If Not IsNothing(Request.QueryString("submitted")) Then%>
                            <%# Eval("EMP_NAME") %>
                        <%End If%>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:BoundField  ItemStyle-ForeColor="black" DataField="REPORT_NAME" HeaderText="74" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left" />

                <asp:TemplateField ItemStyle-Width="150px" ItemStyle-ForeColor="Black" ItemStyle-HorizontalAlign="Center" HeaderText="Date">
                    <ItemTemplate >
                        <%# IIf(Eval("STATUS_ID") = 1, Eval("CREATED_DATE", "{0:dd/MM/yyyy}"), "")%>
                        <%# IIf(Eval("STATUS_ID") = 2, Eval("SUBMITTED_DATE", "{0:dd/MM/yyyy}"), "")%>
                        <%# IIf(Eval("STATUS_ID") = 3, Eval("APPROVED_DATE", "{0:dd/MM/yyyy}"), "")%>
                        <%# IIf(Eval("STATUS_ID") = 4, Eval("FINALIZED_DATE", "{0:dd/MM/yyyy}"), "")%>
                        
                        &nbsp;&nbsp;&nbsp;<a href='#' id='<%#Eval("REPORT_ID")%>' class='getDates' title='<%=hdnViewOtherDates.value%>' style="<%# iif(EVAL("STATUS_ID")=1,"display:none;","display:inline;") %>"><img  src='../images/calendar1.png' width='20px' height='20px' /></a>
                        
                    </ItemTemplate>
                </asp:TemplateField>
                
                <asp:TemplateField ItemStyle-Width="150px" ItemStyle-ForeColor="Black" ItemStyle-HorizontalAlign="Center" HeaderText="70">
                    <ItemTemplate >
                        <%If Session("emp").defaultlanguage = "English" Then%>
                            <%# Eval("STATUS_NAME")%>
                        <%else %>
                            <%# Eval("STATUS_NAME_FR")%>
                        <%end if %>
                    </ItemTemplate >
                </asp:TemplateField>

                <asp:TemplateField  ItemStyle-Width="15px">
                    <ItemTemplate>
                        <%If Request.QueryString("submitted") = 1 Then%>
                            <a href="#" id='<%# Eval("REPORT_ID")*3 %>' class="rejectRpt" title="<%=hdnReject.value %>"> <img  border="0" src="../Images/reject.png" alt="Reject" /></a>
                        <%End If%>
                    </ItemTemplate>
                </asp:TemplateField>         

                <asp:TemplateField  ItemStyle-Width="15px">
                    <ItemTemplate>
                        <a href="#" id='<%# Eval("REPORT_ID")*2 %>' class="approveRpt" title="<%=hdnApprove.value %>"> <img  border="0" src="../Images/approve.png" alt="Approve" /></a>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField ItemStyle-HorizontalAlign="Right"  ItemStyle-Width="15px">
                    <HeaderStyle CssClass="DeleteColumnHeader" />
                    <ItemTemplate><a href="#" id='<%# Eval("REPORT_ID")*4 %>' class="delReport" title="<%=hdnDeleteRptTitle.value %>"><%# IIf(Eval("STATUS_ID") = 1, "<img  border='0' src='../Images/del.png' alt='Delete' />", "")%> </a></ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField  ItemStyle-Width="15px">
                    <ItemTemplate>
                        <a href="#" id='<%# Eval("REPORT_ID") %>' class="finalizeRpt" title="<%=hdnFinalizeTitle.value %>"> <img  border="0" src="../Images/finalize.png" alt="Finalize" /></a>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField  ItemStyle-Width="15px" Visible="false">
                    <ItemTemplate>
                            <a href="#" id='<%# Eval("REPORT_ID") %>' class="reverseRpt" title="Reverse"> <img  border="0" src="../Images/reverse.png" alt="Reverse" /></a>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        
            <EditRowStyle Height="20px" />
            <EmptyDataRowStyle Height="20px" />
            <HeaderStyle ForeColor="White" Height="20px"></HeaderStyle>
            <RowStyle Height="20px" />
        </asp:GridView>

        <br />
    
        <table>
            <tr>
                <td style=" color:#cd1e1e; font-size:x-large ;"><asp:Label ID="lbl72" runat="server" Text="Expenses"></asp:Label></td>
                <td id="Cell-NewExp">&nbsp;&nbsp;<a id="cmdNewExp" href="#" class="newExp"><img src="../images/new.png"  title="<%=hdnAddExpTooltip.value %>" /></a></td>
                <td id="Cell-ReportTitle" style="color:#cd1e1e; font-weight:bold;"><asp:Label runat="server" ID="labelReportName"></asp:Label></td>
                <td></td>
            </tr>
        </table>
       
       <div style="overflow:auto;height:850px;width:100%;" >
            <asp:GridView ID="gridViewExpenses" runat="server" 
                CssClass="mGrid"
                PagerStyle-CssClass="pgr"
                AlternatingRowStyle-CssClass="alt" 
                SelectedRowStyle-CssClass="sel"
                AutoGenerateColumns="False" 
                BorderColor="#DEDFDE" 
                BorderStyle="None" 
                BorderWidth="1px" 
                CellPadding="4" 
                DataSourceID="sqlGetExpenses" 
                ForeColor="Black" 
                GridLines="None" 
                Width="99.5%" AllowSorting="True" 
                EmptyDataText="No expenses to display" 
                ShowHeader="true"
                ShowHeaderWhenEmpty="True" 
                DataKeyNames="EXPENSE_ID" Font-Size="Small">
        
                <Columns>
                    <asp:TemplateField  ItemStyle-Width="10px">
                        <ItemTemplate>
                            <a href="#" id='<%# Eval("EXPENSE_ID") %>' class="expandExp" title="<%=hdnExpand.value %>" ><img  border="0" src="../Images/plus.png" alt="<%=hdnExpand.value %>" style="<%# iif(EVAL("COMMENT")="" and EVAL("ATTENDEES")="" and isdbnull(EVAL("RECEIPT_DATE")),"display:none;","") %>" /></a>
                            <a href="#" id='<%# Eval("EXPENSE_ID")*2 %>' class="collapseExp" title="Collapse"> <img  border="0" src="../Images/minus.png" alt="Collapse" /></a>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField  ItemStyle-Width="15px">
                        <ItemTemplate>                            
                             <a href="#" id='<%# Eval("EXPENSE_ID")*3 %>' class="editExp" title="<%=hdnEditTooltip.value %>"> <img  border="0" src="../Images/edit.png" alt="Edit" /></a>                            
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField  ItemStyle-Width="15px">
                        <ItemTemplate>
                            <% If cboStatus.SelectedValue = "Open" Or (Not IsNothing(Request.QueryString("submitted")) And (cboStatus.SelectedValue = "Pending Approval" Or cboStatus.SelectedValue = "Approved")) Then%>
                                <%If Session("emp").defaultlanguage = "English" Then%>
                                    <a href="#" id='<%# EVAL("EXPENSE_ID") %>' class="<%# iif(isdbnull(EVAL("RECEIPT_TYPE")),"attachReceipt","viewReceipt")%>" title="<%# iif(isdbnull(EVAL("RECEIPT_TYPE")),"Attach Receipt","View Receipt")%>"> <img  border="0" src="../Images/<%# iif(isdbnull(EVAL("RECEIPT_TYPE")),"attachment1","attachment2")%>.png" alt="<%# iif(isdbnull(EVAL("RECEIPT_TYPE")),"Attach Receipt","View Receipt")%>" /></a>
                                <%Else%>
                                    <a href="#" id='<%# EVAL("EXPENSE_ID") %>' class="<%# iif(isdbnull(EVAL("RECEIPT_TYPE")),"attachReceipt","viewReceipt")%>" title="<%# iif(isdbnull(EVAL("RECEIPT_TYPE")),"Joindre un reçu","Voir reçu")%>"> <img  border="0" src="../Images/<%# iif(isdbnull(EVAL("RECEIPT_TYPE")),"attachment1","attachment2")%>.png" alt="<%# iif(isdbnull(EVAL("RECEIPT_TYPE")),"Joindre un reçu","Voir reçu")%>" /></a>
                       
                                <%end if %>
                            <%Else%>
                                                               
                                <a href="#" id='<%# iif(isdbnull(EVAL("RECEIPT_TYPE")),EVAL("EXPENSE_ID"),EVAL("EXPENSE_ID")) %>' class="<%# iif(isdbnull(EVAL("RECEIPT_TYPE")),"attachReceipt","viewReceipt")%>" title="<%# iif(isdbnull(EVAL("RECEIPT_TYPE")),"Attach Receipt","View Receipt")%>"> <img  border="0" src="../Images/<%# iif(isdbnull(EVAL("RECEIPT_TYPE")),"attachment1","attachment2")%>.png" alt="<%# iif(isdbnull(EVAL("RECEIPT_TYPE")),"Attach Receipt","View Receipt")%>" style="<%# iif(isdbnull(EVAL("RECEIPT_TYPE")),"display:none;","") %>"  /></a>

                            <%end if %>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:BoundField ItemStyle-Width="75px"  DataField="EXP_DATE"      HeaderText="59"  ItemStyle-ForeColor="Black" SortExpression="EXP_DATE"  DataFormatString="{0:dd'/'MM'/'yyyy}" ItemStyle-HorizontalAlign="Center" />
                    <asp:BoundField ItemStyle-Width="400px" DataField="CAT_NAME"      HeaderText="60"  ItemStyle-ForeColor="Black" HeaderStyle-HorizontalAlign="Left" />
                    <asp:BoundField ItemStyle-Width="100px" DataField="SUPPLIER_NAME" HeaderText="61"  ItemStyle-ForeColor="Black" ItemStyle-HorizontalAlign="Center" />            
                    <asp:BoundField ItemStyle-Width="50px"  DataField="WORK_ORDER"    HeaderText="CTW" ItemStyle-ForeColor="Black" ItemStyle-HorizontalAlign="Center" />
                    <asp:BoundField ItemStyle-Width="50px"  DataField="PROJECT"       HeaderText="CTP" ItemStyle-ForeColor="Black" ItemStyle-HorizontalAlign="Center" />
                    <asp:BoundField ItemStyle-Width="50px"  DataField="COST_CENTER"   HeaderText="CTC" ItemStyle-ForeColor="Black" ItemStyle-HorizontalAlign="Center" />
                    <asp:BoundField ItemStyle-Width="50px"  DataField="JUR_NAME"      HeaderText="62"  ItemStyle-ForeColor="Black" ItemStyle-HorizontalAlign="Center" />
                    
                    <asp:TemplateField HeaderText="63"  ItemStyle-Width="100px"  ItemStyle-ForeColor="black" ItemStyle-HorizontalAlign="Right">
                        <ItemTemplate><asp:Label ID="Label1" runat="server" Text='<%# iif(EVAL("GRATUITIES")=0,iif(EVAL("RATE")<1,formatnumber(EVAL("AMOUNT")/EVAL("RATE"),0) & " x " & formatnumber(EVAL("RATE"),2),""), formatnumber(EVAL("GRATUITIES"),2))  %>'></asp:Label></ItemTemplate>
                    </asp:TemplateField>

                    <asp:BoundField ItemStyle-Width="75px"  DataField="AMT_BEFORE_TAX" HeaderText="64" ItemStyle-ForeColor="Black" DataFormatString="{0:F}" ItemStyle-HorizontalAlign="Right" />
                    <asp:BoundField ItemStyle-Width="60px"  DataField="GST_PAID"       HeaderText="65" ItemStyle-ForeColor="Black" DataFormatString="{0:F}" ItemStyle-HorizontalAlign="Right" />
                    <asp:BoundField ItemStyle-Width="40px"  DataField="QST_PAID"       HeaderText="66" ItemStyle-ForeColor="Black" DataFormatString="{0:F}" ItemStyle-HorizontalAlign="Right" />
                    <asp:BoundField ItemStyle-Width="100px" DataField="AMOUNT"         HeaderText="67" ItemStyle-ForeColor="Black" DataFormatString="{0:F}" ItemStyle-HorizontalAlign="Right" />
                    <asp:BoundField ItemStyle-Width="15px"  DataField="CURR_SYM"       HeaderText="68" ItemStyle-ForeColor="Black" ItemStyle-HorizontalAlign="Center" />
            
                    <asp:TemplateField  ItemStyle-Width="15px">
                        <ItemTemplate><a href="#" id='<%# Eval("EXPENSE_ID") %>' class="delExpense" title="<%=hdnDeleteRptTitle.value %>"><img  border='0' src='../Images/del.png' alt='Delete' /></a></ItemTemplate>
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

        <asp:Panel ID="pnlAttachReceipt" runat="server" CssClass="modalPopup" style="display:none" Width="500px">
        <table style="width:100%; border-collapse:collapse;"><tr style=" border-bottom:medium solid #cd1e1e;"><td  style="color:#cd1e1e; font-size:1.5em; font-weight:bold;">Attach File</td><td align="right"><img src="../images/av.png" width="50px" height="40px"/></td></tr></table>
        <table width="100%" border=0>               
            <tr><td colspan="2">File:<asp:FileUpload ID="FileUpload2" runat="server" Width="100%" size="40" Height="25px" /></td></tr>
            <tr id="Row-FileError2" style="height:20px;"><td  colspan="2"><asp:Label ID="Label7" ForeColor="#cd1e1e" Font-Bold="true" runat="server" Text="Invalid file type, supported files include jpg, png, gif, pdf, htm/html"></asp:Label></td></tr>            
        </table>
        
        <table width="95%"><tr><td align="right"><br /><asp:Button ID="cmdAttachFile" runat="server" Text="Save" Height="30px" class="button1" CausesValidation="true" ValidationGroup="Attach" /><asp:Button ID="cmdCancelAttach" runat="server" Text="Cancel" class="cancelAttach" UseSubmitBehavior="false"  Height="30px" Width="80px" /></td></tr></table>
   
    </asp:Panel>

        <asp:Panel ID="pnlCreateReport" runat="server" CssClass="modalPopup" DefaultButton="cmdSaveReport" style="display:none" Width="350px">
        <div style="margin:10px">
                    
            <table width="60%">
                <tr style="height:50px;">
                    <td style="color:#cd1e1e; font-size:1.5em; "><asp:Label ID="lbl227" runat="server"></asp:Label></td>
                    <td align="right"><img src="../images/av.png" width="50px" height="40px"/></td>
                </tr>
                <tr style=" background-color:#cd1e1e;height:2px;"><td colspan="10"></td></tr>
                <tr style="height:20px;"><td></td></tr>
                <tr id="Row-WorkOrder"><td colspan="10"><asp:Label ID="Label2" runat="server" Text="Work Order/Project #:  " class="labelText" /><br /><asp:TextBox ID="txtWPNum" runat="server" Width="200px" /><asp:Label ID="Label3" runat="server" Text="(optional)" ForeColor="red"></asp:Label><br /><br /></td></tr>
                <tr><td colspan="10"><asp:Label ID="lbl74" runat="server" Text="Report Name:  " class="labelText" /><asp:TextBox ID="txtReportName" runat="server" Width="300px" MaxLength="30"></asp:TextBox><br /><asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtReportName" ErrorMessage="A report name is required" ValidationGroup="NewReport" /><asp:ValidationSummary ID="ValidationSummary1" ShowSummary="false" ShowMessageBox="true" runat="server" ValidationGroup="NewReport" />   <br /><br /></td></tr>
                <tr><td align="right" colspan="10">
                    <asp:Button ID="cmdSaveReport" runat="server" Text="140" class="button1" CausesValidation="true" ValidationGroup="NewReport" Height="30px" OnClientClick="closeForm('modalCreateReport')" />
                    <input id="Button2" type="button" value="<%= hdnCancelText.value %>" class="cancelRpt" style="height:30px;width:60px;" />
                </td></tr>
            </table>
        </div>
    </asp:Panel>
    
        <asp:Panel ID="pnlCreateExpense" runat="server" CssClass="modalPopup" DefaultButton="cmdSaveExpense" Width="600px" Height="560px" style="display:none;" >
        
        <div style="position:relative;left:15px;">
            <div style="height:475px;">
                <table style="width:95%;">
                    <tbody>
                        <tr id="Row-ExpID"><td><asp:TextBox ID="txtExpenseID" runat="server" Visible="true" Width="81px" Text="0" Height="0px" BorderStyle="None" /></td></tr>
                        <tr id="Row-TitleAddExp"><td colspan="10"><table width="100%"><tr><td style="color:#cd1e1e; font-size:larger; font-size:1.5em;"><asp:Label ID="lbl131" runat="server" Text="Label"></asp:Label>&nbsp;<%=labelReportName.Text%></td><td align="right"><img src="../images/av.png" width="50px" height="40px"/></td></tr></table></td></tr>
                        <tr id="Row-TitleEditExp"><td colspan="10" ><table width="100%"><tr><td style="color:#cd1e1e; font-size:larger; font-size:1.5em;"><asp:Label ID="lbl109" runat="server" Text="Label"></asp:Label>&nbsp;<%=labelReportName.Text%></td><td align="right"><img src="../images/av.png" width="50px" height="40px"/></td></tr></table></td></tr>
                        <tr><td colspan="10" style=" background-image:url(../images/redline.png); background-repeat:repeat-x;"></td></tr>
                    </tbody>
                </table>
                <div class="leftColumn">
                    <table width="95%" border=0>
                        
                        <tr id="Row-JurMsg">
                            <td colspan="3">
                 	            <div class="ui-widget">
		                            <div class="ui-state-highlight ui-corner-all" style="margin-top: 0px; padding: 0em;height:25px;"> 
			                            <p><span class="ui-icon ui-icon-info" style="float: left; margin-right: .3em;"></span>
			                                <asp:Label ID="lblJurMsg" runat="server" Text="" ></asp:Label></p>
		                            </div>
                                </div>
                            </td>
                        </tr>                
                            <tr id="Row-ExpMsg">
                                <td colspan="3">
 	                                <div class="ui-widget">
		                                <div id="ExpMsg" class="ui-state-highlight ui-corner-all" style="margin-top: 0px; padding: 0em;height:50px;"> 
			                                <p><span class="ui-icon ui-icon-info" style="float: left; margin-right: .3em;"></span>
			                                  <asp:Label ID="lblExpMsg" runat="server" Text="" ></asp:Label></p>
		                                </div>
                                    </div>
                                </td>
                            </tr>
                            <tr><td style="height:10px;"></td></tr>                    
                            <tr  height="30px">
                                <td width="20%" align="left"><asp:Label ID="lbl37" runat="server" Text="Expense Type:" class="labelText" /></td>
                                <td width="50%">
                                    <asp:DropDownList ID="cboCat" class="cboCat" runat="server" DataSourceID="sqlGetActiveOrgCategories" DataTextField="CAT_NAME" DataValueField="ORG_CAT_ID" Height="25px" Width="95%" />                                                        
                                    <br /><asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="cboCat" ErrorMessage="" Text="* An expense type is required" ValidationGroup="NewExpense" Display="Dynamic"  />
                                </td>
                            </tr>

                            <tr  height="30px">
                                <td align="left"><asp:Label ID="lbl38" runat="server" Text="Expense Date:" class="labelText" /></td>
                                <td align="left">
                                    <asp:TextBox ID="txtExpDate" runat="server" Width="100px" readonly="true"></asp:TextBox>                            
                                </td>
                            </tr>
    
                            <tr id="Row-TaxRate"  height="30px">
                                <td align="left"><asp:Label ID="lbl39" runat="server" Text="Is your expense subject to:" class="labelText" /></td>
                                <td><asp:DropDownList ID="cboTaxRate" runat="server"  Height="25px" DataSourceID="sqlGetAirTaxRates" DataTextField="TR_DESCRIPTION" DataValueField="JUR_ID" /></td>
                            </tr>

                            <tr id="Row-Rate"  height="30px">
                                <td align="left"><asp:Label ID="lbl40" runat="server" Text="Rate:" class="labelText" /></td>
                                <td>
                                    <%-- <asp:TextBox ID="txtRate" runat="server" class="numberinput"></asp:TextBox> --%>
                                    <asp:DropDownList ID="cboRate" runat="server"  Height="25px"><asp:ListItem></asp:ListItem></asp:DropDownList>
                                </td>
                            </tr>

                            <tr id="Row-KM"  height="30px">
                                <td align="left"><asp:Label ID="lbl41" runat="server" Text="# of KM:" class="labelText" /></td>
                                <td><asp:TextBox ID="txtKM" runat="server" class="numberinput-nodecimal"></asp:TextBox>
                                    <asp:Label ID="lbl509" runat="server" Text=""  ForeColor="Red"/>
                                </td>
                            </tr>

                            <tr id="Row-Project"  height="30px"  <%=iif(session("emp").organization.parent.displayproject,"","style='display:none;'") %>>
                                <td align="left" width="157px"><asp:Label ID="CTP" runat="server" Text="Project" class="labelText" /> </td>
                                <td align="left"><asp:DropDownList ID="cboProject" runat="server" Width="300px" DataSourceID="sqlGetActiveProjects" DataTextField="PWC_NUMBER_DESC" DataValueField="PWC_NUMBER"/></td>
                            </tr>               
                    
                            <tr height="30px" <%=iif(session("emp").organization.parent.displayworkorder,"","style='display:none;'") %>>
                                <td align="left"  width="157px"><asp:Label ID="CTW" runat="server" Text="Work Order" class="labelText" /> </td>
                                <td><asp:DropDownList ID="cboWO" runat="server" Width="300px" DataSourceID="sqlGetActiveWO" DataTextField="PWC_NUMBER_DESC" DataValueField="PWC_NUMBER"/></td>
                            </tr>
                    

                            <tr id="Row-CostCenter" height="30px" <%=iif(session("emp").organization.parent.displaycostcenter,"","style='display:none;'") %>>
                                <td align="left"  width="157px"><asp:Label ID="CTC" runat="server" Text="Cost Center" class="labelText" /> </td>
                                <td><asp:DropDownList ID="cboCC" runat="server" Width="300px" DataSourceID="sqlGetActiveCC" DataTextField="PWC_NUMBER_DESC" DataValueField="PWC_NUMBER"/></td>
                            </tr>

                            <tr id="Row-Supplier" height="30px">
                                <td align="left"><asp:Label ID="lbl42" runat="server" Text="Supplier Name:" class="labelText" /></td>
                                <td><asp:TextBox ID="txtSupplier" runat="server" Width="287px" Height="20px"></asp:TextBox></td>
                            </tr>
                
                            <tr id="Row-Jur" height="30px">
                                <td align="left"><asp:Label ID="lbl43" runat="server" Text="Jurisdiction:" class="labelText" /></td>
                                <td><asp:DropDownList ID="cboJur" runat="server" DataSourceID="sqlGetJurisdictions" DataTextField="JUR_NAME" DataValueField="JUR_ID" Height="25px" Width="214px" /></td>
                            </tr>
                
                            <tr id="Row-TaxStatus" height="30px">
                                <td align="left"><asp:Label ID="lbl44" runat="server" Text="Tax Status:" class="labelText" /></td>
                                <td>
                                    <asp:DropDownList ID="cboTaxStatus" runat="server">
                                        <asp:ListItem Text="Taxable" Value="Taxable"></asp:ListItem>
                                        <asp:ListItem Text="Non-Taxable" Value="Non-Taxable"></asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                            </tr>
                
                            <tr id="Row-Amt" height="10px">
                                <td align="left"><asp:Label ID="lbl45" runat="server" Text="Amount:" class="labelText" /></td>
                                <td>
                                    <asp:TextBox ID="txtAmt" runat="server" Width="65px"  Height="20px" class="numberinput" MaxLength="8"></asp:TextBox>
                                    <asp:DropDownList ID="cboTaxIE" runat="server" Height="25px">
                                        <asp:ListItem Value="1">Tax Included</asp:ListItem>
                                        <asp:ListItem Value="2">Before Tax</asp:ListItem>
                                    </asp:DropDownList>
                            
                                    <asp:DropDownList ID="cboCurr" runat="server" DataSourceID="sqlGetCurrencies" 
                                        DataTextField="CURRENCY" DataValueField="CURR_ID" Height="25px"
                                        style="margin-left: 0px" Width="209px">
                                    </asp:DropDownList>
                                    <br />
                                    <asp:RequiredFieldValidator ID="AmtRequired" runat="server" ControlToValidate="txtAmt" ErrorMessage="* An amount is required"  ValidationGroup="NewExpense"  Display="Dynamic" />
                                </td>
                            </tr>

                            <tr id="Row-Grat" height="30px">
                                <td align="left"><asp:Label ID="lbl46" runat="server" Text="Tip:" class="labelText" /></td>
                                <td valign="middle"><asp:TextBox ID="txtGrat" runat="server" class="numberinput" />&nbsp;&nbsp;<a id="24" href="#" class="popUpWin"><img src="../images/question.png" width="18px" height="18px" /></a></td>
                            </tr>

                            <tr id="Row-DontReimburse">
                                <td align="left" valign="middle"></td>
                                <td class="labelText"><asp:CheckBox ID="chkDontReimburse" runat="server" /><asp:Label ID="lbl51" runat="server" Text="Do not reimburse"></asp:Label> <a id="23" href="#" class="popUpWin"><img src="../images/question.png" width="17px" height="17px" /></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:DropDownList ID="cboTP" DataSourceID="sqlGetActiveTP" DataTextField="ACCOUNT" DataValueField="VENDOR_NUMBER" Width="200px"  runat="server" />
                                </td>
                            </tr>

                            <tr id="Row-Attendees" height="30px">
                                <td align="left" valign="top" ><asp:Label ID="lbl369" runat="server" Text="Attendees:" class="labelText" /></td>
                                <td><asp:TextBox ID="txtAttendees" runat="server" Height="25px" Width="95%" TextMode="MultiLine"  Font-Names="Arial"></asp:TextBox></td>
                            </tr>

                            <tr height="30px">
                                <td align="left" valign="top" ><asp:Label ID="lbl48" runat="server" Text="Comment:" class="labelText" /></td>
                                <td><asp:TextBox ID="txtComment" runat="server" Height="25px" Width="95%" TextMode="MultiLine" Font-Names="Arial" ></asp:TextBox></td>
                            </tr>
                            <tr><td></td></tr>

                            <tr>
                                <td align="left" valign="middle"><asp:Label ID="lbl49" runat="server" Text="Attach Receipt:" class="labelText" /></td>
                        
                                <td valign="middle">
                                    <asp:FileUpload ID="FileUpload1" runat="server" Width="300px" Height="23px" /><asp:Label ID="lblSelectedReceipt" runat="server" CssClass="labelText"></asp:Label>
                                    <table><tr id="Row-FileError1"><td><asp:Label ID="Label6" ForeColor="#cd1e1e" Font-Bold="true" runat="server" Text="Invalid file type, supported files include jpg, png, gif, pdf, htm/html"></asp:Label></td></tr></table>                        
                                    <table><tr><td id="Cell-RemoveAttachment"><a href="#" class="delReceipt">Delete Receipt</a></td></tr></table>                        
                                </td>
                            </tr>
                            <tr id="Row-GST"><td align="left" valign="middle"><asp:Label ID="lbl50" runat="server" Text="GST/HST paid:" class="labelText" /></td><td><asp:TextBox ID="txtGST" runat="server" Width="75px" BorderStyle="Solid" BorderWidth="1px" Enabled="false"  class="numberinput" style=" text-align:right;"></asp:TextBox><asp:Label ID="lblGST" runat="server" Text="" ForeColor="Red" Font-Bold="true"></asp:Label>&nbsp;&nbsp;&nbsp;<a href="#"><img id="imgUnlockGST" src="../images/lock.png" title="Unlock Field" class="unlockGST" width="12px" height="16px" /></a>&nbsp;&nbsp;<a id="367" href="#" class="popUpWin"><img src="../images/question.png" width="17px" height="17px" style="visibility:hidden;" /></a></td></tr>
                            <tr id="Row-HST"><td align="left"><asp:Label ID="lblHSTpaid" runat="server" Text="HST paid:" class="labelText" /></td><td><asp:TextBox ID="txtHST" runat="server" Width="75px" BorderStyle="Solid" BorderWidth="1px" Enabled="true"  class="numberinput" style=" text-align:right;"></asp:TextBox><asp:Label ID="lblHST" runat="server" Text=""></asp:Label></td></tr>
                            <tr id="Row-QST"><td align="left" valign="middle"><asp:Label ID="lbl66" runat="server" Text="QST paid:" class="labelText" /></td><td><asp:TextBox ID="txtQST" runat="server" Width="75px" BorderStyle="Solid" BorderWidth="1px" Enabled="false" ForeColor="Black"  class="numberinput" style=" text-align:right;"></asp:TextBox><asp:Label ID="lblQST" runat="server" Text=""></asp:Label>&nbsp;&nbsp;&nbsp;<a href="#"><img id="imgUnlockQST" src="../images/lock.png" title="Unlock Field" class="unlockQST"  width="12px" height="16px"/></a>&nbsp;&nbsp;<a id="367" href="#" class="popUpWin" style="display:none;"><img src="../images/question.png" width="17px" height="17px" /></a></td></tr>
                            <tr id="Row-Total" ><td align="left" valign="middle" style="  font-size:larger ; color:Green;"><asp:Label ID="lbl67" runat="server" Text="Total paid:" class="labelText" /></td><td><asp:TextBox  ID="txtTotal" runat="server" Width="75px" BorderStyle="Solid" BorderWidth="1px" Enabled="false" ForeColor="Green" style=" text-align:right;" /><div id="exceedMsg" style="position:relative;top:-23px;left:85px;background-color:#cd1e1e;color:White;width:225px;border-radius:3px;text-align:center;"><asp:Label ID="lbl446" runat="server" Text="Total amount exceeds allowed limit"></asp:Label></div></td></tr>
                        </table>                
                </div>
                <div class="rightColumn" style="display: none;">
                    <img id="uploadedReceipt" src="#" alt="uploadedReceipt" style="display: none; max-width: 230px; margin-top: 10px;"/>
                </div>
                <div class="clearFloat"></div>
             </div>
            

             <div style="position:relative;left:130px;top:-20px;width:70%">
                <table width="100%">
                    <tr>
                        <td>&nbsp;</td>
                        <td align="right" >                            
                            <asp:Button ID="cmdSaveExpense" runat="server" Text="140" height="30px" tooltip="Save and close" width="60px" CausesValidation="true" ValidationGroup="NewExpense" CssClass="button2" OnClientClick="closeForm('modalCreateExpense')" />
                            <asp:Button ID="cmdSaveExpense2" runat="server" Text="141"  height="30px" ToolTip="Save and add another expense"  width="60px"  CausesValidation="true" ValidationGroup="NewExpense"  CssClass="button2"  OnClientClick="closeForm('modalCreateExpense')"  />
                            <asp:Button ID="cmdCancel" class="cancelExp" runat="server" Text="142"  height="30px" UseSubmitBehavior="false" width="80px" />
                        </td>
                    </tr>
                </table>
            </div>
        </div> 
        
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
    <asp:HiddenField id="hdnReject" runat="server" />
    <asp:HiddenField id="hdnViewOtherDates" runat="server" />
    <asp:HiddenField id="hdnApprove" runat="server" />
    <asp:HiddenField id="hdnViewExpRptTooltip" runat="server" />
    <asp:HiddenField id="hdnExpDataEntryTooltip" runat="server" />
    <asp:HiddenField id="hdnUnlockGST" runat="server" Value="No" />
    <asp:HiddenField id="hdnUnlockQST" runat="server" Value="No" />
    <asp:HiddenField id="hdnFinalizeMessage" runat="server" />
    <asp:HiddenField id="hdnFinalizeTitle" runat="server" />
    <asp:HiddenField id="hdnCancelText" runat="server" />
    <asp:HiddenField id="hdnSaveText" runat="server" />
    <asp:HiddenField ID="hdnGST" runat="server" />
    <asp:HiddenField ID="hdnQST" runat="server" />
    <asp:HiddenField ID="hdnReportIDEdit" runat="server" />
    <asp:HiddenField ID="hdnCatID" runat="server" Value="0"  />
    <asp:HiddenField ID="hdnPUK" runat="server" Value="0"  />
    <asp:HiddenField ID="hdnLoggedInEmpID" runat="server" Value="0"  />
    <asp:HiddenField ID="hdnExpDate" runat="server" Value="0"  />
    <asp:HiddenField ID="hdnLimit" runat="server" Value="0"  />
    <asp:HiddenField ID="hdnFrom" runat="server" Value="01/07/2010"  />
    <asp:HiddenField ID="hdnTo" runat="server" />
    <asp:HiddenField id="hdnExpDeletedMsg" runat="server" />
    <asp:HiddenField id="hdnRptDeletedMsg" runat="server" />
    <asp:HiddenField id="hdnKMExceeds" runat="server" />
    <asp:HiddenField id="hdnCurrOutsideJur" runat="server" />
    <asp:HiddenField id="hdnInsuranceMsg" runat="server" />
    <asp:HiddenField id="hdnPersonalUseMsg" runat="server" />
    <asp:HiddenField id="hdnApproveRpt" runat="server" />
    <asp:HiddenField id="hdnRejectRpt" runat="server" />
    <asp:HiddenField id="hdnReason" runat="server" />
    <asp:HiddenField id="hdnClose" runat="server" />
    <asp:HiddenField ID="hdnSelectedReceipt" Value="0" runat="server" />
    <asp:HiddenField ID="hdnDeleteReceipt" Value="0" runat="server" />
    <asp:HiddenField ID="hdnTaxesExceedTotal" Value="0" runat="server" />
    <asp:HiddenField ID="hdnExpand" Value="0" runat="server" />


<!-----------------------------------------------MODAL POPUP EXTENDERS----------------------------------------------------------->
            <act:ModalPopupExtender ID="modalProcessing" runat="server"
                TargetControlID="cmddummy"
                PopupControlID="pnlProcessing"
                PopupDragHandleControlID="pnlProcessing"
                DropShadow="false"
                BackgroundCssClass="modalBackground"
                BehaviorID="modalProcessing" />

            <act:ModalPopupExtender ID="modalCreateReport" runat="server"
                TargetControlID="cmddummy"
                PopupControlID="pnlCreateReport"
                drag="false"
                DropShadow="false"
                BackgroundCssClass="modalBackground"
                BehaviorID="modalCreateReport" />
    
            <act:ModalPopupExtender ID="modalCreateExpense" runat="server"
                TargetControlID="cmdDummy"
                PopupControlID="pnlCreateExpense"
                drag="false" 
                DropShadow="false" 
                BackgroundCssClass="modalBackground" 
                BehaviorID="modalCreateExpense" RepositionMode="None" />
    
            <act:ModalPopupExtender ID="modalAttachReceipt" runat="server"
                TargetControlID="cmdDummy"
                PopupControlID="pnlAttachReceipt"
                drag="false"
                DropShadow="false"
                BackgroundCssClass="modalBackground" 
                BehaviorID="modalAttachReceipt" />

<!-----------------------------------------------DATA SOURCES------------------------------------------------------------------->
            
            <asp:SqlDataSource ID="sqlGetActiveProjects" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:dbadvaloremConnStr %>" 
                    SelectCommand="GetPWCByOrg" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="hdnOrgID" Name="OrgID" PropertyName="Value" Type="Int32" />
                    </SelectParameters>

                    <SelectParameters>
                        <asp:Parameter Name="pwcType" DefaultValue="P" />
                    </SelectParameters>

                    <SelectParameters>
                        <asp:Parameter Name="IncludeNonActive" DefaultValue="0" Type="Byte" />
                    </SelectParameters>
                </asp:SqlDataSource>

            <asp:SqlDataSource ID="sqlGetActiveTP" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:dbadvaloremConnStr %>" 
                    SelectCommand="GetAccounts" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="hdnOrgID" Name="OrgID" PropertyName="Value" Type="Int32" />
                        <asp:Parameter Name="Type" DefaultValue="TPA"  />
                        <asp:Parameter Name="Active" DefaultValue="1" Type="Byte" />
                    </SelectParameters>
                    
                </asp:SqlDataSource>

            <asp:SqlDataSource ID="sqlGetActiveWO" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:dbadvaloremConnStr %>" 
                    SelectCommand="GetPWCByOrg" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="hdnOrgID" Name="OrgID" PropertyName="Value" Type="Int32" />
                    </SelectParameters>

                    <SelectParameters>
                        <asp:Parameter Name="pwcType" DefaultValue="W" />
                    </SelectParameters>

                    <SelectParameters>
                        <asp:Parameter Name="IncludeNonActive" DefaultValue="0" Type="Byte" />
                    </SelectParameters>
                </asp:SqlDataSource>

            <asp:SqlDataSource ID="sqlGetActiveCC" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:dbadvaloremConnStr %>" 
                    SelectCommand="GetPWCByOrg" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="hdnOrgID" Name="OrgID" PropertyName="Value" Type="Int32" />
                    </SelectParameters>

                    <SelectParameters>
                        <asp:Parameter Name="pwcType" DefaultValue="C" />
                    </SelectParameters>

                    <SelectParameters>
                        <asp:Parameter Name="IncludeNonActive" DefaultValue="0" Type="Byte" />
                    </SelectParameters>
                </asp:SqlDataSource>
            
            <asp:SqlDataSource ID="sqlReportsByEmpID" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:dbadvaloremConnStr %>" 
                    SelectCommand="GetReportsByEmpID" SelectCommandType="StoredProcedure"
                    FilterExpression="STATUS_NAME like '{0}%'">
             
                 <SelectParameters><asp:ControlParameter ControlID="cboDelegate" DefaultValue="0" Name="EmpID" PropertyName="SelectedValue" Type="Int32" /></SelectParameters>         
                 <FilterParameters><asp:ControlParameter Name="STATUS_NAME" ControlID="cboStatus" PropertyName="SelectedValue" /></FilterParameters>
            </asp:SqlDataSource>

            <asp:SqlDataSource ID="sqlFinalizedWithDates" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:dbadvaloremConnStr %>" 
                    SelectCommand="GetReportsByEmpID" SelectCommandType="StoredProcedure"
                    FilterExpression="STATUS_NAME like '{0}%' AND FINALIZED_DATE>='{1}' AND FINALIZED_DATE <='{2}'">
             
                 <SelectParameters><asp:ControlParameter ControlID="cboDelegate" DefaultValue="0" Name="EmpID" PropertyName="SelectedValue" Type="Int32" /></SelectParameters>         
                 <FilterParameters><asp:ControlParameter Name="STATUS_NAME" ControlID="cboStatus" PropertyName="SelectedValue" /></FilterParameters>
                 <FilterParameters><asp:ControlParameter Name="FINALIZED_DATE" ControlID="hdnFrom" PropertyName="Value" /></FilterParameters>
                 <FilterParameters><asp:ControlParameter Name="FINALIZED_DATE" ControlID="hdnTo" PropertyName="Value" /></FilterParameters>
            </asp:SqlDataSource>

            <asp:SqlDataSource ID="sqlReportsBySuperIDWithDates" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:dbadvaloremConnStr %>" 
                    SelectCommand="GetReportsBySuperID" SelectCommandType="StoredProcedure"
                    FilterExpression="STATUS_NAME like '{0}%' AND FINALIZED_DATE>='{1}' AND FINALIZED_DATE <='{2}'">
             
                <SelectParameters><asp:ControlParameter ControlID="txtSuperID" DefaultValue="0" Name="SuperID" PropertyName="Text" Type="Int32" /></SelectParameters>
                <FilterParameters><asp:ControlParameter Name="STATUS_NAME" ControlID="cboStatus" PropertyName="SelectedValue" /></FilterParameters>
                <FilterParameters><asp:ControlParameter Name="FINALIZED_DATE" ControlID="hdnFrom" PropertyName="Value" /></FilterParameters>
                <FilterParameters><asp:ControlParameter Name="FINALIZED_DATE" ControlID="hdnTo" PropertyName="Value" /></FilterParameters>
            </asp:SqlDataSource>
                
            <asp:SqlDataSource ID="sqlReportsBySuperID" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:dbadvaloremConnStr %>" 
                    SelectCommand="GetReportsBySuperID" SelectCommandType="StoredProcedure"
                    FilterExpression="STATUS_NAME like '{0}%'">
             
                <SelectParameters><asp:ControlParameter ControlID="txtSuperID" DefaultValue="0" Name="SuperID" PropertyName="Text" Type="Int32" /></SelectParameters>
                <FilterParameters><asp:ControlParameter Name="STATUS_NAME" ControlID="cboStatus" PropertyName="SelectedValue" /></FilterParameters>                
            </asp:SqlDataSource>

            <asp:SqlDataSource ID="sqlReportsByFinalizerID" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:dbadvaloremConnStr %>" 
                    SelectCommand="GetReportsByFinalizerID" SelectCommandType="StoredProcedure"
                    FilterExpression="STATUS_NAME like '{0}%'">
             
                <SelectParameters><asp:ControlParameter ControlID="txtSuperID" DefaultValue="0" Name="FinalizerID" PropertyName="Text" Type="Int32" /></SelectParameters>
                <FilterParameters><asp:ControlParameter Name="STATUS_NAME" ControlID="cboStatus" PropertyName="SelectedValue" /></FilterParameters>
            </asp:SqlDataSource>

            <asp:SqlDataSource ID="sqlReportsByFinalizerIDWithDates" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:dbadvaloremConnStr %>" 
                    SelectCommand="GetReportsByFinalizerID" SelectCommandType="StoredProcedure"
                    FilterExpression="STATUS_NAME like '{0}%' AND FINALIZED_DATE>='{1}' AND FINALIZED_DATE <='{2}'">
             
                <SelectParameters><asp:ControlParameter ControlID="txtSuperID" DefaultValue="0" Name="FinalizerID" PropertyName="Text" Type="Int32" /></SelectParameters>
                <FilterParameters><asp:ControlParameter Name="STATUS_NAME" ControlID="cboStatus" PropertyName="SelectedValue" /></FilterParameters>
                <FilterParameters><asp:ControlParameter Name="FINALIZED_DATE" ControlID="hdnFrom" PropertyName="Value" /></FilterParameters>
                <FilterParameters><asp:ControlParameter Name="FINALIZED_DATE" ControlID="hdnTo" PropertyName="Value" /></FilterParameters>
            </asp:SqlDataSource>

            <asp:SqlDataSource ID="sqlReportsByFinalizerIDandEmpIDWithDates" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:dbadvaloremConnStr %>" 
                    SelectCommand="GetReportsByFinalizerID" SelectCommandType="StoredProcedure"
                    FilterExpression="STATUS_NAME like'{0}%' AND EMP_ID = {1} AND FINALIZED_DATE>='{2}' AND FINALIZED_DATE <='{3}'">
             
                 <SelectParameters><asp:ControlParameter ControlID="txtSuperID" DefaultValue="0" Name="FinalizerID" PropertyName="Text" Type="Int32" /></SelectParameters>
                 <FilterParameters><asp:ControlParameter Name="STATUS_NAME" ControlID="cboStatus" PropertyName="SelectedValue" /></FilterParameters>
                 <FilterParameters><asp:ControlParameter Name="EMP_ID" ControlID="cboEmp" PropertyName="SelectedValue" /></FilterParameters>
                 <FilterParameters><asp:ControlParameter Name="FINALIZED_DATE" ControlID="hdnFrom" PropertyName="Value" /></FilterParameters>
                 <FilterParameters><asp:ControlParameter Name="FINALIZED_DATE" ControlID="hdnTo" PropertyName="Value" /></FilterParameters>
            </asp:SqlDataSource>

            <asp:SqlDataSource ID="sqlReportsBySuperIDandEmpID" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:dbadvaloremConnStr %>" 
                    SelectCommand="GetReportsBySuperID" SelectCommandType="StoredProcedure"
                    FilterExpression="STATUS_NAME like'{0}%' AND EMP_ID = {1}">
             
                 <SelectParameters><asp:ControlParameter ControlID="txtSuperID" DefaultValue="0" Name="SuperID" PropertyName="Text" Type="Int32" /></SelectParameters>
                 <FilterParameters><asp:ControlParameter Name="STATUS_NAME" ControlID="cboStatus" PropertyName="SelectedValue" /></FilterParameters>
                 <FilterParameters><asp:ControlParameter Name="EMP_ID" ControlID="cboEmp" PropertyName="SelectedValue" /></FilterParameters>
            </asp:SqlDataSource>

            <asp:SqlDataSource ID="sqlReportsBySuperIDandEmpIDWithDates" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:dbadvaloremConnStr %>" 
                    SelectCommand="GetReportsBySuperID" SelectCommandType="StoredProcedure"
                    FilterExpression="STATUS_NAME like'{0}%' AND EMP_ID = {1} AND FINALIZED_DATE>='{2}' AND FINALIZED_DATE <='{3}'">
             
                 <SelectParameters><asp:ControlParameter ControlID="txtSuperID" DefaultValue="0" Name="SuperID" PropertyName="Text" Type="Int32" /></SelectParameters>
                 <FilterParameters><asp:ControlParameter Name="STATUS_NAME" ControlID="cboStatus" PropertyName="SelectedValue" /></FilterParameters>
                 <FilterParameters><asp:ControlParameter Name="EMP_ID" ControlID="cboEmp" PropertyName="SelectedValue" /></FilterParameters>
                 <FilterParameters><asp:ControlParameter Name="FINALIZED_DATE" ControlID="hdnFrom" PropertyName="Value" /></FilterParameters>
                 <FilterParameters><asp:ControlParameter Name="FINALIZED_DATE" ControlID="hdnTo" PropertyName="Value" /></FilterParameters>
            </asp:SqlDataSource>

            <asp:SqlDataSource ID="sqlListOfEmployeesBySupervisor" runat="server" 
                ConnectionString="<%$ ConnectionStrings:dbadvaloremConnStr %>" 
                SelectCommand="GetEmployeesBySupervisorOrFinalizer" SelectCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:ControlParameter ControlID="txtSuperID" Name="SupervisorID" PropertyName="Text" Type="Decimal" />
                </SelectParameters>
            </asp:SqlDataSource>

            <asp:SqlDataSource ID="sqlListOfEmployeesByFinalizer" runat="server" 
                ConnectionString="<%$ ConnectionStrings:dbadvaloremConnStr %>" 
                SelectCommand="GetEmployeesBySupervisorOrFinalizer" SelectCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:ControlParameter ControlID="txtSuperID" Name="FinalizerID" PropertyName="Text" Type="Decimal" />
                </SelectParameters>
            </asp:SqlDataSource>
     
            <asp:SqlDataSource ID="sqlDelegate" runat="server" 
                ConnectionString="<%$ ConnectionStrings:dbadvaloremConnStr %>" 
                SelectCommand="GetEmployeesByDelegate" SelectCommandType="StoredProcedure">
                 <SelectParameters>
                     <asp:ControlParameter ControlID="txtEmpID" DefaultValue="0" Name="employeeID" PropertyName="Text" Type="Int32" />
                 </SelectParameters>
            </asp:SqlDataSource>

            <asp:SqlDataSource ID="sqlGetExpenses" runat="server" 
                ConnectionString="<%$ ConnectionStrings:dbadvaloremConnStr %>" 
                SelectCommand="GetExpenses2"
                 SelectCommandType="StoredProcedure">

                <SelectParameters>
                    <asp:ControlParameter ControlID="gridViewReports" Name="ReportID" 
                        PropertyName="SelectedValue" Type="Decimal" />
                </SelectParameters>

                <SelectParameters>
                     <asp:SessionParameter SessionField="language" Name="language" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>

            <asp:SqlDataSource ID="sqlGetCurrencies" runat="server" 
                ConnectionString="<%$ ConnectionStrings:dbadvaloremConnStr %>" 
                SelectCommand="GetCurrencies" SelectCommandType="StoredProcedure">
            </asp:SqlDataSource>
             
            <asp:SqlDataSource ID="sqlGetActiveOrgCategories" runat="server" 
                ConnectionString="<%$ ConnectionStrings:dbadvaloremConnStr %>" 
                SelectCommand="GetActiveOrgCategories" SelectCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:ControlParameter ControlID="hdnOrgID" DefaultValue="0" Name="OrgID" PropertyName="Value" Type="Int32" />
					<%--<asp:SessionParameter SessionField="language" Name="language" Type="String" />--%>
                </SelectParameters>
            </asp:SqlDataSource>
        
            <asp:SqlDataSource ID="sqlGetJurisdictions" runat="server" 
                ConnectionString="<%$ ConnectionStrings:dbadvaloremConnStr %>" 
                SelectCommand="GetJurisdictions" SelectCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:SessionParameter SessionField="language" Name="language" Type="String" />
                </SelectParameters>
            
            </asp:SqlDataSource>

            <asp:SqlDataSource ID="sqlGetAirTaxRates" runat="server" 
                ConnectionString="<%$ ConnectionStrings:dbadvaloremConnStr %>" 
                SelectCommand="GetAirTaxRates" SelectCommandType="StoredProcedure">
                
                <SelectParameters>
                    <asp:SessionParameter SessionField="language" Name="language" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>
        
<!----------------------------------------------------------------------------------------------------------------------------->
    
    <div id="dialog" title="Dates"></div>
            
    <table><tr id="dummytable"><td><asp:Button ID="cmdDummy" runat="server" Text="Button"  /></td></tr></table>
                <script type="text/javascript">
                    
                    function hideExportPopup() {
                        var mpe = $find('modalExport');
                        mpe.hide();
                    }
                                       

                    function myConfirm(dialogText, okFunc, cancelFunc, dialogTitle) {
                        var buttons = {};
                        var ok = 'OK';
                        var c = $("#<%=hdnCancelText.ClientID %>").val();
                        
                        console.log('myConfirm - initial vars all set')
                        buttons[ok] = function () { if (typeof (okFunc) == 'function') { setTimeout(okFunc, 50); } $(this).dialog('destroy'); }
                        buttons[c] = function () { if (typeof (cancelFunc) == 'function') { setTimeout(cancelFunc, 50); } $(this).dialog('close'); }

                        console.log('myConfirm - buttons set')
                        console.log(dialogText);

                        $('<div style="padding: 10px; max-width: 500px; word-wrap: break-word;"><span class="labelText" style="font-size:0.9em;">' + dialogText + '</span></div>').dialog({
                            position: ['middle', 'center'],
                            draggable: false,
                            modal: true,
                            resizable: true,
                            width: '400',
                            title: dialogTitle || 'Confirm',
                            minHeight: 75,
                            show: "fade",
                            hide: "fade",
                            buttons: buttons
                        });
                        event.preventDefault();
                    }                     


                    function closeForm(formName) {
                        var close = false;
                        
                        if (formName == 'modalCreateExpense') {
                            if ($("#<%=txtAmt.ClientID %>").val() != '' && $("#<%=cboCat.ClientID %>").val() !=='')
                                close = true;

                            else if ($("#<%=hdnCatID.ClientID %>").val()=='4') //category is km allowance
                                $("#<%=lbl509.ClientID %>").show() //km is required
                        } else 
                            close = true;

                        if (close) {
                            var mpe = $find(formName);
                            if (mpe) { mpe.hide(); }
                            var mpe = $find('modalProcessing');
                            if (mpe) { mpe.show(); }
                        }

                    }
    

                    function startGuidelinesTour() {
                        guidelines(_guidelineSteps)
                    }

                    $(document).ready(function () {

                        if (window.FormData !== undefined) {

                            $('#<%= FileUpload1.ClientID %>').change(function () {
                                readURL(this);
                            });
                        }

                        if (getQuerystring('rID', '0') == '0') $("#selectedReceipt").hide();
                        if (getQuerystring('rID', '0') != '0') $("#<%=pnlCreateExpense.ClientID %>").css('left', -100);

                        /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                        if (getQuerystring('ce', '0') == '1' && $("table[id*=gridViewExpenses]").find("TR").length - 1 < 25 && typeof (isPostBack) != "undefined" && !isPostBack) {
                            if ($("#<%=hdnExpDate.ClientID %>").val() != '0') $("#<%= txtExpDate.ClientID %>").val($("#<%=hdnExpDate.ClientID %>").val());
                            var mpe = $find('modalCreateExpense');
                            if (mpe) { mpe.show(); }
                        }

                        /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

                        if (getQuerystring('rID', '0') != '0') {
                            var record_id = getQuerystring('rID', '0');
                            var puk = $("#<%=hdnPUK.ClientID %>").val();

                            $.ajax({
                                type: "POST",
                                url: "Reports.aspx/CheckReceiptNum",
                                data: "{'rID': '" + getQuerystring('rID', '0') + "','puk': '" + puk + "'}",
                                contentType: "application/json; charset=utf-8",
                                dataType: "json",
                                success: function (returnVal) {
                                    $("#<%=hdnSelectedReceipt.ClientID %>").val(record_id);
                                    $("#<%=FileUpload1.ClientID %>").hide();
                                    $("#<%=lblSelectedReceipt.ClientID %>").text("Receipt #" + record_id);
                                },
                                error: function () {
                                    window.location = "../error.aspx"
                                }
                            });

                        }
                        /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

                        $("#<%=lbl509.ClientID %>").hide();
                        $('#msg').hide();
                        $('#exceedMsg').hide();
                        $("#Row-Attendees").hide();
                        $("#Row-JurMsg").hide();
                        $("#Row-FileError1").hide();
                        $("#Row-FileError2").hide();
                        $("#<%= txtGST.ClientID %>").val('0.00');
                        $("#Row-GST").hide();
                        $("#Row-Project").hide();
                        $("#Row-CostCenter").hide();
                        $('#<%=cboTP.ClientID %>').hide();
                        $('#<%=chkDontReimburse.ClientID %>').prop('checked', false)
                        $("#<%= cboTaxIE.ClientID %>").val('0');
                        $("#<%= txtTotal.ClientID %>").val('0.00');
                        $("#<%=cboCurr.ClientID %>").prop('selectedIndex', 24);

                        $('#dialog').dialog({
                            autoOpen: false,
                            height: 275,
                            width: 425,
                            modal: true,
                            buttons: {
                                "Ok": function () {
                                    del = 1;
                                    $(this).dialog("close");
                                }
                            }
                        });


                        $("#tabs").tabs({});

                        /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

                        if ($("#<%= hdnOpenReport.ClientID %>").val() == "True") {
                            $("#btnNewReport").hide();

                            if (getQuerystring('submitted', '0') != '1') {
                                $("#Cell-ReportTitle").show();
                                if ($("#<%= cboStatus.ClientID %>").val() == "Open") {
                                    $("#btnSubmit").show();
                                    if ($("#<%=gridViewExpenses.ClientID %> tr").length < 26) $("#Cell-NewExp").show();
                                } else {
                                    $("#btnSubmit").hide();
                                    $("#Cell-NewExp").hide();
                                }
                            }
                        }
                        else {
                            $("#Cell-NewExp").hide();
                            $("#Cell-ReportTitle").hide();
                            $("#btnSubmit").hide();

                            if ($("#<%= cboStatus.ClientID %>").val() == "Open")
                                $("#btnNewReport").show();
                            else
                                $("#btnNewReport").hide();

                            if (window.location.search.substring(1) == 'e=1')
                                $("#btnNewReport").hide();
                        }

                        /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

                        $("#<%=txtGrat.ClientID %>").val(0);
                        $("#<%= txtExpDate.ClientID %>").datepicker({ dateFormat: "dd/mm/yy", minDate: "01/07/2010", maxDate: getMaxDate() });
                        $("#<%=txtTo.ClientID %>").datepicker({ dateFormat: "dd/mm/yy", minDate: "01/07/2010", maxDate: getMaxDate() });
                        $("#<%=txtFrom.ClientID %>").datepicker({ dateFormat: "dd/mm/yy", minDate: "01/07/2010", maxDate: getMaxDate() });

                        //apr7
                        //document.getElementById("imgUnlockGST").style.display = "none";
                        //document.getElementById("imgUnlockQST").style.display = "none";
                        $("#Row-WorkOrder").hide();
                        $("#Row-ReportType").hide();
                        $("#Row-ExpMsg").hide();
                        //$("#Row-GST").hide();
                        $("#Row-HST").hide();
                        $("#Row-QST").hide();
                        //$("#Row-Total").hide();
                        $("#Row-TaxStatus").hide();
                        $("#dummytable").hide();
                        $("#Row-ExpID").hide();
                        $("#Row-TitleEditExp").hide();
                        $("#Row-Supplier").hide();
                        $("#Row-Jur").hide();
                        $("#Cell-RemoveAttachment").hide();
                        $("#Row-TaxRate").hide();
                        $("#Row-Rate").hide();
                        $("#Row-KM").hide();
                        $("#Row-Grat").hide();
                        $("#<%=cboCat.ClientID %>").val('');
                        $("#<%=txtKM.ClientID %>").val('');
                        $("#<%=cboRate.ClientID %>").val('');
                        $("#<%=txtAmt.ClientID %>").val('');
                        $("#<%=cboCat.ClientID %>").val('');

                        /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

                        $(".popUpWin").click(function () {
                            var iMyWidth;
                            var iMyHeight;
                            //half the screen width minus half the new window width (plus 5 pixel borders).
                            iMyWidth = (window.screen.width / 2) - (250 + 10);
                            //half the screen height minus half the new window height (plus title and status bars).
                            iMyHeight = (window.screen.height / 2) - (113 + 50);
                            //Open the window.
                            var win2 = window.open("../info.aspx?id=" + $(this).attr("id"), "Info", "status=no,height=226,width=500,resizable=yes,left=" + iMyWidth + ",top=" + iMyHeight + ",screenX=" + iMyWidth + ",screenY=" + iMyHeight + ",toolbar=no,menubar=no,scrollbars=yes,location=no,directories=no");
                            win2.focus();
                        });

                        /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

                        function getMaxDate() {
                            var today = new Date();
                            var maxDate = new Date();

                            if ($("#<%=cboTaxRate.ClientID %>").val() == 10 && $("#<%=hdnCatID.ClientID %>").val() == 5) {
                                maxDate = new Date("March 31, 2013");
                            }

                            if (today > maxDate) today = maxDate;

                            return today;
                        }

                        /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

                        $("#<%=txtFrom.ClientID %>").change(function () {
                            $("#<%=hdnFrom.ClientID %>").val($("#<%=txtFrom.ClientID %>").val());
                        });

                        /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

                        $("#<%=txtTo.ClientID %>").change(function () {
                            $("#<%=hdnTo.ClientID %>").val($("#<%=txtTo.ClientID %>").val());
                        });

                        /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

                        $(".mGrid a.collapseExp").each(function () {
                            $(this).hide();
                        });

                        /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

                        $("#<%=txtKM.ClientID %>").keyup(function () {
                            var km = $("#<%=txtKM.ClientID %>").val() * 1;

                            if ($("#<%=txtKM.ClientID %>").val() == '' || km == 0) {
                                $("#<%=txtAmt.ClientID %>").val('');
                                $("#<%=lbl509.ClientID %>").show();
                            }
                            else {
                                $("#<%=lbl509.ClientID %>").hide();
                                $("#<%=txtAmt.ClientID %>").val(($("#<%=cboRate.ClientID %>").val() * $("#<%=txtKM.ClientID %>").val()));
                            }
                            $("#<%=txtAmt.ClientID %>").keyup();
                        });

                        /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////                        

                        $('#<%=chkDontReimburse.ClientID %>').click(function () {
                            if ($('#<%=chkDontReimburse.ClientID %>').prop('checked') == true)
                                $('#<%=cboTP.ClientID %>').show();
                            else
                                $('#<%=cboTP.ClientID %>').hide();

                        });

                        /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

                        $("#<%=txtGST.ClientID %>").keyup(function () {
                            var numAmount = $("#<%=txtAmt.ClientID %>").val() * 1;
                            numAmount = numAmount + $("#<%=txtGrat.ClientID %>").val() * 1;

                            if ($("#<%=cboTaxIE.ClientID %>").val() == 2) {
                                numAmount = numAmount + $("#<%=txtGST.ClientID %>").val() * 1;
                                numAmount = numAmount + $("#<%=txtQST.ClientID %>").val() * 1;
                            }

                            $("#<%=txtTotal.ClientID %>").val(numAmount.toFixed(2));
                            var numTotal = $("#<%=txtTotal.ClientID %>").val() * 1;
                            var numLimit = $("#<%=hdnLimit.ClientID %>").val() * 1;

                            if (numTotal > numLimit && numLimit > 0) {
                                $('#exceedMsg').show();
                                $("#<%=cmdSaveExpense.ClientID %>").attr('disabled', 'disabled');
                                $("#<%=cmdSaveExpense2.ClientID %>").attr('disabled', 'disabled');

                            } else {
                                $('#exceedMsg').hide();
                                $("#<%=cmdSaveExpense.ClientID %>").removeAttr('disabled');
                                $("#<%=cmdSaveExpense2.ClientID %>").removeAttr('disabled');
                            }

                            //check if modified tax amounts do not exceed total amount    
                            numAmount = $("#<%=txtGST.ClientID %>").val() * 1 + $("#<%=txtQST.ClientID %>").val() * 1; ;

                            if (numAmount > $("#<%=txtAmt.ClientID %>").val()) {
                                $("#<%=cmdSaveExpense.ClientID %>").attr('disabled', 'disabled');
                                $("#<%=cmdSaveExpense2.ClientID %>").attr('disabled', 'disabled');
                                $("#ExpMsg").css('height', '25px');
                                $("#<%=lblExpMsg.ClientID %>").text($("#<%=hdnTaxesExceedTotal.ClientID %>").val());
                                $("#Row-ExpMsg").show();
                            } else {
                                $("#<%=cmdSaveExpense.ClientID %>").removeAttr('disabled');
                                $("#<%=cmdSaveExpense2.ClientID %>").removeAttr('disabled');
                                $("#ExpMsg").css('height', '50px');
                                $("#<%=lblExpMsg.ClientID %>").text('');
                                $("#Row-ExpMsg").hide();
                            }
                        });

                        /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

                        $("#<%=txtQST.ClientID %>").keyup(function () {
                            $("#<%=txtGST.ClientID %>").keyup();
                        });

                        /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

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

                        /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

                        $("#<%=txtExpDate.ClientID %>").change(function () {
                            $("#<%=hdnExpDate.ClientID %>").val($("#<%=txtExpDate.ClientID %>").val());
                            $("#<%=txtAmt.ClientID %>").keyup();
                        });

                        /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

                        $("#<%=txtAmt.ClientID %>").keyup(function () {
                            var jur_id;
                            var exp_date = $("#<%=txtExpDate.ClientID %>").val();
                            var cat_id = $("#<%=hdnCatID.ClientID %>").val();
                            var orgcat_id = $("#<%=cboCat.ClientID %>").val();
                            var tax_inc_exc = $("#<%=cboTaxIE.ClientID %>").val();
                            var kmRate = $("#<%=cboRate.ClientID %>").val();

                            if (kmRate == '') kmRate = 0;
                            if (kmRate == null) kmRate = 0;
                            $('#exceedMsg').hide();

                            if (cat_id == 5)
                                jur_id = $("#<%=cboTaxRate.ClientID %>").val();
                            else
                                jur_id = $("#<%=cboJur.ClientID %>").val();

                            $.ajax({
                                type: "POST",
                                url: "Reports.aspx/GetTaxRates",
                                data: "{'jurID': '" + jur_id + "','expDate': '" + exp_date + "','catID': '" + cat_id + "','taxIncExc': '" + tax_inc_exc + "','orgCatID': '" + orgcat_id + "','kmRate': '" + kmRate + "'}",
                                contentType: "application/json; charset=utf-8",
                                dataType: "json",
                                success: function (returnVal) {
                                    var TaxRates = returnVal.d;
                                    var numAmount;
                                    var total;

                                    numAmount = $("#<%=txtAmt.ClientID %>").val() * TaxRates["GSTHST"];

                                    $("#<%=txtGST.ClientID %>").val(numAmount.toFixed(2));
                                    $("#<%=hdnGST.ClientID %>").val(numAmount.toFixed(2));

                                    numAmount = $("#<%=txtAmt.ClientID %>").val() * TaxRates["QST"];
                                    $("#<%=txtQST.ClientID %>").val(numAmount.toFixed(2));
                                    $("#<%=hdnQST.ClientID %>").val(numAmount.toFixed(2));

                                    numAmount = $("#<%=txtAmt.ClientID %>").val() * 1;
                                    numAmount = numAmount + $("#<%=txtGrat.ClientID %>").val() * 1;

                                    //if amount is before tax
                                    if ($("#<%=cboTaxIE.ClientID %>").val() == 2) {
                                        numAmount = numAmount + $("#<%=txtGST.ClientID %>").val() * 1;
                                        numAmount = numAmount + $("#<%=txtQST.ClientID %>").val() * 1;
                                    }
                                    $("#<%=txtTotal.ClientID %>").val(numAmount.toFixed(2));
                                    $("#Row-Total").show();

                                    //if jurisdiction is quebec, show QST row
                                    if (jur_id == 1)
                                        $("#Row-QST").fadeIn(300);
                                    else
                                        $("#Row-QST").fadeOut(300);

                                    //if jurisdiction is outside canada, hide GST row
                                    if (jur_id == 14)
                                        $("#Row-GST").fadeOut(300);
                                    else
                                        $("#Row-GST").fadeIn(300);

                                    //if km entered exceeds the allowable amount for the jurisdiction, display warning

                                    if (TaxRates["ValidateKM"] == 0) {
                                        $("#<%=lblExpMsg.ClientID %>").text($("#<%=hdnKMExceeds.ClientID %>").val());
                                        $("#Row-ExpMsg").fadeIn(300);
                                    } else {
                                        //if category is not personal use and not insurance premium and the KM is under the allowable limit, 
                                        //hide warning message, otherwise display warning for personal use and insurance premium
                                        if ((cat_id != 44 && cat_id != 15) && TaxRates["AllowanceAmount"] == 0) $("#Row-ExpMsg").hide();
                                    }

                                    var numTotal = $("#<%=txtTotal.ClientID %>").val() * 1;
                                    var numAllowanceAmount = TaxRates["AllowanceAmount"] * 1;
                                    $("#<%=hdnLimit.ClientID %>").val(TaxRates["AllowanceAmount"]);

                                    //check if the total is greater than the allowance limit if the expense is not a km expense 
                                    //and the allowance limit is greater than zero. if yes, then display message saying 
                                    //the amount exceeds the allowed limit
                                    if (numTotal > numAllowanceAmount && cat_id != 4 && numAllowanceAmount > 0) {
                                        $('#exceedMsg').show();
                                        $("#<%=cmdSaveExpense.ClientID %>").css('visibility', 'hidden');
                                        $("#<%=cmdSaveExpense2.ClientID %>").css('visibility', 'hidden');
                                    } else {
                                        $('#exceedMsg').hide();
                                        $("#<%=cmdSaveExpense.ClientID %>").css('visibility', 'visible');
                                        $("#<%=cmdSaveExpense2.ClientID %>").css('visibility', 'visible');
                                    }
                                },
                                error: function () {
                                    if (xhr.responseText.indexOf('is not a valid value') == -1) //ignore error if user hasnt selected a category yet
                                        myMsg("Error#1001: There was an unexpected error", function () { return true; }, "Error");
                                }
                            });
                        });

                        /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

                        $("#<%=cboTaxIE.ClientID %>").change(function () {
                            $("#<%=txtAmt.ClientID %>").keyup();
                        });

                        /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

                        $("#<%=cboTaxIE.ClientID %>").keyup(function () {

                            if ($("#<%=cboTaxIE.ClientID %>").val() == '2') {
                                document.getElementById("imgUnlockGST").style.display = "inline";
                                document.getElementById("imgUnlockQST").style.display = "inline";
                            } else {
                                document.getElementById("imgUnlockGST").style.display = "none";
                                document.getElementById("imgUnlockQST").style.display = "none";
                                $("#<%=txtGST.ClientID %>").prop('disabled', 'disabled');
                                $("#<%=txtQST.ClientID %>").prop('disabled', 'disabled');
                            }

                            $("#<%=txtAmt.ClientID %>").keyup();
                        });

                        /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

                        $("#<%=cboJur.ClientID %>").change(function () {
                            //} else //    $("#msg").hide; //    $("#<%=cboCurr.ClientID %>").val('25'); //else { //    if ($(this).val() == '14') //        $("#<%=cboTaxIE.ClientID %>").css("display", "none"); //    else  //        $("#<%=cboTaxIE.ClientID %>").css("display", "inline"); //}

                            $("#<%=txtAmt.ClientID %>").keyup();

                            if ($("#<%=cboCurr.ClientID %>").val() != '25' && $("#<%=cboJur.ClientID %>").val() != '14') {
                                $("#<%=lblJurMsg.ClientID %>").text($("#<%=hdnCurrOutsideJur.ClientID %>").val());
                                $("#Row-JurMsg").fadeIn(300);
                            } else {
                                $("#Row-JurMsg").hide();
                            }
                        });

                        /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

                        $("#<%=cboRate.ClientID %>").change(function () {
                            $("#<%=txtKM.ClientID %>").keyup();
                        });

                        /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                        //$("#<%=cboCat.ClientID %>").click(function () {
                        //    $("#<%=cboCat.ClientID %>").keyup()
                        //});

                        /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                        $("#<%=cboCat.ClientID %>").blur(function () {
                            $("#<%=cboCat.ClientID %>").keyup();
                        });
                        /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

                        $("#<%=cboCat.ClientID %>").change(function () {
                            $("#<%=txtSupplier.ClientID %>").val('');
                            $("#<%=txtComment.ClientID %>").val('');
                            $("#<%=txtKM.ClientID %>").val('');
                            $("#<%=txtAmt.ClientID %>").val('');
                            $("#<%=txtGrat.ClientID %>").val('');
                            $("#<%=txtAttendees.ClientID %>").val('');
                            $("#<%=txtTotal.ClientID %>").val('0.00');
                            $("#<%=txtGST.ClientID %>").val('0.00');
                            $("#<%=txtQST.ClientID %>").val('0.00');
                            $("#<%=hdnGST.ClientID %>").val(0);
                            $("#<%=hdnQST.ClientID %>").val(0);
                            $("#Row-ExpMsg").hide();
                            $('#exceedMsg').hide();
                            if ($("#<%=cboCat.ClientID %>").val() != 0) $("#<%=cboCat.ClientID %>").keyup();
                        });

                        /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

                        $("#<%=cboCat.ClientID %>").keyup(function () {
                            var org_cat_id = $(this).val();
                            var lang = $("#<%=hdnLanguage.ClientID %>").val();

                            if (org_cat_id != '') {
                                $("#<%=hdnOrgCatID.ClientID %>").val(org_cat_id);
                                //$("#Row-ExpMsg").hide();

                                $.ajax({
                                    type: "POST",
                                    url: "Reports.aspx/GetAllows",
                                    data: "{'orgCatID': '" + org_cat_id + "','lang': '" + lang + "'}",
                                    contentType: "application/json; charset=utf-8",
                                    dataType: "json",
                                    success: function (returnVal) {
                                        
                                        var Allows = returnVal.d;

                                        if (Allows["AllowSupplier"] == 'True') $("#Row-Supplier").show(); else { $("#Row-Supplier").hide(); $("#<%=txtSupplier.ClientID %>").val(''); }
                                        if (Allows["AllowRate"] == 'True') $("#Row-Rate").show(); else { $("#Row-Rate").hide(); $("#<%=cboRate.ClientID %>").val(''); }
                                        if (Allows["AllowGratuity"] == 'True') { $("#Row-Grat").show(); } else { $("#Row-Grat").hide(); }
                                        if (Allows["AllowJurisdiction"] == 'True') $("#Row-Jur").show(); else $("#Row-Jur").hide();
                                        if (Allows["AllowKM"] == 'True') $("#Row-KM").show(); else { $("#Row-KM").hide(); $("#<%=txtKM.ClientID %>").val(0); }
                                        if (Allows["AllowAmount"] == 'True') $("#Row-Amt").show(); else $("#Row-Amt").hide();
                                        if (Allows["AllowTaxRate"] == 'True') $("#Row-TaxRate").show(); else { $("#Row-TaxRate").hide(); $("#<%=cboTaxRate.ClientID %>").val(''); }
                                        if (Allows["AllowTaxIncludedExcluded"] == 'True') $("#<%=cboTaxIE.ClientID %>").show(); else { $("#<%=cboTaxIE.ClientID %>").hide(); $("#<%=cboTaxIE.ClientID %>").val(1); }
                                        if (Allows["AllowReimburse"] == 'True' && $("#<%=cboTP.ClientID %> option").length > 0) $("#Row-DontReimburse").show(); else { $("#Row-DontReimburse").hide(); $('#<%=chkDontReimburse.ClientID %>').attr('checked', false); }
                                        if (Allows["IsAllowance"] == 'True') { $("#imgUnlockGST").hide(); $("#imgUnlockQST").hide(); } else { $("#imgUnlockGST").show(); $("#imgUnlockQST").show(); }
                                        if (Allows["RequiredSegments"].indexOf('P') == -1) $("#Row-Project").hide(); else $("#Row-Project").show();
                                        if (Allows["RequiredSegments"].indexOf('C') == -1) $("#Row-CostCenter").hide(); else $("#Row-CostCenter").show();
                                        if (Allows["AllowAttendees"] == 'True') $("#Row-Attendees").show(); else $("#Row-Attendees").hide();

                                        if (Allows["DefaultCostCenter"] != "0") {
                                            $("#<%=cboCC.ClientID %>").val(Allows["DefaultCostCenter"]);
                                            $("#<%=cboCC.ClientID %>").attr('disabled', 'disabled');
                                        } else {
                                            $("#<%=cboCC.ClientID %>").removeAttr('disabled');
                                            $("#<%=cboCC.ClientID %>").prop('selectedIndex', 0);
                                        }

                                        $("#<%=hdnCatID.ClientID %>").val(Allows["CategoryID"]);
                                        var numAllowanceAmount = Allows["AllowanceAmount"] * 1;

                                        if (Allows["CategoryID"] == "4") //category is KM allowance
                                            $("#<%=cboRate.ClientID %>").val(numAllowanceAmount.toFixed(2));

                                        if (numAllowanceAmount > 0 && Allows["IsAllowance"] == 'True') {
                                            $("#<%=cboRate.ClientID %>").prop("disabled", "disabled");
                                            if (Allows["CategoryID"] == "4") //category is km allowance
                                                $("#<%=txtAmt.ClientID %>").val(numAllowanceAmount.toFixed(2) * $("#<%=txtKM.ClientID %>").val());
                                            else
                                                $("#<%=txtAmt.ClientID %>").val(numAllowanceAmount.toFixed(2));

                                            $("#<%=txtAmt.ClientID %>").prop("disabled", "disabled");
                                            $("#<%=txtAmt.ClientID %>").keyup();
                                        } else {

                                            $("#<%=cboRate.ClientID %>").removeAttr("disabled");
                                            $("#<%=txtAmt.ClientID %>").removeAttr("disabled");

                                            if (Allows["AllowanceAmount"] > "0") {
                                                $("#<%=lblExpMsg.ClientID %>").text(Allows["LimitMessage"] + " $" + numAllowanceAmount.toFixed(2));
                                                $("#ExpMsg").css("height", "25");
                                                $("#Row-ExpMsg").fadeIn(300);
                                            }
                                        }
                                        //if category is personal use, display warning
                                        if (Allows["CategoryID"] == "44") {
                                            $("#<%=lblExpMsg.ClientID %>").text($("#<%=hdnPersonalUseMsg.ClientID %>").val());
                                            $("#ExpMsg").css("height", "25");
                                            $("#Row-ExpMsg").fadeIn(300);

                                            //if category is insurance premium, display warning
                                        } else if (Allows["CategoryID"] == "15") {
                                            $("#<%=lblExpMsg.ClientID %>").text($("#<%=hdnInsuranceMsg.ClientID %>").val());
                                            $("#ExpMsg").css("height", "45");
                                            $("#Row-ExpMsg").fadeIn(300);
                                        }
                                        //if category is selectable rate, and jurisdiction is in canada, set currency to canadian
                                        if (Allows["CategoryID"] == '5' && $("#<%=cboTaxRate.ClientID %>").val() != '14') $("#<%=cboCurr.ClientID %>").val('25');

                                        $("#<%=txtAmt.ClientID %>").keyup();
                                    },
                                    error: function (xhr) {
                                        myMsg("Error#1002: There was an unexpected error" + xhr.responseText, function () { return true; }, "Error");
                                    }
                                });
                            }
                        });

                        /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

                        $(".editExp").click(function () {
                            var record_id = $(this).attr("id") / 3;
                            var puk = $("#<%=hdnPUK.ClientID %>").val();
                            document.body.style.cursor = "wait";

                            $("#Row-TitleAddExp").hide();
                            $("#Row-TitleEditExp").show();
                            $("#Row-Msg").hide();
                            $("#<%=cmdSaveExpense.ClientID %>").removeAttr('disabled');
                            $("#<%=cmdSaveExpense2.ClientID %>").hide();
                            $("#Receipts").css('visibility', 'hidden');
                            $("#<%=RequiredFieldValidator4.ClientID %>").css('display', 'none');
                            $("#<%=cboCat.ClientID %>").prop('disabled', 'disabled');

                            //$("#Row-Total").hide();
                            $("#<%=txtTotal.ClientID %>").val('0.00');
                            //$("#Row-GST").hide();
                            $("#Row-HST").hide();
                            $("#Row-QST").hide();
                            $("#<%=txtGST.ClientID %>").prop('disabled', true);
                            $("#<%=txtQST.ClientID %>").prop('disabled', true);

                            $("#<%=txtExpenseID.ClientID %>").val(record_id);

                            $.ajax({
                                type: "POST",
                                url: "Reports.aspx/GetExpense",
                                data: "{'expID': '" + record_id + "','puk': '" + puk + "'}",
                                contentType: "application/json; charset=utf-8",
                                dataType: "json",
                                async: true,
                                cache: false,
                                success: function (msg) {
                                    var expense = msg.d;
                                    var numAmount;
                                    numAmount = expense["Amount"] * 1;  //mulitply by 1 to convert num to numeric value

                                    $("#<%=cboCat.ClientID %>").val(expense["OrgCategoryID"]);
                                    $("#<%=hdnCatID.ClientID %>").val(expense["CategoryID"]);
                                    $("#<%=hdnOrgCatID.ClientID %>").val(expense["OrgCategoryID"]);
                                    $("#<%=txtAmt.ClientID %>").val(numAmount.toFixed(2));

                                    if (expense["IsAllowance"] == 'True') {
                                        if (expense["AllowanceAmount"] > 0) {
                                            $("#<%=txtAmt.ClientID %>").prop('disabled', true);

                                            if (expense["CategoryID"] == 4) {
                                                $("#<%=cboRate.ClientID %>").prop('disabled', true);
                                            }
                                        }
                                        else {
                                            $("#<%=cboRate.ClientID %>").removeAttr('disabled');
                                            $("#<%=txtAmt.ClientID %>").removeAttr('disabled');
                                        }

                                        $("#<%=cboTaxIE.ClientID %>").hide();
                                    } else
                                        $("#<%=cboTaxIE.ClientID %>").show();

                                    $("#<%=txtComment.ClientID %>").val(expense["Comment"]);

                                    if ($("#<%=txtComment.ClientID %>").val().indexOf('was modified') > 0)
                                        $("#<%=txtComment.ClientID %>").prop('readonly', true);
                                    else
                                        $("#<%=txtComment.ClientID %>").prop('readonly', false);

                                    $("#<%=cboCurr.ClientID %>").val(expense["CurrencyID"]);
                                    $("#<%=txtExpDate.ClientID %>").val(expense["ExpenseDate"]);
                                    $("#<%=hdnExpDate.ClientID %>").val(expense["ExpenseDate"]);
                                    $("#<%=txtGrat.ClientID %>").val(expense["Gratuities"]);
                                    $("#<%=cboJur.ClientID %>").val(expense["JurisdictionID"]);
                                    $("#<%=txtAttendees.ClientID %>").val(expense["Attendees"]);

                                    var numRate = expense["Rate"] * 1;
                                    $("#<%=cboRate.ClientID %>").val(numRate.toFixed(2));
                                    $("#<%=txtSupplier.ClientID %>").val(expense["Supplier"]);
                                    $("#<%=txtGST.ClientID %>").val(expense["GSTPaid"]);
                                    $("#<%=txtQST.ClientID %>").val(expense["QSTPaid"]);
                                    $("#<%=hdnGST.ClientID %>").val(expense["GSTPaid"]);
                                    $("#<%=hdnQST.ClientID %>").val(expense["QSTPaid"]);

                                    if (expense["Reimburse"] == '0') {
                                        $('#<%=chkDontReimburse.ClientID %>').attr('checked', false);
                                        $('#<%=cboTP.ClientID %>').hide();
                                    } else {
                                        $('#<%=chkDontReimburse.ClientID %>').attr('checked', true);
                                        $('#<%=cboTP.ClientID %>').show();
                                        $('#<%=cboTP.ClientID %>').val(expense["TPNum"]);

                                    }

                                    $("#<%=cboTaxIE.ClientID %>").val(expense["TaxStatus"]);

                                    if (expense["ReceiptName"] != "")
                                        $("#Cell-RemoveAttachment").show();
                                    else
                                        $("#Cell-RemoveAttachment").hide();

                                    var mpe = $find('modalCreateExpense');
                                    if (mpe) { mpe.show(); }

                                    //$("#<%=cboCat.ClientID %>").prop('disabled', true);

                                    if (expense["CategoryID"] == 4) {
                                        $("#<%=txtAmt.ClientID %>").val(expense["Amount"]);
                                        $("#<%=txtKM.ClientID %>").val(expense["NumberOfKM"]);
                                    }

                                    $("#<%=txtTotal.ClientID %>").val(expense["Total"]);
                                    $("#<%=cboProject.ClientID %>").val(expense["Project"]);
                                    $("#<%=cboWO.ClientID %>").val(expense["WorkOrder"]);
                                    $("#<%=cboCC.ClientID %>").val(expense["CostCenter"]);

                                    if (expense["AllowAmount"] == 'True') $("#Row-Amt").show(); else $("#Row-Amt").hide();
                                    if (expense["AllowSupplier"] == 'True') $("#Row-Supplier").show(); else $("#Row-Supplier").hide();
                                    if (expense["AllowGratuities"] == 'True') $("#Row-Grat").show(); else $("#Row-Grat").hide();
                                    if (expense["AllowJurisdiction"] == 'True') $("#Row-Jur").show(); else $("#Row-Jur").hide();
                                    if (expense["AllowKM"] == 'True') $("#Row-KM").show(); else $("#Row-KM").hide();
                                    if (expense["AllowNote"] == 'True') $("#Row-Note").show(); else $("#Row-Note").hide();
                                    if (expense["AllowRate"] == 'True') $("#Row-Rate").show(); else $("#Row-Rate").hide();
                                    if (expense["AllowAttendees"] == 'True') $("#Row-Attendees").show(); else $("#Row-Attendees").hide();
                                    if (expense["RequiredSegments"].indexOf('P') == -1) $("#Row-Project").hide(); else $("#Row-Project").show();
                                    if (expense["RequiredSegments"].indexOf('C') == -1) $("#Row-CostCenter").hide(); else $("#Row-CostCenter").show();

                                    if (expense["AllowTaxRate"] == 'True') {
                                        $("#Row-TaxRate").show();
                                        $("#<%=cboTaxRate.ClientID %>").val(expense["JurisdictionID"]);
                                    }
                                    else
                                        $("#Row-TaxRate").hide();

                                    document.body.style.cursor = "default";
                                    $("#Row-Total").show();

                                    var numTotal = $("#<%=txtTotal.ClientID %>").val() * 1;
                                    $("#<%=txtTotal.ClientID %>").val(numTotal.toFixed(2));

                                    //if jurisdiction is outside canada, hide GST and QST rows
                                    if (expense["JurisdictionID"] == '14') {
                                        $("#Row-QST").hide();
                                        $("#Row-GST").hide();
                                    }
                                    else {
                                        $("#Row-GST").show();
                                        //if jurisdiction is quebec, show QST row
                                        if (expense["JurisdictionID"] == '1')
                                            $("#Row-QST").show();
                                        else
                                            $("#Row-QST").hide();
                                    }


                                },
                                error: function (xhr) {
                                    myMsg("Error#1003: There was an unexpected error" + xhr.responseText, function () { return true; }, "Error");
                                }
                            });
                        });

                        /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

                        $("#<%=cboTaxRate.ClientID %>").change(function () {
                            var record_id = $(this).val();

                            if ($(this).val() != '14') $("#<%=cboCurr.ClientID %>").val('25');

                            $("#<%=txtAmt.ClientID %>").keyup();
                        });

                        /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                        $("#<%=txtGrat.ClientID %>").keyup(function () { $("#<%=txtAmt.ClientID %>").keyup(); });
                        $("#<%=txtGST.ClientID %>").keyup(function () { $("#<%=hdnGST.ClientID %>").val($("#<%=txtGST.ClientID %>").val()); });
                        $("#<%=txtQST.ClientID %>").keyup(function () { $("#<%=hdnQST.ClientID %>").val($("#<%=txtQST.ClientID %>").val()); });

                        /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
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
                                success: function (expenseDetails) {
                                    row.after(expenseDetails.d);
                                    var newRow = row.next();
                                    newRow.hide();
                                    newRow.fadeIn(1000);
                                },
                                error: function () {
                                    myMsg("Error#1004: There was an unexpected error", function () { return true; }, "Error");
                                }
                            });

                            return false;
                        });

                        /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                        $(".collapseExp").click(function () {
                            $(this).hide();

                            var record_id = $(this).attr("id") / 2;
                            $("#" + record_id).show();
                            var row = $(this).parents('tr').next();
                            //row.fadeOut(slow);
                            row.fadeOut(1000, function () {
                                row.remove();
                            });
                        });
                        /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

                        $(".delExpense").click(function () {
                            var record_id = $(this).attr("id");

                            var row = $(this).parent("td").parent('tr');
                            var puk = $("#<%=hdnPUK.ClientID %>").val();

                            myConfirm($("#<%=hdnDeleteExpMsg.ClientID %>").val(),
                                function () {
                                    var mpe = $find('modalProcessing');
                                    if (mpe) { mpe.show(); }

                                    $.ajax({
                                        type: "POST",
                                        url: "Reports.aspx/DeleteExpense",
                                        data: "{'expID': '" + record_id + "','puk': '" + puk + "'}",
                                        contentType: "application/json; charset=utf-8",
                                        dataType: "json",
                                        success: function (val) {
                                            row.css("background-color", "red");
                                            row.fadeOut(1000, function () {
                                                row.remove();
                                            });

                                            if ($("#<%=gridViewExpenses.ClientID %> tr").length < 26)
                                                $("#Cell-NewExp").show();
                                            else
                                                $("#Cell-NewExp").hide();

                                            if (mpe) { mpe.hide(); }

                                            $("#msg2").hide();
                                            $("#msg").show();
                                            $("#txtMsg").val($("#<%=hdnExpDeletedMsg.ClientID %>").val());
                                        },
                                        error: function () {
                                            myMsg("There was an error while deleting expense", function () { return true; }, "Error");
                                        }
                                    });
                                },
                                function () { return false; }, $("#<%=hdnDeleteExpTitle.ClientID %>").val());
                        });
                        /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

                        $(".delReport").click(function () {
                            var record_id = $(this).attr("id") / 4;

                            var row = $(this).parent("td").parent('tr');
                            var puk = $("#<%=hdnPUK.ClientID %>").val();
                            console.log('before confirming the delete');
                            myConfirm($("#<%=hdnDeleteRptMsg.ClientID %>").val(), function () {
                                $.ajax({
                                    type: "POST",
                                    url: "Reports.aspx/DeleteReport",
                                    data: "{'rptID': '" + record_id + "','puk': '" + puk + "'}",
                                    contentType: "application/json; charset=utf-8",
                                    dataType: "json",
                                    success: function () {
                                        $("#<%=gridViewExpenses.ClientID %> tr:not(:first-child)").html("");
                                        //window.location = "reports.aspx";
                                        row.css("background-color", "red");
                                        row.fadeOut(1000, function () {
                                            row.remove();
                                        });
                                        $("#btnSubmit").hide();
                                        $("#btnNewReport").show();
                                        $("#Cell-NewExp").hide();
                                        $("#Cell-ReportTitle").hide();
                                        $("#msg2").hide();
                                        $("#msg").show();
                                        $("#txtMsg").val($("#<%=hdnRptDeletedMsg.ClientID %>").val());

                                    },
                                    error: function () {
                                        myMsg("There was an error deleting report", function () { return true; }, "Error");
                                    }
                                });
                            },
                            function () { return false; }, $("#<%=hdnDeleteRptTitle.ClientID %>").val());
                        });
                        /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

                        $(".approveRpt").click(function () {
                            var record_id = $(this).attr("id") / 2;

                            var row = $(this).parent("td").parent('tr');
                            var puk = $("#<%=hdnPUK.ClientID %>").val();

                            myConfirm($("#<%=hdnApproveRpt.ClientID %>").val(), function () {
                                var modalProcessing = $find('modalProcessing');
                                if (modalProcessing) { modalProcessing.show(); }

                                $.ajax({
                                    type: "POST",
                                    url: "Reports.aspx/ApproveReport",
                                    data: "{'rptID': '" + record_id + "','puk': '" + puk + "'}",
                                    contentType: "application/json; charset=utf-8",
                                    dataType: "json",
                                    success: function (errorMessage) {
                                        if (modalProcessing) { modalProcessing.hide(); }
                                        row.css("background-color", "green");
                                        row.fadeOut(1000);
                                        row.remove();

                                        $("#<%=gridViewExpenses.ClientID %> tr").each(function () {
                                            $(this).remove();
                                        });
                                        if (errorMessage.d != '')
                                            myMsg(errorMessage.d , function () { return true; }, "Message");
                                        else {
                                            window.location.href = "Reports.aspx?msg=466";
                                        }
                                    },
                                    error: function () {
                                        myMsg("There was an error while approving report", function () { return true; }, "Error");
                                    }
                                });
                            },
                            function () { return false; }, $("#<%=hdnApprove.ClientID %>").val());

                        });

                        /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                        $(".rejectRpt").click(function () {
                            var record_id = $(this).attr("id") / 3;

                            var row = $(this).parent("td").parent('tr');
                            var puk = $("#<%=hdnPUK.ClientID %>").val();
                            var answer;

                            myConfirm($("#<%=hdnRejectRpt.ClientID %>").val(),
                                function () {
                                    promptReason(function () {
                                        answer = $("#txtReason").val();
                                        var modalProcessing = $find('modalProcessing');
                                        if (modalProcessing) { modalProcessing.show(); }

                                        document.body.style.cursor = "wait";
                                        $.ajax({
                                            type: "POST",
                                            url: "Reports.aspx/RejectReport",
                                            data: "{'rptID': '" + record_id + "','reason': '" + answer + "','puk': '" + puk + "'}",
                                            contentType: "application/json; charset=utf-8",
                                            dataType: "json",
                                            success: function (errorMessage) {
                                                if (modalProcessing) { modalProcessing.hide(); }
                                                row.css("background-color", "red");
                                                row.fadeOut(1000);
                                                row.remove();

                                                $("#<%=gridViewExpenses.ClientID %> tr").each(function () {
                                                    $(this).remove();
                                                });

                                                if (errorMessage.d != '')
                                                    myMsg(errorMessage.d, function () { return true; }, "Message");
                                                else {
                                                    window.location.href = "Reports.aspx?msg=464";
                                                }
                                            },
                                            error: function () {
                                                myMsg("There was an error while rejecting report", function () { return true; }, "Error");
                                            }
                                        });
                                        document.body.style.cursor = "default";
                                    },
                                      $("#<%=hdnReason.ClientID %>").val());
                                },
                                function () {
                                    return false;
                                },
                                $("#<%=hdnReject.ClientID %>").val());
                        });

                        /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                        $(".reverseRpt").click(function () {
                            var record_id = $(this).attr("id");

                            var row = $(this).parent("td").parent('tr');
                            var puk = $("#<%=hdnPUK.ClientID %>").val();
                            var answer;

                            myConfirm('Do you want to reverse this report?',
                                function () {

                                    document.body.style.cursor = "wait";
                                    $.ajax({
                                        type: "POST",
                                        url: "Reports.aspx/ReverseReport",
                                        data: "{'rptID': '" + record_id + "','puk': '" + puk + "'}",
                                        contentType: "application/json; charset=utf-8",
                                        dataType: "json",
                                        success: function (errorMessage) {
                                            row.css("background-color", "red");
                                            row.fadeOut(1000);
                                            row.remove();

                                            $("#<%=gridViewExpenses.ClientID %> tr").each(function () {
                                                $(this).remove();
                                            });

                                            if (errorMessage.d != '')
                                                myMsg(errorMessage.d, function () { return true; }, "Message");
                                            else {
                                                window.location.href = "Reports.aspx?msg=reversed";
                                            }
                                        },
                                        error: function () {
                                            myMsg("Error#1005: There was an unexpected error", function () { return true; }, "Error");
                                        }
                                    });
                                    document.body.style.cursor = "default";

                                },
                                function () {
                                    return false;
                                },
                                'Reject');
                        });
                        /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

                        $(".finalizeRpt").click(function () {
                            var record_id = $(this).attr("id");

                            var row = $(this).parent("td").parent('tr');
                            var msg = $("#<%=hdnFinalizeMessage.ClientID %>").val();
                            var msgTitle = $("#<%=hdnFinalizeTitle.ClientID %>").val();
                            var puk = $("#<%=hdnPUK.ClientID %>").val();

                            myConfirm(msg, function () {
                                var modalProcessing = $find('modalProcessing');
                                if (modalProcessing) { modalProcessing.show(); }

                                $.ajax({
                                    type: "POST",
                                    url: "Reports.aspx/FinalizeReport",
                                    data: "{'rptID': '" + record_id + "','puk': '" + puk + "'}",
                                    contentType: "application/json; charset=utf-8",
                                    dataType: "json",
                                    success: function (errorMessage) {
                                        if (modalProcessing) { modalProcessing.hide(); }
                                        row.css("background-color", "green");
                                        row.fadeOut(1000);
                                        row.remove();

                                        $("#<%=gridViewExpenses.ClientID %> tr").each(function () {
                                            $(this).remove();
                                        });

                                        if (errorMessage.d != '')
                                            myMsg(errorMessage.d, function () { return true; }, "Message");
                                        else {
                                            window.location.href = "Reports.aspx?msg=465";
                                        }
                                    },
                                    error: function () {
                                        myMsg("There was an error while finalizing report", function () { return true; }, "Error");
                                    }
                                });
                            },
                            function () { return false; }, msgTitle);
                        });
                        /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

                        $(".submitRpt").click(function () {
                            var record_id = $("#<%=hdnReportID.ClientID %>").val();
                            var puk = $("#<%=hdnPUK.ClientID %>").val();

                            myConfirm($("#<%=hdnSubmitMessage.ClientID %>").val(), function () {
                                var modalProcessing = $find('modalProcessing');
                                if (modalProcessing) { modalProcessing.show(); }

                                $.ajax({
                                    type: "POST",
                                    url: "Reports.aspx/SubmitReport",
                                    data: "{'rptID': '" + record_id + "','puk': '" + puk + "'}",
                                    contentType: "application/json; charset=utf-8",
                                    dataType: "json",
                                    success: function (returnVal) {
                                        if (modalProcessing) { modalProcessing.hide(); }

                                        if (returnVal.d["ErrorMessage"] == "") {
                                            window.location.href = "Reports.aspx?msg=284";
                                        }
                                        else {
                                            myMsg(returnVal.d["ErrorMessage"], function () { window.location.href = "Reports.aspx?msg=284"; }, returnVal.d["MessageTitle"]);
                                        }
                                    },
                                    error: function () {
                                        myMsg("There was an error while submitting report", function () { return true; }, "Error");
                                    }
                                });
                            },
                                function () { return false; }, $("#<%=hdnSubmitTitle.ClientID %>").val())
                        });
                        /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

                        $("#<%=cboCurr.ClientID %>").change(function () {

                            $("#<%=txtAmt.ClientID %>").keyup();

                            if ($("#<%=cboCurr.ClientID %>").val() != '25' && $("#<%=cboJur.ClientID %>").val() != '14') {
                                $("#<%=lblJurMsg.ClientID %>").text($("#<%=hdnCurrOutsideJur.ClientID %>").val());
                                $("#Row-JurMsg").fadeIn(300);
                            } else {
                                $("#Row-JurMsg").hide();
                            }
                        });
                        /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

                        $(".newExp").click(function () {
                            var record_id = $("#<%=hdnReportID.ClientID %>").val();
                            var puk = $("#<%=hdnPUK.ClientID %>").val();
                            document.body.style.cursor = "wait";

                            $("#Row-TitleAddExp").show();
                            $("#Row-TitleEditExp").hide();
                            $("#Row-Attendees").hide();
                            $("#Row-Msg").hide();
                            $("#Row-ExpMsg").hide();
                            $("#Row-GST").hide();
                            $("#Row-QST").hide();
                            $("#Row-Project").hide();
                            $("#Row-CostCenter").hide();

                            $("#Receipts").css('visibility', 'hidden');
                            $("#<%=RequiredFieldValidator4.ClientID %>").css('display', 'none');
                            $("#<%=AmtRequired.ClientID %>").css('display', 'none');
                            $("#<%=cmdSaveExpense2.ClientID %>").show();
                            $("#<%=cmdSaveExpense.ClientID %>").removeAttr('disabled');
                            $("#<%=cmdSaveExpense2.ClientID %>").removeAttr('disabled');
                            $('#<%=chkDontReimburse.ClientID %>').attr('checked', false);
                            $("#<%=cboTP.ClientID %>").hide();
                            $("#<%=cboTaxIE.ClientID %>").val('1');
                            $("#<%=txtComment.ClientID %>").prop('disabled', false);

                            $("#<%=txtExpenseID.ClientID %>").val(0);
                            $("#<%=cboCat.ClientID %>").prop('disabled', false);
                            $("#<%=txtAmt.ClientID %>").prop('disabled', false);
                            $("#<%=txtKm.ClientID %>").prop('disabled', false);
                            $("#<%=txtGST.ClientID %>").prop('disabled', true);
                            $("#<%=txtQST.ClientID %>").prop('disabled', true);
                            $("#Cell-RemoveAttachment").hide();

                            $("#<%=txtTotal.ClientID %>").val('0.00');
                            $("#<%=txtGST.ClientID %>").val('0.00');
                            $("#<%=txtQST.ClientID %>").val('0.00');

                            $("#Row-HST").hide();
                            $("#Row-QST").hide();
                            $("#Row-Rate").hide();
                            $("#Row-KM").hide();
                            $("#Row-Supplier").hide();
                            $("#Row-Grat").hide();
                            $("#Row-TaxRate").hide();
                            $("#Row-Jur").hide();
                            $("#Row-Grat").hide();
                            $("#Row-KM").hide();
                            $("#Row-Rate").hide();

                            $.ajax({
                                type: "POST",
                                url: "Reports.aspx/GetReport",
                                data: "{'rptID': '" + record_id + "','puk': '" + puk + "'}",
                                contentType: "application/json; charset=utf-8",
                                dataType: "json",
                                success: function (rpt) {
                                    var report = rpt.d;

                                    $("#<%=txtExpDate.ClientID %>").val(report["CreatedDate"]);
                                    $("#<%=hdnExpDate.ClientID %>").val(report["CreatedDate"]);
                                    $("#<%=txtReportName.ClientID %>").val(report["ReportName"]);
                                    $("#<%=cboJur.ClientID %>").val(report["JurisdictionID"]);
                                    $("#<%=cboCat.ClientID %>").prop('selectedIndex', 0);
                                    $("#<%=cboProject.ClientID %>").val(report["Project"]);
                                    $("#<%=txtAmt.ClientID %>").val('');
                                    $("#<%=txtKM.ClientID %>").val('');
                                    $("#<%=cboRate.ClientID %>").val('');
                                    $("#<%=txtComment.ClientID %>").val('');
                                    $("#<%=cboCurr.ClientID %>").prop('selectedIndex', 24); //select canadian currency by default
                                    $("#<%=txtGrat.ClientID %>").val('');
                                    $("#<%=txtSupplier.ClientID %>").val('');

                                    var mpe = $find('modalCreateExpense');
                                    if (mpe) { mpe.show(); }
                                    document.body.style.cursor = "default";

                                },
                                error: function () {
                                    myMsg("Error#1006: There was an unexpected error", function () { return true; }, "Error");
                                }
                            });
                        });
                        /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

                        $(".printRpt").click(function () { popup("ExpenseReport.aspx?id=" + $(this).attr("id")); });
                        /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

                        $(".editRpt").click(function () {

                            var modalCreateReport = $find('modalCreateReport');
                            var record_id = $(this).attr("id");
                            var puk = $("#<%=hdnPUK.ClientID %>").val();
                            $("#<%=hdnReportIDEdit.ClientID %>").val(record_id);

                            $.ajax({
                                type: "POST",
                                url: "Reports.aspx/GetReport",
                                data: "{'rptID': '" + record_id + "','puk': '" + puk + "'}",
                                contentType: "application/json; charset=utf-8",
                                dataType: "json",
                                success: function (rpt) {
                                    var report = rpt.d;

                                    $("#<%=txtReportName.ClientID %>").val(report["ReportName"]);
                                    if (modalCreateReport) { modalCreateReport.show(); }
                                },
                                error: function () {
                                    myMsg("Error#1007: There was an unexpected error", function () { return true; }, "Error");
                                }
                            });
                        });
                        /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

                        $(".newRpt").click(function () {
                            var mpe = $find('modalCreateReport');

                            $("#<%=hdnReportIDEdit.ClientID %>").val('0');
                            if (mpe) { mpe.show(); }
                        });

                        /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

                        $(".cancelRpt").click(function () {
                            var mpe = $find('modalCreateReport');
                            $("#<%=txtReportName.ClientID %>").val('');
                            if (mpe) { mpe.hide(); }
                        });
                        /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

                        $("#<%=FileUpload1.ClientID %>").change(function () {
                            var f = $("#<%=FileUpload1.ClientID %>").val().toUpperCase();
                            var fType = f.substr(f.length - 3);
                            $("#<%=cmdSaveExpense.ClientID %>").removeAttr('disabled');
                            $("#<%=cmdSaveExpense2.ClientID %>").removeAttr('disabled');

                            switch (fType) {
                                case 'JPG':
                                    $("#Row-FileError1").hide();
                                    break;
                                case 'JPEG':
                                    $("#Row-FileError1").hide();
                                    break;
                                case 'GIF':
                                    $("#Row-FileError1").hide();
                                    break;
                                case 'PNG':
                                    $("#Row-FileError1").hide();
                                    break;
                                case 'PDF':
                                    $("#Row-FileError1").hide();
                                    break;
                                case 'HTM':
                                    $("#Row-FileError1").hide();
                                    break;
                                case 'HTML':
                                    $("#Row-FileError1").hide();
                                    break;
                                default:
                                    $("#Row-FileError1").show();
                                    $("#<%=cmdSaveExpense.ClientID %>").prop('disabled', 'disabled');
                                    $("#<%=cmdSaveExpense2.ClientID %>").prop('disabled', 'disabled');
                            }

                        });

                        /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                        $("#<%=FileUpload2.ClientID %>").change(function () {
                            var f = $("#<%=FileUpload2.ClientID %>").val().toUpperCase();
                            var fType = f.substr(f.length - 3);
                            $("#<%=cmdAttachFile.ClientID %>").removeAttr('disabled');

                            switch (fType) {
                                case 'JPG':
                                    $("#Row-FileError2").hide();
                                    break;
                                case 'JPEG':
                                    $("#Row-FileError2").hide();
                                    break;
                                case 'GIF':
                                    $("#Row-FileError2").hide();
                                    break;
                                case 'PNG':
                                    $("#Row-FileError2").hide();
                                    break;
                                case 'PDF':
                                    $("#Row-FileError2").hide();
                                    break;
                                case 'HTM':
                                    $("#Row-FileError2").hide();
                                    break;
                                case 'HTML':
                                    $("#Row-FileError2").hide();
                                    break;
                                default:
                                    $("#Row-FileError2").show();
                                    $("#<%=cmdAttachFile.ClientID %>").prop('disabled', 'disabled');
                            }
                        });
                        /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

                        $(".cancelExp").mousedown(function () {

                            if (getQuerystring('rID', 0) != 0) window.location = 'reports.aspx';
                            var mpe = $find('modalCreateExpense');
                            if (mpe) { mpe.hide(); }
                            $("#<%=FileUpload1.ClientID %>").val('');
                            $("#Row-FileError1").hide();
                            $("#ExpMsg").css('height', '50px');
                            $("#<%=lblExpMsg.ClientID %>").text('');
                            $("#Row-ExpMsg").hide();
                        });


                        /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                        $(".viewReceipt").mousedown(function () {
                            var id = $(this).attr("id");
                            window.open("Receipt.aspx?id=" + id, "Receipt", "width=1000,height=600,toolbar=yes,scrollbars=yes");
                        });


                        /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                        $(".attachReceipt").mousedown(function () {
                            $("#<%=hdnExpenseID.ClientID %>").val($(this).attr("id"));

                            var mpe = $find('modalAttachReceipt');
                            if (mpe) { mpe.show(); }
                        });

                        /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                        $(".cancelAttach").mousedown(function () {
                            $("#<%=FileUpload2.ClientID %>").val('');
                            $("#Row-FileError2").hide();
                            var mpe = $find('modalAttachReceipt');
                            if (mpe) { mpe.hide(); }
                        });
                        /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

                        $(".delReceipt").click(function () {
                            var record_id = $("#<%=txtExpenseID.ClientID %>").val();
                            var puk = $("#<%=hdnPUK.ClientID %>").val();

                            if (confirm($("#<%=hdnDeleteReceipt.ClientID %>").val())) {
                                $.ajax({
                                    type: "POST",
                                    url: "Reports.aspx/DeleteReceipt",
                                    data: "{'expID': '" + record_id + "','puk': '" + puk + "'}",
                                    contentType: "application/json; charset=utf-8",
                                    dataType: "json",
                                    success: function () {
                                        if (getQuerystring('submitted', '0') == '1')
                                            window.location = "Reports.aspx?submitted=1&action=receitdeleted";
                                        else
                                            window.location = "Reports.aspx?action=receitdeleted";

                                    },
                                    error: function () {
                                        myMsg("Error#1008: There was an unexpected error", function () { return true; }, "Error");
                                    }
                                });
                            }
                        });
                        /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

                        $(".getDates").click(function () {
                            var record_id = $(this).attr("id");
                            var puk = $("#<%=hdnPUK.ClientID %>").val();

                            $.ajax({
                                type: "POST",
                                url: "Reports.aspx/getDates",
                                data: "{'rptID': '" + record_id + "','puk': '" + puk + "'}",
                                contentType: "application/json; charset=utf-8",
                                dataType: "json",
                                success: function (sDates) {

                                    if (document.getElementById("dates")) {
                                        var vChild = document.getElementById("dates");
                                        document.getElementById("dialog").removeChild(vChild);
                                    }

                                    $("<div id='dates'>" + sDates.d + "</div>").appendTo("#dialog");
                                    $("#dialog").dialog("open");
                                },
                                error: function (xhr) {
                                    myMsg("Error#1009: There was an unexpected error", function () { return true; }, "Error");
                                }
                            });
                        });
                        /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

                        $(".unlockGST").mousedown(function () {
                            //$("#<%=txtComment.ClientID %>").val('GST was modified - ' + prompt("What is the reason for modifying the GST:"));

                            //if ($("#<%=txtComment.ClientID %>").val().trim() != '') {
                            //    $("#<%=txtComment.ClientID %>").prop('readonly', true);
                            $("#<%=txtGST.ClientID %>").prop('disabled', false);
                            $("#<%=hdnUnlockGST.ClientID %>").val('Yes');
                            //}
                        });
                        /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

                        $(".unlockQST").mousedown(function () {
                            //$("#<%=txtComment.ClientID %>").val('QST was modified - ' + prompt("What is the reason for modifying the QST:"));

                            //if ($("#<%=txtComment.ClientID %>").val().trim() != '') {
                            //    $("#<%=txtComment.ClientID %>").prop('readonly', true);
                            $("#<%=txtQST.ClientID %>").prop('disabled', false);
                            $("#<%=hdnUnlockQST.ClientID %>").val('Yes');
                            //}
                        });
                        /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

                        $(".selected").click(function () {
                            alert('selected');
                        });

                        /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

                        //$('#<%= lbl72.ClientID%>').on('click', startGuidelinesTour);
                        function readURL(input) {

                            if (input.files && input.files[0]) {
                                var extension = input.files[0].name.substring(input.files[0].name.lastIndexOf('.') + 1);

                                if (extension === "jpg" || extension === "png" || extension === "gif") {
                                    var reader = new FileReader();

                                    //if the right column is not already visible we must animate it into view
                                    if (!$('.rightColumn').is(':visible')) {
                                        $("#<%=pnlCreateExpense.ClientID %>").animate({ width: '850px' }, 500);
                                        $('.rightColumn').css('width', '30%');
                                        $('.leftColumn').css('width', '70%');
                                        $('.rightColumn').show();
                                    }

                                    reader.onload = function (e) {
                                        $('#uploadedReceipt').attr('src', e.target.result);
                                        $('#uploadedReceipt').show();
                                    }

                                    reader.readAsDataURL(input.files[0]);
                                } else {
                                    if ($('.rightColumn').is(':visible')) {
                                        $('.leftColumn').css('width', '100%');
                                        $('.rightColumn').css('width', '0%');
                                        $('.rightColumn').hide();
                                        $("#<%=pnlCreateExpense.ClientID %>").animate({ width: '600px' }, 500);

                                    }
                                    $('#uploadedReceipt').hide();
                                }
                            }
                        }
                        /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
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



