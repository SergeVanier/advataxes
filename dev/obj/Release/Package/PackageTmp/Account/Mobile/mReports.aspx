<%@ Page Language="vb"  AutoEventWireup="true" CodeBehind="mReports.aspx.vb" Inherits="Advataxes.mReports" %>

<%@ Register assembly="System.Web.Entity, Version=3.5.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089" namespace="System.Web.UI.WebControls" tagprefix="asp" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="act" %>

<html>
<head>
<title></title>
        <meta name="HandheldFriendly" content="True" />
        <meta name="MobileOptimized" content="320" />
        <meta name="viewport" content="width=500" />

        <link type="text/css" href="../../css/sunny/jquery-ui-1.8.23.custom.css" rel="stylesheet" /> 
        <link href="../../css/style3.css" rel="stylesheet" type="text/css" />
        <script type="text/javascript" src="../../js/jquery-1.7.2.min.js"></script>
        <script type="text/javascript" src="../../js/jquery-ui-1.8.18.custom.min.js"> </script>
        <script type="text/javascript" src="../../js/jquery.js" />


   
 </head>         

<body>
<form id="form1" runat="server">
    <div style="width:100%;">
        <asp:ScriptManager id="ScriptManager1" runat="server" /> 

        <table width="100%" border=0 style="border-collapse:collapse;">
            <tr><td><a href="menu.aspx"><img src="../../images/menu.png" /></a></td><td width="65%"><a href="../../loggedout.aspx?m=1"><img src="../../images/mlogout.png" /></a></td><td align="right"><img src="../../images/av.png" width="60px" /></td></tr>
            <tr style=" border-bottom: solid #cd1e1e;"><td colspan="3"></td></tr>
        </table>

        <%If IsNothing(Session("msgHeight")) Then Session("msgHeight") = "25px"%>
 	    <div id="msg" class="ui-widget">
		    <div class="ui-state-highlight ui-corner-all" style="margin-top: 20px; padding: 0 .7em; height:<%=session("msgHeight")%>;"> 
			    <p style="position:relative;top:-15px;"><span class="ui-icon ui-icon-info" style="float: left; margin-right: .3em;"></span>
                    <input id="txtMsg" type="text" style="width:300px;border:none;background-color:transparent;" /></p>
		    </div>
	    </div>

        <% If Not IsNothing(Session("msg")) And Session("msg") <> "" Then%>
 	        <div id="msg2" class="ui-widget">
		        <div class="ui-state-highlight ui-corner-all" style="margin-top: 20px; padding: 0 .7em; height:<%=session("msgHeight")%>;"> 
			        <p style="position:relative;top:-10px;"><span class="ui-icon ui-icon-info" style="float: left; margin-right: .3em;"></span>
			          <asp:Label ID="lblMsg2" runat="server" ><%=Session("msg")%></asp:Label></p>
		        </div>
	        </div>
            <%Session("msg") = Nothing%>
        <% End If%>
        <%Session("msgHeight") = Nothing%>

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
        <br />
        <table width="100%" border=0>
        <tr>
            <td width="50px" style=" color:#cd1e1e; font-size:x-large ;"><asp:Label ID="lbl71" runat="server" Text="Reports"></asp:Label></td>
            <td class="style11" valign="middle">
                <asp:ImageButton ID="dummy" runat="server" visible="false" />
                
                <a id="btnNewReport" href="#" class="newRpt" title="New Report" ><img src="/images/new.png" /></a>
                &nbsp;&nbsp;&nbsp;<a id="btnSubmit" href="#" class="submitRpt"><img src="/images/submit.png" title="<%=hdnSubmitTooltip.value %>" /></a> 
                <!--<asp:ImageButton ID="cmdDelete" runat="server"  ImageUrl="/images/cmdDelete.png" Height="33px" Width="87px" Visible="False" CausesValidation="false" />-->
            </td>
            
            <td>
                
            </td>
            
            <td width="50px">
            
            </td>
        </tr>
    </table>
 
    <div style="height:960px;">
        <asp:GridView ID="gvReports" runat="server"
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
            EmptyDataText="check desktop login to view reports"
            ShowHeaderWhenEmpty="True" 
            ViewStateMode="Enabled" Font-Size=small>

            <AlternatingRowStyle CssClass="alt"></AlternatingRowStyle>
            <Columns>
                <asp:CommandField ItemStyle-ForeColor="Black" ShowSelectButton="true" ButtonType="Image"  SelectImageUrl="/images/select.png" SelectText="<%=hdnSelectTooltip.value %>" ItemStyle-Width="3%"/>                      
                
                <asp:TemplateField ItemStyle-Width="15px" ItemStyle-ForeColor="Black" Visible="false" >
                      <HeaderStyle CssClass="EditColumnHeader" />
                    <ItemTemplate><a href="#" id='<%# Eval("REPORT_ID") %>' class="editRpt" title="<%=hdnEditTooltip.value %>"> <%# IIf(Eval("STATUS_ID") = 1 Or (Eval("STATUS_ID") = 2 And Request.QueryString("e") = 1), "<img  border='0' src='../../images/edit.png' alt='Edit' />", "")%></a></ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField ItemStyle-Width="15px" ItemStyle-ForeColor="Black" Visible="false">
                    <HeaderStyle CssClass="ViewReportColumnHeader" />
                    <ItemTemplate>
                        <a href="#" id='<%# Eval("REPORT_ID") %>' class="printRpt" title="<%=hdnViewExpRptTooltip.value %>"> <img  border="0" src="../../images/viewreport.png" alt="View Expense Report" width="22px" height="22px" /></a>                        
                    </ItemTemplate>
                </asp:TemplateField>
               
                <asp:BoundField  ItemStyle-ForeColor="black" DataField="REPORT_NAME" HeaderText="74" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left" />
  
                <asp:TemplateField ItemStyle-Width="150px" HeaderText="77" ItemStyle-ForeColor="Black" ItemStyle-HorizontalAlign="Center">
                    <ItemTemplate >
                        <%# IIf(Eval("STATUS_ID") = 1, Eval("CREATED_DATE", "{0:dd/MM/yyyy}"), "")%>                        
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

                <asp:TemplateField ItemStyle-HorizontalAlign="Right"  ItemStyle-Width="15px">
                    <ItemTemplate><a href="#" id='<%# Eval("REPORT_ID")*4 %>' class="delReport"><%# IIf(Eval("STATUS_ID") = 1, "<img  border='0' src='../../images/del.png' alt='Delete' />", "")%> </a></ItemTemplate>
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
                <td id="Cell-NewExp">&nbsp;&nbsp;<a id="cmdNewExp" href="#" class="newExp"><img src="../../images/new.png"  title="<%=hdnAddExpTooltip.value %>" /></a></td>
                <td id="Cell-ReportTitle" style="color:#cd1e1e; font-weight:bold;"><asp:Label runat="server" ID="labelReportName"></asp:Label></td>
                <td></td>
                <td></td>
            </tr>
        </table>
       
       <div style="overflow:auto;height:850px;width:100%;" >
            <asp:GridView ID="gvExpenses" runat="server" 
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
                EmptyDataText="check desktop login to view expenses" 
                ShowHeader="true"
                ShowHeaderWhenEmpty="True" 
                DataKeyNames="EXPENSE_ID" Font-Size="Small">
        
                <Columns>
                    <asp:TemplateField  ItemStyle-Width="10px">
                        <ItemTemplate>
                            <a href="#" id='<%# Eval("EXPENSE_ID") %>' class="expandExp" title="Expand for more details" ><img  border="0" src="../../images/plus<%# iif(EVAL("COMMENT")="" AND EVAL("ATTENDEES")="","2","") %>.png" alt="Expand to view comment" style="<%# iif(EVAL("COMMENT")="" AND EVAL("ATTENDEES")="","display:none;","") %>" /></a>
                            <a href="#" id='<%# Eval("EXPENSE_ID")*2 %>' class="collapseExp" title="Collapse"> <img  border="0" src="../../images/minus.png" alt="Collapse" /></a>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField  ItemStyle-Width="15px">
                        <ItemTemplate>
                            <% If txtStatusID.Text = "1" Or txtStatusID.Text = "5" Or (txtStatusID.Text = "2" And Request.QueryString("e") = 1) Then%>
                                <a href="#" id='<%# Eval("EXPENSE_ID")*3 %>' class="editExp" title="<%=hdnEditTooltip.value %>"> <img  border="0" src="../../images/edit.png" alt="Edit" /></a>
                            <% End If%>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField  ItemStyle-Width="15px">
                        <ItemTemplate>
                            <%If Session("language") = "English" Then%>
                                <a href="#" id='<%# EVAL("EXPENSE_ID") %>' class="<%# iif(isdbnull(EVAL("RECEIPT_TYPE")),"attachReceipt","viewReceipt")%>" title="<%# iif(isdbnull(EVAL("RECEIPT_TYPE")),"Attach Receipt","View Receipt")%>"> <img  border="0" src="../../images/<%# iif(isdbnull(EVAL("RECEIPT_TYPE")),"attachment1","attachment2")%>.png" alt="<%# iif(isdbnull(EVAL("RECEIPT_TYPE")),"Attach Receipt","View Receipt")%>" /></a>
                            <%Else%>
                                <a href="#" id='<%# EVAL("EXPENSE_ID") %>' class="<%# iif(isdbnull(EVAL("RECEIPT_TYPE")),"attachReceipt","viewReceipt")%>" title="<%# iif(isdbnull(EVAL("RECEIPT_TYPE")),"Joindre un reçu","Voir reçu")%>"> <img  border="0" src="../../images/<%# iif(isdbnull(EVAL("RECEIPT_TYPE")),"attachment1","attachment2")%>.png" alt="<%# iif(isdbnull(EVAL("RECEIPT_TYPE")),"Joindre un reçu","Voir reçu")%>" /></a>
                       
                            <%end if %>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:BoundField  DataField="EXP_DATE" HeaderText="59" SortExpression="EXP_DATE"  ItemStyle-ForeColor="Black" DataFormatString="{0:dd'/'MM'/'yyyy}" ItemStyle-Width="75px" ItemStyle-HorizontalAlign="Center" />

                    
                    <asp:BoundField DataField="CAT_NAME" HeaderText="60" ItemStyle-ForeColor="Black" ItemStyle-Width="400px" HeaderStyle-HorizontalAlign="Left" />
                    <asp:BoundField ItemStyle-Width="100px"  DataField="SUPPLIER_NAME" HeaderText="61"  ItemStyle-ForeColor="Black"  ItemStyle-HorizontalAlign="Center" />            
                    <asp:BoundField ItemStyle-Width="50px"  DataField="JUR_NAME" HeaderText="62" ItemStyle-ForeColor="Black" ItemStyle-HorizontalAlign="Center" />
                    
                    <asp:TemplateField HeaderText="63"  ItemStyle-Width="100px"  ItemStyle-ForeColor="black" ItemStyle-HorizontalAlign="Right">
                        <ItemTemplate><asp:Label ID="Label1" runat="server" Text='<%# IIf(New List(Of String)(New String() {"taxi", "meals & entertainment", "meals & entertainment*", "meals & entertainment (work site + 30 km from a 40k urban area)"}).Contains(Eval("CAT_NAME").ToString().ToLower()), IIf(Eval("GRATUITIES") = 0, IIf(Eval("RATE") < 1, FormatNumber(Eval("AMOUNT") / Eval("RATE"), 0) & " x " & FormatNumber(Eval("RATE"), 2), ""), FormatNumber(Eval("GRATUITIES"), 2)), "")  %>'></asp:Label></ItemTemplate>
                    </asp:TemplateField>

                    <asp:BoundField  DataField="AMT_BEFORE_TAX" HeaderText="64" ItemStyle-ForeColor="Black" DataFormatString="{0:F}" ItemStyle-Width="75px" ItemStyle-HorizontalAlign="Right" />
                    <asp:BoundField  DataField="GST_PAID" HeaderText="65" ItemStyle-ForeColor="Black" DataFormatString="{0:F}" ItemStyle-Width="60px" ItemStyle-HorizontalAlign="Right" />
                    <asp:BoundField  DataField="QST_PAID" HeaderText="66" ItemStyle-ForeColor="Black" DataFormatString="{0:F}" ItemStyle-Width="40px" ItemStyle-HorizontalAlign="Right" />
                    <asp:BoundField  DataField="AMOUNT" HeaderText="67" ItemStyle-ForeColor="Black" DataFormatString="{0:F}" ItemStyle-Width="100px" ItemStyle-HorizontalAlign="Right" />
                    <asp:BoundField  DataField="CURR_SYM" HeaderText="68" ItemStyle-ForeColor="Black"  ItemStyle-Width="15px" ItemStyle-HorizontalAlign="Center" />
            
                    <asp:TemplateField  ItemStyle-Width="15px">
                        <ItemTemplate><a href="#" id='<%# Eval("EXPENSE_ID") %>' class="delExpense"><%# IIf(Eval("STATUS_ID") = 1 Or (Eval("STATUS_ID") = 2 And Request.QueryString("e") = 1), "<img  border='0' src='../../Images/del.png' alt='Delete' />", "")%></a></ItemTemplate>
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
     <act:ModalPopupExtender ID="modalAttachReceipt" runat="server"
                TargetControlID="cmdDummy"
                PopupControlID="pnlAttachReceipt"
                PopupDragHandleControlID="pnlAttachReceipt"
                DropShadow="false" Drag="false" RepositionMode="None"
                BackgroundCssClass="modalBackground" 
                BehaviorID="modalAttachReceipt" />

    <asp:Panel ID="pnlAttachReceipt" runat="server" CssClass="modalPopup" style="display:none" Width="400px">
            <div style="margin:10px">            
                <table width="100%" border=0>
                    <tr><td colspan="10"><table width="100%"><tr><td  style="color:#cd1e1e; font-size:larger; font-size:1.5em;">Attach File</td><td align="right"><img src="../../images/av.png" width="50px" height="40px"/></td></tr></table></td></tr>
                    <tr style=" background-color:#cd1e1e;height:2px;"><td></td></tr>
                    <tr style="height:20px;"><td></td></tr>
                    <tr><td colspan="2">File:<asp:FileUpload ID="FileUpload2" runat="server" Width="100%" size="40" Height="25px" /></td></tr>
                    <tr id="Row-FileError"><td colspan="2"><asp:Label ID="Label2" runat="server" ForeColor="#cd1e1e" Font-Bold="true" Text="Invalid file type, supported files include jpg, png, gif, pdf, htm/html"></asp:Label></td></tr>
                    <tr style="height:40px;"><td align="right"><br /><asp:Button ID="cmdAttachFile" runat="server" Text="Save" Height="30px" class="button1" CausesValidation="true" ValidationGroup="Attach" UseSubmitBehavior="true" /><asp:Button ID="cmdCancelAttach" runat="server" Text="Cancel" class="cancelAttach" UseSubmitBehavior="false"  Height="30px" Width="20%" /></td></tr>
                    
                </table>

                
            </div>

    </asp:Panel>    
  
    <asp:Panel ID="pnlProcessing" runat="server" CssClass="modalPopup" Width="300px">
            <div class="labelText" style="margin:10px">
                <table width="100%"><tr><td><img src="../../images/busy.gif" /></td><td align="center" class="labelText"><asp:Label ID="lbl285" runat="server" Text="Processing, please wait ..."></asp:Label></td></tr></table>
           
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
    <asp:HiddenField id="hdnSaveText" runat="server" />
    <asp:HiddenField ID="hdnGST" runat="server" />
    <asp:HiddenField ID="hdnQST" runat="server" />
    <asp:HiddenField ID="hdnReportIDEdit" runat="server" />
    <asp:HiddenField ID="hdnCatID" runat="server" Value="0"  />
    <asp:HiddenField ID="hdnPUK" runat="server" Value="0"  />
    <asp:HiddenField ID="hdnLoggedInEmpID" runat="server" Value="0"  />
    <asp:HiddenField ID="hdnExpDate" runat="server" Value="0"  />
    <asp:HiddenField ID="hdnLimit" runat="server" Value="0"  />

<!-----------------------------------------------MODAL POPUP EXTENDERS----------------------------------------------------------->
           <act:ModalPopupExtender ID="modalProcessing" runat="server"
                TargetControlID="cmddummy"
                PopupControlID="pnlProcessing"
                PopupDragHandleControlID="pnlProcessing"
                DropShadow="false"
                BackgroundCssClass="modalBackground"
                BehaviorID="modalProcessing" />

<!-----------------------------------------------DATA SOURCES------------------------------------------------------------------->
            
            
            <asp:SqlDataSource ID="sqlReportsByEmpID" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:dbadvaloremConnStr %>" 
                    SelectCommand="GetReportsByEmpID" SelectCommandType="StoredProcedure"
                    FilterExpression="STATUS_NAME like'{0}%'">
                             
                <SelectParameters>
                     <asp:SessionParameter Name="EmpID" SessionField="selectedEmpID" Type="Int32" />                   
                 </SelectParameters>
         
               <FilterParameters>
                    <asp:Parameter Name="STATUS_NAME" DefaultValue="Open" />                    
                </FilterParameters>
            </asp:SqlDataSource>
    
            <asp:SqlDataSource ID="sqlGetExpenses" runat="server" 
                ConnectionString="<%$ ConnectionStrings:dbadvaloremConnStr %>" 
                SelectCommand="GetExpenses2"
                 SelectCommandType="StoredProcedure">

                <SelectParameters>
                    <asp:ControlParameter ControlID="gvReports" Name="ReportID" 
                        PropertyName="SelectedValue" Type="Decimal" />
                </SelectParameters>

                <SelectParameters>
                     <asp:SessionParameter SessionField="language" Name="language" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>            
                         
               
<!----------------------------------------------------------------------------------------------------------------------------->
    
    <div id="dialog" title="Dates"></div>
            
    <table>
        <tr id="dummytable"><td><asp:Button ID="cmdDummy" runat="server" Text="Button"  /></td></tr>
    </table>

    </div>
    
    </form>


                <script type="text/javascript">
                    function showProcessing() {
                        var mpe = $find('modalProcessing');
                        if (mpe) { mpe.show(); }
                    }

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
                            title: dialogTitle || 'Message',
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
                        $('#msg').hide();

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

                        if ($("#<%= hdnOpenReport.ClientID %>").val() == "True") {
                            $("#Cell-NewExp").show();
                            $("#Cell-ReportTitle").show();
                            $("#btnSubmit").show();
                            $("#btnNewReport").hide();
                        }
                        else {
                            $("#Cell-NewExp").hide();
                            $("#Cell-ReportTitle").hide();
                            $("#btnSubmit").hide();
                            $("#btnNewReport").show();
                        }

                        $("#dummytable").hide();

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

                            if (today > maxDate) today = maxDate;

                            return today;
                        }

                        $(".mGrid a.collapseExp").each(function () {
                            $(this).hide();
                        });


                        $(".editExp").click(function () {
                            var record_id = $(this).attr("id") / 3;
                            window.location = "AddExpense.aspx?expID=" + record_id;

                        });


                        $(".expandExp").click(function () {
                            var record_id = $(this).attr("id");
                            $(this).hide();
                            $("#" + record_id * 2).show();

                            var row = $(this).parent("td").parent('tr');

                            $.ajax({
                                type: "POST",
                                url: "mReports.aspx/GetOtherExpenseDetails",
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
                                },
                                error: function () {
                                    myMsg("Err1001: There was an unexpected error", function () { return true; }, "Error");
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
                                row.remove();
                            });
                        });


                        $(".delExpense").click(function () {
                            var record_id = $(this).attr("id");
                            
                            var row = $(this).parent("td").parent('tr');
                            var puk = $("#<%=hdnPUK.ClientID %>").val();

                            myConfirm("Do you want to delete this expense?",
                                function () {
                                    $.ajax({
                                        type: "POST",
                                        url: "mReports.aspx/DeleteExpense",
                                        data: "{'expID': '" + record_id + "','puk': '" + puk + "'}",
                                        contentType: "application/json; charset=utf-8",
                                        dataType: "json",
                                        success: function () {
                                            row.css("background-color", "red");
                                            row.fadeOut(1000, function () {
                                                row.remove();
                                            });

                                            $("#msg2").hide();
                                            $("#msg").show();
                                            $("#txtMsg").val("Expense was deleted");
                                        },
                                        error: function () {
                                            myMsg("There was an error while deleting expense", function () { return true; }, "Error");
                                        }
                                    });
                                },
                                function () { return false; }, "Delete");
                        });


                        $(".delReport").click(function () {
                            var record_id = $(this).attr("id") / 4;
                            
                            var row = $(this).parent("td").parent('tr');
                            var puk = $("#<%=hdnPUK.ClientID %>").val();

                            myConfirm($("#<%=hdnDeleteRptMsg.ClientID %>").val(), function () {
                                $.ajax({
                                    type: "POST",
                                    url: "mReports.aspx/DeleteReport",
                                    data: "{'rptID': '" + record_id + "','puk': '" + puk + "'}",
                                    contentType: "application/json; charset=utf-8",
                                    dataType: "json",
                                    success: function () {
                                        $("#<%=gvexpenses.ClientID %> tr:not(:first-child)").html("");
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
                                        $("#txtMsg").val('Report was deleted');

                                    },
                                    error: function () {
                                        myMsg("There was an error deleting report", function () { return true; }, "Error");
                                    }
                                });
                            },
                            function () { return false; }, $("#<%=hdnDeleteRptTitle.ClientID %>").val());
                        });


                        $(".approveRpt").click(function () {
                            var record_id = $(this).attr("id") / 2;
                            
                            var row = $(this).parent("td").parent('tr');

                            myConfirm("Do you want to approve this report?", function () {
                                var mpe = $find('modalProcessing');
                                if (mpe) { mpe.show(); }

                                $.ajax({
                                    type: "POST",
                                    url: "Reports.aspx/ApproveReport",
                                    data: "{'rptID': '" + record_id + "'}",
                                    contentType: "application/json; charset=utf-8",
                                    dataType: "json",
                                    success: function (msg) {
                                        if (mpe) { mpe.hide(); }
                                        row.css("background-color", "green");
                                        row.fadeOut(1000);
                                        row.remove();

                                        $("#<%=gvexpenses.ClientID %> tr").each(function () {
                                            $(this).remove();
                                        });

                                        if (msg.d != '')
                                            myMsg(msg.d, function () { return true; }, "Message");
                                        else {
                                            $("#<%=lblMsg2.ClientID %>").val('Approved');
                                        }
                                    },
                                    error: function () {
                                        myMsg("There was an error while approving report", function () { return true; }, "Error");
                                    }
                                });
                            },
                            function () { return false; }, "Approve");

                        });

                        $(".rejectRpt").click(function () {
                            var record_id = $(this).attr("id") / 3;
                            
                            var row = $(this).parent("td").parent('tr');
                            var puk = $("#<%=hdnPUK.ClientID %>").val();
                            var answer;

                            myConfirm('Do you want to reject this report?',
                                function () {
                                    promptReason(function () {
                                        answer = $("#txtReason").val();
                                        var mpe = $find('modalProcessing');
                                        if (mpe) { mpe.show(); }

                                        document.body.style.cursor = "wait";
                                        $.ajax({
                                            type: "POST",
                                            url: "Reports.aspx/RejectReport",
                                            data: "{'rptID': '" + record_id + "','reason': '" + answer + "','puk': '" + puk + "'}",
                                            contentType: "application/json; charset=utf-8",
                                            dataType: "json",
                                            success: function (msg) {
                                                if (mpe) { mpe.hide(); }
                                                row.css("background-color", "red");
                                                row.fadeOut(1000);
                                                row.remove();

                                                $("#<%=gvexpenses.ClientID %> tr").each(function () {
                                                    $(this).remove();
                                                });

                                                if (msg.d != '')
                                                    myMsg(msg.d, function () { return true; }, "Message");
                                                else {
                                                    window.location.href = "Reports.aspx?msg=rejected";
                                                }
                                            },
                                            error: function () {
                                                myMsg("There was an error while rejecting report", function () { return true; }, "Error");
                                            }
                                        });
                                        document.body.style.cursor = "default";
                                    },
                                     'Reason');
                                },
                                function () {
                                    return false;
                                },
                                'Reject');
                        });

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
                                        success: function (msg) {
                                            if (mpe) { mpe.hide(); }
                                            row.css("background-color", "red");
                                            row.fadeOut(1000);
                                            row.remove();

                                            $("#<%=gvexpenses.ClientID %> tr").each(function () {
                                                $(this).remove();
                                            });

                                            if (msg.d != '')
                                                myMsg(msg.d, function () { return true; }, "Message");
                                            else {
                                                window.location.href = "Reports.aspx?msg=reversed";
                                            }
                                        },
                                        error: function () {
                                            myMsg("Err1002: There was an unexpected error", function () { return true; }, "Error");
                                        }
                                    });
                                    document.body.style.cursor = "default";

                                },
                                function () {
                                    return false;
                                },
                                'Reject');
                        });



                        $(".finalizeRpt").click(function () {
                            var record_id = $(this).attr("id");
                            
                            var row = $(this).parent("td").parent('tr');
                            var msg = $("#<%=hdnFinalizeMessage.ClientID %>").val();
                            var msgTitle = $("#<%=hdnFinalizeTitle.ClientID %>").val();
                            var puk = $("#<%=hdnPUK.ClientID %>").val();

                            myConfirm(msg, function () {
                                var mpe = $find('modalProcessing');
                                if (mpe) { mpe.show(); }

                                $.ajax({
                                    type: "POST",
                                    url: "Reports.aspx/FinalizeReport",
                                    data: "{'rptID': '" + record_id + "','puk': '" + puk + "'}",
                                    contentType: "application/json; charset=utf-8",
                                    dataType: "json",
                                    success: function (msg) {
                                        if (mpe) { mpe.hide(); }
                                        row.css("background-color", "green");
                                        row.fadeOut(1000);
                                        row.remove();

                                        $("#<%=gvexpenses.ClientID %> tr").each(function () {
                                            $(this).remove();
                                        });

                                        if (msg.d != '')
                                            myMsg(msg.d, function () { return true; }, "Message");
                                        else {
                                            window.location.href = "Reports.aspx?msg=finalized";
                                        }
                                    },
                                    error: function () {
                                        myMsg("There was an error while finalizing report", function () { return true; }, "Error");
                                    }
                                });
                            },
                            function () { return false; }, msgTitle);
                        });


                        $(".submitRpt").click(function () {
                            var record_id = $("#<%=hdnReportID.ClientID %>").val();
                            var puk = $("#<%=hdnPUK.ClientID %>").val();

                            myConfirm($("#<%=hdnSubmitMessage.ClientID %>").val(), function () {
                                var mpe = $find('modalProcessing');
                                if (mpe) { mpe.show(); }

                                $.ajax({
                                    type: "POST",
                                    url: "mReports.aspx/SubmitReport",
                                    data: "{'rptID': '" + record_id + "','puk': '" + puk + "'}",
                                    contentType: "application/json; charset=utf-8",
                                    dataType: "json",
                                    success: function (returnVal) {
                                        if (mpe) { mpe.hide(); }

                                        if (returnVal.d["ErrorMessage"] == "") {
                                            
                                            window.location.href = "mReports.aspx?msg=submitted";
                                        }
                                        else {
                                            
                                            myMsg(returnVal.d["ErrorMessage"], function () { window.location.href = "mReports.aspx"; }, returnVal.d["ErrorMessage"]);
                                        }
                                    },
                                    error: function () {
                                        myMsg("There was an error while submitting report", function () { return true; }, "Error");
                                    }
                                });
                            },
                                function () { return false; }, $("#<%=hdnSubmitTitle.ClientID %>").val())
                        });


                        $(".newExp").click(function () {
                            var record_id = $("#<%=hdnReportID.ClientID %>").val();
                            window.location = "AddExpense.aspx?id=" + record_id
                        });

                        $(".printRpt").click(function () { popup("ExpenseReport.aspx?id=" + $(this).attr("id")); });


                        $(".editRpt").click(function () {
                            window.location = "AddReport.aspx?id=" + $(this).attr("id");
                        });


                        $(".newRpt").click(function () {
                            window.location = 'addreport.aspx?id=0';
                        });

                        $(".viewReceipt").mousedown(function () {
                            var id = $(this).attr("id");
                            window.open("../Receipt.aspx?id=" + id, "Receipt", "width=1000,height=600,toolbar=yes,scrollbars=yes");
                        });

                        $(".attachReceipt").mousedown(function () {
                            window.location = "uploadreceipt.aspx?id=" + $(this).attr("id");

                        });


                        $(".getDates").click(function () {
                            var record_id = $(this).attr("id");
                            var puk = $("#<%=hdnPUK.ClientID %>").val();

                            $.ajax({
                                type: "POST",
                                url: "Reports.aspx/getDates",
                                data: "{'rptID': '" + record_id + "','puk': '" + puk + "'}",
                                contentType: "application/json; charset=utf-8",
                                dataType: "json",
                                success: function (returnVal) {
                                    if (document.getElementById("dates")) {
                                        var vChild = document.getElementById("dates");
                                        document.getElementById("dialog").removeChild(vChild);
                                    }

                                    $("<div id='dates'>" + returnVal.d + "</div>").appendTo("#dialog");
                                    $("#dialog").dialog("open");
                                },
                                error: function () {
                                    myMsg("Err1003:There was an unexpected error", function () { return true; }, "Error");
                                }
                            });
                        });

                    });
        </script>



        
        </body>
    <script>
        $(document).ready(function () {
            function disableBack() { window.history.forward() }
            window.onload = disableBack();
            window.onpageshow = function (evt) { if (evt.persisted) disableBack() }
        });
</script>
        
           

 
           

        </html>
















































































































































































































