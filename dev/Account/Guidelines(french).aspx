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
				<li id="empListItem"><a href="#tab-employee">Employ�</a></li>
                <li id="approverListItem"><a href="#tab-approver">Approbateur</a></li>
                <li id="adminListItem"><a href="#tab-admin">Administrateur</a></li>
				<li id="taxDocListItem"><a href="#tab-taxDoc">Documentation fiscale</a></li>
				<li id="yearendListItem"><a href="#tab-yearEnd">Fin d'ann�e</a></li>
			</ul>

			<div id="tab-employee">
                <div style="position:relative;top:20px;left:20px; overflow:auto; height:860px; width:98%;">
                    <table width="96%">
                        <tr style="height:40px;"><td valign="top" style="color:#cd1e1e; font-size:1.5em;">Guide de l'employ�</td></tr>
                        <tr style="height:0.1px; background-color:#cd1e1e;"><td></td></tr>
                        <tr><td style="height:10px;"></td></tr>
											
                        <tr><td style="color:#cd1e1e; font-weight:bold;">1. G�rer un rapport de d�penses</td></tr>
                        
                        <tr><td>
                            <div style="position:relative;left:20px;">
                                <table>
                                    <tr><td style="color:#cd1e1e;">Cr�er un rapport</td></tr>
                                    <tr><td>Pour cr�er un rapport de d�penses, allez � l�onglet � Mes d�penses �, cliquez sur <img src="../images/new.png" width="20px" height="20px" /> � c�t� de � Rapports �, et choisissez un nom pour votre rapport. Nous vous sugg�rons de choisir un nom qui d�crit bien les d�penses que vous voulez enregistrer. � titre d�exemple, le nom peut �tre � Conf�rence � Ottawa � lorsque les d�penses ont �t� encourues dans le cadre d�une conf�rence � Ottawa. Une fois le nom de votre rapport choisi, vous �tes pr�ts � enregistrer vos d�penses en cliquant sur <img src="../images/new.png" width="20px" height="20px" /> � c�t� de � D�penses �. 
                                            Vous pouvez seulement cr�er un rapport � la fois. Vous devez donc soumettre votre rapport pour approbation avant de pouvoir en cr�er un autre. Vous pouvez avoir plus d�un rapport dans l�onglet � Mes d�penses � seulement lorsqu�un ou des rapports d�j� soumis sont renvoy�s par l�approbateur pour qu�ils soient modifi�s.  
                                    </td></tr>
                                    <tr><td style="color:#cd1e1e;">Modifier le nom du rapport</td></tr>
                                    <tr><td>Vous pouvez modifier le nom du rapport en cliquant sur <img src="../images/edit.png" width="20px" height="20px" />. Lorsqu�un rapport est soumis, il n�est plus possible d�en changer le nom. </td></tr>
                                    <tr><td style="color:#cd1e1e;">Supprimer un rapport</td></tr>
                                    <tr><td>Vous pouvez supprimer un rapport qui a �t� cr�� en cliquant sur  <img src="../images/del.png" width="20px" height="20px" />. Vous ne pouvez pas supprimer un rapport dont le statut est � En attente d�approbation � ou � Finalis�s �.  </td></tr>  
                                </table>
                            </div>
                        </td></tr>
                        
                        <tr><td style="color:#cd1e1e; font-weight:bold;">2. 2. G�rer les d�penses</td></tr>
                                    <tr><td>
                                        <div style="position:relative;left:20px;">
                                            <table>
                                            
                                                <tr><td style="color:#cd1e1e;">Ajouter une d�pense</td></tr>
                                                <tr><td>Lorsqu�un rapport est cr��, vous pouvez ajouter une d�pense en cliquant sur <img src="../images/new.png" width="20px" height="20px" /> � la droite de � D�penses � et du nom de votre rapport.</td></tr>
                                                        
                                                <tr><td>
                                                    <div style="position:relative;left:20px;">
                                                        <table>
                                                            <tr><td style="color:#cd1e1e;">Type de d�pense</td></tr>
                                                            <tr><td>Choisissez le type de d�pense encouru, par exemple � Repas et divertissement �, � Allocation kilom�trage � ou � T�l�communication �, en cliquant sur � Type de d�pense �.</td></tr>
                                                            <tr><td style="color:#cd1e1e;">Date de transaction</td></tr>
                                                            <tr><td>Choisissez le jour o� la d�pense a �t� encourue. Une facture d�h�tel pour un s�jour en date du 19 juillet 2012, par exemple, devrait avoir comme date le 19 juillet 2012. De fa�on g�n�rale, la date de transaction �quivaut � la date sur la facture. Si vous n�avez pas de facture, par exemple pour une allocation pour le kilom�trage, choisissez alors la date � laquelle r�f�re l�allocation. Une telle allocation pour un voyage � Ottawa en date du 19 juillet 2012 devrait ainsi �tre dat�e du 19 juillet 2012. Le logiciel n�est pas configur� pour les d�penses qui pr�c�dent le 1er juillet 2010.</td></tr>
                                                            <tr><td style="color:#cd1e1e;">Juridiction</td></tr>
                                                            <tr><td>Choisissez la juridiction canadienne, qu�il s�agisse d�une province ou d�un territoire tels que l�Ontario, la Colombie Britannique ou le Qu�bec, o� la d�pense a �t� encourue. Si votre d�pense a �t� encourue � l�ext�rieur des provinces et des territoires du Canada, s�lectionnez � � l�ext�rieur du Canada �.</td></tr>
                                                            <tr><td style="color:#cd1e1e;">Montant</td></tr>
                                                            <tr><td>Ins�rez le montant tel qu�il appara�t sur votre re�u ou votre allocation. Les sous doivent �tre s�par�s des dollars par un point. Pour les montants sur vos re�us, vous pouvez ins�rer un montant avant les taxes ou un montant qui inclut les taxes en s�lectionnant une des fonctionnalit�s ci-dessous.</td></tr>
                                                            <tr><td style="color:#cd1e1e;">Taxes incluses</td></tr>
                                                            <tr><td>Avec cette fonctionalit�, la TPS/TVH et la TVQ sont, le cas �ch�ant, calcul�es sur un montant qui inclut les taxes. Veuillez toutefois noter que le montant � ins�rer devrait exclure les pourboires optionnels.</td></tr>
                                                            <tr><td style="color:#cd1e1e;">Avant les taxes</td></tr>        
                                                            <tr><td>S�lectionnez cette option lorsque le montant ins�r� n�inclut pas la TPS/TVH et TVQ. Cette option peut s�appliquer � des factures d�h�tel comprenant des montants s�par�s pour la chambre et pour le repas. Dans ces situations, les utilisateurs devraient cr�er une d�pense pour la chambre en choisissant � H�tel � comme type de d�pense, et cr�er une deuxi�me d�pense en choisissant la cat�gorie � Repas et divertissement � appropri�e.</td></tr>
                                                            <tr><td style="color:#cd1e1e;">Pourboires</td></tr>
                                                            <tr><td>Entrez seulement le montant des pourboires facultatifs. Ceux-ci ne sont pas sujets � la TPS/TVH et � la TVQ.</td></tr>
                                                            <tr><td style="color:#cd1e1e;">Devises</td></tr>
                                                            <tr><td>Le logiciel convertit les devises �trang�res en dollars canadiens. Plus de 150 devises �trang�res peuvent �tre s�lectionn�es. De fa�on g�n�rale, la conversion des devises s�appuie sur la valeur de conversion en vigueur lors de la date de transaction. Par d�faut, les montants ins�r�s sont en dollars canadiens (CAD).</td></tr>
															<tr><td style="color:#cd1e1e;">Ne pas rembourser</td></tr>
															<tr><td>S�lectionnez cette option si le montant de d�penses que vous entrez sera pay� par votre organisation en votre nom.</td></tr>
                                                            <tr><td style="color:#cd1e1e;">Nom du fournisseur</td></tr>
                                                            <tr><td>Les utilisateurs peuvent, le cas �ch�ant, entrer le nom du fournisseur.</td></tr>
                                                            <tr><td style="color:#cd1e1e;">Commentaires</td></tr>
                                                            <tr><td>Les employ�s peuvent ins�rer des commentaires en rapport avec les d�penses encourues (par ex. d�ner avec la compagnie ABC).</td></tr>
                                                            <tr><td style="color:#cd1e1e;">TPS/TVH et TVQ pay�es</td></tr>
                                                            <tr><td>Lorsque votre d�pense s�accompagne d�un re�u, comparez les montants de TPS/TVH et de TVQ calcul�s par le logiciel et les montants de TPS/TVH et de TVQ indiqu�s sur votre re�u. Les �carts peuvent �tre dus � une erreur dans le choix de la date de transaction ou du type de d�pense. Corrigez ces choix et refaites la comparaison entre les taxes calcul�es et les taxes indiqu�es sur votre re�u. Des situations irr�guli�res, telles que des achats aupr�s d�un petit fournisseur ou des rabais de TVH pour des repas de moins de 4.00 $ en Ontario, devraient �tre corrig�es. Cliquez sur <img src="../images/lock.png" width="15px" height="20px" /> pour modifier les montants de TPS/TVH et de TVQ. De fa�on similaire, si vous avez perdu le re�u justifiant votre transaction, vous pouvez mettre les champs de TPS/TVH et de TVQ � z�ro. Il faut noter que les frais de taxi, de t�l�phone public et de stationnement payant ne sont pas couverts par l�obligation de fournir des pi�ces justificatives aux fins de la TPS/TVH et de la TVQ.</td></tr>
                                                            <tr><td style="color:#cd1e1e;">Re�u</td></tr>
                                                            <tr><td>Vous pouvez importer vos re�us � c�t� de chaque d�pense que vous entrez. Les re�us peuvent avoir les formats suivants : PDF, JPEG, PNG, TIFF, GIF, BMP et HTML. Pour les importer, cliquez sur � Choisissez un fichier �. </td></tr>
                                                            <tr><td style="color:#cd1e1e;">Taux � s�lectionner</td></tr>
                                                            <tr><td>Cette cat�gorie inclut notablement les services de transport tels que le transport par avion, le transport par train ou par autobus sur des longues distances. Elle exclut les services de transport en commun. Pour cette cat�gorie, les utilisateurs doivent s�lectionner le taux de taxe qui s�applique � leur situation dans un menu d�roulant, en consultant leur facture.</td></tr>
                                                            <tr><td style="color:#cd1e1e;">Usage personnel de l�employ�</td></tr>
                                                            <tr><td>Si vous s�lectionnez ce type de d�penses pour des d�penses encourues pour usage personnel (par opposition � des d�penses encourues pour des fins reli�es � votre organisation), aucune TPS/TVH ou TVQ n�est calcul�e, en d�pit du fait que ces d�penses peuvent avoir de la TPS/TVH ou de la TVQ. Aucune correction n�est n�cessaire de la part de l�employ�.</td></tr>
                                                        </table>                                                    
                                                    </div>
                                                </td></tr>

                                                <tr><td style="color:#cd1e1e;">Modifier une d�pense</td></tr> 
                                                <tr><td>Vous pouvez modifier une d�pense en cliquant sur <img src="../images/edit.png" width="20px" height="20px" />. Vous serez en mesure de modifier des informations telles que la date de transaction, le montant des d�penses, le montant des pourboires, la juridiction et ainsi de suite. La seule information que vous ne pourrez pas modifier est le type de d�pense. </td></tr>
                                                <tr><td style="color:#cd1e1e;">Afficher les commentaires</td></tr>
                                                <tr><td>Vous pouvez afficher les commentaires sur une d�pense en cliquant sur <img src="../images/plus.png" width="15px" height="15px" /> � la gauche de chaque d�pense.</td></tr>
                                                <tr><td style="color:#cd1e1e;">Supprimer une d�pense</td></tr>
                                                <tr><td>Vous pouvez supprimer des d�penses en cliquant sur <img src="../images/del.png" width="20px" height="20px" /> � la droite de chacune.</td></tr>

                                            </table>                                        
                                        </div>
                                    
                                    </td></tr>
                                    
                            
                        <tr><td style="color:#cd1e1e; font-weight:bold;">3.	Soumettre un rapport</td></tr>
                        
                        <tr><td>
                            <div style="position:relative;left:20px;">
                                <table>
                                    <tr><td  style="color:#cd1e1e;" >Soumettre un rapport de d�penses</td></tr>
                                    <tr><td>Vous pouvez soumettre votre rapport de d�penses pour approbation en cliquant sur <img src="../images/submit.png" width="20px" height="20px" />. Une fois que votre rapport de d�penses a �t� soumis, vous pouvez y acc�der en s�lectionnant, dans � Statut �, l�option � En attente d�approbation �. Vous ne pouvez cependant pas le modifier. La seule fa�on pour un employ� de modifier un rapport de d�penses qui a �t� soumis est lorsque la personne charg�e de l�approuver le d�sapprouve. Ce rapport est alors retourn� � l�employ� pour qu�il puisse �tre modifi�.
									<tr valign="bottom" style="height:50px;"><td>Si vous avez des questions, n�h�sitez pas � <a href="contactus.aspx" style="color:#cd1e1e">nous contacter</a>, et l�un de nos repr�sentants communiquera avec vous.</td></tr>
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
                        <tr valign="middle" style="height:60px;"><td>En tant qu'approbateur, votre t�che est de v�rifier les rapports de d�penses qui vous sont soumis par une liste d�employ�s. Ces employ�s vous ont �t� assign�s par l�administrateur de ce logiciel au sein de votre organisation.</td></tr>
                        <tr><td style="color:#cd1e1e; font-weight:bold;">Rapports soumis</td></tr>
                        
                        <tr><td>
                            <div style="position:relative;left:20px;">
                                <table>
                                    <tr><td style="color:#cd1e1e;">V�rifier un rapport</td></tr>
                                    <tr><td>Pour passer en revue un rapport de d�penses, allez � l�onglet � D�penses soumises � et cliquez sur <img src="../images/viewreport.png" width="20px" height="20px" /> sous � Rapports �. S�afficheront alors, pour chaque rapport de d�penses, une liste de tous les types de d�penses, le total des d�penses, de m�me que, le cas �ch�ant, les CTI, les RTI et les RCTI. Pour visualiser les re�us qui ont �t� joints aux d�penses, cliquez sur <img src="../images/attachment2.png" width="20px" height="20px" />.</td></tr>
                                    <tr><td style="color:#cd1e1e;">Modifier un rapport</td></tr>
                                    <tr><td>Il existe deux fa�ons d�apporter des changements � un rapport de d�penses qui a �t� soumis par un employ�. La premi�re consiste � renvoyer le rapport � l�employ� en cliquant sur <img src="../images/reject.png" width="15px" height="15px" />. Le rapport de d�penses r�appara�tra dans l�onglet � Mes d�penses � de l�employ�, et celui-ci pourra le modifier. La deuxi�me fa�on consiste � cliquer sur <img src="../images/edit.png" width="20px" height="20px" /> et � apporter les corrections vous-m�mes.  
                                    </td></tr>
                                    <tr><td style="color:#cd1e1e;">Visualiser un rapport</td></tr>
                                    <tr><td>Pour visualiser les rapports de d�penses, utilisez les fonctionnalit�s � Employ� � et � Statut �. La premi�re permet de visualiser les rapports de d�penses de tous les employ�s qui vous ont �t� assign�s ou d�un employ� en particulier. La deuxi�me de visualiser les rapports de d�penses en fonction de leur statut, soit � En attente d�approbation � ou � Finalis�s �.
                                    </td></tr>

                                    <tr><td style="color:#cd1e1e;">Approuver un rapport</td></tr>
                                    <tr><td>Une fois que la v�rification d�un rapport de d�penses a �t� compl�t�e, vous pouvez proc�der � son approbation. Pour ce faire, cliquez simplement sur <img src="../images/finalize.png" width="15px" height="15px" />.</td></tr>
                                    <tr><td style="color:#cd1e1e;">Rapports finalis�s � des fins comptables</td></tr>
                                    <tr><td>Seuls les rapports finalis�s seront comptabilis�s dans la p�riode au cours de laquelle les rapports ont �t� finalis�s. Ces rapports ne peuvent �tre ni modifi�s ni supprim�s. </td></tr>

                                    <tr valign="bottom" style="height:50px;"><td>Si vous avez des questions, n�h�sitez pas � <a href="contactus.aspx" style="color:#cd1e1e">nous contacter</a> et l�un de nos repr�sentants communiquera avec vous.</td></tr>
                                    
                                </table>
                            </div>
                        </td></tr>
                    </table>
                </div>
            </div>

            <div id="tab-admin">
                <div style="position:relative;top:20px;left:20px; overflow:auto; height:870px; width:98%;">
                    <table width="96%">
                        <tr style="height:40px;"><td valign="top" style="color:#cd1e1e; font-size:1.5em;">Guide de l�administrateur</td></tr>
                        <tr style="height:0.1px; background-color:#cd1e1e;"><td></td></tr>
                        <tr><td style="height:10px;"></td></tr>
                        <tr valign="middle" style="height:60px;"><td>Ce guide pr�sente les fonctionnalit�s li�es aux param�tres d�installation et de gestion que vous trouverez sous l�onglet � Administrateur �.</td></tr>
                        <tr><td style="color:#cd1e1e; font-weight:bold;">Consid�rations initiales</td></tr>
                        <tr><td>Lorsque vous vous inscrivez � Advataxes, vous devez d�terminer si votre organisation est :
                                    <br />�	une institution financi�re aux fins de la TPS/TVH et de la TVQ
                                    <br />�	une organisation autre qu�un organisme sans but lucratif
                        </td></tr>
                        
                        <tr><td>La version actuelle du logiciel n�est pas con�ue pour les organismes sans but lucratif. Si c�est le cas de votre organisation, ce logiciel ne s�adresse pas � votre situation. De plus, votre organisation ne devrait pas utiliser ce logiciel si votre organisation utilise la m�thode rapide de TPS/TVQ, m�thode par laquelle les inscrits versent un montant inf�rieur de taxes per�ues plut�t que de d�terminer les taxes pay�es sur leurs achats pour compenser les taxes per�ues.   
                        </td></tr>
                        
                        <tr><td style="color:#cd1e1e; font-weight:bold;">Param�tres globaux</td></tr>
                        
                        <tr><td>Pour remplir les champs suivants, cliquez sur � Param�tres globaux � dans l�onglet � Administrateur �. Cliquez alors sur <img src="../images/edit.png" width="20px" height="20px"/>.</td></tr>

                        <tr><td>
                            <div style="position:relative;left:20px;">
                                <table>
                                    <tr><td style="color:#cd1e1e;">Premier mois de l�ann�e financi�re</td></tr>
                                    <tr><td>S�lectionnez le premier mois de l�ann�e financi�re de votre organisation. Si les p�riodes comptables ne concordent pas avec les mois du calendrier, veuillez nous contacter (en haut � droite de la page) pour que nous puissions proc�der manuellement.</td></tr>
                                    <tr><td style="color:#cd1e1e;">Nombre de p�riodes de l�ann�e financi�re</td></tr>
                                    <tr><td>S�lectionnez le nombre de p�riodes de votre ann�e financi�re. � 12 � correspond � 12 p�riodes, et ainsi de suite. </td></tr>
                                    <tr><td style="color:#cd1e1e;">Num�ro des comptes payables</td></tr>
                                    <tr><td>Ins�rez le num�ro du compte payable du grand livre pour le remboursement des d�penses.</td></tr>
                                    <tr><td style="color:#cd1e1e;">Num�ro de compte CTI</td></tr>
                                    <tr><td>Pour les inscrits en TPS, ins�rez le num�ro de compte du grand livre o� les cr�dits de taxe sur les intrants (CTI) sont comptabilis�s sous le r�gime de la TPS. <b>Quelques r�f�rences:</b> Pour plus d'informations, voir <a href="#" onclick="javascript:window.open('http://www.cra-arc.gc.ca/F/pub/gm/8-1/LISEZ-MOI.html');" style="color:#cd1e1e;"><u>M�morandum sur la TPS/TVH 8.1 R�gles g�n�rales d�admissibilit�</u></a>.</td></tr>
                                    <tr><td style="color:#cd1e1e;">Num�ro de compte RTI</td></tr>
                                    <tr><td>Pour les inscrits en TVQ, ins�rez le num�ro de compte du grand livre o� les remboursements de taxes sur les intrants (RTI) sont comptabilis�s sous le r�gime de la TVQ.</td></tr>
                                    <tr><td style="color:#cd1e1e;">Num�ro de compte RCTI-ON</td></tr>        
                                    <tr><td>Pour les grandes entreprises sous le r�gime de la TPS, ins�rez le num�ro de compte du grand livre o� la r�cup�ration des cr�dits de taxe sur les intrants (RCTI) en Ontario est comptabilis�e. Si les RCTI sont comptabilis�s dans le num�ro de compte de CTI, ins�rez � nouveau le num�ro de compte de CTI. <b>Quelques r�f�rences:</b> Pour plus d'informations, voir <a href="#" onclick="javascript:window.open('http://www.cra-arc.gc.ca/F/pub/gm/b-104/LISEZ-MOI.html');" style="color:#cd1e1e;"><u>Bulletin d�information technique B-104 Taxe de vente harmonis�e � R�cup�ration temporaire des cr�dits de taxe sur les intrants en Ontario et en Colombie-Britannique.</u></a></td></tr>
                                    <tr><td style="color:#cd1e1e;">Num�ro de compte RCTI-CB</td></tr>
                                    <tr><td>Pour les grandes entreprises sous le r�gime de la TPS, ins�rez le num�ro de compte du grand livre o� la r�cup�ration des cr�dits de taxe sur les intrants (RCTI) en Colombie-Britannique est comptabilis�e. Si les RCTI sont comptabilis�s dans le num�ro de compte de CTI, ins�rez � nouveau le num�ro de compte de CTI. <b>Quelques r�f�rences:</b> Pour plus d'informations, voir <a href="#" onclick="javascript:window.open('http://www.cra-arc.gc.ca/F/pub/gm/b-104/LISEZ-MOI.html');" style="color:#cd1e1e;"><u>Bulletin d�information technique B-104 Taxe de vente harmonis�e � R�cup�ration temporaire des cr�dits de taxe sur les intrants en Ontario et en Colombie-Britannique.</u></a></td></tr>
									<tr><td style="color:#cd1e1e;">Num�ro de compte RCTI-IPE</td></tr>
                                    <tr><td>Pour les grandes entreprises sous le r�gime de la TPS, ins�rez le num�ro de compte du grand livre o� la r�cup�ration des cr�dits de taxe sur les intrants (RCTI) � l��le-du-Prince-�douard est comptabilis�e. Si les RCTI sont comptabilis�s dans le num�ro de compte de CTI, ins�rez � nouveau le num�ro de compte de CTI. <b>Quelques r�f�rences:</b> Pour plus d'informations, voir <a href="#" onclick="javascript:window.open('http://www.gov.pe.ca/photos/original/hst_recap_itc.pdf');" style="color:#cd1e1e;"><u>Revenue Tax Guide 186: Temporary Recapture of certain Provincial Input Tax Credits.</u></a></td></tr>
									<tr><td style="color:#cd1e1e;">P�riode de r�tention</td></tr>
                                    <tr><td>S�lectionnez le nombre d�ann�es (entre 1 et 6) que vous souhaitez qu�Ad Valorem Inc. conserve votre information financi�re (sujet � un abonnement valide � Advataxes). <b>Quelques r�f�rences:</b> <a href="#" onclick="javascript:window.open('http://www.cra-arc.gc.ca/F/pub/tg/rc4409/LISEZ-MOI.html');" style="color:#cd1e1e;"><u>RC4409 Conservation de registres</u></a>.</td></tr>
									<tr><td style="color:#cd1e1e;">Compensation sur le taux interbancaire</td></tr>
                                    <tr><td>Choisissez le pourcentage (entre 0 % et 5 %) que vous souhaitez majorer le taux de conversion des devises �trang�res sur le taux interbancaire officiel. En guise d�exemple, le taux habituel des cartes de cr�dits est de + 2 %. De fa�on g�n�rale, le logiciel convertit les devises �trang�res en dollars canadiens g�n�ralement � la date de transaction.</td></tr>
                                
                                </table>                                                    
                            </div>
                        </td	></tr>

                        <tr><td style="color:#cd1e1e; font-weight:bold;">Organisations</td></tr>
                        
                        <tr><td>Pour modifier le profil de votre organisation, allez � l�onglet � Organisations � et cliquez sur  <img src="../images/edit.png" width="20px" height="20px" />. </td></tr>

                        <tr><td>
                            <div style="position:relative;left:20px;">
                                <table>

                                    <tr><td style="color:#cd1e1e;">Nom</td></tr>
                                    <tr><td>Ins�rez le nom de l�organisation � laquelle les employ�s qui soumettent des rapports de d�penses appartiennent. </td></tr>
                                    <tr><td style="color:#cd1e1e;">Type</td></tr>
                                    <tr><td>S�lectionnez � organisme sans but lucratif � si votre organisation est un organisme sans but lucratif tel que d�fini � l�article 123 de la <i>Loi sur la taxe d�accise</i> et, le cas �ch�ant, � l�article 1 de la <i>Loi sur la taxe de vente du Qu�bec</i>. S�lectionnez � institution financi�re � si votre organisation est une institution financi�re telle que d�finie � la section 123 de la <i>Loi sur la taxe d�accise</i> et, le cas �ch�ant, � l'article 1 de la <i>Loi sur la taxe de vente du Qu�bec</i>. S�lectionnez � autre organisation � si votre organisation n�est pas couverte par les deux premiers types d�organisation. </td></tr>
									<tr><td style="color:#cd1e1e;">Code de l'organisation</td></tr>
                                    <tr><td>Ins�rez le cas �ch�ant le code de votre organisation � des fins comptables.</td></tr>
                                    <tr><td style="color:#cd1e1e;">Juridiction</td></tr>        
                                    <tr><td>Ins�rez la juridiction dans laquelle les employ�s de votre organisation qui soumettent des rapports de d�penses encourront le plus probablement ces d�penses. Cette juridiction appara�tra par d�faut dans l'onglet � Mes d�penses �. </td></tr>
                                    <tr><td style="color:#cd1e1e;">Inscrit en TPS</td></tr>
                                    <tr><td>S�lectionnez � oui � si votre organisation est inscrite en TPS tel que d�fini par l�article 123 de la <i>Loi sur la taxe d�accise</i>. De fa�on g�n�rale, un inscrit en TPS est une personne qui est inscrite ou qui est tenue de l��tre. Si le statut de votre organisation vient � changer, contactez-nous et nous effectuerons le changement.</td></tr>
                                    <tr><td style="color:#cd1e1e;">Inscrit en TVQ</td></tr>
                                    <tr><td>S�lectionnez � oui � si votre organisation est inscrite en TVQ tel que d�fini par l�article 1 de la <i>Loi sur la taxe de vente du Qu�bec</i>. De fa�on g�n�rale, un inscrit en TVQ est une personne qui est inscrite ou qui est tenue de l��tre. Si le statut de votre organisation vient � changer, contactez-nous et nous effectuerons le changement.</td></tr>
                                    <tr><td style="color:#cd1e1e;">Grande entreprise aux fins de la TPS/TVH</td></tr>
                                    <tr><td>D�terminez si votre organisation est une grande entreprise aux fins de la TPS ou une petite ou moyenne entreprise aux fins de la TPS (c�est-�-dire pas une grande entreprise). De fa�on g�n�rale, une grande entreprise aux fins de la TPS est une entreprise au cours d�une p�riode de r�cup�ration donn�e dont le total des ventes taxables et de celles de ses personnes associ�es exc�de 10 millions de dollars. Si ce statut vient � changer, contactez-nous et nous effectuerons le changement. <b>Quelques r�f�rences:</b> <a href="#" onclick="javascript:window.open('http://www.cra-arc.gc.ca/F/pub/gm/b-104/LISEZ-MOI.html');" style="color:#cd1e1e;"><u>Bulletin d�information technique B-104 Taxe de vente harmonis�e � R�cup�ration temporaire des cr�dits de taxe sur les intrants en Ontario et en Colombie-Britannique</u></a></td></tr>
                                    <tr><td style="color:#cd1e1e;">Grande entreprise aux fins de la TVQ</td></tr>
                                    <tr><td>D�terminez si votre organisation est une grande entreprise aux fins de la TVQ ou une petite ou moyenne entreprise aux fins de la TVQ (c�est-�-dire non une grande entreprise). De fa�on g�n�rale, une grande entreprise aux fins de la TVQ est une entreprise au cours d�un exercice donn� dont le total des ventes taxables et de celles de ses personnes associ�es exc�de 10 millions de dollars. Si votre statut d�entreprise vient � changer, contactez-nous et nous effectuerons le changement. <b>Quelques r�f�rences:</b> <a href="#" onclick="javascript:window.open('http://www2.publicationsduquebec.gouv.qc.ca/dynamicSearch/telecharge.php?type=16&file=T0_1F206_1T9BULB.pdf');" style="color:#cd1e1e;"><u>Interpr�tation Revenu Qu�bec TVQ.206.1-9 Qualification de petite ou moyenne entreprise ou de grande entreprise</u></a>.</td></tr>
                                    <tr><td style="color:#cd1e1e;">Ratio d�activit�s commerciales aux fins de la TPS</td></tr>
                                    <tr><td>S�lectionnez le ratio d�activit�s commerciales qui s�applique aux d�penses des employ�s de votre organisation aux fins de la TPS. Le ratio s�lectionn� peut prendre n�importe quelle valeur entre 0 % et 100 %. Si votre ratio vient � changer, contactez-nous et nous effectuerons le changement. <b> Quelques r�f�rences:</b> <a href="#" onclick="javascript:window.open('http://www.cra-arc.gc.ca/F/pub/gm/8-3/LISEZ-MOI.html');" style="color:#cd1e1e;"><u>M�morandum sur la TPS/TVH 8.3 Calcul des cr�dits de taxe sur les intrants.</u></a> <i><b>Pour les institutions financi�res seulement :</i></b> <a href="#" onclick="javascript:window.open('http://www.cra-arc.gc.ca/F/pub/gm/b-106/LISEZ-MOI.html');" style="color:#cd1e1e;"><u>Bulletin d�information technique sur la TPS/TVH B-106 M�thodes d�attribution des cr�dits de taxe sur les intrants pour les institutions financi�res en application de l�article 141.02 de la Loi sur la taxe d�accise.</u></a></td></tr>
                                    <tr><td style="color:#cd1e1e;">Ratio d�activit�s commerciales aux fins de la TVQ</td></tr>
                                    <tr><td>S�lectionnez le ratio d�activit�s commerciales qui s�applique aux d�penses des employ�s de votre organisation aux fins de la TVQ. Le ratio s�lectionn� peut prendre n�importe quelle valeur entre 0 et 100 %. Si votre ratio vient � changer, contactez-nous et nous effectuerons le changement.</td></tr>
                                    <tr><td style="color:#cd1e1e;">Ajouter des organisations</td></tr> 
									<tr><td>Si vous avez plusieurs organisation partageant les m�mes param�tres globaux, cliquez sur � Ajouter � pour configurer d�autres organisations.</td></tr>
                                </table>                                                    
                            </div>
                        </td></tr>

                        <tr><td style="color:#cd1e1e; font-weight:bold;">Cat�gories</td></tr>
                        
                        <tr><td>Choisissez parmi une liste de plus de 30 cat�gories de d�penses celles qui s�appliquent � votre organisation, en cliquant sur <img src="../images/download.png" width="20px" height="20px" />, � c�t� de chacune. Vous pouvez s�lectionner la m�me cat�gorie plusieurs fois si vous devez couvrir diff�rents comptes du GL. Vos employ�s pourront seulement choisir les cat�gories que vous aurez s�lectionn� au pr�alable et qui formeront la liste des � Cat�gories s�lectionn�es �.
                        </td></tr>

                        <tr><td>
                            <div style="position:relative;left:20px;">
                                <table>

                                    <tr><td style="color:#cd1e1e;">S�lectionner <img src="../images/download.png" width="20px" height="20px" /></td></tr>
                                    <tr><td>S�lectionnez les types de d�penses encourus par vos employ�s dans � Cat�gories disponibles �. Si vous choisissez par exemple � Allocation kilom�trage �, cliquez sur <img src="../images/download.png" width="20px" height="20px" /> pour s�lectionner cette cat�gorie. Vous pouvez ins�rez dans le champ appropri� le num�ro de compte de GL de votre organisation pour une meilleure int�gration comptable.  
                                             Il y a essentiellement trois types de cat�gories de d�penses.  </td></tr>
											 <tr><td>
											 Le premier type couvre des r�gles fiscales sp�cifiques. Les cat�gories � Allocation kilom�trage �, � Allocation repas (conducteurs de grands routiers) � et � Usage personnel de l�employ� � sont par exemple r�gies par des dispositions fiscales sp�cifiques (cliquez sur <img src="../images/question.png" width="15px" height="15px" /> pour plus de d�tails sur chacune). Pour les grandes entreprises, des cat�gories telles que � Carburant auto � et � Cellulaire (tarifs mensuels) � sont �galement r�gies par des r�gles fiscales sp�cifiques.</td></tr>
											 <tr><td>
											 <br>Le deuxi�me type de cat�gories correspond � des types de d�penses courants tels que � H�tel �, � Stationnement � et � Fournitures de bureau �. Si la politique de votre organisation consiste � rembourser seulement les allocations pour le kilom�trage et aucun autre type de d�penses reli�s aux v�hicules, assurez-vous de bien s�lectionner � Allocation kilom�trage � et non � Location auto (long terme) �, � Carburant auto � ou encore � Entretien camions & autos �.</td></tr>
											 <tr><td>
											 Finalement, le troisi�me type de cat�gories de d�penses s�applique � des situations diverses qui ne sont pas r�gies par des r�gles fiscales sp�cifiques. Ces cat�gories sont � Taux � s�lectionner �, � Autres d�penses (sans taxes) � et � Autres d�penses (avec taxes) �. La cat�gorie � Taux � s�lectionner � couvre par exemple les situations o� l�utilisateur doit s�lectionner lui-m�me les taux de taxe, en particulier les <b>services de transport</b> autres que le transport en commun tels que le <b>transport par avion</b> et le transport par train ou autobus sur des longues distances.
                                            Pour comprendre la logique fiscale impl�ment�e par le logiciel relativement � chacune des cat�gories, cliquez sur <img src="../images/question.png" width="15px" height="15px" />. 
											Si vous devez apparier la logique fiscale d�une certaine cat�gorie avec plusieurs comptes, vous devez s�lectionner la m�me cat�gorie plusieurs fois et proc�der � son int�gration avec la nomenclature comptable de votre organisation.  										                                 
                                             Si vous avez par exemple plusieurs employ�s qui ach�tent des �chantillons et qu�il est important pour des raisons comptables de pouvoir suivre � la trace les diff�rents �chantillons achet�s, vous pouvez s�lectionner la cat�gorie � Autres d�penses (taxables) � plusieurs fois et la personnaliser en ajoutant des noms et des num�ros de compte GL sp�cifiques :<br />
                                            <br />� Autres d�penses (taxables) � Chandails 600240<br />
                                            � Autres d�penses (taxables) � Pantalons 600250<br />
                                            � Autres d�penses (taxables) � Chapeaux 600260<br /><br />
											Vous pouvez par exemple comptabiliser la cat�gorie � Repas et divertissement � dans plusieurs comptes GL diff�rents (par exemple � production �, � formation � et � projets sp�ciaux �) :<br />
											<br />� Repas et divertissement � production 50025<br />
											� Repas et divertissement � formation 50040<br />
											� Repas et divertissement � projets sp�ciaux 50090<br /><br />
  
                                            Pour retirer une cat�gorie s�lectionn�e de la liste des cat�gories accessibles � vos employ�s, d�sactivez-la en cliquant sur <img src="../images/checked.png" width="20px" height="20px" />.
                                    </td></tr>
                               </table>                                                    
                            </div>
                        
                        </td></tr>
	
                        <tr><td style="color:#cd1e1e; font-weight:bold;">Employees</td></tr>
                        
                        <tr><td>Pour les fins de la TPS et de la TVQ, il est essentiel que les CTI, les RTI et les remboursements sur les d�penses de vos employ�s soient r�clam�s au sein de la m�me organisation dont ils font partie. Lorsque vous ajoutez des employ�s � une organisation, il convient donc de s�assurer qu�ils sont bien des employ�s de cette organisation. Le terme � employ� �, qui inclut les officiers, r�f�re � la d�finition d�un employ� � l�article 123 de la <i>Loi sur la taxe d�accise</i> et � l�article 1 de la <i>Loi sur la taxe de vente du Qu�bec</i>. Le terme peut inclure les associ�s et les b�n�voles sous les conditions dans les articles 174 et 175 de la <i>Loi sur la taxe d�accise</i> et les articles 211 et 212 de la <i>Loi sur la taxe de vente du Qu�bec</i>. <b>Quelques r�f�rences:</b> Voir le <a href="#" onclick="javascript:window.open('http://www.cra-arc.gc.ca/F/pub/gm/9-4/LISEZ-MOI.html');" style="color:#cd1e1e;"><u>M�morandum sur la TPS/TVH 9.4 Remboursements. </u></a>, et le <a href="#" onclick="javascript:window.open('http://www.cra-arc.gc.ca/F/pub/gm/9-3/LISEZ-MOI.html');" style="color:#cd1e1e;"><u>M�morandum sur la TPS/TVH 9.3 Indemnit�s</u></a>. 
                                Cliquez sur <img src="../images/new.png" width="20px" height="20px" /> pour ajouter un employ�.
                        </td></tr>

                        <tr><td>
                            <div style="position:relative;left:20px;">
                                <table>

                                    <tr><td style="color:#cd1e1e;">Nom</td></tr>
                                    <tr><td>Nom de famille de l�employ�.</td></tr>
                                    
                                    <tr><td style="color:#cd1e1e;">Pr�nom</td></tr>
                                    <tr><td>Pr�nom de l�employ�.</td></tr>
                                    
                                    <tr><td style="color:#cd1e1e;">Num�ro de l'employ�</td></tr>        
                                    <tr><td>Num�ro de l�employ� (optionnel).</td></tr>
                                    
                                    <tr><td style="color:#cd1e1e;">Code de d�partement</td></tr>
                                    <tr><td>Code de d�partement de l�employ� (optionnel).</td></tr>
                                    
                                    <tr><td style="color:#cd1e1e;">Approbateur</td></tr>
                                    <tr><td>La personne qui finalise ou rejette les rapports de d�penses de cet employ�.</td></tr>
									
									<tr><td style="color:#cd1e1e;">D�l�gu�</td></tr>
									<tr><td>L�administrateur peut d�l�guer � un employ� la t�che de remplir les rapports de d�penses d�autres employ�s. Les utilisateurs qui sont d�l�gu�s peuvent cr�er des rapports, ajouter des d�penses et soumettre des rapports � la place de leurs coll�gues. Les d�l�gu�s doivent seulement cliquer sur le menu d�roulant dans l�onglet � Mes d�penses � et s�assurer de s�lectionner le bon employ�.</td></tr>
                                    
                                    <tr><td style="color:#cd1e1e;">Courriel</td></tr>
                                    <tr><td>Courriel de l'employ�.</td></tr>
                                    
                                    <tr><td style="color:#cd1e1e;">Nom d'utilisateur</td></tr>
                                    <tr><td>Nom d�utilisateur pour se connecter � Advataxes.</td></tr>
                                    
                                    <tr><td style="color:#cd1e1e;">Statut d'administrateur</td></tr>
                                    <tr><td>Seul l�administrateur a acc�s � l�information disponible dans l�onglet � Administrateur �. Celui-ci peut apporter certaines modifications au profil des employ�s. </td></tr>
									<tr><td style="color:#cd1e1e;">Statut de l'approbateur</td></tr>
                                    <tr><td>L'approbateur est charg� de v�rifier les rapports de d�penses des employ�s qui lui ont �t� assign�s. Lorsqu�un rapport de d�penses est soumis par l�un de ses employ�s, un courriel lui est envoy�. Pour les employ�s qui ne travaillent plus pour l�organisation, cliquez sur <img src="../images/checked.png" width="20px" height="20px" /> sous � Actif � pour d�sactiver leur compte. Ils n'auront plus acc�s � Advataxes. </td></tr>									
                                    
                                    <tr><td style="color:#cd1e1e;">Notification par courriel</td></tr>
                                    <tr><td>Si cette option est s�lectionn�e, l�employ� sera notifi� par courriel toutes les fois qu�un rapport de d�penses est finalis�, et ceci pour tous les employ�s de son organisation. Le courriel inclura le montant qui est d� � l�employ�. Habituellement, la personne qui est en charge de rembourser les employ�s est la personne qui recevra ce courriel. </td></tr>
                                
                                </table>                
                            </div>
                        </td></tr>

                        <tr><td style="color:#cd1e1e; font-weight:bold;">Rapports</td></tr>
                        
                        <tr><td>La section � Rapports � fournit une liste de rapports aux fins de la TPS/TVH et TVQ, de comptabilit� et de gestion.  </td></tr>

                        <tr><td>
                            <div style="position:relative;left:20px;">
                                <table>

                                    <tr><td style="color:#cd1e1e;">�ventail des rapports</td></tr>
                                    <tr><td>Cette option vous permet d�obtenir des rapports par p�riode, par type de d�pense ou par intervalle de temps.</td></tr>
                                    <tr><td style="color:#cd1e1e;">Ann�e financi�re</td></tr>
                                    <tr><td>Cette option vous permet de choisir l�ann�e financi�re et la p�riode comptable. Choisissez une p�riode financi�re termin�e pour obtenir le sommaire et les d�tails comptables. Le logiciel ferme automatiquement toutes les p�riodes comptables. Si les mois du calendrier concordent avec p�riodes financi�res de votre organisation, les donn�es comptables telles que les CTI et les RTI et les montants de d�penses seront disponibles le 1er de chaque mois.</td></tr>
                                    <tr><td style="color:#cd1e1e;">Type de rapport</td></tr>        
                                    <tr><td>Plusieurs types de rapport sont disponibles. Vous pouvez fournir un sommaire des rapports de d�penses qui totalise tous les montants comptabilis�s par cat�gorie de d�penses, par TPS/TVH et TVQ � r�clamer et de la r�cup�ration des CTI. Le sommaire par cat�gorie est utile pour proc�der � des ajustements fiscaux sur certaines cat�gories. L�Agence du revenu du Canada permet par exemple de r�clamer des CTI sur des d�penses pour usage personnel allant jusqu�� 500 $. Comme le logiciel ne calcule pas les taxes sur ces d�penses, il est du moins possible de proc�der � un ajustement de fin d�ann�e. Un ajustement similaire peut �tre fait avec les allocations pour le d�m�nagement sur lesquelles il est possible de r�clamer la TPS sur les premiers 650 $. </td></tr>
                                </table>                
                            </div>
                        
                        </td></tr>

                        <tr><td style="color:#cd1e1e; font-weight:bold;">Tableau de bord</td></tr>
                        
                        <tr><td>Vous trouverez dans l�onglet � Tableau de bord � une liste d�employ�s et la date � laquelle ceux-ci se sont connect�s pour la derni�re fois � Advataxes. Lorsque vous ajouter un nouvel employ�, la date de cr�ation correspond � la date de la premi�re connexion. <br /><br /><br /></td></tr>
                        <tr><td>Si vous avez des questions, n'h�sitez pas � <a href="contactus.aspx" style="color:#cd1e1e">nous contacter</a> et l'un de nos repr�sentants communiquera avec vous.</td></tr>

                    </table>
                </div>
                
            </div>
			
			<div id="tab-taxDoc">
				<div style="position:relative;top:20px;left:20px; overflow:auto; height:870px; width:98%;">
				
					<table width="96%">
						<tr style="height:40px;"><td valign="top" style="color:#cd1e1e; font-size:1.5em;">Documentation fiscale</td></tr>
						<tr style="height:0.1px; background-color:#cd1e1e;"><td></td></tr>
						<tr><td style="height:10px;"></td></tr>

						<tr style="background-color:#cd1e1e;color:white;"><td><b>Gouvernement f�d�ral</b></td></tr>
						<tr style="height:10px;"><td></td></tr>
						
						<tr><td><a href="#" onclick="javascript:window.open('http://laws-lois.justice.gc.ca/fra/lois/E-15/page-1.html');" style="color:#cd1e1e;"><u>Loi sur la taxe d�accise</u></a></td></tr>
						
						<tr><td><a href="#" onclick="javascript:window.open('http://www.canlii.org/fr/ca/legis/lois/lrc-1985-c-1-5e-suppl/derniere/lrc-1985-c-1-5e-suppl.html');" style="color:#cd1e1e;"><u>Loi de l�imp�t sur le revenu</u></a></td></tr> 
						
						<tr><td><a href="#" onclick="javascript:window.open('http://www.cra-arc.gc.ca/F/pub/gm/4-3/LISEZ-MOI.html');" style="color:#cd1e1e;"><u>Nouvelle s�rie de m�morandum sur la TPS/TVH 4.3 Produits alimentaires de base</u></a></td></tr>
						
						<tr><td><a href="#" onclick="javascript:window.open('http://www.cra-arc.gc.ca/F/pub/gm/8-1/LISEZ-MOI.html');" style="color:#cd1e1e;"><u>M�morandum sur la TPS/TVH 8.1 R�gles g�n�rales d�admissibilit�</u></a></td></tr>
						
						<tr><td><a href="#" onclick="javascript:window.open('http://www.cra-arc.gc.ca/F/pub/gm/8-2/LISEZ-MOI.html');" style="color:#cd1e1e;"><u>M�morandum sur la TPS/TVH 8.2 Restrictions g�n�rales</u></a></td></tr> 
						
						<tr><td><a href="#" onclick="javascript:window.open('http://www.cra-arc.gc.ca/F/pub/gm/8-3/LISEZ-MOI.html');" style="color:#cd1e1e;"><u>M�morandum sur la TPS/TVH 8.3 Calcul des cr�dits de taxe sur les intrants</u></a></td></tr>

						<tr><td><a href="#" onclick="javascript:window.open('http://www.cra-arc.gc.ca/F/pub/gm/8-4/LISEZ-MOI.html');" style="color:#cd1e1e;"><u>M�morandum sur la TPS/TVH 8.4 Documents requis pour demander des cr�dits de taxe sur les intrants</u></a></td></tr>
						
						<tr><td><a href="#" onclick="javascript:window.open('http://www.cra-arc.gc.ca/F/pub/gm/9-3/LISEZ-MOI.html');" style="color:#cd1e1e;"><u>M�morandum sur la TPS/TVH 9.3 Indemnit�s</u></a></td></tr> 
						
						<tr><td><a href="#" onclick="javascript:window.open('http://www.cra-arc.gc.ca/F/pub/gm/9-4/LISEZ-MOI.html');" style="color:#cd1e1e;"><u>M�morandum sur la TPS/TVH 9.4 Remboursements</u></a></td></tr> 
						
						<tr><td><a href="#" onclick="javascript:window.open('http://www.cra-arc.gc.ca/F/pub/gi/gi-061/LISEZ-MOI.html');" style="color:#cd1e1e;"><u>Info TPS/TVH GI-061 Taxe de vente harmonis�e de la Colombie-Britannique � Remboursement au point de vente pour les carburants</u></a></td></tr>
						
						<tr><td><a href="#" onclick="javascript:window.open('http://www.cra-arc.gc.ca/F/pub/gi/gi-065/LISEZ-MOI.html');" style="color:#cd1e1e;"><u>Info TPS/TVH GI-065 Taxe de vente harmonis�e de l�Ontario et de la Colombie-Britannique � Remboursement au point de vente pour les livres</u></a></td></tr>

						<tr><td><a href="#" onclick="javascript:window.open('http://www.cra-arc.gc.ca/F/pub/gp/rc4036/LISEZ-MOI.html');" style="color:#cd1e1e;"><u>RC4036 Renseignements sur la TPS/TVH pour l�industrie du tourisme et des congr�s</u></a></td></tr>

						<tr><td><a href="#" onclick="javascript:window.open('http://www.cra-arc.gc.ca/F/pub/tg/rc4409/LISEZ-MOI.html');" style="color:#cd1e1e;"><u>RC4409 Conservation de registres</u></a></td></tr>

						<tr><td><a href="#" onclick="javascript:window.open('http://www.cra-arc.gc.ca/F/pub/gm/b-104/LISEZ-MOI.html');" style="color:#cd1e1e;"><u>Bulletin d�information technique B-104 Taxe de vente harmonis�e � R�cup�ration temporaire des cr�dits de taxe sur les intrants en Ontario et en Colombie-Britannique</u></a></td></tr> 

						<tr><td><a href="#" onclick="javascript:window.open('http://www.cra-arc.gc.ca/F/pub/gm/b-106/LISEZ-MOI.html');" style="color:#cd1e1e;"><u>Bulletin d�information technique B-106 M�thodes d�attribution des cr�dits de taxe sur les intrants pour les institutions financi�res en application de l�article 141.02 de la Loi sur la taxe d�accise</i></u></a></td></tr> 	
						
						<tr><td><a href="#" onclick="javascript:window.open('http://www.cra-arc.gc.ca/F/pbg/tf/t2200/');" style="color:#cd1e1e;"><u>T2200 D�claration des conditions de travail</u></a></td></tr> 
						
						<tr><td><a href="#" onclick="javascript:window.open('http://www.cra-arc.gc.ca/F/pub/tg/t4130/LISEZ-MOI.html');" style="color:#cd1e1e;"><u>T4130 Guide de l�employeur � Avantages et allocations imposables</u></a></td></tr>
						
						<tr><td><a href="#" onclick="javascript:window.open('http://www.cra-arc.gc.ca/F/pub/tp/it522r/LISEZ-MOI.html');" style="color:#cd1e1e;"><u>IT522R Frais aff�rents � un v�hicule � moteur, frais de d�placement et frais de vendeurs engag�s ou effectu�s par les employ�s</u></a></td></tr> 
						
						<tr><td><a href="#" onclick="javascript:window.open('http://www.cra-arc.gc.ca/F/pub/gr/news54/');" style="color:#cd1e1e;"><u>Nouvelles de la TPS/TVH No 54</u></a></td></tr> 
						
						<tr><td><a href="#" onclick="javascript:window.open('http://www.fin.gc.ca/n11/11-146-fra.asp');" style="color:#cd1e1e;"><u>Le gouvernement annonce les plafonds de d�duction des frais d�automobile et les taux des avantages relatifs � l�utilisation d�une automobile pour les entreprises en 2012</u></a></td></tr>  
						
						<tr style="height:20px;"><td></td></tr>
						
						<tr style="background-color:#cd1e1e;color:white;"><td><b>Gouvernement du Qu�bec</b></td></tr>
						<tr style="height:10px;"><td></td></tr>
						
						<tr><td><a href="#" onclick="javascript:window.open('http://www.canlii.org/fr/qc/legis/lois/lrq-c-t-0.1/derniere/lrq-c-t-0.1.html');" style="color:#cd1e1e;"><u>Loi sur la taxe de vente du Qu�bec</u></a></td></tr>
															
						<tr><td><a href="#" onclick="javascript:window.open('http://www2.publicationsduquebec.gouv.qc.ca/dynamicSearch/telecharge.php?type=16&file=T0_1F206_1T6BULB.pdf');" style="color:#cd1e1e;"><u>Interpr�tation Revenu Qu�bec TVQ.206.1-6 Restriction � l�obtention d�un remboursement de la taxe sur les intrants � l��gard des v�hicules routiers de moins de 3 000 kilogrammes</u></a></td></tr> 
						
						<tr><td><a href="#" onclick="javascript:window.open('http://www2.publicationsduquebec.gouv.qc.ca/dynamicSearch/telecharge.php?type=16&file=T0_1F206_1T8BULB.pdf');" style="color:#cd1e1e;"><u>Interpr�tation Revenu Qu�bec TVQ.206.1-8 RTI relativement � l�essence utilis�e par une grande entreprise</u></a></td></tr> 
						
						<tr><td><a href="#" onclick="javascript:window.open('http://www2.publicationsduquebec.gouv.qc.ca/dynamicSearch/telecharge.php?type=16&file=T0_1F206_1T9BULB.pdf');" style="color:#cd1e1e;"><u>Interpr�tation Revenu Qu�bec TVQ.206.1-9 Qualification de petite ou moyenne entreprise ou de grande entreprise</u></a></td></tr> 
						
						<tr><td><a href="#" onclick="javascript:window.open('http://www2.publicationsduquebec.gouv.qc.ca/dynamicSearch/telecharge.php?type=16&file=T0_1F211T3R3BULB.pdf');" style="color:#cd1e1e;"><u>Interpr�tation Revenu Qu�bec TVQ.211-3/R3 Remboursement de la taxe sur les intrants � l��gard d�une allocation de d�penses</u></a></td></tr>
						
						<tr><td><a href="#" onclick="javascript:window.open('http://www2.publicationsduquebec.gouv.qc.ca/dynamicSearch/telecharge.php?type=16&file=T0_1F212T2BULB.pdf');" style="color:#cd1e1e;"><u>Interpr�tation Revenu Qu�bec TVQ.212-2 Caract�ristiques d�un remboursement de d�penses</u></a></td></tr>
						
						<tr><td><a href="#" onclick="javascript:window.open('http://www2.publicationsduquebec.gouv.qc.ca/dynamicSearch/telecharge.php?type=16&file=T0_1F212T3BULB.pdf');" style="color:#cd1e1e;"><u>Interpr�tation Revenu Qu�bec TVQ.212-3 Cotisations professionnelles de salari�s</u></a></td></tr>
						
						<tr><td><a href="#" onclick="javascript:window.open('http://www2.publicationsduquebec.gouv.qc.ca/dynamicSearch/telecharge.php?type=16&file=T0_1F457_1T1BULB.pdf');" style="color:#cd1e1e;"><u>Interpr�tation Revenu Qu�bec TVQ.457.1-1 D�penses de divertissement</u></a></td></tr> 
						
						<tr><td><a href="#" onclick="javascript:window.open('http://www2.publicationsduquebec.gouv.qc.ca/dynamicSearch/telecharge.php?type=16&file=I3F37T2R2BULB.pdf');" style="color:#cd1e1e;"><u>Interpr�tation Revenu Qu�bec IMP-37-2/R2 Paiement ou remboursement par un employeur des montants exigibles d�un employ� membre d�une association professionnelle</u></a></td></tr> 
						
						<tr><td><a href="#" onclick="javascript:window.open('http://www.revenuquebec.ca/fr/citoyen/taxes/tpstvq/transport/hors_quebec/tvq.aspx');" style="color:#cd1e1e;"><u>Application de la TVQ en mati�re de transport de passagers hors du Qu�bec</u></a></td></tr> 
						
						<tr><td><a href="#" onclick="javascript:window.open('http://www.revenuquebec.ca/fr/entreprise/taxes/tvq_tps/perception/cas_particuliers/transport/hors_quebec/tps.aspx');" style="color:#cd1e1e;"><u>Application de la TPS  en mati�re de transport de passagers hors du Qu�bec</u></a></td></tr> 
												
						<tr style="height:20px;"><td></td></tr>
						<tr style="background-color:#cd1e1e;color:white;"><td><b>Gouvernement de l��le-du-Prince-�douard</b></td></tr>	
						<tr style="height:10px;"><td></td></tr>
						
						<tr><td><a href="#" onclick="javascript:window.open('http://www.gov.pe.ca/photos/original/hst_recap_itc.pdf');" style="color:#cd1e1e;"><u>Revenue Tax Guide 186 (PEI): Temporary Recapture of certain Provincial Input Tax Credits </u></a></td></tr>
						 						
					</table>
				</div>
			</div>
			
						
			<div id="tab-yearEnd">
				<div style="position:relative;top:20px;left:20px; overflow:auto; height:870px; width:98%;">
				
					<table width="96%">
						<tr style="height:40px;"><td valign="top" style="color:#cd1e1e; font-size:1.5em;">Fin d'ann�e</td></tr>
						<tr style="height:0.1px; background-color:#cd1e1e;"><td></td></tr>
						<tr><td style="height:10px;"></td></tr>
					
					<tr><td>Le logiciel est con�u pour qu�un administrateur puisse, le cas �ch�ant, extraire l�information pertinente et effectuer des ajustements de fin d�ann�e de TPS/TVH et de TVQ sur plusieurs cat�gories de d�penses.</td></tr> 
					<tr><td></td></tr>
					<tr><td style="color:#cd1e1e; font-weight:bold; font-size: 15px">Fonctionnalit� pour obtenir des rapports sp�cifiques aux fins de la TPS/TVH et de la TVQ</td></tr>
					<tr><td>Dans la section � Administrateur �, allez � l�onglet � Rapports �. Vous pouvez ensuite cliquer sur � Personnalisez � dans � �ventail des rapports �, et s�lectionner l�intervalle de temps d�sir� (par ex. le 1er janvier 2013 au 31 d�cembre 2013).</td></tr> 
					<tr><td>Dans � Type de rapport �, vous pouvez aussi s�lectionner � Sommaire par cat�gorie � et la cat�gorie d�sir�e dans le champ � Cat�gorie �. Vous pourrez ainsi voir les montants de d�penses comptabilis�s, les p�riodes comptabilis�es, les noms des employ�s et les re�us en rapport avec cette cat�gorie de d�penses s�ils ont �t� import�s par l�employ� durant cet intervalle de temps.</td></tr> 
					<tr><td></td></tr>
					<tr><td style="color:#cd1e1e; font-weight:bold; font-size:15px">G�rer la TPS/TVH et la TVQ, et davantage</td></tr>
					<tr><td>La grande vari�t� de rapports peut �tre utilis�e pour g�rer la TPS/TVH et la TVQ pour des ajustements de fin d�ann�e dans les situations suivantes :</td></tr>
					<tr><td></td></tr>
					<tr><td style="color:#cd1e1e; font-weight:bold;">D�penses sur des v�hicules</td></tr>
					<tr><td>Il existe plusieurs r�gles fiscales r�gissant l�usage de v�hicules par des employ�s tant � des fins d�affaires que personnelles, r�gles qui sont bas�es sur le nombre de kilom�tres parcourus. Les cons�quences fiscales peuvent avoir un impact sur les cat�gories de d�penses suivantes :</td></tr>
					<tr><td>
					<ul>
						<li>Entretien autos & camions</li>
						<li>Location auto (long terme)</li>
						<li>Carburant auto</li>
					</ul>	
					</td></tr>
					<tr><td>Voir <a href="#" onclick="javascript:window.open('http://www.cra-arc.gc.ca/F/pub/tg/t4130/LISEZ-MOI.html');" style="color:#cd1e1e;"><u>T4130 Guide de l�employeur � Avantages et allocations imposables</u></a> et <a href="#" onclick="javascript:window.open('http://www.cra-arc.gc.ca/F/pub/gm/8-2/LISEZ-MOI.html');" style="color:#cd1e1e;"><u>M�morandum sur la TPS/TVH 8.2 Restrictions g�n�rales</u></a> pour plus de d�tails.</td></tr>
					<tr><td>Tous les rapports d�taillant les d�penses peuvent �galement �tre produits par division (par ex. Marketing), ou par employ� pour tout intervalle de temps.</td></tr>
					<tr><td></td></tr>
					<tr><td style="color:#cd1e1e; font-weight:bold;">D�penses pour usage personnel</td></tr>
					<tr><td>Il existe une r�gle administrative permettant aux inscrits de r�clamer des intrants sur des d�penses pour usage personnel, et ce jusqu�� 500 $ de d�penses par ann�e. Bien que le logiciel n�automatise pas cette r�gle en proposant une cat�gorie distincte pour ce genre de d�penses, vous pouvez obtenir la liste des d�penses comptabilis�es dans ce logiciel et proc�der, le cas �ch�ant, � un recouvrement de taxes sur ces d�penses. Vous pouvez obtenir plus de d�tails sur cette r�gle dans le <a href="#" onclick="javascript:window.open('http://www.cra-arc.gc.ca/F/pub/gm/8-2/LISEZ-MOI.html');" style="color:#cd1e1e;"><u>M�morandum sur la TPS/TVH 8.2 Restrictions g�n�rales.</u></a>.</td></tr>
					<tr><td></td></tr>
					<tr><td style="color:#cd1e1e;font-weight:bold;">Allocation d�m�nagement</td></tr>
					<tr><td>La politique de l�ARC est � l�effet que les allocations pour le d�m�nagement rembours�es � un employ� jusqu�� concurrence de 650 $ peuvent donner lieu � un cr�dit de taxe sur les intrants.  Revenu Qu�bec  consid�re qu�une allocation pour le d�m�nagement �quivalant � deux semaines de salaire est acceptable aux fins de la TVQ. Pour plus d�informations, consultez le document <a href="#" onclick="javascript:window.open('http://www.cra-arc.gc.ca/F/pub/gr/news54/LISEZ-MOI.html');" style="color:#cd1e1e;"><u>Nouvelles TPS/TVH no 54</u></a>. Comme le logiciel n�automatise pas le calcul des taxes sur ces allocations, vous pouvez extraire les d�penses comptabilis�es et proc�der, le cas �ch�ant, aux ajustements de TPS/TVH et de TVQ.</td></tr>
					<tr><td style="color:#cd1e1e;font-weight:bold;">Allocation kilom�trage et RCTI en ON et en CB</td></tr>
					<tr><td>Pour les grandes entreprises qui ont de la r�cup�ration de cr�dits de taxe sur les intrants sur cette d�pense, sachez que Finances Canada est en discussion avec la Colombie-Britannique et l�Ontario sur la cr�ation d�un facteur administratif sur les allocations d�autos. Le document <a href="#"onclick="javascript:window.open('http://www.tei.org/news/Documents/TEI%20CCTC-CRA-Finance%20Liaison%20Agenda.pdf');" style="color:#cd1e1e;"><u>Tax Executives Institute, Inc. Excise Tax Questions submitted to Canada Revenue Agency and the Department of Finance December 4-5, 2012</u></a> note que ce facteur permettrait de recouvrir des taxes sur des aspects de l�allocation kilom�trage non classifi�s comme biens ou services d�termin�s tels que les r�parations et l�entretien. Des ajustements <u>p�riodiques</u> de RCTI peuvent �tre n�cessaires. Notez que nous attendons que les autorit�s fiscales fournissent des instructions d�taill�es sur cette question. </td></tr>
											
					</table>
				</div>
			</div>

          <asp:HiddenField ID="hdnAdmin" runat="server" />
          <asp:HiddenField ID="hdnApprover" runat="server" />

    </div>
</asp:Content>
