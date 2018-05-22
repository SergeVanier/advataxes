<%@ Page Language="VB" src="/en/inc/mail.vb" inherits="customFunctions" %>
<html lang="en">
<head>
	<meta charset="utf-8">
	<title>Demo request | Advataxes</title>
	<meta name="description" content="Schedule a one-on-one web demonstration of the Advataxes software.">

	<script runat="server" language="vb">
		Sub btnSend_Click(sender As Object, e As EventArgs)
			Dim returnValue As String

			Dim message As String
			message = "Name: " & txtName.Text & "<br><br>Organization: " & txtOrganization.Text & "<br><br>Email: " & txtEmail.Text & "<br><br>Appointment: " & txtTime.Text & "<br><br>Comments:<br>" & txtComments.Text

			returnValue = sendEmail(Me.txtEmail.Text, "Advataxes - Demo request from " & txtName.Text, message)

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
					<h1>Demo request</h1>
				</div>
			</div><!-- end row -->
		</div><!-- end container -->
	</div><!-- end container wrapper -->
	
<div class="container">
	<div class="row">
	
<% If not IsPostBack Then %>
		<div class="col-md-12">
			<div class="widget">
				<p>If you would like to get an understanding of how you can get a return on your investment with Advataxes, an employee expense software, schedule a one-on-one web demo. 
				The current demo last around 30 minutes. Please fill out this page and we will contact you.</p>
				<p>Thank you.</p>
			</div><!-- end widget -->
		</div>

		<div class="clear"></div>

		<div class="col-md-7">
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
					<label class="control-label">Organization*</label>
					<div class="controls">
						<div class="row">
							<div class="col-md-9">
								<div class="alert alertOrganization" style="display:none;"><strong><i class="fa fa-exclamation-triangle"></i></strong> Enter your organization name.</div>
								<asp:textbox id="txtOrganization" runat="server" placeHolder="Name of your organization" class="form-control" />
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
					<label class="control-label" for="inputName">Appointment date and time*</label>
					<div class="controls">
						<div class="row">
							<div class="col-md-9">
								<div class="alert alertTime" style="display:none;"><strong><i class="fa fa-exclamation-triangle"></i></strong> Enter a date and a time.</div>
								<asp:textbox id="txtTime" runat="server" placeHolder="Appointment date and time" class="form-control" />
							</div><!-- end col -->
						</div><!-- end row -->
					</div><!-- end controls -->
				</div><!-- end form-group -->

				<div class="form-group">
					<label class="control-label" for="inputMessage">Comments</label>
					<div class="controls">
						<div class="row">
							<div class="col-md-10">
								<asp:textbox  textmode="multiline"  id="txtComments" runat="server" placeHolder="Your comments" class="form-control" />
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

<script type="text/javascript">
		$("#btnSend").click(function() {
			$(".alertName").css("display", "none");
			$(".alertOrganization").css("display", "none");
			$(".alertEmail").css("display", "none");
			$(".alertTime").css("display", "none");

			var error = 0;
			$("#txtName").val($("#txtName").val().replace(/</g, "&lt;"));
			$("#txtName").val($("#txtName").val().replace(/>/g, "&gt;"));
			var formName = $("#txtName").val();
			$("#txtOrganization").val($("#txtOrganization").val().replace(/</g, "&lt;"));
			$("#txtOrganization").val($("#txtOrganization").val().replace(/>/g, "&gt;"));
			var formOrganization = $("#txtOrganization").val();
			var formEmail = $("#txtEmail").val();
			var regex = /^([a-zA-Z0-9_.+-])+\@(([a-zA-Z0-9-])+\.)+([a-zA-Z0-9]{2,4})+$/;
			$("#txtTime").val($("#txtTime").val().replace(/</g, "&lt;"));
			$("#txtTime").val($("#txtTime").val().replace(/>/g, "&gt;"));
			var formTime = $("#txtTime").val();
			$("#txtComments").val($("#txtComments").val().replace(/</g, "&lt;"));
			$("#txtComments").val($("#txtComments").val().replace(/>/g, "&gt;"));
			
			if ( formName.length < 1 ) {
				error = 1;
				$(".alertName").css("display", "block");
			}
			if ( formOrganization.length < 1 ) {
				error = 1;
				$(".alertOrganization").css("display", "block");
			}
			if ( formEmail.length < 1 || !regex.test(formEmail) ) {
				error = 1;
				$(".alertEmail").css("display", "block");
			}
			if ( formTime.length < 1 ) {
				error = 1;
				$(".alertTime").css("display", "block");
			}

			if ( error == 1 ) {
				return false;
			}
		});
</script>

</body>
</html>
