<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="SignUp.aspx.vb" Inherits="Advataxes.SignUp" %>
    
    <asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">


            <script type="text/javascript" src="../../js/jquery-1.7.2.min.js"></script>

             <script type="text/javascript">

                 $(document).ready(function () {
                     $("#Row-UserAlreadyExists").hide();
                     $('#<%=cmdRegister.ClientID %>').attr('disabled', 'disabled');

                     $("#<%=chkTermsOfUse.ClientID %>").checked = false;

                     $("#<%=txtEmail.ClientID %>").change(function () {
                         //document.myform.email1
                         var status = false;
                         var emailRegEx = /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i;
                         var email = $("#<%=txtEmail.ClientID %>").val();

                         if (email.search(emailRegEx) == -1) {
                             alert("Invalid email address");
                             $('#<%=cmdRegister.ClientID %>').attr('disabled', 'disabled');
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

                     $("#<%=chkTermsOfUse.ClientID %>").click(function () {

                         if ($("#<%=cboType.ClientID %>").val() != 1) {
                             var satisfied = $('#<%=chkTermsOfUse.ClientID %>:checked').val();

                             if (satisfied != undefined) {
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
                             url: "signup.aspx/CheckUsername",
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
            <!-- Google Code for Free trial Conversion Page -->
            <script type="text/javascript">
            /* <![CDATA[ */
            var google_conversion_id = 1011812024;
            var google_conversion_language = "en";
            var google_conversion_format = "2";
            var google_conversion_color = "ffffff";
            var google_conversion_label = "I78oCOCduQUQuI284gM";
            var google_conversion_value = Free trial;
            /* ]]> */
            </script>
            <script type="text/javascript" src="//www.googleadservices.com/pagead/conversion.js">
            </script>
            <noscript>
            <div style="display:inline;">
            <img height="1" width="1" style="border-style:none;" alt="" src="//www.googleadservices.com/pagead/conversion/1011812024/?value=Free%20trial&amp;label=I78oCOCduQUQuI284gM&amp;guid=ON&amp;script=0"/>
            </div>
            </noscript>

       <div style="position:relative;top:-30px;">

           <table width="100%" height="50" cellpadding="1" cellspacing="0" border=0>
               <tr>
                  <td width="77%" ><table width="100%" border=0><tr><td align="left" width="90%" style="color:navy;font-size:1.6em;"><asp:Label ID="lbl308" runat="server" Text="Label"></asp:Label></td><td align="right"><img src="images/av.png" width="100%" height="100%" /></td></tr></table></td>
                </tr> 
           </table> 
        </div>
       <div style="position:relative;top:-50px;left:8px;color:#cd1e1e;"><%If Session("language") = "French" Then%><asp:Label ID="lbl314" runat="server" Text="Label" style="color:#cd1e1e; font-weight:bold;"></asp:Label><br /><%End If%><asp:Label ID="lbl305" runat="server" Text="Label"></asp:Label></div>
       
       <div style="position:relative;top:-35px;background-image:url(images/login.png); background-repeat:no-repeat;">
           <table width="100%" height="300" cellpadding="1" cellspacing="0" border="0">
                <tr style="height:10px;"><td></td></tr>
                <tr>
                                
    <%--                <td width="20%" valign="top">
                            <div>
                                <img src="images/register.jpg" width="200px" height="150px" />
                            </div>                                       
                            <div style="position:relative;top:65px;">
                                <!--<a href="#" onclick="javascript:bookmark();">Bookmark this page</a>-->
                            </div>
                    </td>
               
    --%>                               

                    <td width="52%" valign="top" >
                        <table width="100%">
                            
                            <tr>
                                <td width="40%" class="labelText">&nbsp;&nbsp;<asp:Label ID="lbl289" runat="server" Text="Label"></asp:Label></td><td>
                                    <asp:DropDownList ID="cboType" runat="server" DataSourceID="sqlType" DataTextField="ORG_TYPE_NAME" DataValueField="ORG_TYPE_ID" >
                                    </asp:DropDownList>

                                    <asp:SqlDataSource ID="sqlType" runat="server"  ConnectionString="<%$ ConnectionStrings:dbadvaloremConnStr %>" SelectCommand="GetOrgTypes" SelectCommandType="StoredProcedure">
                                        <SelectParameters>
                                            <asp:SessionParameter SessionField="language" Name="language" Type="String" />
                                        </SelectParameters>
                                    </asp:SqlDataSource>

                                    <a id="5" href="#"  class="popUpWin"><img src="images/question.png" width="17px" height="17px"  /></a>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ErrorMessage="*" ControlToValidate="cboType"></asp:RequiredFieldValidator><br /></td>
                            </tr>

                            <tr>
                                <td width="30%" class="labelText">&nbsp;&nbsp;<asp:Label ID="lbl290" runat="server" Text="Label"></asp:Label></td><td><asp:TextBox ID="txtOrg" runat="server" Width="80%" ></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="*" ControlToValidate="txtOrg"></asp:RequiredFieldValidator><br /></td>
                            </tr>

                            <tr>
                                <td class="labelText">&nbsp;&nbsp;<asp:Label ID="lbl291" runat="server" Text="Label"></asp:Label></td><td><asp:TextBox ID="txtFName" runat="server" Width="80%"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="*" ControlToValidate="txtFName"></asp:RequiredFieldValidator><br /></td>
                            </tr>
                
                            <tr>
                                <td class="labelText">&nbsp;&nbsp;<asp:Label ID="lbl292" runat="server" Text="Label"></asp:Label></td><td><asp:TextBox ID="txtLName" runat="server" Width="80%"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ErrorMessage="*" ControlToValidate="txtLName"></asp:RequiredFieldValidator><br /></td>
                            </tr>

                            <tr>
                                <td class="labelText">&nbsp;&nbsp;<asp:Label ID="lbl293" runat="server" Text="Label"></asp:Label></td><td><asp:TextBox ID="txtTitle" runat="server"  Width="80%"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ErrorMessage="*" ControlToValidate="txtTitle"></asp:RequiredFieldValidator><br /></td>
                            </tr>
                
                            <tr>
                                <td class="labelText">&nbsp;&nbsp;<asp:Label ID="lbl294" runat="server" Text="Label"></asp:Label></td><td><asp:TextBox ID="txtEmail" runat="server" Width="80%"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ErrorMessage="*" ControlToValidate="txtEmail"></asp:RequiredFieldValidator><br /></td>
                            </tr>

                        

                            <tr>
                                <td class="labelText">&nbsp;&nbsp;<asp:Label ID="lbl301" runat="server" Text="Label"></asp:Label></td><td><asp:TextBox ID="txtUserName" runat="server"  Width="50%"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*" ControlToValidate="hdnGoodUsername"></asp:RequiredFieldValidator><br /></td>
                            </tr>
                            
                            <tr id="Row-UserAlreadyExists"> 
                                <td></td>
                                <td><asp:Label runat="server" ID="lblInvalidUsername" Visible="true" ForeColor="Red" Font-Bold="true"  ></asp:Label></td>
                            </tr>
                            
                            <tr>
                                <td class="labelText">&nbsp;&nbsp;<asp:Label ID="lbl302" runat="server" Text="Label"></asp:Label></td><td><asp:TextBox ID="txtPassword" runat="server" Width="50%" textmode="Password" ></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="*" ControlToValidate="txtPassword"></asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td class="labelText">&nbsp;&nbsp;<asp:Label ID="lbl303" runat="server" Text="Label"></asp:Label></td><td><asp:TextBox ID="txtCPassword" runat="server" Width="50%" TextMode="Password"></asp:TextBox>                            
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="*" ControlToValidate="txtCPassword"></asp:RequiredFieldValidator><br />
                                <asp:CompareValidator ID="CompareValidator1" runat="server" ErrorMessage="Passwords don't match" ControlToValidate="txtCPassword" ControlToCompare="txtPassword"></asp:CompareValidator>
                                </td>
                            </tr>

                            <%If Session("language") = "English" Then%>
                                <tr><td colspan="2" align="right"><table width="100%"><tr><td colspan="2" align="left"><asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server" ErrorMessage="*" ControlToValidate="hdnTermsAccepted"></asp:RequiredFieldValidator><asp:CheckBox ID="chkTermsOfUse" runat="server" />I accept the <a href="javascript:window.location = 'https://www.advataxes.ca/en/terms-of-use.aspx';" >terms of use</a></td>
                            <%Else%>
                                <tr><td colspan="2" align="right"><table width="100%"><tr><td colspan="2" align="left"><asp:RequiredFieldValidator ID="RequiredFieldValidator11" runat="server" ErrorMessage="*" ControlToValidate="hdnTermsAccepted"></asp:RequiredFieldValidator><asp:CheckBox ID="CheckBox1" runat="server" />J'accepte les <a href="javascript:window.location = 'https://www.advataxes.ca/fr/conditions-utilisation.aspx';" >conditions d'utilisation</a></td><td align="center"></td>
                            <%end if %>
                            
                            <td align="center"><asp:Button ID="cmdRegister" runat="server" Text="Start Trial" class="button2"  />&nbsp;&nbsp;<asp:Button ID="cmdCancel" runat="server" Text="Cancel" class="button1" CausesValidation="false" Visible="false" /></td></tr></table> </td></tr>
                            
                            <tr>
                                <td colspan="2"><asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" Width="100%"  ControlToValidate="txtPassword" ErrorMessage="Password must be at least 8 characters including, at least 1 lower case alphanumeric, at least 1 numerical and 1 of the following special characters ! @ # $ & _" ValidationExpression= "^(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$&_]).{8,20}$" /></td>
                            </tr> 

                        </table>
                
                    </td>
            
                    <td valign="top">
                          <table border=0 style="height:325px;width:425px;background-image:url('images/signup4.jpg');background-repeat:no-repeat;">
                            <tr style="height:50px;"><td style="color:navy;font-size:1.1em;"><b><asp:Label ID="lbl309" runat="server" Text="Label"></asp:Label></b></td></tr>
                            <tr style="height:20px;"><td><img src="images/todo.png"/> <asp:Label ID="lbl310" runat="server" Text="Label"></asp:Label></td></tr>
                            <tr style="height:20px;"><td><img src="images/todo.png"/> <asp:Label ID="lbl311" runat="server" Text="Label"></asp:Label></td></tr>
                            <tr style="height:20px;"><td><img src="images/todo.png"/> <asp:Label ID="lbl312" runat="server" Text="Label"></asp:Label></td></tr>
                            <tr style="height:30px;"><td></td></tr>
                            <tr style="height:30px;"><td></td></tr>
                          </table>
                          <!--<img src="images/signup.jpg" width="320px" height="200px"  />-->
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
