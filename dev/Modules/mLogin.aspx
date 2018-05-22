<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="mLogin.aspx.vb" Inherits="Advataxes.mLogin" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="act" %>


<html>

<head>
<meta name="HandheldFriendly" content="True" />
<meta name="MobileOptimized" content="320" />
<meta name="viewport" content="width=device-width" />

<title>Advataxes</title>
        <link href="../css/style3.css" rel="stylesheet" type="text/css" />
        <link type="text/css" href="../css/sunny/jquery-ui-1.8.23.custom.css" rel="stylesheet" /> 
        <script type="text/javascript" src="../js/jquery-1.7.2.min.js"></script>
        <script type="text/javascript" src="../js/jquery-ui-1.8.18.custom.min.js"> </script>
        <script type="text/javascript" src="../js/jquery.js"> </script>
        <link rel="shortcut icon" href="../web-images/favicon.ico" />

        <script language="javascript">
            
            $(document).ready(function () {
                $("#cmdCancel").click(function () {
                    var mpe = $find('ModalPopupExtender1');
                    if (mpe) { mpe.hide(); }

                });

            });

        </script>

    <script type = "text/javascript" >
        function preventBack() { window.history.forward(); }
        setTimeout("preventBack()", 0);
        window.onunload = function () { null };
</script>
 </head>

 <body>
 <form runat="server"  defaultfocus="Login2_UserName">
    <asp:ScriptManager  runat="server" />                  
      
            <div style="position:relative;left:50%;text-align:center;width:300px;margin-left: -100px;">
                <% If Not IsNothing(Session("msg")) Then%>
                    <div class="ui-widget" style=" position:relative;left:5px;top:0px;height:100px;width:200px;">
		                <div class="ui-state-highlight ui-corner-all" style="margin-top: 0px; padding: 0 2 0 2; font-size:0.8em"> 
			                <p><span class="ui-icon ui-icon-info" style="float: left; margin-right: .3em;"></span>
			                    <%= Session("msg")%></p>
		                </div>
                        <br />
	                </div>
                    <%Session("msgHeight") = Nothing%>
                    <%Session("msg") = Nothing%>
                <% End If%>

                <% If Not IsNothing(Session("error")) Then%>
 	                <div class="ui-widget"  style=" position:relative;left:5px;top:0px;width:200px;">
		                <div class="ui-state-error ui-corner-all" style="margin-top: 0px; padding: 0 2 0 2; font-size:0.8em; height:<%=iif(not isnothing(session("msgHeight")),right(session("msgHeight"),2),40)%>px;"> 
			                <p><span class="ui-icon ui-icon-alert" style="float: left; margin-right: .3em;"></span>
			                  <%= Session("error")%> </p>
		                </div>
                        <br />
	                </div>
                    <%Session("msgHeight") = Nothing%>
                    <%Session("error") = Nothing%>
                <% End If%>

                <table width="200px">
                    <tr><td style=" font-size:X-large;color:#cd1e1e;">Login</td><td align="right"><img src="../images/av.png" width="80px" /></td></tr>
                    <tr><td colspan="2">
                        <asp:Login ID="Login2" runat="server" TextLayout="TextOnTop" DisplayRememberMe="false"
                            Width="200px" TitleText="" Height="225px" TextBoxStyle-Width="1" 
                            LoginButtonStyle-CssClass="button1" LoginButtonStyle-ForeColor="#CD1E1E" 
                            LabelStyle-CssClass="labelText" LabelStyle-Font-Size="Large"  DestinationPageUrl="~/account/mobile/menu.aspx">
                            <LabelStyle CssClass="labelText"></LabelStyle>

                            <LoginButtonStyle CssClass="button1" ForeColor="#CD1E1E" Font-Size="Large" Width="200px" Height="60px"></LoginButtonStyle>

                            <TextBoxStyle Width="100%" Height="30px" BorderStyle="solid" Font-Size="Large"  BorderWidth="1px"  />
                            <TitleTextStyle Font-Bold="True" Font-Size="Large"  ForeColor="#CD1E1E" HorizontalAlign="Left" />
                            </asp:Login>
                            <br />
                            <!--<a href='../login.aspx'>Go to Desktop version</a>-->
                            <div style="position:relative;top:-40px;width:120px;display:none;"><asp:LinkButton ID="lnkForgotPwd" runat="server">Forgot Password?</asp:LinkButton></div>
                    </td></tr>
                </table>
            </div>
    <asp:Panel ID="pnlForgotPwd" runat="server" CssClass="modalPopup" Height="300px" Width="400px" style="display:none">
        
        <table width="99%">
            
            <tr style="height:50px;"><td><asp:Label ID="Label2" runat="server" Text="Reset Password" style="color:#cd1e1e;font-size:1.5em;"></asp:Label></td><td align="right"><img src="images/av.png" /></td></tr>
            <tr style=" background-color:#cd1e1e;height:2px;"><td colspan="2"></td></tr>
            <tr style="height:20px;"><td></td></tr>
            <tr><td colspan="2" class="labelText">An email will be sent to the email address associated with the username you enter. Follow the instructions in the email to reset your password</td></tr>
            <tr style="height:10px;"><td>&nbsp;</td></tr>
            <tr>
                <td colspan="2" class="labelText">
                    User Name:&nbsp;&nbsp;<asp:TextBox ID="txtResetPassword" runat="server" Width="200px"></asp:TextBox><asp:RequiredFieldValidator  ID="RequiredFieldValidator9" runat="server" ErrorMessage="*" ControlToValidate="txtResetPassword" ValidationGroup="ResetPwd"></asp:RequiredFieldValidator>       
                </td>
            </tr>
            <tr style="height:70px;">
                <td colspan="2" align="right" valign="bottom">
                    <asp:Button ID="cmdRequestPassword" runat="server" Text="Submit"  CausesValidation="true" ValidationGroup="ResetPwd" class="button1"/>
                    
                    <input id="cmdCancel" class="button1" type="button" value="Cancel" />
                    
                </td>
            
            </tr>
        
        </table>
    </asp:Panel>
  
      <act:ModalPopupExtender ID="ModalPopupExtender2" runat="server"
        TargetControlID="Button1"
        PopupControlID="pnlLogin"
        PopupDragHandleControlID="pnlLogin"
        DropShadow="false"
        BackgroundCssClass="modalBackground"
         BehaviorID="ModalPopupExtender2" RepositionMode="None"  />

    <act:ModalPopupExtender ID="ModalPopupExtender1" runat="server"
        TargetControlID="lnkForgotPwd"
        PopupControlID="pnlForgotPwd"
        PopupDragHandleControlID="pnlForgotPwd"
        DropShadow="false"
        BackgroundCssClass="modalBackground"
         BehaviorID="ModalPopupExtender1"  />
   
    <asp:Button ID="Button1" runat="server" Text="Button" visible="true" style="display:none;" />
    </form> 
    </body>

    </html>