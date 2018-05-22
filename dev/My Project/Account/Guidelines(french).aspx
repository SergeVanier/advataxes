<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="Guidelines.aspx.vb" Inherits="WebApplication1.Guidelines" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link type="text/css" href="../../css/sunny/jquery-ui-1.8.23.custom.css" rel="stylesheet" /> 
    <script type="text/javascript" src="../../js/jquery-1.7.2.min.js"></script>
    <script type="text/javascript" src="../../js/jquery-ui-1.8.18.custom.min.js"> </script>
    <script type="text/javascript" src="../../js/jquery.js"> </script>


  
    <script>

        $(document).ready(function () {
            $(function () {
                $("#tabs").tabs();
            });



            if ($("#<%=hdnAdmin.ClientID %>").val() == "False") $("#adminListItem").css("display", "none")
   	        if ($("#<%=hdnAdmin.ClientID %>").val() == "False") $("#taxDocListItem").css("display", "none")
            if ($("#<%=hdnApprover.ClientID %>").val() == "False") $("#approverListItem").css("display", "none")
            if ($("#<%=hdnAdmin.ClientID %>").val() == "False") $("#yearendListItem").css("display", "none")
        });
    
    </script>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
      <br />
      <div id="tabs" style="height:950px;">
			<ul>
				<li id="empListItem"><a href="#tab-employee">Employé</a></li>
                <li id="approverListItem"><a href="#tab-approver">Approbateur</a></li>
                <li id="adminListItem"><a href="#tab-admin">Administrateur</a></li>
				<li id="taxDocListItem"><a href="#tab-taxDoc">Documentation fiscale</a></li>
				<li id="yearendListItem"><a href="#tab-yearEnd">Fin d'année</a></li>
			</ul>

			<div id="tab-employee">
                <div style="position:relative;top:20px;left:20px; overflow:auto; height:860px; width:98%;">
                    <table width="96%">
                        <tr style="height:40px;"><td valign="top" style="color:#cd1e1e; font-size:1.5em;">Guide de l'employé</td></tr>
                        <tr style="height:0.1px; background-color:#cd1e1e;"><td></td></tr>
                        <tr><td style="height:10px;"></td></tr>
											
                        <tr><td style="color:#cd1e1e; font-weight:bold;">1. Gérer un rapport de dépenses</td></tr>
                        
                        <tr><td>
                            <div style="position:relative;left:20px;">
                                <table>
                                    <tr><td style="color:#cd1e1e;">Créer un rapport</td></tr>
                                    <tr><td>Pour créer un rapport de dépenses, allez à l’onglet « Mes dépenses », cliquez sur <img src="../images/new.png" width="20px" height="20px" /> à côté de « Rapports », et choisissez un nom pour votre rapport. Nous vous suggérons de choisir un nom qui décrit bien les dépenses que vous voulez enregistrer. À titre d’exemple, le nom peut être « Conférence à Ottawa » lorsque les dépenses ont été encourues dans le cadre d’une conférence à Ottawa. Une fois le nom de votre rapport choisi, vous êtes prêts à enregistrer vos dépenses en cliquant sur <img src="../images/new.png" width="20px" height="20px" /> à côté de « Dépenses ». 
                                            Vous pouvez seulement créer un rapport à la fois. Vous devez donc soumettre votre rapport pour approbation avant de pouvoir en créer un autre. Vous pouvez avoir plus d’un rapport dans l’onglet « Mes dépenses » seulement lorsqu’un ou des rapports déjà soumis sont renvoyés par l’approbateur pour qu’ils soient modifiés.  
                                    </td></tr>
                                    <tr><td style="color:#cd1e1e;">Modifier le nom du rapport</td></tr>
                                    <tr><td>Vous pouvez modifier le nom du rapport en cliquant sur <img src="../images/edit.png" width="20px" height="20px" />. Lorsqu’un rapport est soumis, il n’est plus possible d’en changer le nom. </td></tr>
                                    <tr><td style="color:#cd1e1e;">Supprimer un rapport</td></tr>
                                    <tr><td>Vous pouvez supprimer un rapport qui a été créé en cliquant sur  <img src="../images/del.png" width="20px" height="20px" />. Vous ne pouvez pas supprimer un rapport dont le statut est « En attente d’approbation » ou « Finalisés ».  </td></tr>  
                                </table>
                            </div>
                        </td></tr>
                        
                        <tr><td style="color:#cd1e1e; font-weight:bold;">2. 2. Gérer les dépenses</td></tr>
                                    <tr><td>
                                        <div style="position:relative;left:20px;">
                                            <table>
                                            
                                                <tr><td style="color:#cd1e1e;">Ajouter une dépense</td></tr>
                                                <tr><td>Lorsqu’un rapport est créé, vous pouvez ajouter une dépense en cliquant sur <img src="../images/new.png" width="20px" height="20px" /> à la droite de « Dépenses » et du nom de votre rapport.</td></tr>
                                                        
                                                <tr><td>
                                                    <div style="position:relative;left:20px;">
                                                        <table>
                                                            <tr><td style="color:#cd1e1e;">Type de dépense</td></tr>
                                                            <tr><td>Choisissez le type de dépense encouru, par exemple « Repas et divertissement », « Allocation kilométrage » ou « Télécommunication », en cliquant sur « Type de dépense ».</td></tr>
                                                            <tr><td style="color:#cd1e1e;">Date de transaction</td></tr>
                                                            <tr><td>Choisissez le jour où la dépense a été encourue. Une facture d’hôtel pour un séjour en date du 19 juillet 2012, par exemple, devrait avoir comme date le 19 juillet 2012. De façon générale, la date de transaction équivaut à la date sur la facture. Si vous n’avez pas de facture, par exemple pour une allocation pour le kilométrage, choisissez alors la date à laquelle réfère l’allocation. Une telle allocation pour un voyage à Ottawa en date du 19 juillet 2012 devrait ainsi être datée du 19 juillet 2012. Le logiciel n’est pas configuré pour les dépenses qui précèdent le 1er juillet 2010.</td></tr>
                                                            <tr><td style="color:#cd1e1e;">Juridiction</td></tr>
                                                            <tr><td>Choisissez la juridiction canadienne, qu’il s’agisse d’une province ou d’un territoire tels que l’Ontario, la Colombie Britannique ou le Québec, où la dépense a été encourue. Si votre dépense a été encourue à l’extérieur des provinces et des territoires du Canada, sélectionnez « À l’extérieur du Canada ».</td></tr>
                                                            <tr><td style="color:#cd1e1e;">Montant</td></tr>
                                                            <tr><td>Insérez le montant tel qu’il apparaît sur votre reçu ou votre allocation. Les sous doivent être séparés des dollars par un point. Pour les montants sur vos reçus, vous pouvez insérer un montant avant les taxes ou un montant qui inclut les taxes en sélectionnant une des fonctionnalités ci-dessous.</td></tr>
                                                            <tr><td style="color:#cd1e1e;">Taxes incluses</td></tr>
                                                            <tr><td>Avec cette fonctionalité, la TPS/TVH et la TVQ sont, le cas échéant, calculées sur un montant qui inclut les taxes. Veuillez toutefois noter que le montant à insérer devrait exclure les pourboires optionnels.</td></tr>
                                                            <tr><td style="color:#cd1e1e;">Avant les taxes</td></tr>        
                                                            <tr><td>Sélectionnez cette option lorsque le montant inséré n’inclut pas la TPS/TVH et TVQ. Cette option peut s’appliquer à des factures d’hôtel comprenant des montants séparés pour la chambre et pour le repas. Dans ces situations, les utilisateurs devraient créer une dépense pour la chambre en choisissant « Hôtel » comme type de dépense, et créer une deuxième dépense en choisissant la catégorie « Repas et divertissement » appropriée.</td></tr>
                                                            <tr><td style="color:#cd1e1e;">Pourboires</td></tr>
                                                            <tr><td>Entrez seulement le montant des pourboires facultatifs. Ceux-ci ne sont pas sujets à la TPS/TVH et à la TVQ.</td></tr>
                                                            <tr><td style="color:#cd1e1e;">Devises</td></tr>
                                                            <tr><td>Le logiciel convertit les devises étrangères en dollars canadiens. Plus de 150 devises étrangères peuvent être sélectionnées. De façon générale, la conversion des devises s’appuie sur la valeur de conversion en vigueur lors de la date de transaction. Par défaut, les montants insérés sont en dollars canadiens (CAD).</td></tr>
															<tr><td style="color:#cd1e1e;">Ne pas rembourser</td></tr>
															<tr><td>Sélectionnez cette option si le montant de dépenses que vous entrez sera payé par votre organisation en votre nom.</td></tr>
                                                            <tr><td style="color:#cd1e1e;">Nom du fournisseur</td></tr>
                                                            <tr><td>Les utilisateurs peuvent, le cas échéant, entrer le nom du fournisseur.</td></tr>
                                                            <tr><td style="color:#cd1e1e;">Commentaires</td></tr>
                                                            <tr><td>Les employés peuvent insérer des commentaires en rapport avec les dépenses encourues (par ex. dîner avec la compagnie ABC).</td></tr>
                                                            <tr><td style="color:#cd1e1e;">TPS/TVH et TVQ payées</td></tr>
                                                            <tr><td>Lorsque votre dépense s’accompagne d’un reçu, comparez les montants de TPS/TVH et de TVQ calculés par le logiciel et les montants de TPS/TVH et de TVQ indiqués sur votre reçu. Les écarts peuvent être dus à une erreur dans le choix de la date de transaction ou du type de dépense. Corrigez ces choix et refaites la comparaison entre les taxes calculées et les taxes indiquées sur votre reçu. Des situations irrégulières, telles que des achats auprès d’un petit fournisseur ou des rabais de TVH pour des repas de moins de 4.00 $ en Ontario, devraient être corrigées. Cliquez sur <img src="../images/lock.png" width="15px" height="20px" /> pour modifier les montants de TPS/TVH et de TVQ. De façon similaire, si vous avez perdu le reçu justifiant votre transaction, vous pouvez mettre les champs de TPS/TVH et de TVQ à zéro. Il faut noter que les frais de taxi, de téléphone public et de stationnement payant ne sont pas couverts par l’obligation de fournir des pièces justificatives aux fins de la TPS/TVH et de la TVQ.</td></tr>
                                                            <tr><td style="color:#cd1e1e;">Reçu</td></tr>
                                                            <tr><td>Vous pouvez importer vos reçus à côté de chaque dépense que vous entrez. Les reçus peuvent avoir les formats suivants : PDF, JPEG, PNG, TIFF, GIF, BMP et HTML. Pour les importer, cliquez sur « Choisissez un fichier ». </td></tr>
                                                            <tr><td style="color:#cd1e1e;">Taux à sélectionner</td></tr>
                                                            <tr><td>Cette catégorie inclut notablement les services de transport tels que le transport par avion, le transport par train ou par autobus sur des longues distances. Elle exclut les services de transport en commun. Pour cette catégorie, les utilisateurs doivent sélectionner le taux de taxe qui s’applique à leur situation dans un menu déroulant, en consultant leur facture.</td></tr>
                                                            <tr><td style="color:#cd1e1e;">Usage personnel de l’employé</td></tr>
                                                            <tr><td>Si vous sélectionnez ce type de dépenses pour des dépenses encourues pour usage personnel (par opposition à des dépenses encourues pour des fins reliées à votre organisation), aucune TPS/TVH ou TVQ n’est calculée, en dépit du fait que ces dépenses peuvent avoir de la TPS/TVH ou de la TVQ. Aucune correction n’est nécessaire de la part de l’employé.</td></tr>
                                                        </table>                                                    
                                                    </div>
                                                </td></tr>

                                                <tr><td style="color:#cd1e1e;">Modifier une dépense</td></tr> 
                                                <tr><td>Vous pouvez modifier une dépense en cliquant sur <img src="../images/edit.png" width="20px" height="20px" />. Vous serez en mesure de modifier des informations telles que la date de transaction, le montant des dépenses, le montant des pourboires, la juridiction et ainsi de suite. La seule information que vous ne pourrez pas modifier est le type de dépense. </td></tr>
                                                <tr><td style="color:#cd1e1e;">Afficher les commentaires</td></tr>
                                                <tr><td>Vous pouvez afficher les commentaires sur une dépense en cliquant sur <img src="../images/plus.png" width="15px" height="15px" /> à la gauche de chaque dépense.</td></tr>
                                                <tr><td style="color:#cd1e1e;">Supprimer une dépense</td></tr>
                                                <tr><td>Vous pouvez supprimer des dépenses en cliquant sur <img src="../images/del.png" width="20px" height="20px" /> à la droite de chacune.</td></tr>

                                            </table>                                        
                                        </div>
                                    
                                    </td></tr>
                                    
                            
                        <tr><td style="color:#cd1e1e; font-weight:bold;">3.	Soumettre un rapport</td></tr>
                        
                        <tr><td>
                            <div style="position:relative;left:20px;">
                                <table>
                                    <tr><td  style="color:#cd1e1e;" >Soumettre un rapport de dépenses</td></tr>
                                    <tr><td>Vous pouvez soumettre votre rapport de dépenses pour approbation en cliquant sur <img src="../images/submit.png" width="20px" height="20px" />. Une fois que votre rapport de dépenses a été soumis, vous pouvez y accéder en sélectionnant, dans « Statut », l’option « En attente d’approbation ». Vous ne pouvez cependant pas le modifier. La seule façon pour un employé de modifier un rapport de dépenses qui a été soumis est lorsque la personne chargée de l’approuver le désapprouve. Ce rapport est alors retourné à l’employé pour qu’il puisse être modifié.
									<tr valign="bottom" style="height:50px;"><td>Si vous avez des questions, n’hésitez pas à <a href="contactus.aspx" style="color:#cd1e1e">nous contacter</a>, et l’un de nos représentants communiquera avec vous.</td></tr>
                                </table>
                            </div>
                        </td></tr>
                    </table>
                </div>
            </div>
            
            <div id="tab-approver">
                <div style="position:relative;top:20px;left:20px; overflow:auto; height:880px; width:98%;">
                    <table width="96%">
                        <tr style="height:40px;"><td valign="top" style="color:#cd1e1e; font-size:1.5em;">Guide de l'approbateur</td></tr>
                        <tr style="height:0.1px; background-color:#cd1e1e;"><td></td></tr>
                        <tr><td style="height:10px;"></td></tr>
                        <tr valign="middle" style="height:60px;"><td>En tant qu'approbateur, votre tâche est de vérifier les rapports de dépenses qui vous sont soumis par une liste d’employés. Ces employés vous ont été assignés par l’administrateur de ce logiciel au sein de votre organisation.</td></tr>
                        <tr><td style="color:#cd1e1e; font-weight:bold;">Rapports soumis</td></tr>
                        
                        <tr><td>
                            <div style="position:relative;left:20px;">
                                <table>
                                    <tr><td style="color:#cd1e1e;">Vérifier un rapport</td></tr>
                                    <tr><td>Pour passer en revue un rapport de dépenses, allez à l’onglet « Dépenses soumises » et cliquez sur <img src="../images/viewreport.png" width="20px" height="20px" /> sous « Rapports ». S’afficheront alors, pour chaque rapport de dépenses, une liste de tous les types de dépenses, le total des dépenses, de même que, le cas échéant, les CTI, les RTI et les RCTI. Pour visualiser les reçus qui ont été joints aux dépenses, cliquez sur <img src="../images/attachment2.png" width="20px" height="20px" />.</td></tr>
                                    <tr><td style="color:#cd1e1e;">Modifier un rapport</td></tr>
                                    <tr><td>Il existe deux façons d’apporter des changements à un rapport de dépenses qui a été soumis par un employé. La première consiste à renvoyer le rapport à l’employé en cliquant sur <img src="../images/reject.png" width="15px" height="15px" />. Le rapport de dépenses réapparaîtra dans l’onglet « Mes dépenses » de l’employé, et celui-ci pourra le modifier. La deuxième façon consiste à cliquer sur <img src="../images/edit.png" width="20px" height="20px" /> et à apporter les corrections vous-mêmes.  
                                    </td></tr>
                                    <tr><td style="color:#cd1e1e;">Visualiser un rapport</td></tr>
                                    <tr><td>Pour visualiser les rapports de dépenses, utilisez les fonctionnalités « Employé » et « Statut ». La première permet de visualiser les rapports de dépenses de tous les employés qui vous ont été assignés ou d’un employé en particulier. La deuxième de visualiser les rapports de dépenses en fonction de leur statut, soit « En attente d’approbation » ou « Finalisés ».
                                    </td></tr>

                                    <tr><td style="color:#cd1e1e;">Approuver un rapport</td></tr>
                                    <tr><td>Une fois que la vérification d’un rapport de dépenses a été complétée, vous pouvez procéder à son approbation. Pour ce faire, cliquez simplement sur <img src="../images/finalize.png" width="15px" height="15px" />.</td></tr>
                                    <tr><td style="color:#cd1e1e;">Rapports finalisés à des fins comptables</td></tr>
                                    <tr><td>Seuls les rapports finalisés seront comptabilisés dans la période au cours de laquelle les rapports ont été finalisés. Ces rapports ne peuvent être ni modifiés ni supprimés. </td></tr>

                                    <tr valign="bottom" style="height:50px;"><td>Si vous avez des questions, n’hésitez pas à <a href="contactus.aspx" style="color:#cd1e1e">nous contacter</a> et l’un de nos représentants communiquera avec vous.</td></tr>
                                    
                                </table>
                            </div>
                        </td></tr>
                    </table>
                </div>
            </div>

            <div id="tab-admin">
                <div style="position:relative;top:20px;left:20px; overflow:auto; height:870px; width:98%;">
                    <table width="96%">
                        <tr style="height:40px;"><td valign="top" style="color:#cd1e1e; font-size:1.5em;">Guide de l’administrateur</td></tr>
                        <tr style="height:0.1px; background-color:#cd1e1e;"><td></td></tr>
                        <tr><td style="height:10px;"></td></tr>
                        <tr valign="middle" style="height:60px;"><td>Ce guide présente les fonctionnalités liées aux paramètres d’installation et de gestion que vous trouverez sous l’onglet « Administrateur ».</td></tr>
                        <tr><td style="color:#cd1e1e; font-weight:bold;">Considérations initiales</td></tr>
                        <tr><td>Lorsque vous vous inscrivez à Advataxes, vous devez déterminer si votre organisation est :
                                    <br />•	une institution financière aux fins de la TPS/TVH et de la TVQ
                                    <br />•	une organisation autre qu’un organisme sans but lucratif
                        </td></tr>
                        
                        <tr><td>La version actuelle du logiciel n’est pas conçue pour les organismes sans but lucratif. Si c’est le cas de votre organisation, ce logiciel ne s’adresse pas à votre situation. De plus, votre organisation ne devrait pas utiliser ce logiciel si votre organisation utilise la méthode rapide de TPS/TVQ, méthode par laquelle les inscrits versent un montant inférieur de taxes perçues plutôt que de déterminer les taxes payées sur leurs achats pour compenser les taxes perçues.   
                        </td></tr>
                        
                        <tr><td style="color:#cd1e1e; font-weight:bold;">Paramètres globaux</td></tr>
                        
                        <tr><td>Pour remplir les champs suivants, cliquez sur « Paramètres globaux » dans l’onglet « Administrateur ». Cliquez alors sur <img src="../images/edit.png" width="20px" height="20px"/>.</td></tr>

                        <tr><td>
                            <div style="position:relative;left:20px;">
                                <table>
                                    <tr><td style="color:#cd1e1e;">Premier mois de l’année financière</td></tr>
                                    <tr><td>Sélectionnez le premier mois de l’année financière de votre organisation. Si les périodes comptables ne concordent pas avec les mois du calendrier, veuillez nous contacter (en haut à droite de la page) pour que nous puissions procéder manuellement.</td></tr>
                                    <tr><td style="color:#cd1e1e;">Nombre de périodes de l’année financière</td></tr>
                                    <tr><td>Sélectionnez le nombre de périodes de votre année financière. « 12 » correspond à 12 périodes, et ainsi de suite. </td></tr>
                                    <tr><td style="color:#cd1e1e;">Numéro des comptes payables</td></tr>
                                    <tr><td>Insérez le numéro du compte payable du grand livre pour le remboursement des dépenses.</td></tr>
                                    <tr><td style="color:#cd1e1e;">Numéro de compte CTI</td></tr>
                                    <tr><td>Pour les inscrits en TPS, insérez le numéro de compte du grand livre où les crédits de taxe sur les intrants (CTI) sont comptabilisés sous le régime de la TPS. <b>Quelques références:</b> Pour plus d'informations, voir <a href="#" onclick="javascript:window.open('http://www.cra-arc.gc.ca/F/pub/gm/8-1/LISEZ-MOI.html');" style="color:#cd1e1e;"><u>Mémorandum sur la TPS/TVH 8.1 Règles générales d’admissibilité</u></a>.</td></tr>
                                    <tr><td style="color:#cd1e1e;">Numéro de compte RTI</td></tr>
                                    <tr><td>Pour les inscrits en TVQ, insérez le numéro de compte du grand livre où les remboursements de taxes sur les intrants (RTI) sont comptabilisés sous le régime de la TVQ.</td></tr>
                                    <tr><td style="color:#cd1e1e;">Numéro de compte RCTI-ON</td></tr>        
                                    <tr><td>Pour les grandes entreprises sous le régime de la TPS, insérez le numéro de compte du grand livre où la récupération des crédits de taxe sur les intrants (RCTI) en Ontario est comptabilisée. Si les RCTI sont comptabilisés dans le numéro de compte de CTI, insérez à nouveau le numéro de compte de CTI. <b>Quelques références:</b> Pour plus d'informations, voir <a href="#" onclick="javascript:window.open('http://www.cra-arc.gc.ca/F/pub/gm/b-104/LISEZ-MOI.html');" style="color:#cd1e1e;"><u>Bulletin d’information technique B-104 Taxe de vente harmonisée – Récupération temporaire des crédits de taxe sur les intrants en Ontario et en Colombie-Britannique.</u></a></td></tr>
                                    <tr><td style="color:#cd1e1e;">Numéro de compte RCTI-CB</td></tr>
                                    <tr><td>Pour les grandes entreprises sous le régime de la TPS, insérez le numéro de compte du grand livre où la récupération des crédits de taxe sur les intrants (RCTI) en Colombie-Britannique est comptabilisée. Si les RCTI sont comptabilisés dans le numéro de compte de CTI, insérez à nouveau le numéro de compte de CTI. <b>Quelques références:</b> Pour plus d'informations, voir <a href="#" onclick="javascript:window.open('http://www.cra-arc.gc.ca/F/pub/gm/b-104/LISEZ-MOI.html');" style="color:#cd1e1e;"><u>Bulletin d’information technique B-104 Taxe de vente harmonisée – Récupération temporaire des crédits de taxe sur les intrants en Ontario et en Colombie-Britannique.</u></a></td></tr>
									<tr><td style="color:#cd1e1e;">Numéro de compte RCTI-IPE</td></tr>
                                    <tr><td>Pour les grandes entreprises sous le régime de la TPS, insérez le numéro de compte du grand livre où la récupération des crédits de taxe sur les intrants (RCTI) à l’Île-du-Prince-Édouard est comptabilisée. Si les RCTI sont comptabilisés dans le numéro de compte de CTI, insérez à nouveau le numéro de compte de CTI. <b>Quelques références:</b> Pour plus d'informations, voir <a href="#" onclick="javascript:window.open('http://www.gov.pe.ca/photos/original/hst_recap_itc.pdf');" style="color:#cd1e1e;"><u>Revenue Tax Guide 186: Temporary Recapture of certain Provincial Input Tax Credits.</u></a></td></tr>
									<tr><td style="color:#cd1e1e;">Période de rétention</td></tr>
                                    <tr><td>Sélectionnez le nombre d’années (entre 1 et 6) que vous souhaitez qu’Ad Valorem Inc. conserve votre information financière (sujet à un abonnement valide à Advataxes). <b>Quelques références:</b> <a href="#" onclick="javascript:window.open('http://www.cra-arc.gc.ca/F/pub/tg/rc4409/LISEZ-MOI.html');" style="color:#cd1e1e;"><u>RC4409 Conservation de registres</u></a>.</td></tr>
									<tr><td style="color:#cd1e1e;">Compensation sur le taux interbancaire</td></tr>
                                    <tr><td>Choisissez le pourcentage (entre 0 % et 5 %) que vous souhaitez majorer le taux de conversion des devises étrangères sur le taux interbancaire officiel. En guise d’exemple, le taux habituel des cartes de crédits est de + 2 %. De façon générale, le logiciel convertit les devises étrangères en dollars canadiens généralement à la date de transaction.</td></tr>
                                
                                </table>                                                    
                            </div>
                        </td	></tr>

                        <tr><td style="color:#cd1e1e; font-weight:bold;">Organisations</td></tr>
                        
                        <tr><td>Pour modifier le profil de votre organisation, allez à l’onglet « Organisations » et cliquez sur  <img src="../images/edit.png" width="20px" height="20px" />. </td></tr>

                        <tr><td>
                            <div style="position:relative;left:20px;">
                                <table>

                                    <tr><td style="color:#cd1e1e;">Nom</td></tr>
                                    <tr><td>Insérez le nom de l’organisation à laquelle les employés qui soumettent des rapports de dépenses appartiennent. </td></tr>
                                    <tr><td style="color:#cd1e1e;">Type</td></tr>
                                    <tr><td>Sélectionnez « organisme sans but lucratif » si votre organisation est un organisme sans but lucratif tel que défini à l’article 123 de la <i>Loi sur la taxe d’accise</i> et, le cas échéant, à l’article 1 de la <i>Loi sur la taxe de vente du Québec</i>. Sélectionnez « institution financière » si votre organisation est une institution financière telle que définie à la section 123 de la <i>Loi sur la taxe d’accise</i> et, le cas échéant, à l'article 1 de la <i>Loi sur la taxe de vente du Québec</i>. Sélectionnez « autre organisation » si votre organisation n’est pas couverte par les deux premiers types d’organisation. </td></tr>
									<tr><td style="color:#cd1e1e;">Code de l'organisation</td></tr>
                                    <tr><td>Insérez le cas échéant le code de votre organisation à des fins comptables.</td></tr>
                                    <tr><td style="color:#cd1e1e;">Juridiction</td></tr>        
                                    <tr><td>Insérez la juridiction dans laquelle les employés de votre organisation qui soumettent des rapports de dépenses encourront le plus probablement ces dépenses. Cette juridiction apparaîtra par défaut dans l'onglet « Mes dépenses ». </td></tr>
                                    <tr><td style="color:#cd1e1e;">Inscrit en TPS</td></tr>
                                    <tr><td>Sélectionnez « oui » si votre organisation est inscrite en TPS tel que défini par l’article 123 de la <i>Loi sur la taxe d’accise</i>. De façon générale, un inscrit en TPS est une personne qui est inscrite ou qui est tenue de l’être. Si le statut de votre organisation vient à changer, contactez-nous et nous effectuerons le changement.</td></tr>
                                    <tr><td style="color:#cd1e1e;">Inscrit en TVQ</td></tr>
                                    <tr><td>Sélectionnez « oui » si votre organisation est inscrite en TVQ tel que défini par l’article 1 de la <i>Loi sur la taxe de vente du Québec</i>. De façon générale, un inscrit en TVQ est une personne qui est inscrite ou qui est tenue de l’être. Si le statut de votre organisation vient à changer, contactez-nous et nous effectuerons le changement.</td></tr>
                                    <tr><td style="color:#cd1e1e;">Grande entreprise aux fins de la TPS/TVH</td></tr>
                                    <tr><td>Déterminez si votre organisation est une grande entreprise aux fins de la TPS ou une petite ou moyenne entreprise aux fins de la TPS (c’est-à-dire pas une grande entreprise). De façon générale, une grande entreprise aux fins de la TPS est une entreprise au cours d’une période de récupération donnée dont le total des ventes taxables et de celles de ses personnes associées excède 10 millions de dollars. Si ce statut vient à changer, contactez-nous et nous effectuerons le changement. <b>Quelques références:</b> <a href="#" onclick="javascript:window.open('http://www.cra-arc.gc.ca/F/pub/gm/b-104/LISEZ-MOI.html');" style="color:#cd1e1e;"><u>Bulletin d’information technique B-104 Taxe de vente harmonisée – Récupération temporaire des crédits de taxe sur les intrants en Ontario et en Colombie-Britannique</u></a></td></tr>
                                    <tr><td style="color:#cd1e1e;">Grande entreprise aux fins de la TVQ</td></tr>
                                    <tr><td>Déterminez si votre organisation est une grande entreprise aux fins de la TVQ ou une petite ou moyenne entreprise aux fins de la TVQ (c’est-à-dire non une grande entreprise). De façon générale, une grande entreprise aux fins de la TVQ est une entreprise au cours d’un exercice donné dont le total des ventes taxables et de celles de ses personnes associées excède 10 millions de dollars. Si votre statut d’entreprise vient à changer, contactez-nous et nous effectuerons le changement. <b>Quelques références:</b> <a href="#" onclick="javascript:window.open('http://www2.publicationsduquebec.gouv.qc.ca/dynamicSearch/telecharge.php?type=16&file=T0_1F206_1T9BULB.pdf');" style="color:#cd1e1e;"><u>Interprétation Revenu Québec TVQ.206.1-9 Qualification de petite ou moyenne entreprise ou de grande entreprise</u></a>.</td></tr>
                                    <tr><td style="color:#cd1e1e;">Ratio d’activités commerciales aux fins de la TPS</td></tr>
                                    <tr><td>Sélectionnez le ratio d’activités commerciales qui s’applique aux dépenses des employés de votre organisation aux fins de la TPS. Le ratio sélectionné peut prendre n’importe quelle valeur entre 0 % et 100 %. Si votre ratio vient à changer, contactez-nous et nous effectuerons le changement. <b> Quelques références:</b> <a href="#" onclick="javascript:window.open('http://www.cra-arc.gc.ca/F/pub/gm/8-3/LISEZ-MOI.html');" style="color:#cd1e1e;"><u>Mémorandum sur la TPS/TVH 8.3 Calcul des crédits de taxe sur les intrants.</u></a> <i><b>Pour les institutions financières seulement :</i></b> <a href="#" onclick="javascript:window.open('http://www.cra-arc.gc.ca/F/pub/gm/b-106/LISEZ-MOI.html');" style="color:#cd1e1e;"><u>Bulletin d’information technique sur la TPS/TVH B-106 Méthodes d’attribution des crédits de taxe sur les intrants pour les institutions financières en application de l’article 141.02 de la Loi sur la taxe d’accise.</u></a></td></tr>
                                    <tr><td style="color:#cd1e1e;">Ratio d’activités commerciales aux fins de la TVQ</td></tr>
                                    <tr><td>Sélectionnez le ratio d’activités commerciales qui s’applique aux dépenses des employés de votre organisation aux fins de la TVQ. Le ratio sélectionné peut prendre n’importe quelle valeur entre 0 et 100 %. Si votre ratio vient à changer, contactez-nous et nous effectuerons le changement.</td></tr>
                                    <tr><td style="color:#cd1e1e;">Ajouter des organisations</td></tr> 
									<tr><td>Si vous avez plusieurs organisation partageant les mêmes paramètres globaux, cliquez sur « Ajouter » pour configurer d’autres organisations.</td></tr>
                                </table>                                                    
                            </div>
                        </td></tr>

                        <tr><td style="color:#cd1e1e; font-weight:bold;">Catégories</td></tr>
                        
                        <tr><td>Choisissez parmi une liste de plus de 30 catégories de dépenses celles qui s’appliquent à votre organisation, en cliquant sur <img src="../images/download.png" width="20px" height="20px" />, à côté de chacune. Vous pouvez sélectionner la même catégorie plusieurs fois si vous devez couvrir différents comptes du GL. Vos employés pourront seulement choisir les catégories que vous aurez sélectionné au préalable et qui formeront la liste des « Catégories sélectionnées ».
                        </td></tr>

                        <tr><td>
                            <div style="position:relative;left:20px;">
                                <table>

                                    <tr><td style="color:#cd1e1e;">Sélectionner <img src="../images/download.png" width="20px" height="20px" /></td></tr>
                                    <tr><td>Sélectionnez les types de dépenses encourus par vos employés dans « Catégories disponibles ». Si vous choisissez par exemple « Allocation kilométrage », cliquez sur <img src="../images/download.png" width="20px" height="20px" /> pour sélectionner cette catégorie. Vous pouvez insérez dans le champ approprié le numéro de compte de GL de votre organisation pour une meilleure intégration comptable.  
                                             Il y a essentiellement trois types de catégories de dépenses.  </td></tr>
											 <tr><td>
											 Le premier type couvre des règles fiscales spécifiques. Les catégories « Allocation kilométrage », « Allocation repas (conducteurs de grands routiers) » et « Usage personnel de l’employé » sont par exemple régies par des dispositions fiscales spécifiques (cliquez sur <img src="../images/question.png" width="15px" height="15px" /> pour plus de détails sur chacune). Pour les grandes entreprises, des catégories telles que « Carburant auto » et « Cellulaire (tarifs mensuels) » sont également régies par des règles fiscales spécifiques.</td></tr>
											 <tr><td>
											 <br>Le deuxième type de catégories correspond à des types de dépenses courants tels que « Hôtel », « Stationnement » et « Fournitures de bureau ». Si la politique de votre organisation consiste à rembourser seulement les allocations pour le kilométrage et aucun autre type de dépenses reliés aux véhicules, assurez-vous de bien sélectionner « Allocation kilométrage » et non « Location auto (long terme) », « Carburant auto » ou encore « Entretien camions & autos ».</td></tr>
											 <tr><td>
											 Finalement, le troisième type de catégories de dépenses s’applique à des situations diverses qui ne sont pas régies par des règles fiscales spécifiques. Ces catégories sont « Taux à sélectionner », « Autres dépenses (sans taxes) » et « Autres dépenses (avec taxes) ». La catégorie « Taux à sélectionner » couvre par exemple les situations où l’utilisateur doit sélectionner lui-même les taux de taxe, en particulier les <b>services de transport</b> autres que le transport en commun tels que le <b>transport par avion</b> et le transport par train ou autobus sur des longues distances.
                                            Pour comprendre la logique fiscale implémentée par le logiciel relativement à chacune des catégories, cliquez sur <img src="../images/question.png" width="15px" height="15px" />. 
											Si vous devez apparier la logique fiscale d’une certaine catégorie avec plusieurs comptes, vous devez sélectionner la même catégorie plusieurs fois et procéder à son intégration avec la nomenclature comptable de votre organisation.  										                                 
                                             Si vous avez par exemple plusieurs employés qui achètent des échantillons et qu’il est important pour des raisons comptables de pouvoir suivre à la trace les différents échantillons achetés, vous pouvez sélectionner la catégorie « Autres dépenses (taxables) » plusieurs fois et la personnaliser en ajoutant des noms et des numéros de compte GL spécifiques :<br />
                                            <br />• Autres dépenses (taxables) – Chandails 600240<br />
                                            • Autres dépenses (taxables) – Pantalons 600250<br />
                                            • Autres dépenses (taxables) – Chapeaux 600260<br /><br />
											Vous pouvez par exemple comptabiliser la catégorie « Repas et divertissement » dans plusieurs comptes GL différents (par exemple « production », « formation » et « projets spéciaux ») :<br />
											<br />• Repas et divertissement – production 50025<br />
											• Repas et divertissement – formation 50040<br />
											• Repas et divertissement – projets spéciaux 50090<br /><br />
  
                                            Pour retirer une catégorie sélectionnée de la liste des catégories accessibles à vos employés, désactivez-la en cliquant sur <img src="../images/checked.png" width="20px" height="20px" />.
                                    </td></tr>
                               </table>                                                    
                            </div>
                        
                        </td></tr>
	
                        <tr><td style="color:#cd1e1e; font-weight:bold;">Employees</td></tr>
                        
                        <tr><td>Pour les fins de la TPS et de la TVQ, il est essentiel que les CTI, les RTI et les remboursements sur les dépenses de vos employés soient réclamés au sein de la même organisation dont ils font partie. Lorsque vous ajoutez des employés à une organisation, il convient donc de s’assurer qu’ils sont bien des employés de cette organisation. Le terme « employé », qui inclut les officiers, réfère à la définition d’un employé à l’article 123 de la <i>Loi sur la taxe d’accise</i> et à l’article 1 de la <i>Loi sur la taxe de vente du Québec</i>. Le terme peut inclure les associés et les bénévoles sous les conditions dans les articles 174 et 175 de la <i>Loi sur la taxe d’accise</i> et les articles 211 et 212 de la <i>Loi sur la taxe de vente du Québec</i>. <b>Quelques références:</b> Voir le <a href="#" onclick="javascript:window.open('http://www.cra-arc.gc.ca/F/pub/gm/9-4/LISEZ-MOI.html');" style="color:#cd1e1e;"><u>Mémorandum sur la TPS/TVH 9.4 Remboursements. </u></a>, et le <a href="#" onclick="javascript:window.open('http://www.cra-arc.gc.ca/F/pub/gm/9-3/LISEZ-MOI.html');" style="color:#cd1e1e;"><u>Mémorandum sur la TPS/TVH 9.3 Indemnités</u></a>. 
                                Cliquez sur <img src="../images/new.png" width="20px" height="20px" /> pour ajouter un employé.
                        </td></tr>

                        <tr><td>
                            <div style="position:relative;left:20px;">
                                <table>

                                    <tr><td style="color:#cd1e1e;">Nom</td></tr>
                                    <tr><td>Nom de famille de l’employé.</td></tr>
                                    
                                    <tr><td style="color:#cd1e1e;">Prénom</td></tr>
                                    <tr><td>Prénom de l’employé.</td></tr>
                                    
                                    <tr><td style="color:#cd1e1e;">Numéro de l'employé</td></tr>        
                                    <tr><td>Numéro de l’employé (optionnel).</td></tr>
                                    
                                    <tr><td style="color:#cd1e1e;">Code de département</td></tr>
                                    <tr><td>Code de département de l’employé (optionnel).</td></tr>
                                    
                                    <tr><td style="color:#cd1e1e;">Approbateur</td></tr>
                                    <tr><td>La personne qui finalise ou rejette les rapports de dépenses de cet employé.</td></tr>
									
									<tr><td style="color:#cd1e1e;">Délégué</td></tr>
									<tr><td>L’administrateur peut déléguer à un employé la tâche de remplir les rapports de dépenses d’autres employés. Les utilisateurs qui sont délégués peuvent créer des rapports, ajouter des dépenses et soumettre des rapports à la place de leurs collègues. Les délégués doivent seulement cliquer sur le menu déroulant dans l’onglet « Mes dépenses » et s’assurer de sélectionner le bon employé.</td></tr>
                                    
                                    <tr><td style="color:#cd1e1e;">Courriel</td></tr>
                                    <tr><td>Courriel de l'employé.</td></tr>
                                    
                                    <tr><td style="color:#cd1e1e;">Nom d'utilisateur</td></tr>
                                    <tr><td>Nom d’utilisateur pour se connecter à Advataxes.</td></tr>
                                    
                                    <tr><td style="color:#cd1e1e;">Statut d'administrateur</td></tr>
                                    <tr><td>Seul l’administrateur a accès à l’information disponible dans l’onglet « Administrateur ». Celui-ci peut apporter certaines modifications au profil des employés. </td></tr>
									<tr><td style="color:#cd1e1e;">Statut de l'approbateur</td></tr>
                                    <tr><td>L'approbateur est chargé de vérifier les rapports de dépenses des employés qui lui ont été assignés. Lorsqu’un rapport de dépenses est soumis par l’un de ses employés, un courriel lui est envoyé. Pour les employés qui ne travaillent plus pour l’organisation, cliquez sur <img src="../images/checked.png" width="20px" height="20px" /> sous « Actif » pour désactiver leur compte. Ils n'auront plus accès à Advataxes. </td></tr>									
                                    
                                    <tr><td style="color:#cd1e1e;">Notification par courriel</td></tr>
                                    <tr><td>Si cette option est sélectionnée, l’employé sera notifié par courriel toutes les fois qu’un rapport de dépenses est finalisé, et ceci pour tous les employés de son organisation. Le courriel inclura le montant qui est dû à l’employé. Habituellement, la personne qui est en charge de rembourser les employés est la personne qui recevra ce courriel. </td></tr>
                                
                                </table>                
                            </div>
                        </td></tr>

                        <tr><td style="color:#cd1e1e; font-weight:bold;">Rapports</td></tr>
                        
                        <tr><td>La section « Rapports » fournit une liste de rapports aux fins de la TPS/TVH et TVQ, de comptabilité et de gestion.  </td></tr>

                        <tr><td>
                            <div style="position:relative;left:20px;">
                                <table>

                                    <tr><td style="color:#cd1e1e;">Éventail des rapports</td></tr>
                                    <tr><td>Cette option vous permet d’obtenir des rapports par période, par type de dépense ou par intervalle de temps.</td></tr>
                                    <tr><td style="color:#cd1e1e;">Année financière</td></tr>
                                    <tr><td>Cette option vous permet de choisir l’année financière et la période comptable. Choisissez une période financière terminée pour obtenir le sommaire et les détails comptables. Le logiciel ferme automatiquement toutes les périodes comptables. Si les mois du calendrier concordent avec périodes financières de votre organisation, les données comptables telles que les CTI et les RTI et les montants de dépenses seront disponibles le 1er de chaque mois.</td></tr>
                                    <tr><td style="color:#cd1e1e;">Type de rapport</td></tr>        
                                    <tr><td>Plusieurs types de rapport sont disponibles. Vous pouvez fournir un sommaire des rapports de dépenses qui totalise tous les montants comptabilisés par catégorie de dépenses, par TPS/TVH et TVQ à réclamer et de la récupération des CTI. Le sommaire par catégorie est utile pour procéder à des ajustements fiscaux sur certaines catégories. L’Agence du revenu du Canada permet par exemple de réclamer des CTI sur des dépenses pour usage personnel allant jusqu’à 500 $. Comme le logiciel ne calcule pas les taxes sur ces dépenses, il est du moins possible de procéder à un ajustement de fin d’année. Un ajustement similaire peut être fait avec les allocations pour le déménagement sur lesquelles il est possible de réclamer la TPS sur les premiers 650 $. </td></tr>
                                </table>                
                            </div>
                        
                        </td></tr>

                        <tr><td style="color:#cd1e1e; font-weight:bold;">Tableau de bord</td></tr>
                        
                        <tr><td>Vous trouverez dans l’onglet « Tableau de bord » une liste d’employés et la date à laquelle ceux-ci se sont connectés pour la dernière fois à Advataxes. Lorsque vous ajouter un nouvel employé, la date de création correspond à la date de la première connexion. <br /><br /><br /></td></tr>
                        <tr><td>Si vous avez des questions, n'hésitez pas à <a href="contactus.aspx" style="color:#cd1e1e">nous contacter</a> et l'un de nos représentants communiquera avec vous.</td></tr>

                    </table>
                </div>
                
            </div>
			
			<div id="tab-taxDoc">
				<div style="position:relative;top:20px;left:20px; overflow:auto; height:870px; width:98%;">
				
					<table width="96%">
						<tr style="height:40px;"><td valign="top" style="color:#cd1e1e; font-size:1.5em;">Documentation fiscale</td></tr>
						<tr style="height:0.1px; background-color:#cd1e1e;"><td></td></tr>
						<tr><td style="height:10px;"></td></tr>

						<tr style="background-color:#cd1e1e;color:white;"><td><b>Gouvernement fédéral</b></td></tr>
						<tr style="height:10px;"><td></td></tr>
						
						<tr><td><a href="#" onclick="javascript:window.open('http://laws-lois.justice.gc.ca/fra/lois/E-15/page-1.html');" style="color:#cd1e1e;"><u>Loi sur la taxe d’accise</u></a></td></tr>
						
						<tr><td><a href="#" onclick="javascript:window.open('http://www.canlii.org/fr/ca/legis/lois/lrc-1985-c-1-5e-suppl/derniere/lrc-1985-c-1-5e-suppl.html');" style="color:#cd1e1e;"><u>Loi de l’impôt sur le revenu</u></a></td></tr> 
						
						<tr><td><a href="#" onclick="javascript:window.open('http://www.cra-arc.gc.ca/F/pub/gm/4-3/LISEZ-MOI.html');" style="color:#cd1e1e;"><u>Nouvelle série de mémorandum sur la TPS/TVH 4.3 Produits alimentaires de base</u></a></td></tr>
						
						<tr><td><a href="#" onclick="javascript:window.open('http://www.cra-arc.gc.ca/F/pub/gm/8-1/LISEZ-MOI.html');" style="color:#cd1e1e;"><u>Mémorandum sur la TPS/TVH 8.1 Règles générales d’admissibilité</u></a></td></tr>
						
						<tr><td><a href="#" onclick="javascript:window.open('http://www.cra-arc.gc.ca/F/pub/gm/8-2/LISEZ-MOI.html');" style="color:#cd1e1e;"><u>Mémorandum sur la TPS/TVH 8.2 Restrictions générales</u></a></td></tr> 
						
						<tr><td><a href="#" onclick="javascript:window.open('http://www.cra-arc.gc.ca/F/pub/gm/8-3/LISEZ-MOI.html');" style="color:#cd1e1e;"><u>Mémorandum sur la TPS/TVH 8.3 Calcul des crédits de taxe sur les intrants</u></a></td></tr>

						<tr><td><a href="#" onclick="javascript:window.open('http://www.cra-arc.gc.ca/F/pub/gm/8-4/LISEZ-MOI.html');" style="color:#cd1e1e;"><u>Mémorandum sur la TPS/TVH 8.4 Documents requis pour demander des crédits de taxe sur les intrants</u></a></td></tr>
						
						<tr><td><a href="#" onclick="javascript:window.open('http://www.cra-arc.gc.ca/F/pub/gm/9-3/LISEZ-MOI.html');" style="color:#cd1e1e;"><u>Mémorandum sur la TPS/TVH 9.3 Indemnités</u></a></td></tr> 
						
						<tr><td><a href="#" onclick="javascript:window.open('http://www.cra-arc.gc.ca/F/pub/gm/9-4/LISEZ-MOI.html');" style="color:#cd1e1e;"><u>Mémorandum sur la TPS/TVH 9.4 Remboursements</u></a></td></tr> 
						
						<tr><td><a href="#" onclick="javascript:window.open('http://www.cra-arc.gc.ca/F/pub/gi/gi-061/LISEZ-MOI.html');" style="color:#cd1e1e;"><u>Info TPS/TVH GI-061 Taxe de vente harmonisée de la Colombie-Britannique – Remboursement au point de vente pour les carburants</u></a></td></tr>
						
						<tr><td><a href="#" onclick="javascript:window.open('http://www.cra-arc.gc.ca/F/pub/gi/gi-065/LISEZ-MOI.html');" style="color:#cd1e1e;"><u>Info TPS/TVH GI-065 Taxe de vente harmonisée de l’Ontario et de la Colombie-Britannique – Remboursement au point de vente pour les livres</u></a></td></tr>

						<tr><td><a href="#" onclick="javascript:window.open('http://www.cra-arc.gc.ca/F/pub/gp/rc4036/LISEZ-MOI.html');" style="color:#cd1e1e;"><u>RC4036 Renseignements sur la TPS/TVH pour l’industrie du tourisme et des congrès</u></a></td></tr>

						<tr><td><a href="#" onclick="javascript:window.open('http://www.cra-arc.gc.ca/F/pub/tg/rc4409/LISEZ-MOI.html');" style="color:#cd1e1e;"><u>RC4409 Conservation de registres</u></a></td></tr>

						<tr><td><a href="#" onclick="javascript:window.open('http://www.cra-arc.gc.ca/F/pub/gm/b-104/LISEZ-MOI.html');" style="color:#cd1e1e;"><u>Bulletin d’information technique B-104 Taxe de vente harmonisée – Récupération temporaire des crédits de taxe sur les intrants en Ontario et en Colombie-Britannique</u></a></td></tr> 

						<tr><td><a href="#" onclick="javascript:window.open('http://www.cra-arc.gc.ca/F/pub/gm/b-106/LISEZ-MOI.html');" style="color:#cd1e1e;"><u>Bulletin d’information technique B-106 Méthodes d’attribution des crédits de taxe sur les intrants pour les institutions financières en application de l’article 141.02 de la Loi sur la taxe d’accise</i></u></a></td></tr> 	
						
						<tr><td><a href="#" onclick="javascript:window.open('http://www.cra-arc.gc.ca/F/pbg/tf/t2200/');" style="color:#cd1e1e;"><u>T2200 Déclaration des conditions de travail</u></a></td></tr> 
						
						<tr><td><a href="#" onclick="javascript:window.open('http://www.cra-arc.gc.ca/F/pub/tg/t4130/LISEZ-MOI.html');" style="color:#cd1e1e;"><u>T4130 Guide de l’employeur – Avantages et allocations imposables</u></a></td></tr>
						
						<tr><td><a href="#" onclick="javascript:window.open('http://www.cra-arc.gc.ca/F/pub/tp/it522r/LISEZ-MOI.html');" style="color:#cd1e1e;"><u>IT522R Frais afférents à un véhicule à moteur, frais de déplacement et frais de vendeurs engagés ou effectués par les employés</u></a></td></tr> 
						
						<tr><td><a href="#" onclick="javascript:window.open('http://www.cra-arc.gc.ca/F/pub/gr/news54/');" style="color:#cd1e1e;"><u>Nouvelles de la TPS/TVH No 54</u></a></td></tr> 
						
						<tr><td><a href="#" onclick="javascript:window.open('http://www.fin.gc.ca/n11/11-146-fra.asp');" style="color:#cd1e1e;"><u>Le gouvernement annonce les plafonds de déduction des frais d’automobile et les taux des avantages relatifs à l’utilisation d’une automobile pour les entreprises en 2012</u></a></td></tr>  
						
						<tr style="height:20px;"><td></td></tr>
						
						<tr style="background-color:#cd1e1e;color:white;"><td><b>Gouvernement du Québec</b></td></tr>
						<tr style="height:10px;"><td></td></tr>
						
						<tr><td><a href="#" onclick="javascript:window.open('http://www.canlii.org/fr/qc/legis/lois/lrq-c-t-0.1/derniere/lrq-c-t-0.1.html');" style="color:#cd1e1e;"><u>Loi sur la taxe de vente du Québec</u></a></td></tr>
															
						<tr><td><a href="#" onclick="javascript:window.open('http://www2.publicationsduquebec.gouv.qc.ca/dynamicSearch/telecharge.php?type=16&file=T0_1F206_1T6BULB.pdf');" style="color:#cd1e1e;"><u>Interprétation Revenu Québec TVQ.206.1-6 Restriction à l’obtention d’un remboursement de la taxe sur les intrants à l’égard des véhicules routiers de moins de 3 000 kilogrammes</u></a></td></tr> 
						
						<tr><td><a href="#" onclick="javascript:window.open('http://www2.publicationsduquebec.gouv.qc.ca/dynamicSearch/telecharge.php?type=16&file=T0_1F206_1T8BULB.pdf');" style="color:#cd1e1e;"><u>Interprétation Revenu Québec TVQ.206.1-8 RTI relativement à l’essence utilisée par une grande entreprise</u></a></td></tr> 
						
						<tr><td><a href="#" onclick="javascript:window.open('http://www2.publicationsduquebec.gouv.qc.ca/dynamicSearch/telecharge.php?type=16&file=T0_1F206_1T9BULB.pdf');" style="color:#cd1e1e;"><u>Interprétation Revenu Québec TVQ.206.1-9 Qualification de petite ou moyenne entreprise ou de grande entreprise</u></a></td></tr> 
						
						<tr><td><a href="#" onclick="javascript:window.open('http://www2.publicationsduquebec.gouv.qc.ca/dynamicSearch/telecharge.php?type=16&file=T0_1F211T3R3BULB.pdf');" style="color:#cd1e1e;"><u>Interprétation Revenu Québec TVQ.211-3/R3 Remboursement de la taxe sur les intrants à l’égard d’une allocation de dépenses</u></a></td></tr>
						
						<tr><td><a href="#" onclick="javascript:window.open('http://www2.publicationsduquebec.gouv.qc.ca/dynamicSearch/telecharge.php?type=16&file=T0_1F212T2BULB.pdf');" style="color:#cd1e1e;"><u>Interprétation Revenu Québec TVQ.212-2 Caractéristiques d’un remboursement de dépenses</u></a></td></tr>
						
						<tr><td><a href="#" onclick="javascript:window.open('http://www2.publicationsduquebec.gouv.qc.ca/dynamicSearch/telecharge.php?type=16&file=T0_1F212T3BULB.pdf');" style="color:#cd1e1e;"><u>Interprétation Revenu Québec TVQ.212-3 Cotisations professionnelles de salariés</u></a></td></tr>
						
						<tr><td><a href="#" onclick="javascript:window.open('http://www2.publicationsduquebec.gouv.qc.ca/dynamicSearch/telecharge.php?type=16&file=T0_1F457_1T1BULB.pdf');" style="color:#cd1e1e;"><u>Interprétation Revenu Québec TVQ.457.1-1 Dépenses de divertissement</u></a></td></tr> 
						
						<tr><td><a href="#" onclick="javascript:window.open('http://www2.publicationsduquebec.gouv.qc.ca/dynamicSearch/telecharge.php?type=16&file=I3F37T2R2BULB.pdf');" style="color:#cd1e1e;"><u>Interprétation Revenu Québec IMP-37-2/R2 Paiement ou remboursement par un employeur des montants exigibles d’un employé membre d’une association professionnelle</u></a></td></tr> 
						
						<tr><td><a href="#" onclick="javascript:window.open('http://www.revenuquebec.ca/fr/citoyen/taxes/tpstvq/transport/hors_quebec/tvq.aspx');" style="color:#cd1e1e;"><u>Application de la TVQ en matière de transport de passagers hors du Québec</u></a></td></tr> 
						
						<tr><td><a href="#" onclick="javascript:window.open('http://www.revenuquebec.ca/fr/entreprise/taxes/tvq_tps/perception/cas_particuliers/transport/hors_quebec/tps.aspx');" style="color:#cd1e1e;"><u>Application de la TPS  en matière de transport de passagers hors du Québec</u></a></td></tr> 
												
						<tr style="height:20px;"><td></td></tr>
						<tr style="background-color:#cd1e1e;color:white;"><td><b>Gouvernement de l’Île-du-Prince-Édouard</b></td></tr>	
						<tr style="height:10px;"><td></td></tr>
						
						<tr><td><a href="#" onclick="javascript:window.open('http://www.gov.pe.ca/photos/original/hst_recap_itc.pdf');" style="color:#cd1e1e;"><u>Revenue Tax Guide 186 (PEI): Temporary Recapture of certain Provincial Input Tax Credits </u></a></td></tr>
						 						
					</table>
				</div>
			</div>
			
						
			<div id="tab-yearEnd">
				<div style="position:relative;top:20px;left:20px; overflow:auto; height:870px; width:98%;">
				
					<table width="96%">
						<tr style="height:40px;"><td valign="top" style="color:#cd1e1e; font-size:1.5em;">Fin d'année</td></tr>
						<tr style="height:0.1px; background-color:#cd1e1e;"><td></td></tr>
						<tr><td style="height:10px;"></td></tr>
					
					<tr><td>Le logiciel est conçu pour qu’un administrateur puisse, le cas échéant, extraire l’information pertinente et effectuer des ajustements de fin d’année de TPS/TVH et de TVQ sur plusieurs catégories de dépenses.</td></tr> 
					<tr><td></td></tr>
					<tr><td style="color:#cd1e1e; font-weight:bold; font-size: 15px">Fonctionnalité pour obtenir des rapports spécifiques aux fins de la TPS/TVH et de la TVQ</td></tr>
					<tr><td>Dans la section « Administrateur », allez à l’onglet « Rapports ». Vous pouvez ensuite cliquer sur « Personnalisez » dans « Éventail des rapports », et sélectionner l’intervalle de temps désiré (par ex. le 1er janvier 2013 au 31 décembre 2013).</td></tr> 
					<tr><td>Dans « Type de rapport », vous pouvez aussi sélectionner « Sommaire par catégorie » et la catégorie désirée dans le champ « Catégorie ». Vous pourrez ainsi voir les montants de dépenses comptabilisés, les périodes comptabilisées, les noms des employés et les reçus en rapport avec cette catégorie de dépenses s’ils ont été importés par l’employé durant cet intervalle de temps.</td></tr> 
					<tr><td></td></tr>
					<tr><td style="color:#cd1e1e; font-weight:bold; font-size:15px">Gérer la TPS/TVH et la TVQ, et davantage</td></tr>
					<tr><td>La grande variété de rapports peut être utilisée pour gérer la TPS/TVH et la TVQ pour des ajustements de fin d’année dans les situations suivantes :</td></tr>
					<tr><td></td></tr>
					<tr><td style="color:#cd1e1e; font-weight:bold;">Dépenses sur des véhicules</td></tr>
					<tr><td>Il existe plusieurs règles fiscales régissant l’usage de véhicules par des employés tant à des fins d’affaires que personnelles, règles qui sont basées sur le nombre de kilomètres parcourus. Les conséquences fiscales peuvent avoir un impact sur les catégories de dépenses suivantes :</td></tr>
					<tr><td>
					<ul>
						<li>Entretien autos & camions</li>
						<li>Location auto (long terme)</li>
						<li>Carburant auto</li>
					</ul>	
					</td></tr>
					<tr><td>Voir <a href="#" onclick="javascript:window.open('http://www.cra-arc.gc.ca/F/pub/tg/t4130/LISEZ-MOI.html');" style="color:#cd1e1e;"><u>T4130 Guide de l’employeur – Avantages et allocations imposables</u></a> et <a href="#" onclick="javascript:window.open('http://www.cra-arc.gc.ca/F/pub/gm/8-2/LISEZ-MOI.html');" style="color:#cd1e1e;"><u>Mémorandum sur la TPS/TVH 8.2 Restrictions générales</u></a> pour plus de détails.</td></tr>
					<tr><td>Tous les rapports détaillant les dépenses peuvent également être produits par division (par ex. Marketing), ou par employé pour tout intervalle de temps.</td></tr>
					<tr><td></td></tr>
					<tr><td style="color:#cd1e1e; font-weight:bold;">Dépenses pour usage personnel</td></tr>
					<tr><td>Il existe une règle administrative permettant aux inscrits de réclamer des intrants sur des dépenses pour usage personnel, et ce jusqu’à 500 $ de dépenses par année. Bien que le logiciel n’automatise pas cette règle en proposant une catégorie distincte pour ce genre de dépenses, vous pouvez obtenir la liste des dépenses comptabilisées dans ce logiciel et procéder, le cas échéant, à un recouvrement de taxes sur ces dépenses. Vous pouvez obtenir plus de détails sur cette règle dans le <a href="#" onclick="javascript:window.open('http://www.cra-arc.gc.ca/F/pub/gm/8-2/LISEZ-MOI.html');" style="color:#cd1e1e;"><u>Mémorandum sur la TPS/TVH 8.2 Restrictions générales.</u></a>.</td></tr>
					<tr><td></td></tr>
					<tr><td style="color:#cd1e1e;font-weight:bold;">Allocation déménagement</td></tr>
					<tr><td>La politique de l’ARC est à l’effet que les allocations pour le déménagement remboursées à un employé jusqu’à concurrence de 650 $ peuvent donner lieu à un crédit de taxe sur les intrants.  Revenu Québec  considère qu’une allocation pour le déménagement équivalant à deux semaines de salaire est acceptable aux fins de la TVQ. Pour plus d’informations, consultez le document <a href="#" onclick="javascript:window.open('http://www.cra-arc.gc.ca/F/pub/gr/news54/LISEZ-MOI.html');" style="color:#cd1e1e;"><u>Nouvelles TPS/TVH no 54</u></a>. Comme le logiciel n’automatise pas le calcul des taxes sur ces allocations, vous pouvez extraire les dépenses comptabilisées et procéder, le cas échéant, aux ajustements de TPS/TVH et de TVQ.</td></tr>
					<tr><td style="color:#cd1e1e;font-weight:bold;">Allocation kilométrage et RCTI en ON et en CB</td></tr>
					<tr><td>Pour les grandes entreprises qui ont de la récupération de crédits de taxe sur les intrants sur cette dépense, sachez que Finances Canada est en discussion avec la Colombie-Britannique et l’Ontario sur la création d’un facteur administratif sur les allocations d’autos. Le document <a href="#"onclick="javascript:window.open('http://www.tei.org/news/Documents/TEI%20CCTC-CRA-Finance%20Liaison%20Agenda.pdf');" style="color:#cd1e1e;"><u>Tax Executives Institute, Inc. Excise Tax Questions submitted to Canada Revenue Agency and the Department of Finance December 4-5, 2012</u></a> note que ce facteur permettrait de recouvrir des taxes sur des aspects de l’allocation kilométrage non classifiés comme biens ou services déterminés tels que les réparations et l’entretien. Des ajustements <u>périodiques</u> de RCTI peuvent être nécessaires. Notez que nous attendons que les autorités fiscales fournissent des instructions détaillées sur cette question. </td></tr>
											
					</table>
				</div>
			</div>

          <asp:HiddenField ID="hdnAdmin" runat="server" />
          <asp:HiddenField ID="hdnApprover" runat="server" />

    </div>
</asp:Content>
