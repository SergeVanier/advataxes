<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="payment.aspx.vb" Inherits="Advataxes.order" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" >

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta http-equiv="Content-Type" content="text/html;charset=ISO-8859-1" />
    <link href="css/style3.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="../../js/jquery-1.7.2.min.js"></script>

    <script type="text/javascript">

        $(document).ready(function () {
            //$("#a3").val($("#cboEmployees").val() * 90);
            $("#Row-GST").hide();
            $("#Row-HST").hide();
            $("#Row-QST").hide();

            $("#cboEmployees").change(function () {

                var record_id = $("#hdnJurID").val();
                var numOfEmp = $("#cboEmployees").val();

                $.ajax({
                    type: "POST",
                    url: "payment.aspx/Calculate",
                    data: "{'jurID': '" + record_id + "','numOfEmp': '" + numOfEmp + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (returnVal) {
                        var GST; var QST; var HST;

                        GST = returnVal.d[0];
                        $("#txtGST").val(GST.toFixed(2));
                        HST = returnVal.d[1];
                        $("#txtHST").val(HST.toFixed(2));
                        QST = returnVal.d[2];
                        $("#txtQST").val(QST.toFixed(2));

                        num = returnVal.d[3];
                        $("#txtSubTotal").val(num.toFixed(2));
                        
                        num = returnVal.d[4];
                        $("#txtTotal").val(num.toFixed(2));

                        if ($("#txtGST").val() == 0) { $("#Row-GST").hide(); } else { $("#Row-GST").show(); }
                        if ($("#txtHST").val() == 0) { $("#Row-HST").hide(); } else { $("#Row-HST").show(); }
                        if ($("#txtQST").val() == 0) { $("#Row-QST").hide(); } else { $("#Row-QST").show(); }
                        $("#Amount").val($("#txtTotal").val());
                    }
                });

            });

            $(".submit").click(function () {
                if ($("#cboEmployees").prop('selectedIndex') == 0)
                    alert("Please select number of employees before submitting");
                else
                    if ($("#txtTotal").val() != '0.00')
                        document.getElementById('frmSubmit').submit();
                    else
                        alert("Invalid Total");
            });

        });        
    </script>
</head>





<body style=" background-image:url('../images/bg2.png'); background-position:top; background-repeat:repeat-x;">

	<div id="header" class="2" style="max-width:2000px;" >
		<table width="100%" border="0">
            <tr>
                <td width="40%">
                    <a href="index.html" id="logo"><img src="../images/advataxes-en-tm.png" alt="LOGO" height="65%" width="55%" /></a>
                </td>

                <td valign="top" style=" text-align:right;">
                    <asp:Label ID="lblCompany" runat="server" Text="" style="font-weight:bold;"></asp:Label>
                <br />
                <asp:LoginView ID="HeadLoginView" runat="server" EnableViewState="false">
                        <AnonymousTemplate>
                            </span> <a href="~/Login.aspx" ID="HeadLoginStatus" runat="server"> Log In </a> 
                        </AnonymousTemplate>
                    </asp:LoginView>
                    
                    <div style="text-align:right;"><br /><a href="" onclick="javascript:alert('Version française disponible bientôt');">Français</a><%If Not IsNothing(Session("emp")) Then%> &nbsp;&nbsp;&nbsp;<a href="../account/contactus.aspx">Contact Us</a><%End If%></div>
                    
                </td>
            </tr>
        </table>


	</div> <!-- /#header -->
    <div id="contents" style="min-height:450px;" >
    <div id="background" class="background" style="margin:auto;max-width:2000px;border:none;">
    <div style=" vertical-align:middle;">
    <table border="0" style="height: 325px; background-image:url(../images/bg2.jpg);" width="99%">
                <tr>
                    
                    <td valign="top">
                        <div ID="MainContent" >
                        <form id="frmSubmit" action="https://www.paypal.com/cgi-bin/webscr" method="post">
                <!-- Identify your business so that you can collect the payments. -->  
                <input type="hidden" name="business" value="paypal@advalorem.ca" />  

                <!-- Specify a Subscribe button. -->  
                <input type="hidden" name="cmd" value="_xclick" />
                  
                <!-- Identify the subscription. -->  
                
                <input type="hidden" name="item_name" value="Advataxes: 1 year subscription" />
                <input type="hidden" name="hosted_button_id" value="6F2NN2CANRNYS" />
  
                <!-- Set the revised subscription price and terms. -->  
                <input type="hidden" name="currency_code" value="CAD" />  
                <input type="hidden" name="no_shipping" value="1" />  
                <input type="hidden" name="return" value="https://www.advataxes.ca/" />  
                <input type="hidden" name="image_url" value="https://www.advataxes.ca/images/advataxes-en-tm.png" />
                
                <input type="hidden" name="first_name" value="<%=session("firstName") %>" />
                <input type="hidden" name="last_name" value="<%=session("lastName") %>" />
                <input type="hidden" name="address1" value="<%=session("address1") %>" />
                <input type="hidden" name="address2" value="<%=session("address2") %>" />
                <input type="hidden" name="city" value="<%=session("city") %>" />
                <input type="hidden" name="zip" value="<%=session("postal") %>" />
                <input type="hidden" name="state" value="<%=session("jur") %>" />
                <input type="hidden" name="email" value="<%=session("email") %>" />
                <input type="hidden" name="custom" value="<%=session("username") %>" />
                <input type="hidden" id="Amount" name="amount" value="20.00" />
                <input type="hidden" id="Qty" name="quantity" value="1" />
                <input type="hidden" name="charset" value="ISO-8859-1" />
                <input type="hidden" name="on0" value="Number of employees" />
                                
            
            <table border="0">
                <tr><td colspan="10" style="color:#cd1e1e; font-size:2em;">Payment</td><td colspan="11" align="right"><img src="images/av.png" width="75px" height="50px" /></td></tr>
                <tr style="height:0.1px; background-color:#cd1e1e;"><td colspan="11"></td></tr>
                <tr style="height:20px;"><td colspan="10"></td></tr>                               
                <tr><td rowspan="10" valign="top"><img src="images/payment.png" width="200px" alt="" /></td><td></td><td></td><td rowspan="10" colspan="10" valign="top" style="color:#cd1e1e;"><table><tr style="height:20px;"><td></td></tr><tr><td  valign="middle"><img src="images/redbullet.png" alt="" /></td><td>Please contact Ad Valorem if you have more than 50 employees.</td></tr><tr style="height:20px;"><td></td></tr><tr><td><img src="images/redbullet.png" alt="" /></td><td valign="top">You will be redirected to Paypal when you click "Pay Now" to complete the transaction. </td></tr></table></td></tr>
                
                <tr style="height:50px;">
                    <td class="labelText" width="160px">Number of employees:</td>               
                    <td align="center">
                        <select id="cboEmployees" name="os0" style="width:50px;">
	                        <option value="0"></option>
                            <option value="5">5 </option>
                            <option value="6">6 </option>
                            <option value="7">7 </option>
                            <option value="8">8 </option>
                            <option value="9">9 </option>
                            <option value="10">10 </option>
	                        <option value="11">11 </option>
	                        <option value="12">12 </option>
                            <option value="13">13 </option>
                            <option value="14">14 </option>
                            <option value="15">15 </option>
                            <option value="16">16 </option>
                            <option value="17">17 </option>
                            <option value="18">18 </option>
                            <option value="19">19 </option>
                            <option value="20">20 </option>
                            <option value="21">21 </option>
                            <option value="22">22 </option>
	                        <option value="23">23</option>
	                        <option value="24">24 </option>
                            <option value="25">25 </option>
                            <option value="26">26 </option>
                            <option value="27">27 </option>
                            <option value="28">28 </option>
                            <option value="29">29 </option>
                            <option value="30">30 </option>
                            <option value="31">31 </option>
                            <option value="32">32 </option>
                            <option value="33">33 </option>
                            <option value="34">34 </option>
	                        <option value="35">35 </option>
	                        <option value="36">36 </option>
                            <option value="37">37 </option>
                            <option value="38">38 </option>
                            <option value="39">39 </option>
                            <option value="40">40 </option>
                            <option value="41">41 </option>
                            <option value="42">42 </option>
                            <option value="43">43 </option>
                            <option value="44">44 </option>
                            <option value="45">45 </option>
                            <option value="46">46 </option>
	                        <option value="47">47 </option>
	                        <option value="48">48 </option>
                            <option value="49">49 </option>
                            <option value="50">50 </option>
                            
                        </select> 
                    </td>
                </tr>
                
                <tr style="height:50px;">
                    <td class="labelText">Jurisdiction:</td>    
                    <td><input id="txtJur" type="text" value="<%=session("jur") %>"  readonly="readonly" style="border:none;text-align:center;" /></td>
                </tr>

                <tr id="Row-SubTotal" style="height:50px;">
                    <td class="labelText">Sub-Total:</td>
                    <td align="left">$ <input id="txtSubTotal" type="text" style="border:none;width:88px; text-align:right;" value="0.00" readonly="readonly" /></td>
                </tr>

                <tr id="Row-GST">
                    <td class="labelText">GST:</td>
                    <td align="left">$ <input id="txtGST" type="text" style="border:none;width:88px; text-align:right;" readonly="readonly" /></td>
                </tr>
                <tr id="Row-HST">
                    <td class="labelText">HST:</td>
                    <td align="left">$ <input id="txtHST" type="text" style="border:none;width:88px; text-align:right;" readonly="readonly" /></td>
                </tr>
                <tr id="Row-QST">
                    <td class="labelText">QST:</td>
                    <td align="left">$ <input id="txtQST" type="text" style="border:none;width:88px; text-align:right;" readonly="readonly" /></td>
                </tr>
                
                <tr style=" background-color:silver;height:0.1px;"><td colspan="2"></td></tr>
                <tr>
                    <td class="labelText">Total:</td>
                    <td align="left">$ <input id="txtTotal" type="text" value="0.00"  readonly="readonly" style="border:none;width:88px; text-align:right;" /></td>
                </tr>

                <tr valign="bottom" align="right" style="height:75px;"><td colspan="2"><div style="position:relative;left:-155px;top:52px;"><img src="images/paypal.png" alt="" /></div><a href="#"><img alt="" src="https://www.paypalobjects.com/en_US/i/btn/btn_paynowCC_LG.gif" class="submit" /></a>
                </td></tr>
                
               
            </table>

            <table width="100%">
                <tr style="height:10px;"><td colspan="11"></td></tr>
                <tr style="height:0.1px; background-color:#cd1e1e;"><td colspan="11"></td></tr>
                <tr><td align="right" colspan="11"><img src="images/symantec.png" alt="" /></td></tr>
            </table>            
                       
            
            <img alt="" border="0" src="https://www.paypalobjects.com/en_US/i/scr/pixel.gif" width="1" height="1" />

                <input id="hdnJurID" type="hidden" value="<%=session("jurID") %>"  />
        </form>
                        </div>
                    </td>
                </tr>
            </table>
            </div>

     
    </div>
    </div>
    <div id="footer">
<%--		<ul class="contacts">
			<h3>Contact Us</h3>
			<li><span>Email</span><p>: company@email.com</p></li>
			<li><span>Address</span><p>: 189 Lorem Ipsum Pellentesque, Mauris Etiam ut velit odio Proin id nisi enim 0000</p></li>
			<li><span>Phone</span><p>: 117-683-9187-000</p></li>
		</ul>
		<ul id="connect">
			<h3>Get Updated</h3>
			<li><a href="blog.html">Blog</a></li>
			<li><a href="http://facebook.com/freewebsitetemplates" target="_blank">Facebook</a></li>
			<li><a href="http://twitter.com/fwtemplates" target="_blank">Twitter</a></li>
		</ul>
		<div id="newsletter">
			<p><b>Sign-up for Newsletter</b>
				In sollicitudin vulputate metus, sed commodo diam elementum nec. Sed et risus sed magna convallis adipiscing.
			</p>
			<form action="" method="">
				<input type="text" value="Name" class="txtfield" onblur="javascript:if(this.value==''){this.value=this.defaultValue;}" onfocus="javascript:if(this.value==this.defaultValue){this.value='';}" />
				<input type="text" value="Enter Email Address" class="txtfield" onblur="javascript:if(this.value==''){this.value=this.defaultValue;}" onfocus="javascript:if(this.value==this.defaultValue){this.value='';}" />
				<input type="submit" value="" class="button" />
			</form>
		    
        </div>--%>
		<span class="footnote"><table width="100%"><tr><td align="left">Copyright &copy; 2012. AdValorem Inc. | All rights reserved</td><td align="right"><a href="javascript:window.open('https://www.advataxes.ca/privacy-policy.html')">Privacy Statements</a> | <a href="javascript:window.open('https://www.advataxes.ca/terms-of-use.html')">Terms of use</a></td></tr></table> </span>
	</div> <!-- /#footer -->

        <script type="text/javascript">

            window.onload = function () {

                var divWidth;
                var minWdith;

                if (document.body.clientWidth <= 800) {
                    divWidth = "90%";
                    minWidth = "600px";
                }
                else if (document.body.clientWidth <= 1400) {
                    divWidth = "70%";
                    minWidth = "800px";
                }
                else {
                    divWidth = "50%";
                    minWidth = "900px";
                }

                document.getElementById("background").style.width = divWidth;
                document.getElementById("background").style.minWidth = minWidth;
                document.getElementById("header").style.width = divWidth;
                document.getElementById("header").style.minWidth = minWidth;

            } 

    </script>
</body>
</html>
