<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="maintenance.aspx.vb" Inherits="WebApplication1.maintenance" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div style="position:relative;top:50px;width:200px;"><img src="/images/maintenance.jpg" width="200px" /></div>
    <div style="position:relative;top:-150px;left:250px;">
        <asp:Label ID="Label2" runat="server" Text="Entretien du site/Site Maintenance" Font-Size="2em" CssClass="labelText"></asp:Label><br /><br /><br />
        <asp:Label ID="Label1" runat="server" Text="Désolé, Advataxes n'est pas disponible." Font-Size="1.3em"></asp:Label><br /><br />
        <asp:Label ID="Label3" runat="server" Text="Veuillez revenir plus tard." Font-Size="1.3em"></asp:Label><br /><br />
        <div style=" background-image:url('/images/constructionline.png'); background-repeat:repeat-x; width:700px;height:20px;">&nbsp;</div><br />
        <asp:Label ID="Label4" runat="server" Text="Sorry, Advataxes is unavailable at the moment." Font-Size="1.3em"></asp:Label><br /><br />
        <asp:Label ID="Label5" runat="server" Text="Please check back at a later time." Font-Size="1.3em"></asp:Label>
    </div>
    
</asp:Content>
