<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="MyProfile.aspx.vb" Inherits="Advataxes.MyProfile" %>




<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
        <link type="text/css" href="../../css/sunny/jquery-ui-1.8.23.custom.css" rel="stylesheet" />
        <script type="text/javascript" src="../../js/jquery-1.7.2.min.js"></script>
        <script type="text/javascript" src="../../js/jquery-ui-1.8.18.custom.min.js"> </script>
        <script type="text/javascript" src="../../js/jquery.js"> </script>
</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

        <script type="text/javascript">

            $(document).ready(function () {
                
                $(function () {
                    $("#tabs").tabs();
                });
            });

        </script>

    <% If lblMsg2.Text <> "" Then%>
 	    <div class="ui-widget">
		    <div class="ui-state-highlight ui-corner-all" style="margin-top: 20px; padding: 0 .7em;"> 
			    <p><span class="ui-icon ui-icon-info" style="float: left; margin-right: .3em;"></span>
			      <asp:Label ID="lblMsg2" runat="server" Text="" ></asp:Label></p>
		    </div>
        </div>
    <% End If%>

    <% If lblError.Text <> "" Then%>
            <br />
            <div class="ui-widget">
				<div class="ui-state-error ui-corner-all" style="padding: 0 .7em;"> 
					<p><span class="ui-icon ui-icon-alert" style="float: left; margin-right: .3em;"></span> 
					<strong>Alert:</strong><asp:Label ID="lblError" runat="server" Text="" ></asp:Label></p>
				</div>
			</div>
     <% End If%>


    <asp:ScriptManager id="ScriptManager1" runat="server"  /> 
    <br />
      <div id="tabs" style="min-height:375px;">
			<ul>
				<li><a href="#tabs-1"><asp:Label ID="lbl147" runat="server" Text="Label"></asp:Label></a></li>
                <li><a href="#tabs-2"><asp:Label ID="lbl230" runat="server" Text="Label"></asp:Label></a></li>
			</ul>

			<div id="tabs-1">
                <table border="0" width="80%">
                    <tr style="height:20px;"><td></td></tr>
                    <tr><td width="20%" class="labelText"><asp:Label ID="lbl148" runat="server" Text="Label"></asp:Label></td><td width="80%"><asp:TextBox ID="txtFirstName" runat="server" Width="65%" ReadOnly="true" ></asp:TextBox></td>
                    </tr>
                    <tr><td class="labelText"><asp:Label ID="lbl149" runat="server" Text="Label" /></td><td colspan="2"><asp:TextBox ID="txtLastName" runat="server" Width="65%"  ReadOnly="true" ></asp:TextBox></td></tr>
                    <tr><td class="labelText"><asp:Label ID="lbl229" runat="server" Text="Label" /></td><td colspan="2"><asp:TextBox ID="txtTitle" runat="server" Width="65%" ></asp:TextBox></td></tr>
                    <tr><td class="labelText"><asp:Label ID="lbl150" runat="server" Text="Label" /></td><td colspan="2"><asp:TextBox ID="txtPhone" runat="server" Width="65%" ></asp:TextBox></td></tr>
                    <tr><td class="labelText"><asp:Label ID="lbl70" runat="server" Text="Label" /></td><td colspan="2"><asp:TextBox ID="txtStatus" runat="server" Width="65%" ReadOnly="true" ></asp:TextBox></td></tr>
                                       
                    <tr><td class="labelText"><asp:Label ID="lbl151" runat="server" Text="Label" /></td><td colspan="2">
                        <asp:DropDownList ID="cboLang" Width="100px" runat="server">
                            <asp:ListItem Value="English">English</asp:ListItem>
                            <asp:ListItem Value="French">French</asp:ListItem>
                        </asp:DropDownList>
                    </td></tr>

                    <tr style="height:20px;"><td></td></tr>
                    <tr><td class="labelText"><asp:Label ID="lbl152" runat="server" Text="Label" /></td><td colspan="2"><asp:Label ID="lblDelegate" runat="server" Text=""  Width="100%"></asp:Label></td></tr>
                    <tr><td class="labelText"><asp:Label ID="lbl159" runat="server" Text="Label" /></td><td colspan="2"><asp:Label ID="lblSupervisor" runat="server" Text=""  Width="100%"></asp:Label></td></tr>
                    <tr><td class="labelText"><asp:Label ID="lbl382" runat="server" Text="Label" Visible="false"  /></td><td colspan="2"><asp:Label ID="lblFinalizer" runat="server" Text=""  Width="100%" Visible="false"></asp:Label></td></tr>                                       

                    <tr><td class="labelText" valign="top"><asp:Label ID="lbl55" runat="server" Text="Label" />(s)</td><td colspan="2"><asp:Label ID="lblAdmin" runat="server" Text=""  Width="100%"></asp:Label></td></tr>
                    <tr style="height:60px;"><td colspan="2" valign="bottom" align="center"><div style="position:relative;left:50px;"><asp:Button ID="cmdSave" class="button1" runat="server" Text="140" Height="30px"/></div></td></tr>                
                </table>
            </div>
            
            <div id="tabs-2">
                <table border="0" width="50%">
                    <tr><td colspan="10"><asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" Width="95%"  ControlToValidate="txtNewPassword" ErrorMessage="Password must be at least 8 characters, at least 1 numeric digit and 1 of the following special characters ! @ # $ & _" ValidationExpression= "^(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$&_]).{8,20}$" /></td></tr>
                    <tr><td width="50%" class="labelText"><asp:Label ID="lbl153" runat="server" Text="Label" /></td><td width="50%"><asp:TextBox ID="txtOldPassword" runat="server" Width="93%" TextMode="Password"></asp:TextBox><asp:RequiredFieldValidator  ID="RequiredFieldValidator1" runat="server" ErrorMessage="*" ControlToValidate="txtOldPassword"  ValidationGroup="NewPwd"></asp:RequiredFieldValidator></td></tr>                        
                    <tr><td class="labelText"><asp:Label ID="lbl154" runat="server" Text="Label" /></td><td><asp:TextBox ID="txtNewPassword" runat="server" TextMode="Password" Width="93%"></asp:TextBox><asp:RequiredFieldValidator  ID="RequiredFieldValidator2" runat="server" ErrorMessage="*" ControlToValidate="txtNewPassword" ValidationGroup="NewPwd"></asp:RequiredFieldValidator></td></tr>                                
                    <tr><td class="labelText"><asp:Label ID="lbl155" runat="server" Text="Label" /></td><td><asp:TextBox ID="txtConfirm" runat="server" TextMode="Password" Width="93%"></asp:TextBox><asp:RequiredFieldValidator  ID="RequiredFieldValidator3" runat="server" ErrorMessage="*" ControlToValidate="txtConfirm"  ValidationGroup="NewPwd"></asp:RequiredFieldValidator></td></tr>
                    <tr><td></td><td colspan="10"><asp:CompareValidator ID="CompareValidator1" runat="server" ErrorMessage="Passwords don't match" ControlToValidate="txtConfirm" ControlToCompare="txtNewPassword"></asp:CompareValidator></td></tr>        
                    <tr><td align="right" colspan="2"><asp:Button ID="cmdSavePassword" class="button1" runat="server" Text="140" CausesValidation="true" Height="30px" ValidationGroup="NewPwd" /></td></tr>                                                
                </table>

                <div style="position:absolute;top:75px;left:510px;width:285px; height:400px; background-image:url(../images/bggrey.png); background-repeat:no-repeat;">
                    <table>
                        <tr valign="bottom" style="height:30px; font-weight:bold;"><td class="labelText">&nbsp;&nbsp;<asp:Label ID="lbl156" runat="server" Text="Label"></asp:Label> </td></tr>
                        <tr style="height:20px;"><td></td></tr>
                        <tr style="height:10px;"><td><img src="../images/bluebullet.png"/> <asp:Label ID="lbl231" runat="server" Text="Label"></asp:Label> </td></tr>
                        <tr style="height:35px;"><td><img src="../images/bluebullet.png"/> <asp:Label ID="lbl232" runat="server" Text="Label"></asp:Label> </td></tr>
                        <tr style="height:35px;"><td><img src="../images/bluebullet.png"/> <asp:Label ID="lbl233" runat="server" Text="Label"></asp:Label> </td></tr>
                        <tr style="height:35px;"><td><img src="../images/bluebullet.png"/> <asp:Label ID="lbl234" runat="server" Text="Label"></asp:Label> ! @ # $ & _</td></tr>
                    </table>
                </div>
            </div>
    </div>

    <asp:HiddenField ID="hdnSelectedTab" runat="server" Value="0" /> 

    <%--
    <br /><br />

    <a href="#" class="changePassword">Change Password</a><br /><br />
    
    
    <table>
        <tr id="Row-ChangePassword">
            <td>
                
            </td>
        </tr>
    </table>
    --%>
    
    
    <!--*********************************************************************-->
    <asp:SqlDataSource ID="sqlSupervisors" runat="server" 
        ConnectionString="<%$ ConnectionStrings:dbadvaloremConnStr %>" 
        SelectCommand="GetSupervisors" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="hdnOrgID" Name="OrgID" PropertyName="Value" 
                Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:HiddenField ID="hdnOrgID" runat="server" />
</asp:Content>
