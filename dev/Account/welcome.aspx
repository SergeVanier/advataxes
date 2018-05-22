<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="welcome.aspx.vb" Inherits="Advataxes.welcome" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
        <br />
        <table width="100%" style=" height:450px;" border=0>
             <tr>
                <td rowspan="2" width="18%" valign="top"><img src="../images/welcome.png" height="375px" /></td>
                <td valign="top" height="40px;" style=" font-size:1.9em;color:#cd1e1e;">Attention</td>
             </tr>
             <tr>
                <td valign="top">
                    <div style="height:325px; overflow:scroll;">
                        <br />
                        <table>
                            <tr>
                                <td class="labelText"><asp:Label ID="lblMsg" runat="server" Text=""></asp:Label></td>
                            </tr>
                     
                             <tr valign="bottom" style="height:40px;">
                                <td class="labelText" align="left"><asp:Button ID="cmdContinue" runat="server" Text="541" Height="30px" /></td>
                             </tr>
                     
                        </table>
                    </div>
                </td>
             </tr>
             <tr style="height:20px;"><td></td></tr>
             <tr style="height:0.1px; background-color:#cd1e1e;"><td colspan="2"></td></tr>
        </table>
    

</asp:Content>
