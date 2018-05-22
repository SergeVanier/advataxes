<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Login.aspx.vb" Inherits="Advataxes.Login" MasterPageFile="~/Site.Master" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="act" %>

<asp:Content ID="headContent" ContentPlaceHolderID="head" runat="server">
    <%--<link href="../css/style3.css" rel="stylesheet" type="text/css" />
        <link type="text/css" href="css/sunny/jquery-ui-1.8.23.custom.css" rel="stylesheet" /> --%>
        <%--<script type="text/javascript" src="js/jquery-1.7.2.min.js"></script>
        <script type="text/javascript" src="js/jquery-ui-1.8.18.custom.min.js"> </script>
        <script type="text/javascript" src="js/jquery.js"> </script>--%>
        <link rel="shortcut icon" href="/web-images/favicon.ico" />

        <script language="javascript">

            $(document).ready(function () {
                $("#cmdCancel").click(function () {
                    var mpe = $find('ModalPopupExtender1');
                    if (mpe) { mpe.hide(); }

                });

            });

        </script>
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent"  runat="server"    > 
    

        

    <asp:ScriptManager id="ScriptManager1" runat="server" />    
      <%=""%>

          <% If Not IsNothing(Session("msg")) Or Not IsNothing(Request.QueryString("action")) Then%>
            
            <div class="ui-widget" style="position:relative;top:25px;left:150px; height:1px;width:600px;">
		        <div class="ui-state-highlight ui-corner-all" style="margin-top: 0px; padding: 0 2 0 2; font-size:0.8em"> 
			        <p><span class="ui-icon ui-icon-info" style="float: left; margin-right: .3em;"></span>
			          <%= Session("msg")%>
                      <%If Not IsNothing(Request.QueryString("action")) Then%> 
                        <asp:Label ID="Label1" runat="server" Text="You have been logged out" Visible="false"></asp:Label>
                      <%End If%> 
                      
                    </p>
		        </div>                
	        </div>
            <%Session("msgHeight") = Nothing%>
            <%Session("msg") = Nothing%>
        <% End If%>

    <% If Not IsNothing(Request.QueryString("error")) Or Not IsNothing(Session("error")) Then%>
 	    <div class="ui-widget"  style="position:relative;top:25px;left:150px; width:600px;">
		    <div class="ui-state-error ui-corner-all" style="margin-top: 0px; padding: 0 2 0 2; font-size:0.8em;height:40px;"> 
			    <p><span class="ui-icon ui-icon-alert" style="float: left; margin-right: .3em;"></span>
                    <asp:Label ID="lblError" runat="server" Text="Label"><%=IIf(IsNothing(Session("error")), "", Session("error"))%></asp:Label>
                </p>
		    </div>            
	    </div>
        <%Session("msgHeight") = Nothing%>
        <%Session("error") = Nothing%>
    <% End If%>
        
        <div style="width:700px; margin-left:auto; margin-right:auto;">
          <table width="100%" border=0  style="border-collapse:collapse;" ><tr><td align="left" >
              <br />
                   <table width="100%" height="250px" cellpadding="0" cellspacing="0" border="0">
                        <tr>
                            <td width="25%" align="left" valign="top"><img src="images/login4.png" /></td>
                            <td width="40px" style=" background-image:url(images/login5.png); background-repeat:repeat-x;"></td>
                            <td align="left" valign="top" style=" background-image:url(images/login5.png); background-repeat:repeat-x;">
                                <table width=100% border=0>
                                    <tr><td valign="top" height="70px" style="color:#cd1e1e;">
                                        <div style="height:20px; font-size:1.4em;position:relative;left:5px;top:40px; font-weight:bold; ">
                                            <asp:Label ID="lblLogin" runat="server" Text="Login"></asp:Label>
                                        </div>
                                        <div style="text-align:right;"><asp:LinkButton ID="lnkLang" runat="server" PostBackUrl="login.aspx?lang=f">French</asp:LinkButton><br /><br />
                                            <a href="mobile/mlogin.aspx" style="display:none;">Mobile Login</a></div></td></tr>
                                    <tr><td>
                                        <asp:Login ID="Login2" runat="server" TextLayout="TextOnTop" DisplayRememberMe="false"
                                            Width="215px" TitleText="" Height="225px" TextBoxStyle-Width="1" 
                                            LoginButtonStyle-CssClass="button1" LoginButtonStyle-ForeColor="#CD1E1E" 
                                            LabelStyle-CssClass="labelText" LabelStyle-Font-Size="small"  DestinationPageUrl="~/loggedin.aspx">
                                            <LabelStyle CssClass="labelText"></LabelStyle>

                                            <LoginButtonStyle CssClass="button2" ForeColor="#CD1E1E"></LoginButtonStyle>
                                            <TextBoxStyle Width="200px" Height="20px" BorderStyle="solid" Font-Size="medium" BorderWidth="1px"/>
                                            <TitleTextStyle Font-Bold="True" Font-Size="Large" ForeColor="#CD1E1E" HorizontalAlign="Left" />
                                            
                                        </asp:Login>
                                        
                                        <br />
                                        <div style="position:relative;top:-30px;width:250px;"><asp:LinkButton ID="lnkForgotPwd" runat="server">Forgot Password?</asp:LinkButton></div>    
                                        

                                    </td></tr>
                                </table>                                
                            </td>
                        </tr>
                   </table>
               </td></tr>
           </table>
       </div>
    <asp:Panel ID="pnlForgotPwd" runat="server" CssClass="modalPopup" Height="300px" Width="400px" style="display:none">        
        <table width="99%">            
            <tr style="height:50px;">
                <td>
                    <asp:Label ID="lblResetPasswordTitle" runat="server" Text="Reset Password" style="color:#cd1e1e;font-size:1.5em;"></asp:Label>
                </td>
                <td align="right"><img src="images/av.png" />

                </td></tr>
            <tr style=" background-color:#cd1e1e;height:2px;"><td colspan="2"></td></tr>
            <tr style="height:20px;"><td></td></tr>
            <tr><td colspan="2" class="labelText"><asp:Label ID="lblResetPassword" runat="server" /></td></tr>
            <tr style="height:10px;"><td>&nbsp;</td></tr>
            <tr>
                <td colspan="2" class="labelText">
                    <asp:Label ID="lblUserName" runat="server" Text="Username" />:&nbsp;&nbsp;<asp:TextBox ID="txtResetPassword" runat="server" Width="200px"></asp:TextBox><asp:RequiredFieldValidator  ID="RequiredFieldValidator9" runat="server" ErrorMessage="*" ControlToValidate="txtResetPassword"  ValidationGroup="ResetPwd"></asp:RequiredFieldValidator>                        
                </td>
            </tr>
            <tr style="height:70px;">
                <td colspan="2" align="right" valign="bottom">
                    <asp:Button ID="cmdRequestPassword" runat="server" CausesValidation="true" ValidationGroup="ResetPwd" class="button1"/>
                    <input id="cmdCancel" class="button1" type="button" value="<%=hdncanceltext.value %>" />
                </td>
            </tr>
        </table>
        <asp:HiddenField ID="hdnCancelText" runat="server" />
    </asp:Panel>
  

    <act:ModalPopupExtender ID="ModalPopupExtender1" runat="server"
        TargetControlID="lnkForgotPwd"
        PopupControlID="pnlForgotPwd"
        PopupDragHandleControlID="pnlForgotPwd"
        DropShadow="false"
        BackgroundCssClass="modalBackground"
         BehaviorID="ModalPopupExtender1"  />
   
    <asp:Button ID="Button1" runat="server" Text="Button" visible="true" style="display:none;" />
 </asp:Content>