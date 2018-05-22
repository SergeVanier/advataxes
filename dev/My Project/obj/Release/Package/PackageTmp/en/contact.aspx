<%@ Page Language="VB" src="/en/inc/mail.vb" inherits="customFunctions" %>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>Contact us | Advataxes</title>
    <meta name="description" content="Contact form for Advataxes">

	<script runat="server" language="vb">
		Sub btnSend_Click(sender As Object, e As EventArgs)
			Dim returnValue As String

			Dim message As String
			message = txtMessage.Text & "<br><br>" & txtName.Text & " - " & txtEmail.Text

			returnValue = sendEmail(Me.txtEmail.Text, "Advataxes - Contact us - " & txtName.Text, message)

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
            <h1>Contact us</h1>
          </div>
        </div><!-- end row -->
      </div><!-- end container -->
    </div><!-- end container wrapper -->

 <% If not IsPostBack Then %>

    <div class="container-wrapper">
      <div class="google-map"><iframe width="770" height="200" frameborder="0" scrolling="no" marginheight="0" marginwidth="0" src="https://maps.google.co.nz/maps?ie=UTF8&amp;&amp;q=Ad+Valorem+Inc.,+Boulevard+Cr%C3%A9mazie+Est,+Montreal,+QC,+Canada&amp;hl=en&amp;t=m&amp;z=16&amp;iwloc=near&amp;output=embed"></iframe></div>
    </div>
    
    <div class="container">
      <div class="row">

        <div class="col-md-9">
          <h2>Send us a message</h2>
		  <form class="form-horizontal form-contact" runat="server">

            <div class="form-group">
              <label class="control-label" for="inputName">Name*</label>
              <div class="controls">
                <div class="row">
                  <div class="col-md-6">
					<div class="alert alertName" style="display:none;"><strong><i class="fa fa-exclamation-triangle"></i></strong> Enter a name.</div>
					<asp:textbox id="txtName" runat="server" placeHolder="First and Last Name" class="form-control" />
                  </div><!-- end col -->
                </div><!-- end row -->
              </div><!-- end controls -->
            </div><!-- end form-group -->

            <div class="form-group">
              <label class="control-label" for="inputEmail">Email Address*</label>
              <div class="controls">
                <div class="row">
                  <div class="col-md-6">
					<div class="alert alertEmail" style="display:none;"><strong><i class="fa fa-exclamation-triangle"></i></strong> Enter a valid email.</div>
					<asp:textbox id="txtEmail" runat="server" placeholder="Email Address" class="form-control" />
                  </div><!-- end col -->
                </div><!-- end row -->
              </div><!-- end controls -->
            </div><!-- end form-group -->

            <div class="form-group">
              <label class="control-label" for="inputMessage">Message*</label>
              <div class="controls">
                <div class="row">
                  <div class="col-md-10">
					<div class="alert alertMessage" style="display:none;"><strong><i class="fa fa-exclamation-triangle"></i></strong> Enter a message.</div>
					<asp:textbox  textmode="multiline"  id="txtMessage" runat="server" placeHolder="Your Message" class="form-control" />
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

        <div class="col-md-3 sidebar">
          <div class="widget">
            <h2>Contact Details</h2>
            <ul class="fa-ul">
				<li><i class="fa-li fa fa-map-marker"></i>1100 Crémazie Boulevard East<br />Suite 708<br />Montreal, Quebec<br />H2P 2X2<br /><br />Entrance to the parking by Crémazie Boulevard</li>
				<li><i class="fa-li fa fa-phone"></i>514-461-1543</li>
				<li><i class="fa-li fa fa-phone"></i>1-877-818-6688</li>
				<li><i class="fa-li fa fa-fax"></i>514-461-1559</li>
            </ul>
          </div><!-- end widget -->
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
    
    <script type="text/javascript">
      $(document).ready(function() {
        $('.dropdown-toggle').dropdown();
        $("[rel='tooltip']").tooltip();
        // Init jQuery UI slider
        $("#slider").slider({
            min: 1,
            max: 5,
            value: 3,
            orientation: "horizontal",
            range: "min",
        });
      });


		$("#btnSend").click(function() {
			$(".alertName").css("display", "none");
			$(".alertEmail").css("display", "none");
			$(".alertMessage").css("display", "none");

			var error = 0;
			$("#txtName").val($("#txtName").val().replace(/</g, "&lt;"));
			$("#txtName").val($("#txtName").val().replace(/>/g, "&gt;"));
			var formName = $("#txtName").val();
			var formEmail = $("#txtEmail").val();
			var regex = /^([a-zA-Z0-9_.+-])+\@(([a-zA-Z0-9-])+\.)+([a-zA-Z0-9]{2,4})+$/;
			$("#txtMessage").val($("#txtMessage").val().replace(/</g, "&lt;"));
			$("#txtMessage").val($("#txtMessage").val().replace(/>/g, "&gt;"));
			var formMessage = $("#txtMessage").val();
			
			if ( formName.length < 1 ) {
				error = 1;
				$(".alertName").css("display", "block");
			}
			if ( formEmail.length < 1 || !regex.test(formEmail) ) {
				error = 1;
				$(".alertEmail").css("display", "block");
			}
			if ( formMessage.length < 1 ) {
				error = 1;
				$(".alertMessage").css("display", "block");
			}

			if ( error == 1 ) {
				return false;
			}
		});
    </script>

  </body>
</html>
