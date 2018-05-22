<%@ Page Language="VB" src="/en/inc/mail.vb" inherits="customFunctions" %>
<html lang="fr">
<head>
	<meta charset="utf-8">
	<title>Demandez une démonstration | Advataxes</title>
	<meta name="description" content="">

	<script runat="server" language="vb">
		Sub btnSend_Click(sender As Object, e As EventArgs)
			Dim returnValue As String

			Dim message As String
			message = "Nom: " & txtName.Text & "<br><br>"
			message += "Organisation: " & txtOrganization.Text & "<br><br>"
			message += "Courriel: " & txtEmail.Text & "<br><br>"
			message += "Rendez-vous: " & txtTime.Text & "<br><br>"
			message += "Commentaires: " & txtComments.Text & "<br><br>"

			returnValue = sendEmail(Me.txtEmail.Text, "Advataxes - Démonstration - " & txtOrganization.Text, message)

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
					<h1>Demandez une démonstration</h1>
				</div>
			</div><!-- end row -->
		</div><!-- end container -->
	</div><!-- end container wrapper -->
	
<div class="container">
	<div class="row">
	
<% If not IsPostBack Then %>
		<div class="col-md-12">
			<div class="widget">
				<p>Si vous désirez comprendre comment Advataxes, un logiciel sur les dépenses des employés, peut représenter un investissement pour votre organisation, fixez une démonstration web personalisée. 
				La démonstration dure environ 30 minutes. Compléter le présent formulaire et nous vous contacterons.</p>
				<p>Merci</p>
			</div><!-- end widget -->
		</div>

		<div class="clear"></div>

		<div class="col-md-7">
			<form class="form-horizontal form-contact" runat="server">
		
				<div class="form-group">
					<label class="control-label" for="inputName">Nom*</label>
					<div class="controls">
						<div class="row">
							<div class="col-md-9">
								<div class="alert alertName" style="display:none;"><strong><i class="fa fa-exclamation-triangle"></i></strong> Enter un nom.</div>
								<asp:textbox id="txtName" runat="server" placeHolder="Prénom et nom" class="form-control" />
							</div><!-- end col -->
						</div><!-- end row -->
					</div><!-- end controls -->
				</div><!-- end form-group -->

				<div class="form-group">
					<label class="control-label">Organisation*</label>
					<div class="controls">
						<div class="row">
							<div class="col-md-9">
								<div class="alert alertOrganization" style="display:none;"><strong><i class="fa fa-exclamation-triangle"></i></strong> Entrer le nom de votre organisation.</div>
								<asp:textbox id="txtOrganization" runat="server" placeHolder="Nom de votre organisation" class="form-control" />
							</div><!-- end col -->
						</div><!-- end row -->
					</div><!-- end controls -->
				</div><!-- end form-group -->
			
				<div class="form-group">
					<label class="control-label">Courriel*</label>
					<div class="controls">
						<div class="row">
							<div class="col-md-9">
								<div class="alert alertEmail" style="display:none;"><strong><i class="fa fa-exclamation-triangle"></i></strong> Entrer un courriel valide.</div>
								<asp:textbox id="txtEmail" runat="server" placeholder="Courriel" class="form-control" />
							</div><!-- end col -->
						</div><!-- end row -->
					</div><!-- end controls -->
				</div><!-- end form-group -->

				<div class="form-group">
					<label class="control-label" for="inputName">Date et heure du rendez-vous*</label>
					<div class="controls">
						<div class="row">
							<div class="col-md-9">
								<div class="alert alertTime" style="display:none;"><strong><i class="fa fa-exclamation-triangle"></i></strong> Entrer une date et une heure.</div>
								<asp:textbox id="txtTime" runat="server" placeHolder="Date et heure du rendez-vous" class="form-control" />
							</div><!-- end col -->
						</div><!-- end row -->
					</div><!-- end controls -->
				</div><!-- end form-group -->

				<div class="form-group">
					<label class="control-label" for="inputMessage">Commentaires</label>
					<div class="controls">
						<div class="row">
							<div class="col-md-10">
								<asp:textbox  textmode="multiline"  id="txtComments" runat="server" placeHolder="Vos commentaires" class="form-control" />
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

			</div>
		</div><!-- end row -->
	</div><!-- end container -->

<div class="clear"></div>

<!-- #include file="/fr/inc/footer.inc" -->

<script src="/en/js/jquery-1.9.0-min.js"></script>
<script src="/en/js/bootstrap.js"></script>
<script src="/en/js/zion.js"></script>

<script type="text/javascript">
		$("#cmdSubmit").click(function() {
			$(".alertName").css("display", "none");
			$(".alertOrganization").css("display", "none");
			$(".alertEmail").css("display", "none");
			$(".alertTime").css("display", "none");

			var error = 0;
			var formName = $("#txtName").val();
			var formOrganization = $("#txtOrganization").val();
			var formEmail = $("#txtEmail").val();
			var regex = /^([a-zA-Z0-9_.+-])+\@(([a-zA-Z0-9-])+\.)+([a-zA-Z0-9]{2,4})+$/;
			var formTime = $("#txtTime").val();
			
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
