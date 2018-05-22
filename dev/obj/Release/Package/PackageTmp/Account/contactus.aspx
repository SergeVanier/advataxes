<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="contactus.aspx.vb" Inherits="Advataxes.feedback" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
        <br />
        <table width="100%" height="300px" border=0>
            <tr>
                    <td width="23%" rowspan="6" valign="top"><img src="../images/contactus.png" width="90%" height="40%" /></td>
                    
                    <%If Session("contactus") <> "" Then%>
                        <td width="60%" colspan="2" valign="top"><asp:Label ID="lblMsg" runat="server" class="labelText" Text=""></asp:Label></td>
                            <td width="60%" colspan="2" valign="top"></td>
                            <td></td>
                            <td width="30%" align="right"><img src="../images/av.png" /></td>
                    
                            </tr>
                            
                            <tr>
                                <td valign="top" width="7%"></td>
                                <td valign="top"></td>
                                <td></td>

                            </tr>
                            <tr>
                                <td valign="top" width="7%" colspan="3"><a href="reports.aspx"><asp:Label ID="lbl480" runat="server" Text="Label" /></a></td>
                                <td valign="top"></td>
                                <td></td>

                            </tr>

                             <tr style="height:20px;">
                                <td></td>
                            </tr>
        
                            <tr>
                                <td colspan="2" valign="top">&nbsp;</td>
                            </tr>

                            <tr>
                            <td colspan="2" align="right" valign="middle">&nbsp;</td>

                    <%Else%>
                            <td width="60%" colspan="2" valign="middle" ><asp:Label ID="lbl462" runat="server" class="labelText" Text="Please provide any feedback or comments you may have regarding the Advataxes online service."></asp:Label></td>
                            <td width="30%" align="right"><img src="../images/av.png" /></td>
                    
                            </tr>

                            <tr>
                                <td valign="top" width="7%"><asp:Label ID="lbl" runat="server" Text="Type:" class="labelText"></asp:Label></td>
                                <td valign="top">
                                    <asp:DropDownList ID="cboTopic" runat="server"> 
                                        <asp:ListItem Value="0">Report a problem</asp:ListItem>
                                        <asp:ListItem Value="1">General Inquiry</asp:ListItem>
                                        <asp:ListItem Value="2">Submit a comment</asp:ListItem>
                                        <asp:ListItem Value="3">Other</asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                                <td></td>

                            </tr>

                            <tr>
                                <td valign="top" width="7%"><asp:Label ID="lbl463" runat="server" Text="Subject:" class="labelText"></asp:Label></td>
                                <td valign="top"><asp:TextBox ID="txtSubject" runat="server" Width="100%"></asp:TextBox></td>
                                <td></td>

                            </tr>

                             <tr style="height:40px;">
                                <td valign="bottom"><asp:Label ID="lbl48" runat="server" Text="Comment:" class="labelText"></asp:Label></td>
                            </tr>
        
                            <tr>
                                <td colspan="3" valign="top"><asp:TextBox ID="txtComment" runat="server" Width="100%" Height="125px" TextMode="MultiLine"></asp:TextBox></td>
                            </tr>

                            <tr>
                        <td colspan="2" align="left" valign="middle"><asp:Button ID="cmdSubmit" runat="server" Text="240" class="button1" /></td>

                    <%end if %>

                    <%Session("contactus") = ""%>
            
            </tr>
            <tr style="height:15px;"><td></td></tr>
            <tr style="height:0.1; background-color:#cd1e1e"><td colspan="10"></td></tr>
            
            <%If Session("emp").defaultlanguage = "English" Then%>
                <tr valign="top" style="height:40px;"><td colspan="10" class="labelText">Advataxes is a product of <a href="https://www.advalorem.ca">Advalorem Inc</a>, 1100 Crémazie Boulevard East, Suite 708, Montreal Qc Canada H2P 2X2 &nbsp;&nbsp;&nbsp; Tel: 1-877-818-6688 </td></tr>
            <%Else%>
                <tr valign="top" style="height:40px;"><td colspan="10" class="labelText">Advataxes est un produit de <a href="https://www.advalorem.ca">Advalorem Inc</a>, 1100 boulevard Crémazie Est, Bureau 708, Montréal Qc Canada H2P 2X2 &nbsp;&nbsp;&nbsp; Tél: 1-877-818-6688 </td></tr>
            <%End If%>

        </table>

</asp:Content>

