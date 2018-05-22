<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="subscribe.aspx.vb" Inherits="Advataxes.subscribe" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
                <script type="text/javascript" src="js/jquery-1.7.2.min.js"></script>
                
                <script>
                    $(document).ready(function () {
                        $('#<%=cmdRegister.ClientID %>').attr('disabled', 'disabled');
                        $("#Row-InvalidEmail").hide();
                        
                        $("#Row-UserAlreadyExists").hide();
                        $("#Row-Country").hide();
                        $("#<%=chkTermsOfUse.ClientID %>").checked = false;

                        $("#<%=txtEmail.ClientID %>").change(function () {
                            //document.myform.email1
                            var status = false;
                            var emailRegEx = /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i;
                            var email = $("#<%=txtEmail.ClientID %>").val();

                            if (email.search(emailRegEx) == -1) {
                                $("#Row-InvalidEmail").show();
                                $('#<%=cmdRegister.ClientID %>').attr('disabled', 'disabled');
                            } else {
                                $("#Row-InvalidEmail").hide();
                            }
                        });


                        $("#<%=cboType.ClientID %>").change(function () {
                            if ($(this).val() == 1) {
                                alert('Advataxes does not currently support non-profit organizations. Please check back again in the near future for this feature.');
                                $("#<%=cmdRegister.ClientID %>").prop('disabled', 'disabled');

                            } else {
                                var satisfied = $('#<%=chkTermsOfUse.ClientID %>:checked').val();

                                if (satisfied != undefined)
                                    $('#<%=cmdRegister.ClientID %>').removeAttr('disabled');
                                else
                                    $('#<%=cmdRegister.ClientID %>').attr('disabled', 'disabled');

                            }

                        });

                        $("#<%=cboProvince.ClientID %>").change(function () {
                            if ($("#<%=cboProvince.ClientID %>").val() < 14) {
                                $("#<%=cboCountry.ClientID %>").val(1);
                                $("#Row-Country").hide();
                            }
                            else {
                                $("#<%=cboCountry.ClientID %>").val(2);
                                $("#Row-Country").show();
                            }
                        });

                        $("#<%=cboCountry.ClientID %>").change(function () {
                            if ($("#<%=cboProvince.ClientID %>").val() == 14 && $("#<%=cboCountry.ClientID %>").val() == 1) {
                                alert('Invalid selection');
                                $("#<%=cboCountry.ClientID %>").val(2);
                            }
                        });


                        $("#<%=chkTermsOfUse.ClientID %>").click(function () {

                            if ($("#<%=cboType.ClientID %>").val() > 1) {
                                var satisfied = $('#<%=chkTermsOfUse.ClientID %>:checked').val();

                                if (satisfied != undefined)
                                    if ($("#<%=lblInvalidUsername.ClientID %>").text() == "") {
                                        $("#<%=hdnTermsAccepted.ClientID %>").val('True');
                                        $('#<%=cmdRegister.ClientID %>').removeAttr('disabled');
                                    }
                                    else {
                                        $("#<%=hdnTermsAccepted.ClientID %>").val('');
                                        $('#<%=cmdRegister.ClientID %>').attr('disabled', 'disabled');
                                    }
                            }
                        });

                        $("#<%=txtUsername.ClientID %>").keyup(function () {
                            var username = $("#<%=txtUserName.ClientID %>").val();

                            $.ajax({
                                type: "POST",
                                url: "subscribe.aspx/CheckUsername",
                                data: "{'username': '" + username + "'}",
                                contentType: "application/json; charset=utf-8",
                                dataType: "json",
                                async: true,
                                cache: false,
                                success: function (returnVal) {

                                    if (returnVal.d != 0) {
                                        $("#<%=lblInvalidUsername.ClientID %>").text("Username already exists");
                                        $("#Row-UserAlreadyExists").show();
                                        $("#<%=hdnGoodUsername.ClientID %>").val('');
                                    }
                                    else {
                                        $("#<%=lblInvalidUsername.ClientID %>").text("");
                                        $("#Row-UserAlreadyExists").hide();
                                        $("#<%=hdnGoodUsername.ClientID %>").val('True');
                                    }
                                }
                            });
                        });


                        $(".popUpWin").click(function () {
                            var iMyWidth;
                            var iMyHeight;
                            //half the screen width minus half the new window width (plus 5 pixel borders).
                            iMyWidth = (window.screen.width / 2) - (350 + 10);
                            //half the screen height minus half the new window height (plus title and status bars).
                            iMyHeight = (window.screen.height / 2) - (150 + 50);
                            //Open the window.
                            var win2 = window.open("../info.aspx?id=" + $(this).attr("id"), "Info", "status=no,height=300,width=700,resizable=yes,left=" + iMyWidth + ",top=" + iMyHeight + ",screenX=" + iMyWidth + ",screenY=" + iMyHeight + ",toolbar=no,menubar=no,scrollbars=no,location=no,directories=no");
                            win2.focus();
                        });

                    });
                </script>


</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
        <!-- Google Code for Subscription Conversion Page -->
        <script type="text/javascript">
        /* <![CDATA[ */
        var google_conversion_id = 1011812024;
        var google_conversion_language = "en";
        var google_conversion_format = "2";
        var google_conversion_color = "ffffff";
        var google_conversion_label = "cbSOCNieuQUQuI284gM";
        var google_conversion_value = Sbuscription;
        /* ]]> */
        </script>
        <script type="text/javascript" src="//www.googleadservices.com/pagead/conversion.js">
        </script>
        <noscript>
        <div style="display:inline;">
        <img height="1" width="1" style="border-style:none;" alt="" src="//www.googleadservices.com/pagead/conversion/1011812024/?value=Sbuscription&amp;label=cbSOCNieuQUQuI284gM&amp;guid=ON&amp;script=0"/>
        </div>
        </noscript>

       <div style="position:relative;top:-20px;">
           <table width="100%" height="50" cellpadding="1" cellspacing="0" border=0>
               <tr><td width="77%" ><table width="100%" border=0><tr><td align="left" width="90%" style="font-size:1.6em;"><asp:Label ID="lbl304" runat="server" Text="Label"></asp:Label></td><td align="right"><img src="images/av.png" width="100%" height="100%" /></td></tr></table></td></tr> 
           </table> 
        </div>
             

       <div style="position:relative;top:-45px;left:8px;color:#cd1e1e;"><%If Session("language") = "French" Then%><asp:Label ID="lbl314" runat="server" Text="Label" style="color:#cd1e1e; font-weight:bold;"></asp:Label><br /><%End If%><asp:Label ID="lbl305" runat="server" Text="Label" /></div>
        

       <div id="billinginfo" style="position:relative;top:-35px;background-image:url(images/login3.png); background-repeat:no-repeat;">
           <table width="100%" height="300" cellpadding="1" cellspacing="0" border="0">
                <tr style="height:10px;"><td></td></tr>
                <tr>
                    <td width="50%" valign="top" >
                        <table border="0" width="100%">
                            
                            <tr>
                                <td width="30%" class="labelText">&nbsp;&nbsp;<asp:Label ID="lbl289" runat="server" Text="Label"></asp:Label></td><td>
                                    
                                    <asp:DropDownList ID="cboType" runat="server" DataSourceID="sqlType" DataTextField="ORG_TYPE_NAME" DataValueField="ORG_TYPE_ID">
                                    </asp:DropDownList>
                                    
                                    <asp:SqlDataSource ID="sqlType" runat="server"  ConnectionString="<%$ ConnectionStrings:dbadvaloremConnStr %>" 
                                            SelectCommand="GetOrgTypes" SelectCommandType="StoredProcedure">
                                            <SelectParameters>
                                                <asp:SessionParameter SessionField="language" Name="language" Type="String" />
                                            </SelectParameters>
            
                                        </asp:SqlDataSource>
                                    
                            
                                    <a id="5" href="#"  class="popUpWin"><img src="images/question.png" width="17px" height="17px"  /></a>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ErrorMessage="*" ControlToValidate="cboType" ValidationGroup="New"></asp:RequiredFieldValidator><br /></td>
                            </tr>

                            <tr>
                                <td width="40%" class="labelText">&nbsp;&nbsp;<asp:Label ID="lbl290" runat="server" Text="Label"></asp:Label></td><td><asp:TextBox ID="txtOrg" runat="server" Width="85%" ></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="*" ControlToValidate="txtOrg" ValidationGroup="New"></asp:RequiredFieldValidator><br /></td>
                            </tr>

                            <tr>
                                <td class="labelText">&nbsp;&nbsp;<asp:Label ID="lbl291" runat="server" Text="Label"></asp:Label></td><td><asp:TextBox ID="txtFName" runat="server" Width="85%"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="*" ControlToValidate="txtFName" ValidationGroup="New"></asp:RequiredFieldValidator><br /></td>
                            </tr>
                
                            <tr>
                                <td class="labelText">&nbsp;&nbsp;<asp:Label ID="lbl292" runat="server" Text="Label"></asp:Label></td><td><asp:TextBox ID="txtLName" runat="server" Width="85%"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ErrorMessage="*" ControlToValidate="txtLName" ValidationGroup="New"></asp:RequiredFieldValidator><br /></td>
                            </tr>

                            <tr>
                                <td class="labelText">&nbsp;&nbsp;<asp:Label ID="lbl293" runat="server" Text="Label"></asp:Label></td><td><asp:TextBox ID="txtTitle" runat="server"  Width="85%"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ErrorMessage="*" ControlToValidate="txtTitle" ValidationGroup="New"></asp:RequiredFieldValidator><br /></td>
                            </tr>
                
                            <tr>
                                <td class="labelText">&nbsp;&nbsp;<asp:Label ID="lbl294" runat="server" Text="Label"></asp:Label></td><td><asp:TextBox ID="txtEmail" runat="server" Width="85%"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ErrorMessage="*" ControlToValidate="txtEmail" ValidationGroup="New"></asp:RequiredFieldValidator><br /></td>
                            </tr>

                            <tr id="Row-InvalidEmail"> 
                                <td></td>
                                <td><asp:Label runat="server" ID="Label1" Visible="true" ForeColor="Red" Font-Bold="true" text="Invalid email address" /></td>
                            </tr>

                            <tr>
                                <td width="30%" class="labelText">&nbsp;&nbsp;<asp:Label ID="lbl298" runat="server" Text="Label"></asp:Label></td><td>
                                    <asp:DropDownList ID="cboProvince" runat="server" DataSourceID="sqlJurisdictions" DataTextField="JUR_NAME" DataValueField="JUR_ID">
                                        <asp:ListItem></asp:ListItem>                                       
                                    </asp:DropDownList>
                                    
                                    <asp:SqlDataSource ID="sqlJurisdictions" runat="server"   ConnectionString="<%$ ConnectionStrings:dbadvaloremConnStr %>" 
                                            SelectCommand="GetJurisdictions" SelectCommandType="StoredProcedure">
                                            <SelectParameters>
                                                <asp:SessionParameter SessionField="language" Name="language" Type="String" />
                                            </SelectParameters>
                                            
                                    </asp:SqlDataSource>

                                <asp:RequiredFieldValidator ID="RequiredFieldValidator12" runat="server" ErrorMessage="*" ControlToValidate="cboProvince" ValidationGroup="New"></asp:RequiredFieldValidator><br /></td>
                            </tr>

                            <tr id="Row-Country">
                                <td width="30%" class="labelText">&nbsp;&nbsp;<asp:Label ID="lbl315" runat="server" Text="Country"></asp:Label></td><td>
                                    <asp:DropDownList ID="cboCountry" runat="server" DataSourceID="sqlCountries" DataTextField="COUNTRY_NAME" DataValueField="COUNTRY_ID" />
                                    <asp:SqlDataSource ID="sqlCountries" runat="server"   ConnectionString="<%$ ConnectionStrings:dbadvaloremConnStr %>" SelectCommand="GetCountries" SelectCommandType="StoredProcedure" />                                           
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server" ErrorMessage="*" ControlToValidate="cboCountry"  ValidationGroup="New"/><br />
                                </td>
                            </tr>

                            <tr>
                                <td class="labelText">&nbsp;&nbsp;<asp:Label ID="lbl295" runat="server" Text="Label"></asp:Label></td><td><asp:TextBox ID="txtAddress" runat="server" Width="85%"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="*" ControlToValidate="txtAddress" ValidationGroup="New"></asp:RequiredFieldValidator><br /></td>
                            </tr>

                            <tr>
                                <td class="labelText">&nbsp;&nbsp;<asp:Label ID="lbl296" runat="server" Text="Label"></asp:Label></td><td><asp:TextBox ID="txtAddress2" runat="server" Width="85%"></asp:TextBox></td> 
                                
                            </tr>

                            <tr>
                                <td class="labelText">&nbsp;&nbsp;<asp:Label ID="lbl297" runat="server" Text="Label"></asp:Label></td><td><asp:TextBox ID="txtCity" runat="server" Width="85%"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator11" runat="server" ErrorMessage="*" ControlToValidate="txtCity" ValidationGroup="New"></asp:RequiredFieldValidator><br /></td>
                            </tr>

                            <tr>
                                <td class="labelText">&nbsp;&nbsp;<asp:Label ID="lbl299" runat="server" Text="Label"></asp:Label></td><td><asp:TextBox ID="txtPostal" runat="server" Width="30%"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="*" ControlToValidate="txtPostal" ValidationGroup="New"></asp:RequiredFieldValidator><br /></td>
                            </tr>

                            <tr>
                                <td class="labelText">&nbsp;&nbsp;<asp:Label ID="lbl300" runat="server" Text="Label"></asp:Label></td><td><asp:TextBox ID="txtPhone" runat="server" Width="50%"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator13" runat="server" ErrorMessage="*" ControlToValidate="txtPhone" ValidationGroup="New"></asp:RequiredFieldValidator><br /></td>
                            </tr>

                            <%If IsNothing(Session("upgrade")) Then%>
                                                        
                                <tr id="Row-Username">
                                    <td class="labelText">&nbsp;&nbsp;<asp:Label ID="lbl301" runat="server" Text="Label"></asp:Label></td><td><asp:TextBox ID="txtUserName" runat="server"  Width="50%"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator14" runat="server" ErrorMessage="*" ControlToValidate="hdnGoodUserName" ValidationGroup="New"></asp:RequiredFieldValidator><br /></td>
                                </tr>
                            
                                <tr id="Row-UserAlreadyExists"> 
                                    <td></td>
                                    <td><asp:Label runat="server" ID="lblInvalidUserName" Visible="true" ForeColor="Red" Font-Bold="true"  ></asp:Label></td>
                                </tr>

                                <tr id="Row-Password">
                                    <td class="labelText">&nbsp;&nbsp;<asp:Label ID="lbl302" runat="server" Text="Label"></asp:Label></td><td><asp:TextBox ID="txtPassword" runat="server" Width="50%" textmode="Password" ></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator15" runat="server" ErrorMessage="*" ControlToValidate="txtPassword" ValidationGroup="New"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr  id="Row-CPassword">
                                    <td class="labelText" valign="top">&nbsp;&nbsp;<asp:Label ID="lbl303" runat="server" Text="Label"></asp:Label></td><td><asp:TextBox ID="txtCPassword" runat="server" Width="50%" TextMode="Password"></asp:TextBox>                            
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator16" runat="server" ErrorMessage="*" ControlToValidate="txtCPassword" ValidationGroup="New"></asp:RequiredFieldValidator>
                                    <br /><asp:CompareValidator ID="CompareValidator1" runat="server" ErrorMessage="Passwords don't match" ControlToValidate="txtCPassword" ControlToCompare="txtPassword"></asp:CompareValidator>
                                    </td>
                                </tr>
                            <%end if  %>

                            <tr>
                                <td colspan="10"><asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat=server Width="95%"  ControlToValidate="txtPassword" ErrorMessage="Password must be at least 8 characters including, at least 1 lower case alphanumeric, at least 1 numerical and 1 of the following special characters ! @ # $ & _" ValidationExpression= "^(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$&_]).{8,20}$" /></td>
                            </tr>
                            
                            <tr><td colspan="2" align="right"><div style="position: relative;top:0px;left:-20px;width:100px;"></div> </td></tr>
                            <tr><td colspan="2" align="right"><div style="position: relative;top:-40px;left:-290px;width:300px;"></div></td></tr>
                        </table>
                
                    </td>
            
                    <td valign="top">
                        <table>
                            <tr>
                                <td><img src="images/signup.jpg" width="375px" height="320px"  /></td>
                            </tr>


                            <tr valign="bottom" style="height:50px;"><td><asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*" ControlToValidate="hdnTermsAccepted" ValidationGroup="New"></asp:RequiredFieldValidator><asp:CheckBox ID="chkTermsOfUse" runat="server" />
                            
                                <%If Session("language") = "English" Then%>
                                    I accept the <a href="javascript:window.location = 'https://www.advataxes.ca/en/terms-of-use.aspx';" >terms of use</a>                
                                <%else%>                            
                                    J'accepte les <a href="javascript:window.location = 'https://www.advataxes.ca/fr/conditions-utilisation.aspx';" >conditions d'utilisation</a>
                                <%end if %>
                            
                            </td></tr>                            

                            <tr valign="bottom" style="height:60px;"><td><asp:Button ID="cmdRegister" runat="server" Text="Continue >>" class="button2" CausesValidation="true" ValidationGroup="New"  />&nbsp;&nbsp;<asp:Button ID="cmdCancel" runat="server" Text="Cancel" class="button1" CausesValidation="false" Visible="false" /></td></tr>
                        </table>
                        
                    
                    </td>

                </tr>

                <tr style="height:15px;"><td width="5%"></td></tr>
                <tr><td width="5%"></td><td></td><td colspan="20" style="color:Blue;"><%=Session("msg")%></td></tr>
                <tr style="height:50px;"><td width="5%"></td></tr>
                <!--<tr style=" background-color:#cd1e1e;height:1px;"><td colspan="20" width="5%"></td></tr>            -->
               
           </table>

           
       </div>
       
       <div style="display:none;">
            <asp:TextBox ID="hdnTermsAccepted" runat="server" Visible="true" style="height:0px;"></asp:TextBox>
            <asp:TextBox ID="hdnGoodUsername" runat="server" Visible="true" style="height:0px;"></asp:TextBox>
       </div>
</asp:Content>
