﻿<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="index.aspx.vb" Inherits="Advataxes.index" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="act" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!-- Website template by freewebsitetemplates.com -->
<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>Advalorem</title>
	<link rel="stylesheet" href="css/style-home.css" type="text/css" charset="utf-8" />	
	<!--[if lte IE 7]>
		<link rel="stylesheet" href="css/ie.css" type="text/css" charset="utf-8" />	
	<![endif]-->
</head>

<body style=" background-image:url('images/bg2.png');">
 <form id="form1" runat="server">
    <asp:ScriptManager id="ScriptManager1" runat="server" />  
    
    <asp:Panel ID="pnlLogin" runat="server" CssClass="modalPopupLogin">
            <div style="position:absolute;left:100px;top:175px;">
                
                <asp:Login ID="Login2" runat="server" TextLayout="TextOnTop" DestinationPageUrl="Account/Reports.aspx" DisplayRememberMe="False" Height="189px"  Width="300px" TitleText="" >
                    <TextBoxStyle Width="250px" Height="25px" BorderStyle="solid" BorderWidth="1px" />
                </asp:Login>
            </div>
    </asp:Panel>

    <act:ModalPopupExtender ID="ModalPopupExtender1" runat="server"
        TargetControlID="cmdLogin"
        PopupControlID="pnlLogin"
        PopupDragHandleControlID="pnlLogin"
        DropShadow="false"
        BackgroundCssClass="modalBackground" />
   
    <asp:Button ID="Button1" runat="server" Text="Button" visible="true" />
	<div id="header">
		<table width="100%">
        
        <tr>
            <td width="95%">
                <a href="index.html" id="logo"><img src="images/advalorem.png" alt="LOGO" /></a>    
            </td>
            <td>
                [ <a href="Login.aspx?login=1">Login</a> ] <br />
                [ <a href="Login.aspx?login=0">Sign up</a> ]
                <asp:Button ID="cmdLogin" runat="server" Text="Button" />
            </td>
        </tr>
        </table>
        
		
        
        <div id="navigation">
			<ul>
				<li class="first selected"><a href="index.html">Home</a></li>
				<li><a href="about.html">About us</a></li>
				<li><a href="services.html">Services</a></li>
				<li><a href="solutions.html">Solutions</a></li>
				<li><a href="support.html">Support</a></li>
				<li><a href="blog.html">Blog</a></li>
				<li><a href="contact.html">Contact</a></li>
			</ul>
		</div>
		<div id="search">
			<form action="" method="">
				<input type="text" value="Search" class="txtfield" onblur="javascript:if(this.value==''){this.value=this.defaultValue;}" onfocus="javascript:if(this.value==this.defaultValue){this.value='';}" />
				<input type="submit" value="" class="button" />
			</form>
		</div>
	</div> <!-- /#header -->
	<div id="adbox">
		<div class="body">
			<div class="images">
				<img src="images/gears.png" alt="Img" class="preview" />
				<img src="images/shake-hands.jpg" alt="Img" height="144" width="230px" />
				
			</div>
			<div class="details">
				<p>
					<span>
                        This website template has been designed by <a href="http://www.freewebsitetemplates.com/">Free Website Templates</a> for you, for free.
					</span>
					You can remove any link to our website from this website template, you're free to use this website template without linking back to us.
				</p>
			</div>
		</div>
		<div class="footer">
			<ul>
				<li class="selected">
					<a href="index.html"><img src="images/meeting2.jpg" alt="Img" /></a>
					<p>
						<a href="index.html">Morbi quiseros sedquam interdum placerat</a><br/>
						Fusce placerat tellusdiam rutrum porttitor
					</p>
				</li>
				<li>
					<a href="index.html"><img src="images/flags2.jpg" alt="Img" /></a>
					<p>
						<a href="index.html">Ut posuere nibh in tortor</a><br/>
						Phasellusposuere semper loremsodales orci fringilla eget.
					</p>
				</li>
				<li>
					<a href="index.html"><img src="images/boys.jpg" alt="Img" /></a>
					<p>
						<a href="index.html">In sagittis lacus mollis nunc</a><br/>
						malesuada et facilisisipsum scelerisque
					</p>
				</li>
			</ul>
			<span class="bottom-shadow"></span>
		</div>
	</div> <!-- /#adbox -->
	<div id="contents">
		<div class="body">
			<div id="sidebar">
				<h3>Blog</h3>
				<ul>
					<li>
						Quisque iaculis erat in velit fermentum pellentesque. 
						<span>Sept. 21 | by Nullam <a href="blog.html">8</a></span>
					</li>
					<li>
						Semper. Cras eu elit velit. Nullam vel eros turpis.
						<span>Sept. 21 | by Nullam <a href="blog.html">8</a></span>
					</li>
					<li>
						Aenean id erat elit, quis venenatis erat. 
						Cras ornare orci vitae metus 
						<span>Sept. 21 | by Nullam <a href="blog.html">8</a></span>
					</li>
					<li>
						Vivamus euismod dictum purus ac semper. 
						Etiam sed elit id ante commodo
						<span>Sept. 21 | by Nullam <a href="blog.html">8</a></span>
					</li>
					<li>
						Fusce ac quam nibh, at pharetra dolor. 
						In quis odio arcu, vel laoreet eros. 
						Nam vel sem dui. 
						<span>Sept. 21 | by Nullam <a href="blog.html">8</a></span>
					</li>
				</ul>
			</div>
			<div id="main">
				<span>This website template has been designed by <a href="http://www.freewebsitetemplates.com/">Free Website Templates</a> for you, for free. You can replace all this text with your own text.</span>
				<ul>
					<li>
						<a href=""><img src="images/globe.jpg" alt="Img" /><h3>Lorem ipsum dolor sit amet</h3></a>
						<p>Donec venenatis, mauris in blandit tempor, sem tellus vehicula lorem</p>
					</li>
					<li>
						<a href=""><img src="images/tools.jpg" alt="Img" /><h3>Proin condiment porttitor ultrices</h3></a>
						<p>Cras tristique faucibus sagittis. Praesent pulvinar, dolor in posuere vulputate</p>
					</li>
					<li>
						<a href=""><img src="images/check.jpg" alt="Img" /><h3>Quisque consequat</h3></a>
						<p>Sed vitae massa at turpis mollis aliquam sed vitae tellus integer arcu</p>
					</li>
					<li>
						<a href=""><img src="images/graph.jpg" alt="Img" /><h3>Class aptent taciti sociosqu</h3></a>
						<p>Nam quis arcu erat ultricies volutpat leo, in molestie est laoreet eu</p>
					</li>
				</ul>
				<p>If you're having problems editing this website template, then don't hesitate to ask for help on the <a href="http://www.freewebsitetemplates.com/forum/">Forum</a>.</p>
			</div>
		</div>
	</div> <!-- /#contents -->
	<div id="footer">
		<ul class="contacts">
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
		</div>
		<span class="footnote">&copy; Copyright &copy; 2011. All rights reserved</span>
	</div> <!-- /#footer -->
    </form> 
</body>
</html>