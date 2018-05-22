<%@ Page Language="VB" src="/en/inc/mail.vb" inherits="customFunctions" %>
<html lang="fr">
<head>
    <meta charset="utf-8">
    <title>Grande entreprise | Advataxes</title>
    <meta name="description" content="">

	<script runat="server" language="vb">
		Sub btnSend_Click(sender As Object, e As EventArgs)
			Dim returnValue As String

			Dim message As String
			message = "Nom: " & txtName.Text & "<br><br>"
			message += "Courriel: " & txtEmail.text & "<br><br>"
			message += "Téléphone: " & txtPhone.text & "<br><br>"
			message += "Compagnie: " & txtCompany.text & "<br><br>"
			message += "Type: Grande entreprise<br><br>"

			returnValue = sendEmail(Me.txtEmail.Text, "Advataxes - Essai gratuit - " & txtCompany.Text, message)

			If returnValue = "1" Then
				Me.lblemailSent.Text = "<h3>Votre message a été envoyé.</h3><h3>Merci.</h3>"
			Else
				'Me.lblemailSent.Text = "Error: " & returnValue
				Me.lblemailSent.Text = "<h3>Oops! Désolé, une erreur est survenue, le message n'a pas être envoyé. Veuillez nous en avertir à info@advalorem.ca. Merci de votre compréhension</h3>"
			End If
		End Sub
	</script>

	<!-- #include file="/fr/inc/header-html.inc" -->

  <body>
  
 	<!-- #include file="/fr/inc/header-menu.inc" -->	
	
    <div class="clear"></div>

    <div class="container-wrapper container-top">
      <div class="container container-top">
        <div class="row">
          <div class="col-md-12 center">
            <h1>Grande entreprise</h1>
          </div>
        </div><!-- end row -->
      </div><!-- end container -->
    </div><!-- end container wrapper -->
	
    <div class="container">
      <div class="row">
	  
<% If not IsPostBack Then %>
        <div class="col-md-12">
          <div class="widget">
				<h4>Pas de carte de crédit requis – Sans engagement<h4>
				<p>Voyez par vous-même comment Advataxes est conçu pour que vos employés gèrent non seulement les dépenses mais aussi la TPS/TVH et la TVQ.</p>
			</div><!-- end widget -->
        </div>

		<div class="clear"></div>
		
		<div class="col-md-5 hidden-xs" style="padding-top:0px;">
			<div style="height:400px; background:url('/en/images/get-one-month-free.jpg') no-repeat scroll 25% center / 100% auto #FFFFFF;"></div>
		</div>
		

        <div class="col-md-7">
          <form class="form-horizontal form-contact" runat="server">
		  
            <div class="form-group">
              <label class="control-label" for="inputName">Nom*</label>
              <div class="controls">
                <div class="row">
                  <div class="col-md-9">
					<div class="alert alertName" style="display:none;"><strong><i class="fa fa-exclamation-triangle"></i></strong> Entrez votre prénom et votre nom.</div>
                    <asp:textbox id="txtName" runat="server" placeHolder="Prénom et Nom" class="form-control" />
                  </div><!-- end col -->
                </div><!-- end row -->
              </div><!-- end controls -->
            </div><!-- end form-group -->
			
            <div class="form-group">
              <label class="control-label">Courriel de l'entreprise*</label>
              <div class="controls">
                <div class="row">
                  <div class="col-md-9">
					<div class="alert alertEmail" style="display:none;"><strong><i class="fa fa-exclamation-triangle"></i></strong> Entrez un courriel valide.</div>
                    <asp:textbox id="txtEmail" runat="server" placeholder="Courriel" class="form-control" />
                  </div><!-- end col -->
                </div><!-- end row -->
              </div><!-- end controls -->
            </div><!-- end form-group -->

            <div class="form-group">
              <label class="control-label">Téléphone de l'entreprise*</label>
              <div class="controls">
                <div class="row">
                  <div class="col-md-9">
					<div class="alert alertPhone" style="display:none;"><strong><i class="fa fa-exclamation-triangle"></i></strong> Entrez le numéro de téléphone de votre entreprise.</div>
                    <asp:textbox id="txtPhone" runat="server" placeholder="Numéro de téléphone" class="form-control" />
                  </div><!-- end col -->
                </div><!-- end row -->
              </div><!-- end controls -->
            </div><!-- end form-group -->
			
			<div class="form-group">
              <label class="control-label">Nom de l'entreprise*</label>
              <div class="controls">
                <div class="row">
                  <div class="col-md-9">
					<div class="alert alertCompany" style="display:none;"><strong><i class="fa fa-exclamation-triangle"></i></strong> Entrez le nom de votre entreprise.</div>
                    <asp:textbox id="txtCompany" runat="server" placeholder="Nom de l'entreprise" class="form-control" />
                  </div><!-- end col -->
                </div><!-- end row -->
              </div><!-- end controls -->
            </div><!-- end form-group -->

            <div class="form-actions form-actions-no-bg">
				<asp:button id="btnSend" text="Envoyez" onclick="btnSend_Click" runat="server" class="btn btn-lg btn-purple"></asp:button>
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
		
		<div class="clear"></div>

		<br /><br />
		
        <div class="col-md-12">
			<p>Si vous avez des questions contactez-nous au 1-877-818-6688.</p>
		</div>
						
        </div>
      </div><!-- end row -->
    </div><!-- end container -->
        
    <div class="clear"></div>
      
	<!-- #include file="/fr/inc/footer.inc" -->
    
	<script src="/en/js/jquery-1.9.0-min.js"></script>
    <script src="/en/js/bootstrap.js"></script>
    <script src="/en/js/zion.js"></script>

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
