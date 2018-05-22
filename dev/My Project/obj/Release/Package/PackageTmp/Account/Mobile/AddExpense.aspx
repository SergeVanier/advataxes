<%@ Page Language="vb"  AutoEventWireup="true" CodeBehind="AddExpense.aspx.vb" Inherits="Advataxes.AddExpense" %>

<%@ Register assembly="System.Web.Entity, Version=3.5.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089" namespace="System.Web.UI.WebControls" tagprefix="asp" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="act" %>


<html>
<head>
    <meta name="HandheldFriendly" content="True" />
    <meta name="MobileOptimized" content="320" />
    <meta name="viewport" content="width=device-width" />
    <title></title>
</head>
<body>
<form  runat="server">
        <link type="text/css" href="../../css/sunny/jquery-ui-1.8.23.custom.css" rel="stylesheet" /> 
        <link href="../../css/style3.css" rel="stylesheet" type="text/css" />        
        <script type="text/javascript" src="../../js/jquery-1.7.2.min.js"></script>
        <script type="text/javascript" src="../../js/jquery-ui-1.8.18.custom.min.js"> </script>
        <script type="text/javascript" src="~/js/jquery.js" /> 
        
         
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
       
    <br />

<!---------------------------------------------------PANELS---------------------------------------------------------------->

            <table width="90%" border=0>
                <tr id="Row-ExpID"><td><asp:TextBox ID="txtExpenseID" runat="server" Visible="true" Width="81px" Text="0" Height="0px" BorderStyle="None" /></td></tr>
                <tr id="Row-TitleAddExp"><td colspan="2"><table width="100%"><tr><td style="color:#cd1e1e; font-size:1.5em;"><asp:Label ID="lbl131" runat="server" Text="Add Expense "></asp:Label></td><td align="right"><img src="../../images/av.png" width="50px" height="40px"/></td></tr></table></td></tr>
                <tr id="Row-TitleEditExp"><td colspan="2" ><table width="100%"><tr><td style="color:#cd1e1e; font-size:1.5em;"><asp:Label runat="server" Text="Edit Expense"></asp:Label></td><td align="right"><img src="../../images/av.png" width="50px" height="40px"/></td></tr></table></td></tr>
                <tr><td colspan="2" style=" background-image:url(../../images/redline.png); background-repeat:repeat-x;"></td></tr>
                <tr id="Row-JurMsg">
                    <td colspan="2">
                 	    <div class="ui-widget">
		                    <div class="ui-state-highlight ui-corner-all" style="margin-top: 0px; padding: 0em;height:50px;"> 
			                    <p><span class="ui-icon ui-icon-info" style="float: left; margin-right: .3em;"></span>
			                        <asp:Label ID="lblJurMsg" runat="server" Text="" ></asp:Label></p>
		                    </div>
                        </div>
                    </td>
                </tr>                
                    <tr id="Row-ExpMsg">
                        <td colspan="2">
 	                        <div class="ui-widget" style="position:relative;top:-20px;">
		                        <div id="ExpMsg" class="ui-state-highlight ui-corner-all" style="margin-top: 20px; padding: 0em .7em;height:50px;"> 
			                        <span class="ui-icon ui-icon-info" style="float: left; margin-right: .3em;"></span>
			                          <asp:Label ID="lblExpMsg" runat="server" Text="" ></asp:Label>
		                        </div>
                            </div>
                        </td>
                    </tr>
                                               
                    
                    <tr  height="30px">
                        <td align="left"><asp:Label ID="lbl37" runat="server" Text="Expense Type:" class="labelText"  Font-Size="medium" /></td>
                        <td>
                            <asp:DropDownList ID="cboCat" class="cboCat" runat="server" DataSourceID="SqlDataSource4" DataTextField="CAT_NAME" DataValueField="ORG_CAT_ID" Height="30px" Width="95%"  Font-Size="Medium"/>
                            <br /><asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="cboCat" ErrorMessage="* An expense type is required"  ValidationGroup="NewExpense"  />
                        </td>
                    </tr>

                    <tr height="30px">
                        <td align="left"><asp:Label ID="lbl38" runat="server" Text="Expense Date:" class="labelText"  Font-Size="medium" /></td>
                        <td align="left">
                            <asp:TextBox ID="txtExpDate" runat="server" Width="100px" readonly="true" Text="30/07/2013"  Font-Size="medium" Height="30px"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtExpDate" ErrorMessage="*"  ValidationGroup="NewExpense" />
                        </td>
                    </tr>
    
                    <tr id="Row-TaxRate"  height="30px">
                        <td align="left"><asp:Label ID="lbl39" runat="server" Text="Is your expense subject to:" class="labelText" Font-Size="medium"  /></td>
                        <td><asp:DropDownList ID="cboTaxRate" runat="server"   Font-Size="medium" Height="30px" DataSourceID="sqlGetAirTaxRates" DataTextField="TR_DESCRIPTION" DataValueField="JUR_ID" /></td>
                    </tr>

                    <tr id="Row-Rate"  height="30px">
                        <td align="left"><asp:Label ID="lbl40" runat="server" Text="Rate:" class="labelText"  Font-Size="medium" /></td>
                        <td>
                            <%-- <asp:TextBox ID="txtRate" runat="server" class="numberinput"></asp:TextBox> --%>
                            <asp:DropDownList ID="cboRate" runat="server"   Font-Size="medium" Height="30px">
                                <asp:ListItem></asp:ListItem>
                             </asp:DropDownList>
                        </td>
                    </tr>

                    <tr id="Row-KM"  height="30px">
                        <td align="left"><asp:Label ID="lbl41" runat="server" Text="# of KM:" class="labelText"  Font-Size="medium"  /></td>
                        <td><asp:TextBox ID="txtKM" runat="server" class="numberinput-nodecimal"  Font-Size="medium" Height="30px"></asp:TextBox></td>
                    </tr>

                    <%If Session("emp").organization.parent.DisplayProject Then%>
                        <tr  height="30px">
                        <td align="left"><asp:Label ID="lbl322" runat="server" Text="Project" class="labelText" Font-Size="medium"  /> </td>
                        <td align="left"><asp:DropDownList ID="cboProject" runat="server" Width="95%" DataSourceID="sqlGetActiveProjects" DataTextField="PWC_NUMBER_DESC" DataValueField="PWC_NUMBER"  Font-Size="medium" Height="30px"/></td>
                        </tr>
                    <%End If%>

                    <%If Session("emp").organization.parent.DisplayWorkOrder Then%>
                        <tr height="30px">
                        <td align="left"><asp:Label ID="lbl323" runat="server" Text="Work Order" class="labelText"  Font-Size="medium" /> </td>
                        <td><asp:DropDownList ID="cboWO" runat="server" Width="95%" DataSourceID="sqlGetActiveWO" DataTextField="PWC_NUMBER_DESC" DataValueField="PWC_NUMBER"  Font-Size="medium" Height="30px"/></td>
                        </tr>
                    <%End If%>

                    <%If Session("emp").organization.parent.DisplayCostCenter Then%>
                        <tr height="30px">
                        <td align="left"  width="157px"><asp:Label ID="lbl324" runat="server" Text="Cost Center" class="labelText" Font-Size="medium"  /> </td>
                        <td><asp:DropDownList ID="cboCC" runat="server" Width="95%" DataSourceID="sqlGetActiveCC" DataTextField="PWC_NUMBER_DESC" DataValueField="PWC_NUMBER"  Font-Size="medium" Height="30px"/></td>
                        </tr>
                    <%End If%>

                    <tr id="Row-Supplier" height="30px">
                        <td align="left"><asp:Label ID="lbl42" runat="server" Text="Supplier Name:" class="labelText" Font-Size="medium" /></td>
                        <td><asp:TextBox ID="txtSupplier" runat="server" Width="95%"  Font-Size="medium" Height="30px"></asp:TextBox></td>
                    </tr>
                
                    <tr id="Row-Jur" height="30px">
                        <td align="left"><asp:Label ID="lbl43" runat="server" Text="Jurisdiction:" class="labelText"  Font-Size="medium" /></td>
                        <td><asp:DropDownList ID="cboJur" runat="server" DataSourceID="SqlDataSource5" DataTextField="JUR_NAME" DataValueField="JUR_ID" Width="214px"  Font-Size="medium" Height="30px" /></td>
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
                        <td align="left"><asp:Label ID="lbl45" runat="server" Text="Amount:" class="labelText"  Font-Size="medium" /></td>
                        <td>
                            <asp:TextBox ID="txtAmt" runat="server" Width="65px"   Font-Size="medium" Height="30px" class="numberinput" MaxLength="8"></asp:TextBox>                            
                            <asp:DropDownList ID="cboTaxIE" runat="server" Height="30px" Font-Size="Medium">
                                <asp:ListItem Value="1" Selected="True">Tax Included</asp:ListItem>
                                <asp:ListItem Value="2">Before Tax</asp:ListItem>
                            </asp:DropDownList>
                            <br /><br />
                            <asp:DropDownList ID="cboCurr" runat="server" DataSourceID="SqlDataSource3" 
                                DataTextField="CURRENCY" DataValueField="CURR_ID"  Font-Size="medium" Height="30px"
                                style="margin-left: 0px" Width="197px">
                            </asp:DropDownList>
                            <br /><asp:RequiredFieldValidator ID="AmtRequired" runat="server" ControlToValidate="txtAmt" ErrorMessage="* An amount is required"  ValidationGroup="NewExpense" />
                        </td>
                    </tr>

                    <tr id="Row-Grat" height="30px">
                        <td align="left"><asp:Label ID="lbl46" runat="server" Text="Tip:" class="labelText"  Font-Size="medium" /></td>
                        <td valign="middle"><asp:TextBox ID="txtGrat" runat="server" class="numberinput"  Font-Size="medium" Height="30px"/>&nbsp;&nbsp;<a id="24" href="#" class="popUpWin"><img src="../../images/question.png" width="18px" height="18px" /></a></td>
                    </tr>

                    <tr id="Row-DontReimburse">
                        <td align="left" valign="middle"></td>
                       <td class="labelText"><asp:CheckBox ID="chkDontReimburse" runat="server" /><asp:Label ID="lbl51" runat="server" Text="Do not reimburse" Font-Size="medium" ></asp:Label> <a id="23" href="#" class="popUpWin"><img src="../../images/question.png" width="17px" height="17px" /></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:DropDownList ID="cboTP" DataSourceID="sqlGetActiveTP" DataTextField="ACCOUNT" DataValueField="VENDOR_NUMBER" Width="200px" height="30px" Font-Size="Medium"  runat="server"></asp:DropDownList></td> 
                    </tr>

                    <tr id="Row-Attendees" height="30px">
                        <td align="left" valign="top" ><asp:Label ID="lbl369" runat="server" Text="Attendees:" class="labelText" Font-Size="Medium" /></td>
                        <td><asp:TextBox ID="txtAttendees" runat="server" Height="25px" Width="95%" TextMode="MultiLine" Font-Names="Arial"  Font-Size="Medium"></asp:TextBox></td>
                    </tr>

                    <tr height="30px">
                        <td align="left" valign="top" ><asp:Label ID="lbl48" runat="server" Text="Comment:" class="labelText"  Font-Size="medium" /></td>
                        <td><asp:TextBox ID="txtComment" runat="server"  Font-Size="medium" Height="30px" Width="95%" TextMode="MultiLine"  Font-Names="Arial"></asp:TextBox></td>
                    </tr>

                    <tr>
                        <td align="left" valign="middle"><asp:Label ID="lbl49" runat="server" Text="Attach Receipt:" class="labelText"  Font-Size="medium" /></td>
                        
                        <td valign="middle">
                            <asp:FileUpload ID="FileUpload1" runat="server" Height="23px"  />
                            <table><tr><td id="Cell-RemoveAttachment"  style=" font-size:medium;"><a href="#" class="delReceipt">Delete Receipt</a></td></tr></table>
                        </td>
                    </tr>

                    <tr id="Row-FileError"><td colspan="2"><asp:Label ID="Label1" ForeColor="#cd1e1e" Font-Bold="true" runat="server" Text="Invalid file type, supported files include jpg, png, gif, pdf, htm/html"></asp:Label></td></tr>
                    <tr id="Row-GST"><td align="left" valign="middle"><asp:Label ID="lbl50" runat="server" Text="GST/HST paid:" class="labelText" Font-Size="medium"  /></td><td><asp:TextBox ID="txtGST" runat="server" Width="75px" BorderStyle="Solid" BorderWidth="1px" Enabled="false"  class="numberinput"  Font-Size="medium" Height="30px" style=" text-align:right;"></asp:TextBox><asp:Label ID="lblGST" runat="server" Text=""></asp:Label>&nbsp;&nbsp;&nbsp;<a href="#"><img id="imgUnlockGST" src="../../images/lock.png" title="Unlock Field" class="unlockGST" width="12px" height="16px" /></a></td></tr>
                    <tr id="Row-HST"><td align="left"><asp:Label ID="lblHSTpaid" runat="server" Text="HST paid:" class="labelText" /></td><td><asp:TextBox ID="txtHST" runat="server" Width="75px" BorderStyle="Solid" BorderWidth="1px" Enabled="true"  class="numberinput" style=" text-align:right;"></asp:TextBox><asp:Label ID="lblHST" runat="server" Text=""></asp:Label></td></tr>
                    <tr id="Row-QST"><td align="left" valign="middle"><asp:Label ID="lbl66" runat="server" Text="QST paid:" class="labelText"  Font-Size="medium" /></td><td><asp:TextBox ID="txtQST" runat="server" Width="75px" BorderStyle="Solid" BorderWidth="1px" Enabled="false" ForeColor="Black"  class="numberinput"  Font-Size="medium" Height="30px" style=" text-align:right;"></asp:TextBox><asp:Label ID="lblQST" runat="server" Text=""></asp:Label>&nbsp;&nbsp;&nbsp;<a href="#"><img id="imgUnlockQST" src="../../images/lock.png" title="Unlock Field" class="unlockQST"  width="12px" height="16px"/></a></td></tr>
                    <tr id="Row-Total"><td align="left" valign="middle" style="  font-size:medium ; color:Green;"><asp:Label ID="lbl67" runat="server" Text="Total paid:" class="labelText" Font-Size="medium"  /></td><td><asp:TextBox  ID="txtTotal" runat="server" Width="75px" BorderStyle="Solid" BorderWidth="1px" Enabled="false" ForeColor="Green"  Font-Size="medium" Height="30px" style=" text-align:right;" /><div id="exceedMsg" style="position:relative;top:-23px;left:85px;background-color:#cd1e1e;color:White;width:225px;border-radius:3px;text-align:center;">Total amount exceeds allowed limit</div></td></tr>
                </table>

             <div style="position:relative;width:95%;">
                <table width="100%">
                    <tr>
                        <td>&nbsp;</td>
                        <td align="right" >
                            <asp:Button ID="cmdSaveExpense" runat="server" Text="140" tooltip="Save and close" width="80px" Height="50px" CausesValidation="true" ValidationGroup="NewExpense"   />
                            <asp:Button ID="cmdSaveExpense2" runat="server" Text="141"  ToolTip="Save and add another expense"   width="80px" Height="50px"  CausesValidation="true" ValidationGroup="NewExpense"  OnClientClick="showProcessing()"  />
                            <asp:Button ID="cmdCancel" class="cancelExp" runat="server" Text="142"  UseSubmitBehavior="false"  width="80px" Height="50px" />
                        </td>
                    </tr>
                </table>
            </div>
           

<!-----------------------------------------------HIDDEN FIELDS------------------------------------------------------------------->
    <asp:TextBox ID="txtEmpID" runat="server" Visible="False" Width="81px"></asp:TextBox>
    <asp:TextBox ID="txtSuperID" runat="server" Visible="False" Width="81px"></asp:TextBox>
    <asp:TextBox ID="txtStatusID" runat="server" Visible="false" value="0"></asp:TextBox>
    <asp:HiddenField id="hdnOrgID" runat="server" />
    <asp:HiddenField id="hdnReportID" runat="server" Value="0" />
    <asp:HiddenField id="hdnExpenseID" runat="server" Value="0" />
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

            <asp:Panel ID="pnlProcessing" runat="server" CssClass="modalPopup" Width="300px">
                <div class="labelText" style="margin:10px">
                    <table width="100%"><tr><td><img src="../../images/busy.gif" /></td><td align="center" class="labelText"><asp:Label ID="lbl285" runat="server" Text=""></asp:Label></td></tr></table>
                </div>
            </asp:Panel>

    <act:ModalPopupExtender ID="modalProcessing" runat="server"
                TargetControlID="cmddummy"
                PopupControlID="pnlProcessing"
                PopupDragHandleControlID="pnlProcessing"
                DropShadow="false"
                BackgroundCssClass="modalBackground"
                BehaviorID="modalProcessing" />

                    

<!-----------------------------------------------DATA SOURCES------------------------------------------------------------------->
                <asp:SqlDataSource ID="sqlGetActiveTP" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:dbadvaloremConnStr %>" 
                    SelectCommand="GetAccounts" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="hdnOrgID" Name="OrgID" PropertyName="Value" Type="Int32" />
                        <asp:Parameter Name="Type" DefaultValue="TPA"  />
                        <asp:Parameter Name="Active" DefaultValue="1" Type="Byte" />
                    </SelectParameters>
                    
                </asp:SqlDataSource>


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
         
    
            <asp:SqlDataSource ID="sqlEmp" runat="server" 
                ConnectionString="<%$ ConnectionStrings:dbadvaloremConnStr %>" 
                SelectCommand="SELECT * FROM [vEmployees] WHERE ([SUPERVISOR_EMP_ID] = @SUPERVISOR_EMP_ID) ORDER BY LAST_NAME">
                <SelectParameters>
                    <asp:ControlParameter ControlID="txtSuperID" Name="SUPERVISOR_EMP_ID" PropertyName="Text" Type="Decimal" />
                </SelectParameters>
            </asp:SqlDataSource>
     
            <asp:SqlDataSource ID="sqlDelegate" runat="server" 
                ConnectionString="<%$ ConnectionStrings:dbadvaloremConnStr %>" 
                SelectCommand="SELECT * FROM [vEmployees] WHERE ([DELEGATE_EMP_ID] = @EmpID)">
                 <SelectParameters>
                     <asp:ControlParameter ControlID="txtEmpID" DefaultValue="0" Name="EmpID" PropertyName="Text" Type="Int32" />
                 </SelectParameters>
            </asp:SqlDataSource>


            <asp:SqlDataSource ID="SqlDataSource3" runat="server" 
                ConnectionString="<%$ ConnectionStrings:dbadvaloremConnStr %>" 
                SelectCommand="GetCurrenciesSome" SelectCommandType="StoredProcedure">
            </asp:SqlDataSource>
             
            <asp:SqlDataSource ID="SqlDataSource4" runat="server" 
                ConnectionString="<%$ ConnectionStrings:dbadvaloremConnStr %>" 
                SelectCommand="GetActiveOrgCategories" SelectCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:ControlParameter ControlID="hdnOrgID" DefaultValue="0" Name="OrgID" PropertyName="Value" Type="Int32" />
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
    
    <div id="dialog" title="Dates"></div>
            
    <table>
        <tr id="dummytable"><td><asp:Button ID="cmdDummy" runat="server" Text="Button"  /></td></tr>
    </table>



                <script type="text/javascript">
                    
                    function showProcessing() {
                        if ($("#<%=txtAmt.ClientID %>").val() != '') {
                            var mpe = $find('modalProcessing');
                            if (mpe) { mpe.show(); }
                        }
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

                    function getQueryStrings() { 
                          var assoc  = {};
                          var decode = function (s) { return decodeURIComponent(s.replace(/\+/g, " ")); };
                          var queryString = location.search.substring(1); 
                          var keyValues = queryString.split('&'); 

                          for(var i in keyValues) { 
                            var key = keyValues[i].split('=');
                            if (key.length > 1) {
                              assoc[decode(key[0])] = decode(key[1]);
                            }
                          } 

                          return assoc; 
                    }

                    $(document).ready(function () {
                        $('#<%=cboTP.ClientID %>').hide();
                        $("#Row-FileError").hide();
                        $("#Row-TitleAddExp").show();
                        $("#Row-TitleEditExp").hide();
                        $("#Row-Attendees").hide();

                        var qs = getQueryStrings();
                        var myParam = qs["expID"];

                        if (myParam > 0) {
                            var record_id = myParam;
                            var puk = $("#<%=hdnPUK.ClientID %>").val();
                            $("#<%=hdnExpenseID.ClientID %>").val(myParam);

                            document.body.style.cursor = "wait";

                            $("#Row-TitleAddExp").hide();
                            $("#Row-TitleEditExp").show();
                            $("#Row-Msg").hide();
                            $("#exceedMsg").hide();

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
                                url: "AddExpense.aspx/GetExpense",
                                data: "{'expID': '" + record_id + "','puk': '" + puk + "'}",
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

                                    if (msg.d[27] == 1) {
                                        if (msg.d[28] > 0) {
                                            $("#<%=txtAmt.ClientID %>").prop('disabled', true);

                                            if (msg.d[0] == 4) {
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

                                    $("#<%=txtComment.ClientID %>").val(msg.d[2]);
                                    $("#<%=cboCurr.ClientID %>").val(msg.d[3]);
                                    $("#<%=txtExpDate.ClientID %>").val(msg.d[4]);
                                    $("#<%=hdnExpDate.ClientID %>").val(msg.d[4]);
                                    $("#<%=txtGrat.ClientID %>").val(msg.d[5]);
                                    $("#<%=cboJur.ClientID %>").val(msg.d[6]);

                                    num = msg.d[7] * 1;
                                    $("#<%=cboRate.ClientID %>").val(num.toFixed(2));
                                    $("#<%=txtSupplier.ClientID %>").val(msg.d[8]);
                                    $("#<%=txtGST.ClientID %>").val(msg.d[18]);
                                    $("#<%=txtQST.ClientID %>").val(msg.d[19]);
                                    $("#<%=hdnGST.ClientID %>").val(msg.d[18]);
                                    $("#<%=hdnQST.ClientID %>").val(msg.d[19]);

                                    if (msg.d[22] == '0') {
                                        $('#<%=chkDontReimburse.ClientID %>').attr('checked', false);
                                        $('#<%=cboTP.ClientID %>').hide();
                                    } else {
                                        $('#<%=chkDontReimburse.ClientID %>').attr('checked', true);
                                        $('#<%=cboTP.ClientID %>').show();
                                        $('#<%=cboTP.ClientID %>').val(msg.d[29]);
                                    }

                                    $("#<%=cboTaxIE.ClientID %>").val(msg.d[9]);

                                    if (msg.d[21] != "")
                                        $("#Cell-RemoveAttachment").show();
                                    else
                                        $("#Cell-RemoveAttachment").hide();

                                    var mpe = $find('MPE4');
                                    if (mpe) { mpe.show(); }

                                    $("#<%=cboCat.ClientID %>").prop('disabled', true);

                                    if (msg.d[0] == 4) {
                                        $("#<%=txtAmt.ClientID %>").val(msg.d[1]);
                                        $("#<%=txtKM.ClientID %>").val(msg.d[1] / msg.d[7]);
                                    }

                                    if (msg.d[0] == 20) {
                                        $("#<%=txtAttendees.ClientID %>").val(msg.d[29]);
                                        $("#Row-Attendees").show();
                                    }

                                    $("#<%=txtTotal.ClientID %>").val(msg.d[23]);
                                    $("#<%=cboProject.ClientID %>").val(msg.d[24]);
                                    $("#<%=cboWO.ClientID %>").val(msg.d[25]);
                                    $("#<%=cboCC.ClientID %>").val(msg.d[26]);

                                    //if (msg.d[18] > 0)
                                    //    $("#Row-GST").show();

                                    //if (msg.d[19] > 0)
                                    //    $("#Row-QST").show();

                                    if (msg.d[10] == 1) $("#Row-Amt").show(); else $("#Row-Amt").hide();
                                    if (msg.d[11] == 1) $("#Row-Supplier").show(); else $("#Row-Supplier").hide();
                                    if (msg.d[12] == 1) $("#Row-Grat").show(); else $("#Row-Grat").hide();
                                    if (msg.d[13] == 1) $("#Row-Jur").show(); else $("#Row-Jur").hide();
                                    if (msg.d[14] == 1) $("#Row-KM").show(); else $("#Row-KM").hide();
                                    if (msg.d[15] == 1) $("#Row-Note").show(); else $("#Row-Note").hide();
                                    if (msg.d[16] == 1) $("#Row-Rate").show(); else $("#Row-Rate").hide();

                                    if (msg.d[17] == 1) {
                                        $("#Row-TaxRate").show();
                                        $("#<%=cboTaxRate.ClientID %>").val(msg.d[6]);
                                    }
                                    else
                                        $("#Row-TaxRate").hide();

                                    document.body.style.cursor = "default";
                                    //$("#<%=txtAmt.ClientID %>").keyup();
                                    $("#Row-Total").show();

                                    num = $("#<%=txtTotal.ClientID %>").val() * 1;
                                    $("#<%=txtTotal.ClientID %>").val(num.toFixed(2));


                                    if (msg.d[9] == 1) {
                                        document.getElementById("imgUnlockGST").style.display = "none";
                                        document.getElementById("imgUnlockQST").style.display = "none";
                                    } else {
                                        document.getElementById("imgUnlockGST").style.display = "inline";
                                        document.getElementById("imgUnlockQST").style.display = "inline";
                                    }

                                    if (msg.d[6] == '14') {
                                        $("#Row-QST").hide();
                                        $("#Row-GST").hide();
                                    }
                                    else {
                                        $("#Row-GST").show();
                                        if (msg.d[6] == '1')
                                            $("#Row-QST").show();
                                        else
                                            $("#Row-QST").hide();
                                    }


                                },
                                error: function () {
                                    myMsg("Err1001:There was an unexpected error", function () { return true; }, "Error");
                                }
                            });

                        }

                        $('#msg').hide();
                        $("#exceedMsg").hide();
                        $("#Row-JurMsg").hide();
                        $("#<%= txtGST.ClientID %>").val('0.00');
                        $("#Row-GST").hide();
                        $("#<%= cboTaxIE.ClientID %>").val('1');
                        $("#<%= txtTotal.ClientID %>").val('0.00');
                        $("#<%=cboCurr.ClientID %>").prop('selectedIndex', 0);

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


                        $("#<%=txtGrat.ClientID %>").val();
                        $("#<%= txtExpDate.ClientID %>").datepicker({ dateFormat: "dd/mm/yy", minDate: "01/07/2010", maxDate: getMaxDate() });

                        document.getElementById("imgUnlockGST").style.display = "none";
                        document.getElementById("imgUnlockQST").style.display = "none";
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
                        //$("#Row-TitleEditExp").hide();
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


                        $(".popUpWin").click(function () {
                            var iMyWidth;
                            var iMyHeight;
                            //half the screen width minus half the new window width (plus 5 pixel borders).
                            iMyWidth = (window.screen.width / 2) - (350 + 10);
                            //half the screen height minus half the new window height (plus title and status bars).
                            iMyHeight = (window.screen.height / 2) - (150 + 50);
                            //Open the window.
                            var win2 = window.open("/info.aspx?id=" + $(this).attr("id"), "Info", "status=no,height=300,width=700,resizable=yes,left=" + iMyWidth + ",top=" + iMyHeight + ",screenX=" + iMyWidth + ",screenY=" + iMyHeight + ",toolbar=no,menubar=no,scrollbars=no,location=no,directories=no");
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
                                var num1 = $("#<%=txtTotal.ClientID %>").val() * 1;
                                var num2 = $("#<%=hdnLimit.ClientID %>").val() * 1;

                                if (num1 > num2 && num2 > 0) {
                                    $("#exceedMsg").show();
                                    $("#<%=cmdSaveExpense.ClientID %>").css('visibility', 'hidden');
                                    $("#<%=cmdSaveExpense2.ClientID %>").css('visibility', 'hidden');
                                } else {
                                    $("#exceedMsg").hide();
                                    $("#<%=cmdSaveExpense.ClientID %>").css('visibility', 'visible');
                                    $("#<%=cmdSaveExpense2.ClientID %>").css('visibility', 'visible');
                                }
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

                            var num1 = $("#<%=txtTotal.ClientID %>").val() * 1;
                            var num2 = $("#<%=hdnLimit.ClientID %>").val() * 1;

                            if (num1 > num2 && num2 > 0) {
                                $("#exceedMsg").show();
                                $("#<%=cmdSaveExpense.ClientID %>").css('visibility', 'hidden');
                                $("#<%=cmdSaveExpense2.ClientID %>").css('visibility', 'hidden');
                            } else {
                                $("#exceedMsg").hide();
                                $("#<%=cmdSaveExpense.ClientID %>").css('visibility', 'visible');
                                $("#<%=cmdSaveExpense2.ClientID %>").css('visibility', 'visible');
                            }
                        });


                        $("#<%=txtAmt.ClientID %>").blur(function () {
                            if ($("#<%=txtTotal.ClientID %>").val() == "NaN") {
                                alert("You entered an invalid amount");
                                $("#<%=cmdSaveExpense.ClientID %>").css('visibility', 'hidden');
                                $("#<%=cmdSaveExpense2.ClientID %>").css('visibility', 'hidden');
                            } else {
                                $("#<%=cmdSaveExpense.ClientID %>").css('visibility', 'visible');
                                $("#<%=cmdSaveExpense2.ClientID %>").css('visibility', 'visible');
                            }

                        });

                        $("#<%=txtExpDate.ClientID %>").change(function () {
                            $("#<%=hdnExpDate.ClientID %>").val($("#<%=txtExpDate.ClientID %>").val());
                            $("#<%=txtAmt.ClientID %>").keyup();
                        });

                        $("#<%=txtAmt.ClientID %>").keyup(function (e) {
                            // start  new code added for artf162518
                            
                            if (e.keyCode == 188) {
                                e.preventDefault();
                                $(this).val($(this).val().replace(/\,/g, '.'));

                            }
                            // end  new code added for artf162518
                            var jur_id;
                            var exp_date = $("#<%=txtExpDate.ClientID %>").val();
                            var cat_id = $("#<%=hdnCatID.ClientID %>").val();
                            var orgcat_id = $("#<%=cboCat.ClientID %>").val();
                            var tax_inc_exc = $("#<%=cboTaxIE.ClientID %>").val();
                            var kmRate = $("#<%=cboRate.ClientID %>").val();
                            $("#exceedMsg").hide();

                            if (kmRate == '') kmRate = 0;
                            if (kmRate == null) kmRate = 0;

                            if (cat_id == 5)
                                jur_id = $("#<%=cboTaxRate.ClientID %>").val();
                            else
                                jur_id = $("#<%=cboJur.ClientID %>").val();

                            $.ajax({
                                type: "POST",
                                url: "AddExpense.aspx/GetTaxRates",
                                data: "{'jurID': '" + jur_id + "','expDate': '" + exp_date + "','catID': '" + cat_id + "','taxIncExc': '" + tax_inc_exc + "','orgCatID': '" + orgcat_id + "','kmRate': '" + kmRate + "'}",
                                contentType: "application/json; charset=utf-8",
                                dataType: "json",
                                success: function (returnVal) {
                                    var num;
                                    var total;

                                    num = $("#<%=txtAmt.ClientID %>").val() * returnVal.d[0];

                                    $("#<%=txtGST.ClientID %>").val(num.toFixed(2));
                                    $("#<%=hdnGST.ClientID %>").val(num.toFixed(2));
                                    num = $("#<%=txtAmt.ClientID %>").val() * returnVal.d[1];
                                    $("#<%=txtQST.ClientID %>").val(num.toFixed(2));
                                    $("#<%=hdnQST.ClientID %>").val(num.toFixed(2));

                                    num = $("#<%=txtAmt.ClientID %>").val() * 1;
                                    num = num + $("#<%=txtGrat.ClientID %>").val() * 1;

                                    if ($("#<%=cboTaxIE.ClientID %>").val() == 2) {
                                        num = num + $("#<%=txtGST.ClientID %>").val() * 1;
                                        num = num + $("#<%=txtQST.ClientID %>").val() * 1;
                                    }
                                    $("#<%=txtTotal.ClientID %>").val(num.toFixed(2));
                                    $("#Row-Total").show();

                                    if (jur_id == 1)
                                        $("#Row-QST").fadeIn(300);
                                    else
                                        $("#Row-QST").fadeOut(300);

                                    if (jur_id == 14)
                                        $("#Row-GST").fadeOut(300);
                                    else
                                        $("#Row-GST").fadeIn(300);

                                    if (returnVal.d[2] == 0) {
                                        $("#<%=lblExpMsg.ClientID %>").text('KM rate selected exceeds the allowable rate for the selected jurisdiction. Taxes will not be calculated.');
                                        $("#Row-ExpMsg").fadeIn(300);
                                    } else {
                                        if ((cat_id != 44 && cat_id != 15) && returnVal.d[4] == 0) $("#Row-ExpMsg").hide();
                                    }

                                    var num1 = $("#<%=txtTotal.ClientID %>").val() * 1;
                                    var num2 = returnVal.d[4] * 1;
                                    $("#<%=hdnLimit.ClientID %>").val(returnVal.d[4]);

                                    if (num1 > num2 && cat_id != 4 && num2 > 0) {
                                        $("#exceedMsg").show();
                                        $("#<%=cmdSaveExpense.ClientID %>").css('visibility', 'hidden');
                                        $("#<%=cmdSaveExpense2.ClientID %>").css('visibility', 'hidden');
                                    } else {
                                        $("#exceedMsg").hide();
                                        $("#<%=cmdSaveExpense.ClientID %>").css('visibility', 'visible');
                                        $("#<%=cmdSaveExpense2.ClientID %>").css('visibility', 'visible');
                                    }
                                },
                                error: function (xhr, error) {
                                    if (xhr.responseText.indexOf('is not a valid value') == -1)
                                        myMsg("Err1002: There was an unexpected error", function () { return true; }, "Error");
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
                                $("#<%=txtGST.ClientID %>").prop('disabled', 'disabled');
                                $("#<%=txtQST.ClientID %>").prop('disabled', 'disabled');
                            }

                            $("#<%=txtAmt.ClientID %>").keyup();
                        });

                        $("#<%=cboJur.ClientID %>").change(function () {
                            //} else //    $("#msg").hide; //    $("#<%=cboCurr.ClientID %>").val('25'); //else { //    if ($(this).val() == '14') //        $("#<%=cboTaxIE.ClientID %>").css("display", "none"); //    else  //        $("#<%=cboTaxIE.ClientID %>").css("display", "inline"); //}

                            $("#<%=txtAmt.ClientID %>").keyup();

                            if ($("#<%=cboCurr.ClientID %>").val() != '25' && $("#<%=cboJur.ClientID %>").val() != '14') {
                                $("#<%=lblJurMsg.ClientID %>").text("WARNING: The selected currency is outside the jurisdiction");
                                $("#Row-JurMsg").fadeIn(300);
                            } else {
                                $("#Row-JurMsg").hide();
                            }
                        });

                        $("#<%=cboRate.ClientID %>").change(function () {
                            $("#<%=txtKM.ClientID %>").keyup();
                        });

                        //$("#<%=cboCat.ClientID %>").click(function () {
                        //    $("#<%=cboCat.ClientID %>").keyup()
                        //});


                        $("#<%=cboCat.ClientID %>").blur(function () {
                            $("#<%=cboCat.ClientID %>").keyup();
                        });


                        $("#<%=cboCat.ClientID %>").change(function () {
                            $("#<%=txtSupplier.ClientID %>").val('');
                            $("#<%=txtComment.ClientID %>").val('');
                            $("#<%=txtKM.ClientID %>").val('');
                            $("#<%=txtAmt.ClientID %>").val('');
                            $("#<%=txtAttendees.ClientID %>").val('');
                            $("#<%=txtTotal.ClientID %>").val('0.00');
                            $("#<%=txtGST.ClientID %>").val('0.00');
                            $("#<%=txtQST.ClientID %>").val('0.00');
                            $("#<%=hdnGST.ClientID %>").val(0);
                            $("#<%=hdnQST.ClientID %>").val(0);
                            $("#Row-ExpMsg").hide();
                            $("#exceedMsg").hide();
                            $("#<%=cboCat.ClientID %>").keyup();

                        });

                        $("#<%=cboCat.ClientID %>").keyup(function () {
                            var org_cat_id = $(this).val();

                            $("#<%=hdnOrgCatID.ClientID %>").val(org_cat_id);
                            //$("#Row-ExpMsg").hide();

                            if (org_cat_id != '') {
                                $.ajax({
                                    type: "POST",
                                    url: "AddExpense.aspx/GetAllows",
                                    data: "{'orgCatID': '" + org_cat_id + "'}",
                                    contentType: "application/json; charset=utf-8",
                                    dataType: "json",
                                    success: function (returnVal) {

                                        if (returnVal.d[0] == 1) $("#Row-Supplier").show(); else { $("#Row-Supplier").hide(); $("#<%=txtSupplier.ClientID %>").val(''); }
                                        //if (returnVal.d[0] == 1) $("#Row-Supplier").fadeIn(1000); else { $("#Row-Supplier").hide(); $("#<%=txtSupplier.ClientID %>").val(''); }
                                        if (returnVal.d[1] == 1) $("#Row-Rate").show(); else { $("#Row-Rate").hide(); $("#<%=cboRate.ClientID %>").val(''); }
                                        if (returnVal.d[2] == 1) {
                                            $("#Row-Grat").show();
                                            //$("#Row-Total").show();
                                        }
                                        else {
                                            $("#Row-Grat").hide();
                                            //$("#Row-Total").hide();
                                        }

                                        if (returnVal.d[3] == 1) $("#Row-Jur").show(); else $("#Row-Jur").hide();
                                        if (returnVal.d[4] == 1) $("#Row-KM").show(); else { $("#Row-KM").hide(); $("#<%=txtKM.ClientID %>").val(0); }
                                        if (returnVal.d[5] == 1) $("#Row-Amt").show(); else $("#Row-Amt").hide();
                                        if (returnVal.d[6] == 1) $("#Row-TaxRate").show(); else { $("#Row-TaxRate").hide(); $("#<%=cboTaxRate.ClientID %>").val(''); }
                                        if (returnVal.d[8] == 1) $("#<%=cboTaxIE.ClientID %>").show(); else { $("#<%=cboTaxIE.ClientID %>").hide(); $("#<%=cboTaxIE.ClientID %>").val(1); }
                                        if (returnVal.d[9] == 1) $("#Row-DontReimburse").show(); else { $("#Row-DontReimburse").hide(); $('#<%=chkDontReimburse.ClientID %>').attr('checked', false); }
                                        if (returnVal.d[13] == 1) $("#Row-Attendees").show(); else $("#Row-Attendees").hide();

                                        $("#<%=hdnCatID.ClientID %>").val(returnVal.d[7]);
                                        var num = returnVal.d[10] * 1;

                                        if (returnVal.d[7] == "4")
                                            $("#<%=cboRate.ClientID %>").val(num.toFixed(2));
                                        //alert(returnVal.d[11]);
                                        if (returnVal.d[10] > 0 && returnVal.d[11] == 1) {
                                            $("#<%=cboRate.ClientID %>").prop("disabled", "disabled");
                                            if (returnVal.d[7] == "4")
                                                $("#<%=txtAmt.ClientID %>").val(num.toFixed(2) * $("#<%=txtKM.ClientID %>").val());
                                            else
                                                $("#<%=txtAmt.ClientID %>").val(num.toFixed(2));

                                            $("#<%=txtAmt.ClientID %>").prop("disabled", "disabled");
                                            $("#<%=txtAmt.ClientID %>").keyup();

                                        } else {
                                            $("#<%=cboRate.ClientID %>").removeAttr("disabled");
                                            $("#<%=txtAmt.ClientID %>").removeAttr("disabled");

                                            if (returnVal.d[10] > 0) {
                                                var num = returnVal.d[10] * 1;
                                                $("#<%=lblExpMsg.ClientID %>").text("This category has a set limit of $" + num.toFixed(2));
                                                $("#ExpMsg").css("height", "25");
                                                $("#Row-ExpMsg").fadeIn(300);
                                            }
                                        }

                                        if (returnVal.d[7] == "44") {
                                            $("#<%=lblExpMsg.ClientID %>").text("Taxes, if any, are not calculated on expenses incurred for personal use");
                                            $("#ExpMsg").css("height", "25");
                                            $("#Row-ExpMsg").fadeIn(300);

                                        } else if (returnVal.d[7] == "15") {
                                            $("#<%=lblExpMsg.ClientID %>").text("Provincial insurance tax, if any, (i.e. Ont 8%, Qc 5% or 9%) are not recoverable and should be included in the amount");
                                            $("#ExpMsg").css("height", "45");
                                            $("#Row-ExpMsg").fadeIn(300);
                                        }

                                        if (returnVal.d[7] == '5')
                                            if ($("#<%=cboTaxRate.ClientID %>").val() != '14') $("#<%=cboCurr.ClientID %>").val('25');

                                        $("#<%=txtAmt.ClientID %>").keyup();
                                    },
                                    error: function () {
                                        myMsg("Err1003: There was an unexpected error", function () { return true; }, "Error");
                                    }
                                });
                            }
                        });


                        $("#<%=cboTaxRate.ClientID %>").change(function () {
                            var record_id = $(this).val();
                            //$("#<%=txtExpDate.ClientID %>").datepicker("option", "maxDate", getMaxDate());
                            if ($(this).val() != '14') $("#<%=cboCurr.ClientID %>").val('25');

                            $("#<%=txtAmt.ClientID %>").keyup();
                        });

                        $("#<%=txtGrat.ClientID %>").keyup(function () { $("#<%=txtAmt.ClientID %>").keyup(); });
                        $("#<%=txtGST.ClientID %>").keyup(function () { $("#<%=hdnGST.ClientID %>").val($("#<%=txtGST.ClientID %>").val()); });
                        $("#<%=txtQST.ClientID %>").keyup(function () { $("#<%=hdnQST.ClientID %>").val($("#<%=txtQST.ClientID %>").val()); });


                        $("#<%=cboCurr.ClientID %>").change(function () {
                            //if ($(this).val() != '25') {
                            //   if ($("#<%=hdnCatID.ClientID %>").val() == '5')
                            //       $("#<%=cboTaxRate.ClientID %>").val('14');
                            //   else
                            //       $("#<%=cboJur.ClientID %>").val('14');

                            $("#<%=txtAmt.ClientID %>").keyup();
                            //}

                            if ($("#<%=cboCurr.ClientID %>").val() != '25' && $("#<%=cboJur.ClientID %>").val() != '14') {
                                $("#<%=lblJurMsg.ClientID %>").text("WARNING: The selected currency is outside the jurisdiction");
                                $("#Row-JurMsg").fadeIn(300);
                            } else {
                                $("#Row-JurMsg").hide();
                            }
                        });


                        $("#<%=FileUpload1.ClientID %>").change(function () {
                            if ($("#<%=FileUpload1.ClientID %>").val() != '') {
                                var f = $("#<%=FileUpload1.ClientID %>").val().toUpperCase();
                                var fType = f.substr(f.length - 3);

                                $("#<%=cmdSaveExpense.ClientID %>").removeAttr('disabled');
                                $("#<%=cmdSaveExpense2.ClientID %>").removeAttr('disabled');

                                switch (fType) {
                                    case 'JPG': $("#Row-FileError").hide(); break;
                                    case 'JPEG': $("#Row-FileError").hide(); break;
                                    case 'GIF': $("#Row-FileError").hide(); break;
                                    case 'PNG': $("#Row-FileError").hide(); break;
                                    case 'PDF': $("#Row-FileError").hide(); break;
                                    case 'HTM': $("#Row-FileError").hide(); break;
                                    case 'HTML': $("#Row-FileError").hide(); break;
                                    default:
                                        $("#Row-FileError").show();
                                        $("#<%=cmdSaveExpense.ClientID %>").prop('disabled', 'disabled');
                                        $("#<%=cmdSaveExpense2.ClientID %>").prop('disabled', 'disabled');
                                }
                            }
                        });


                        $(".cancelExp").mousedown(function () {
                            //$("#<%=FileUpload1.ClientID %>").style.visibility = 'hidden';
                            var mpe = $find('MPE4');
                            if (mpe) { mpe.hide(); }
                            $("#<%=FileUpload1.ClientID %>").val('');
                        });


                        $(".delReceipt").click(function () {
                            var record_id = $("#<%=txtExpenseID.ClientID %>").val();

                            if (confirm("Do you want to delete the receipt?")) {
                                $.ajax({
                                    type: "POST",
                                    url: "AddExpense.aspx/DeleteReceipt",
                                    data: "{'expID': '" + record_id + "'}",
                                    contentType: "application/json; charset=utf-8",
                                    dataType: "json",
                                    success: function () {
                                        window.location = "mReports.aspx?action=receitdeleted";
                                    },
                                    error: function () {
                                        myMsg("Err1004: There was an unexpected error", function () { return true; }, "Error");
                                    }
                                });
                            }
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
                                    myMsg("Err1005: There was an unexpected error", function () { return true; }, "Error");
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

                        $('#<%=chkDontReimburse.ClientID %>').click(function () {
                            if ($('#<%=chkDontReimburse.ClientID %>').prop('checked') == true)
                                $('#<%=cboTP.ClientID %>').show();
                            else
                                $('#<%=cboTP.ClientID %>').hide();
                        });

                    });
        </script>


        </form>
        </body>
    </html>























































































































































































































