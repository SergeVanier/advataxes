<%@ Page Language="VB" src="/en/inc/mail.vb" inherits="customFunctions" %>
<html lang="en">
<head>
	<meta charset="utf-8">
	<title>Get one month free | Advataxes</title>
	<meta name="description" content="">


	<script runat="server" language="vb">
		Sub btnSend_Click(sender As Object, e As EventArgs)
			Dim returnValue As String

			Dim message As String
			Dim strBusinessType As String
			If ( businessType.Value = 1 ) Then
				strBusinessType = "Small or medium"
			Else If ( businessType.Value = 2 ) Then
				strBusinessType = "Large"
			End If

			message = "Name: " & txtName.Text & "<br><br>"
			message += "Email: " & txtEmail.text & "<br><br>"
			message += "Phone: " & txtPhone.text & "<br><br>"
			message += "Company: " & txtCompany.text & "<br><br>"
			message += "Business: " & strBusinessType & "<br><br>"
			message += "Approbation - Name: " & txtApprobationName.text & "<br><br>"
			message += "Approbation - Email: " & txtApprobationEmail.text & "<br><br>"

			returnValue = sendEmail(Me.txtEmail.Text, "Advataxes - Get one month free - " & txtName.Text, message)

			If returnValue = "1" Then
				Me.lblemailSent.Text = "<h3>Your message has been sent.</h3><h3>Thank you for your interest in Advataxes.</h3>"
			Else
				'Me.lblemailSent.Text = "Error: " & returnValue
				Me.lblemailSent.Text = "<h3>Oops! I'm sorry but something went wrong, we couldn't send the message. Please advise us by email so we can fix this issue at info@advalorem.ca.</h3>"
			End If
		End Sub
	</script>
 
<!-- #include file="/en/inc/header-html.inc" -->

<body>

<!-- #include file="/en/inc/header-menu.inc" -->	
	
<div class="clear"></div>

<div class="container-wrapper container-top">
	<div class="container container-top">
		<div class="row">
			<div class="col-md-12 center">
				<h1>Get one month free</h1>
			</div>
		</div><!-- end row -->
	</div><!-- end container -->
</div><!-- end container wrapper -->
	
<div class="container">
<div class="row">
	
<% If not IsPostBack Then %>
<div class="col-md-12">
<div class="widget">
				<h4>No credit card - No obligation<h4>
				<p>See for yourself how Advataxes is designed for your employees to handle, not only expenses but also the GST/HST and the QST.</p>
			</div><!-- end widget -->
</div>

		<div class="clear"></div>
		
		<div class="col-md-12 center" style="padding-top:0px;">
			<img src="/en/images/hand-building-bridge.jpg">
		</div>
		

<div class="col-md-12">
<form class="form-horizontal form-contact" runat="server">
		
<div class="form-group">
<label class="control-label" for="inputName">Name*</label>
<div class="controls">
<div class="row">
<div class="col-md-9">
					<div class="alert alertName" style="display:none;"><strong><i class="fa fa-exclamation-triangle"></i></strong> Enter a name.</div>
<asp:textbox id="txtName" runat="server" placeHolder="First and Last Name" class="form-control" />
</div><!-- end col -->
</div><!-- end row -->
</div><!-- end controls -->
</div><!-- end form-group -->
			
<div class="form-group">
<label class="control-label">Business Email*</label>
<div class="controls">
<div class="row">
<div class="col-md-9">
					<div class="alert alertEmail" style="display:none;"><strong><i class="fa fa-exclamation-triangle"></i></strong> Enter a valid email.</div>
<asp:textbox id="txtEmail" runat="server" placeholder="Email Address" class="form-control" />
</div><!-- end col -->
</div><!-- end row -->
</div><!-- end controls -->
</div><!-- end form-group -->

<div class="form-group">
<label class="control-label">Business Phone*</label>
<div class="controls">
<div class="row">
<div class="col-md-9">
					<div class="alert alertPhone" style="display:none;"><strong><i class="fa fa-exclamation-triangle"></i></strong> Enter a phone number.</div>
<asp:textbox id="txtPhone" runat="server" placeholder="Phone Number" class="form-control" />
</div><!-- end col -->
</div><!-- end row -->
</div><!-- end controls -->
</div><!-- end form-group -->
			
			<div class="form-group">
				<label class="control-label">Company Name*</label>
				<div class="controls">
					<div class="row">
						<div class="col-md-9">
							<div class="alert alertCompany" style="display:none;"><strong><i class="fa fa-exclamation-triangle"></i></strong> Enter a company name.</div>
							<asp:textbox id="txtCompany" runat="server" placeholder="Company Name" class="form-control" />
						</div><!-- end col -->
					</div><!-- end row -->
				</div><!-- end controls -->
			</div><!-- end form-group -->

			<div class="form-group">
				<div class="controls">
					<div class="row">
						<div class="col-md-9">
							<asp:HiddenField id="businessType" value="1" runat="server" />
							<label class="radio checked">
								<asp:RadioButton id="radio1" groupname="business" value="" runat="server" checked="" />
								<span></span>
								Small or medium business
							</label>
							<label class="radio">
								<asp:RadioButton id="radio2" groupname="business" value="" runat="server" />
								<span></span>
								Large business
							</label>
						</div><!-- end col -->
					</div><!-- end row -->
				</div><!-- end controls -->
			</div><!-- end form-group -->


<h4>Would you also like to try the approbation?</h4>
<p>If so, please provide us with the contact details of a colleague and you will be reviewing each other expense report</p>

			<div class="form-group">
              <label class="control-label">Name</label>
              <div class="controls">
                <div class="row">
                  <div class="col-md-9">
                    <asp:textbox id="txtApprobationName" runat="server" placeholder="Colleague's name" class="form-control" />
                  </div><!-- end col -->
                </div><!-- end row -->
              </div><!-- end controls -->
            </div><!-- end form-group -->

			<div class="form-group">
              <label class="control-label">Email</label>
              <div class="controls">
                <div class="row">
                  <div class="col-md-9">
                    <asp:textbox id="txtApprobationEmail" runat="server" placeholder="Colleague's email" class="form-control" />
                  </div><!-- end col -->
                </div><!-- end row -->
              </div><!-- end controls -->
            </div><!-- end form-group -->

<div class="form-actions form-actions-no-bg">
	<asp:button id="btnSend" text="Send" onclick="btnSend_Click" runat="server" class="btn btn-lg btn-purple"></asp:button>
</div>
</form>
		</div>

<% Else %>
<div class="col-md-12">
		<h3><asp:Label id="lblEmailSent" runat="server"></asp:Label></h3>
		</div>
<%End If %>	

		
		<div class="clear"></div>


						
</div>
</div><!-- end row -->
</div><!-- end container -->

<div class="clear"></div>

<!-- #include file="/en/inc/footer.inc" -->

<script src="/en/js/jquery-1.9.0-min.js"></script>
<script src="/en/js/bootstrap.js"></script>
<script src="/en/js/zion.js"></script>
<script src="/en/js/customSmoothScroll2.js"></script>

<script type="text/javascript">
		$("#radio1").click(function() {
			$("#businessType").attr("value", "1");
		});
		$("#radio2").click(function() {
			$("#businessType").attr("value", "2");
		});

		$("#cmdSubmit").click(function() {
			$(".alertName").css("display", "none");
			$(".alertEmail").css("display", "none");
			$(".alertPhone").css("display", "none");
			$(".alertCompany").css("display", "none");

			var error = 0;
			var formName = $("#txtName").val();
			var formEmail = $("#txtEmail").val();
			var regex = /^([a-zA-Z0-9_.+-])+\@(([a-zA-Z0-9-])+\.)+([a-zA-Z0-9]{2,4})+$/;
			var formPhone = $("#txtPhone").val();
			var formCompany = $("#txtCompany").val();
			
			if ( formName.length < 1 ) {
				error = 1;
				$(".alertName").css("display", "block");
			}
			if ( formEmail.length < 1 || !regex.test(formEmail) ) {
				error = 1;
				$(".alertEmail").css("display", "block");
			}
			if ( formPhone.length < 1 ) {
				error = 1;
				$(".alertPhone").css("display", "block");
			}
			if ( formCompany.length < 1 ) {
				error = 1;
				$(".alertCompany").css("display", "block");
			}

			if ( error == 1 ) {
				return false;
			}
		});
</script>

</body>
</html>
