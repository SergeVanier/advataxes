<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="PasswordReset.aspx.vb" Inherits="Advataxes.PasswordReset" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
        <br />
        <table width="100%" height="300px" >
            <!--<tr style="height:50px;"><td colspan="10" ><asp:Label ID="Label2" runat="server" Text="New Password" style="color:#cd1e1e;font-size:large;"></asp:Label></td></tr>-->
            
            <!--<tr style="height:20px;"><td></td></tr>-->
            
            <tr valign="top">
                <td valign="top">
                    <img src="images/keyboard.jpg" />
                </td>
            
                <td width="35%" valign="top">
                    <table border="0"  width="95%">
                        <tr style="height:50px;"><td valign="top" class="labelText" style="font-size:1.5em;">Create Password</td></tr>
                        <tr style="height:50px;"><td width="25%" class="labelText">Password:</td></tr>
                            
                            <tr>
                                <td width="25%">
                                    <asp:TextBox ID="txtNewPassword" runat="server" TextMode="Password" Width="75%"></asp:TextBox><asp:RequiredFieldValidator  ID="RequiredFieldValidator2" runat="server" ErrorMessage="*" ControlToValidate="txtNewPassword" ValidationGroup="NewPwd"></asp:RequiredFieldValidator>
                                    
                                </td>
                            </tr>
                        
                        <tr style="height:50px;"><td class="labelText">Confirm Password:</td></tr>
                        <tr><td><asp:TextBox ID="txtConfirm" runat="server" TextMode="Password" Width="75%"></asp:TextBox><asp:RequiredFieldValidator  ID="RequiredFieldValidator3" runat="server" ErrorMessage="*" ControlToValidate="txtConfirm"  ValidationGroup="NewPwd"></asp:RequiredFieldValidator>
                                <br /><asp:CompareValidator ID="CompareValidator1" runat="server" ErrorMessage="Passwords don't match" ControlToValidate="txtConfirm" ControlToCompare="txtNewPassword" ValidationGroup="NewPwd"></asp:CompareValidator>
                            </td>
                        </tr>
                        <tr style="height:50px; vertical-align:bottom;">                            
                            <td colspan="2" align="right">              
                            <asp:CheckBox ID="cbDisplayPassword" runat="server" AutoPostBack="true" Text="Display password" />              
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;         
                            <asp:Button ID="cmdSavePassword" class="button1" runat="server" Text="Save" CausesValidation="true" Height="30px" ValidationGroup="NewPwd" /></td></tr>
                    </table>
                </td>
                <td width="45%">
                    <div style="position:relative;background-image:url(images/bggrey.png); background-repeat:no-repeat;height:230px;width:300px;">
                        <table >
                            <tr valign="bottom" style="height:30px; font-weight:bold;"><td class="labelText">&nbsp;&nbsp;Password must contain:</td></tr>
                            <tr style="height:20px;"><td></td></tr>
                            <tr style="height:10px;"><td class="labelText"><img src="../images/bluebullet.png"/> A minimum of 8 characters </td></tr>
                            <tr style="height:35px;"><td class="labelText"><img src="../images/bluebullet.png"/> At least one lower case alphanumeric</td></tr>
                            <tr style="height:35px;"><td class="labelText"><img src="../images/bluebullet.png"/> At least one numerical</td></tr>
                            <tr style="height:35px;"><td class="labelText"><img src="../images/bluebullet.png"/> and one special characters ! @ # $ & _ </td></tr>
                            
                        </table>
        
                    </div>
                
                </td>
            </tr>
            <tr style="height:30px; width:50%;"><td></td>
                <td colspan="3">
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="txtNewPassword" ErrorMessage="Password must be at least 8 characters including, at least 1 lower case alphanumeric, at least 1 numerical and 1 of the following special characters ! @ # $ & _" ValidationGroup="NewPwd" ValidationExpression= "^(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$&_]).{8,20}$" />
                </td>
            </tr>
           
        </table>
        
    
</asp:Content>
