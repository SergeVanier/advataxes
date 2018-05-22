<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="Error.aspx.vb" Inherits="Advataxes._Error" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <br />

    <table>
        <tr>
            <td><img src="images/error.jpg" width="75px" height="75px" /></td>
            <td class="labelText">
                <%= Session("msg")%>
                <br />
                <%= Session("error")%>
            </td>
        </tr>
        <%--<tr>
            <td>
                <%= Server.GetLastError().ToString() %>
            </td>
        </tr>--%>
    </table>
    
    <%Session("msg") = Nothing%>   
    <%Session("error") = Nothing%>
</asp:Content>
