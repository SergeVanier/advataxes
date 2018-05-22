<%@ Page Language="VB" src="/en/inc/mail.vb" inherits="customFunctions" %>
<html lang="en">
<head>
	<meta charset="utf-8">
	<title>Mail Testing | Advataxes</title>

	<script runat="server" language="vb">
		Sub btnSend_Click(sender As Object, e As EventArgs)
			Dim returnValue As String

			returnValue = sendEmail(emailFromServer, Me.txtSubject.Text, Me.txtMessage.Text, Me.txtTo.Text)
			
			If returnValue = "1" Then
				Me.lblemailSent.Text = "<h3>Your message has been sent.</h3><h3>Thank you for your interest in Advataxes.</h3>"
			Else
				Me.lblemailSent.Text = "Error: " & returnValue
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
            <h1>Mail Testing</h1>
          </div>
        </div><!-- end row -->
      </div><!-- end container -->
    </div><!-- end container wrapper -->
	
    <div class="container">
      <div class="row">

<% If not IsPostBack Then %>
	<div class="col-md-12">

	<form class="form-horizontal form-contact" runat="server">
				<div class="form-group">
					<label class="control-label" for="inputName">To*</label>
					<div class="controls">
						<div class="row">
							<div class="col-md-9">
								<div class="alert alertTo" style="display:none;"><strong><i class="fa fa-exclamation-triangle"></i></strong> Enter a valid email address.</div>
								<asp:textbox id="txtTo" runat="server" placeHolder="Email To" class="form-control" />
							</div><!-- end col -->
						</div><!-- end row -->
					</div><!-- end controls -->
				</div><!-- end form-group -->

				<div class="form-group">
					<label class="control-label" for="inputName">Subject*</label>
					<div class="controls">
						<div class="row">
							<div class="col-md-9">
								<div class="alert alertSubject" style="display:none;"><strong><i class="fa fa-exclamation-triangle"></i></strong> Enter a subject.</div>
								<asp:textbox id="txtSubject" runat="server" placeHolder="Subject" class="form-control" value="Advataxes Test" />
							</div><!-- end col -->
						</div><!-- end row -->
					</div><!-- end controls -->
				</div><!-- end form-group -->

				<div class="form-group">
					<label class="control-label" for="inputMessage">Message</label>
					<div class="controls">
						<div class="row">
							<div class="col-md-10">
								<div class="alert alertMessage" style="display:none;"><strong><i class="fa fa-exclamation-triangle"></i></strong> Enter a message.</div>
								<asp:textbox textmode="multiline" id="txtMessage" runat="server" placeHolder="Your Message" class="form-control" Text="Advataxes Test" />
							</div><!-- end col -->
						</div><!-- end row -->
					</div><!-- end controls -->
				</div><!-- end form-group -->

            <div class="form-actions form-actions-no-bg">
				<asp:button id="btnSend" text="Send Message" onclick="btnSend_Click" runat="server" class="btn btn-lg btn-purple"></asp:button>
            </div>
</form>
	</div>

<% Else %>
    <div class="container">
      <div class="row">
        <div class="col-md-9">
			<h3><asp:Label id="lblemailSent" runat="server"></asp:Label></h3>
		</div>
<%End If %>	
    

			</div>
      </div><!-- end row -->  
    </div><!-- end container -->
        
    <div class="clear"></div>
      
	<!-- #include file="/en/inc/footer.inc" -->

	<script src="/en/js/jquery-1.9.0-min.js"></script>
    <script src="/en/js/bootstrap.js"></script>
    <script src="/en/js/zion.js"></script>
	<script src="/en/js/custom_checkbox_and_radio.js"></script>
    <script src="/en/js/custom_radio.js"></script>
    <script src="/en/js/jquery-ui.js"></script>
</body>
</html>
