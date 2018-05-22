<%@ Page Language="vb"  AutoEventWireup="true" CodeBehind="AddReport.aspx.vb" Inherits="Advataxes.AddReport" %>

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
<form runat="server">
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


            
            <div style="margin:10px">
                    
                <table width="100%">
                    <tr style="height:50px;">
                        <td style="color:#cd1e1e; font-size:1.5em; "><asp:Label ID="lbl227" runat="server"></asp:Label></td>
                        <td align="right"><img src="../../images/av.png" width="50px" height="40px"/></td>
                    </tr>
                    <tr style=" background-color:#cd1e1e;height:2px;"><td colspan="10"></td></tr>
                    <tr style="height:20px;"><td></td></tr>                    
                    <tr><td colspan="10"><asp:Label ID="lbl74" runat="server" Text="Report Name:  " class="labelText" Font-Size="Large" /><asp:TextBox ID="txtReportName" runat="server" Width="100%" Height="30px" Font-Size="Large"></asp:TextBox><br /><asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtReportName" ErrorMessage="* Title cannot be blank" ValidationGroup="NewReport" /><br /><br /></td></tr>
                    <tr><td align="right" colspan="10">
                        <asp:Button ID="cmdSaveReport" runat="server" Text="140" class="button1" CausesValidation="true" Height="30px" OnClientClick="showProcessing()" />
                        <asp:Button ID="cmdCancel" runat="server" Text="Cancel" class="button1" />
                    </td></tr>
                </table>
            </div>
            <asp:HiddenField id="hdnCancelText" runat="server" />

                <script type="text/javascript">
                    
                    function showProcessing() {
                        var mpe = $find('modalProcessing');
                        if (mpe) { mpe.show(); }
                    }

                    $(document).ready(function () {
                        $('#msg').hide();
                    });

                </script>


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
                
            <table style="display:none;"><tr id="dummytable"><td><asp:Button ID="cmdDummy" runat="server" Text="Button"  /></td></tr></table>
        </form>
        </body>
    </html>























































































































































































































