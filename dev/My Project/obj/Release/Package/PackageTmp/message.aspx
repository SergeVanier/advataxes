<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="message.aspx.vb" Inherits="Advataxes.message" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .style4
        {
            width: 85%;
        }
        .style5
        {
            width: 157px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    
    <table width="100%">
         <tr style="height:20px;"><td class="style5"></td></tr>
         <tr>
            <td colspan="2" style=" font-size:1.9em;color:#cd1e1e;"><asp:Label ID="lblMsgTitle" runat="server" Text="Label"></asp:Label></td>
         </tr>
         <tr style="height:0.1px; background-color:#cd1e1e;"><td colspan="2"></td></tr>
         <tr style="height:20px;"><td class="style5"></td></tr>
         <tr>
            <td class="style5"><img src="../images/welcome.png" /></td>

            <td valign="top" class="style4">
                <table>
                     <tr style="height:40px;">
                        <td class="labelText" align="left"><asp:Label ID="lblMsg" runat="server" Text="Label"></asp:Label></td>
                     </tr>
                </table>
            </td>
         </tr>
         <tr style="height:20px;"><td class="style5"></td></tr>
         <tr style="height:0.1px; background-color:#cd1e1e;"><td colspan="2"></td></tr>
    </table>
    <%Session("message") = Nothing%>
    <%Session("msgTitle") = Nothing%>
    <%Session("error") = Nothing%>
</asp:Content>
