<%@ Page Language="VB" src="/en/inc/mail.vb" inherits="customFunctions" %>
<html lang="en">
<head>
	<meta charset="utf-8">
	<title>Démonstration | Advataxes</title>
	<meta name="description" content="">


	<script runat="server" language="vb">
		Sub btnSend_Click(sender As Object, e As EventArgs)
			Dim returnValue As String

			Dim message As String

			message = "Nom: " & txtName.Text & "<br><br>"
			message += "Courriel: " & txtEmail.text & "<br><br>"
			message += "Téléphone: " & txtPhone.text & "<br><br>"
			message += "Compagnie: " & txtCompany.text & "<br><br>"

			returnValue = sendEmail(Me.txtEmail.Text, "Advataxes - Démonstration - " & txtName.Text, message)

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
				<h1>Démonstration</h1>
			</div>
		</div><!-- end row -->
	</div><!-- end container -->
</div><!-- end container wrapper -->
	
<div class="container">
<div class="row">
	
<% If not IsPostBack Then %>
<div class="col-md-12">
<div class="widget">
				<p>Utiliser ce formulaire pour vous inscrire à une démonstration en ligne pour Advataxes, le logiciel sur les comptes de dépenses d'employés.</p>
			</div><!-- end widget -->
</div>

		<div class="clear"></div>
		

<div class="col-md-12">
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
<label class="control-label">Courriel*</label>
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
<label class="control-label">Téléphone*</label>
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
				<label class="control-label">Compagnie*</label>
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

<!-- #include file="/fr/inc/footer.inc" -->

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
