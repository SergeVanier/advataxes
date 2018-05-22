<%@ Page Title="" Language="vb" AutoEventWireup="false" CodeBehind="TaxCalculator.aspx.vb" Inherits="Advataxes.TaxCalculator" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="act" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Calculatrice des taxes sur les dépenses de voyages | Advataxes</title>
    <meta name="description" content="">
   
	<!-- #include file="/fr/inc/header-html.inc" -->
	<script src="/en/js/jquery-1.9.0-min.js"></script>

  <body>
  
 	<!-- #include file="/fr/inc/header-menu.inc" -->	
	
    <div class="clear"></div>

    <div class="container-wrapper container-top">
      <div class="container container-top">
        <div class="row">
          <div class="col-md-12 center">
            <h1>Calculatrice des taxes sur les dépenses de voyages</h1>
          </div>
        </div><!-- end row -->
      </div><!-- end container -->
    </div><!-- end container wrapper -->


    <div class="container">
      <div class="row">
		<div class="col-md-12" style="min-width:1024px;">    

    <form id="form1" runat="server" >
    <asp:ScriptManager id="ScriptManager1" runat="server" /> 
    <div style="width:65%; margin:0 auto;">
        <table border=0 width="100%" style=" border-collapse:collapse;height:50px;">
            <tr valign="top" style="height:10px;">            
                <td colspan="3"><asp:Label ID="Label10" runat="server" Text="Calculatrice des taxes sur les dépenses de voyage" Font-Size="2.2em" style=" font-family:Lao UI"></asp:Label></td>            
            </tr>
            <tr valign="top" style="height:10px;"><td colspan="3"><span style="color:red; font-size:1.1em;">Advataxes automatise la récupération de la TVQ au taux de 25% pour les grandes entreprises sur les dépenses couvertes par les RTI restreints pour la période du 1<sup>er</sup> janvier 2018 au 31 décembre 2018. Pour plus de détails sur ce changement fiscal consultez l'article "<a href="https://blog.advataxes.ca/fr/qst-phasing-out-the-restricted-itr-starting-on-january-2018/">TVQ – Élimination graduelle des RTI restreints à partir du 1er janvier 2018</a>".</span><br><br></td></tr>
            <tr valign="top" style="height:10px;"><td colspan="3"><span style="color:red; font-size:1.1em;">Tient compte de la baisse des RCTI en Ontario a 25% du 1<sup>er</sup> juillet 2017 au 30 juin 2018 sur les biens et services déterminés pour les grandes entreprises.</span><br><br></td></tr>
        </table>
		<br />
    <div style="width:98%; padding:10px; border:solid thin silver;border-radius:10px;">
         <table width="100%" border=0 style=" border-collapse:collapse;height:500px;">
            <tr style="height:5px;"><td></td></tr>
            <tr valign="middle" style=" height:40px;">
                <td style="font-size:0.9em" ><asp:Label ID="lbl" runat="server" Text="Label" Font-Bold="true">Calcule le montant net recouvrable de TPS/TVH et TVQ pour les petites/moyennes et les grandes entreprises sur les dépenses de voyages encourues par les employés</asp:Label> <span style="color:#cd1e1e; font-weight:bold; font-size:1.4em;"> *</span><br /><br /></td>
                <td rowspan="2" valign="top"  width="30%" style="font-weight:normal;">
                    <table>
                        <tr><td width="20px"></td><td class="sideTitle">Type d'entreprise</td></tr>
                        <tr><td></td></tr>
                        <tr><td></td><td style="font-size:0.9em; text-align:justify;">Sélectionner si l'entreprise est une grande entreprise ou une petite/moyenne entreprise pour les fins de la TPS/HST et de la TVQ</td></tr>
                        <tr style="height:20px"><td></td></tr>
                        <tr style="border-top: solid thin #cd1e1e"><td></td><td class="sideTitle">Type de dépense</td></tr>
                        <tr><td></td></tr>
                        <tr><td></td><td style="font-size:0.9em; text-align:justify;">Sélectionner le type de dépense que l'employé à encouru dans le cadre des activités commerciales</td></tr>
                        <tr style="height:20px"><td></td></tr>
                        <tr><td></td><td class="sideTitle">Jurisdiction</td></tr>
                        <tr><td></td></tr>
                        <tr style="border-top: solid thin #cd1e1e"><td></td><td style="font-size:0.9em; text-align:justify;">Sélectionner la province canadienne ou le territoire où la dépense a été encouru</td></tr>
                        <tr style="height:20px"><td></td></tr>
                        <tr><td></td><td class="sideTitle">Date</td></tr>
                        <tr><td></td></tr>
                        <tr style="border-top: solid thin #cd1e1e"><td></td><td style="font-size:0.9em; text-align:justify;">Le calcul utilisera les taux des taxes indirectes canadiennes de la journée.</td></tr>
                        <tr style="height:20px"><td></td></tr>

                        <tr><td></td><td class="sideTitle">Montant</td></tr>
                        <tr><td></td></tr>
                        <tr style="border-top: solid thin #cd1e1e"><td></td><td style="font-size:0.9em; text-align:justify;">Insérer le montant des taxes incluses ou avant taxes (les allocations sont calculés sur une base taxes incluses)</td></tr>
                        <tr style="height:20px"><td></td></tr>

                        <tr><td></td><td class="sideTitle">Taxes incluses</td></tr>
                        <tr><td></td></tr>
                        <tr style="border-top: solid thin #cd1e1e"><td></td><td style="font-size:0.9em; text-align:justify;">Le montant doit inclure les taxes de ventes canadiennes perçues soit la TPS, TVH, TVQ, TVMAN, TVSASK & TVCB.</td></tr>
                        <tr style="height:20px"><td></td></tr>

                        <tr><td></td><td class="sideTitle">TPS/TVH payée</td></tr>
                        <tr><td></td></tr>
                        <tr style="border-top: solid thin #cd1e1e"><td></td><td style="font-size:0.9em; text-align:justify;">Calcul la TPS/TVH payée (à valider avec le reçu) ou réputée payée sur la dépense</td></tr>
                        <tr style="height:20px"><td></td></tr>
                        <tr><td></td><td class="sideTitle">TVQ payée</td></tr>
                        <tr><td></td></tr>
                        <tr style="border-top: solid thin #cd1e1e"><td></td><td style="font-size:0.9em; text-align:justify;">Calcul la TVQ payée (à valider avec le reçu) ou réputée payée sur la dépense</td></tr>
                        <tr style="height:20px"><td></td></tr>
                        <tr><td></td><td class="sideTitle">Total</td></tr>
                        <tr><td></td></tr>
                        <tr style="border-top: solid thin #cd1e1e"><td></td><td style="font-size:0.9em; text-align:justify;">Montant total de la dépense soumise par l'employée</td></tr>
                        <tr style="height:20px"><td></td></tr>
                        <tr><td></td><td class="sideTitle">CTI</td></tr>
                        <tr><td></td></tr>
                        <tr style="border-top: solid thin #cd1e1e"><td></td><td style="font-size:0.9em; text-align:justify;">CTI; crédit de taxes sur les intrants sous la <i>Loi sur la taxe d'accise</i></td></tr>
                        <tr style="height:20px"><td></td></tr>
                        <tr><td></td><td class="sideTitle">RTI</td></tr>
                        <tr><td></td></tr>
                        <tr style="border-top: solid thin #cd1e1e"><td></td><td style="font-size:0.9em; text-align:justify;">RTI; remboursement de taxes sur les intrants sous la <i>Loi sur la taxe de vente du Québec</i> </td></tr>
                        <tr style="height:20px"><td></td></tr>
                        <tr><td></td><td class="sideTitle">RCTI</td></tr>
                        <tr><td></td></tr>
                        <tr style="border-top: solid thin #cd1e1e"><td></td><td style="font-size:0.9em; text-align:justify;">RCTI; récupération du crédit de taxes sur les intrants sous la <i>Loi sur la taxe d'accise</i></td></tr>
                        <tr style="height:20px"><td></td></tr>
                        <tr><td></td><td class="sideTitle">Nette</td></tr>
                        <tr><td></td></tr>
                        <tr><td></td><td style="font-size:0.9em; text-align:justify;">Réfère au montant de la dépense nette qui égale le "Total" moins le "CTI", moins le "RTI" et plus le "RCTI"</td></tr>          
                    </table>
                    <br /><br />
                </td>
            </tr>
        
            <tr>
                <td valign="top" width="70%">
                <div style=" padding:10px; background-color:#E6E3E3;border-radius:8px;">
                    <table width="100%" style="font-size:1.2em; border-collapse:collapse;">
                            <tr style="height:35px;">
                                <td width="30%"><span class="title">Taille de l'entreprise</span></td>
                                <td>
                                    <asp:DropDownList ID="cboSize" runat="server" Width="150px" CssClass="update" style="border-radius:5px;height:30px;  ">
                                        <asp:ListItem Value="1">Petite/Moyenne</asp:ListItem>
                                        <asp:ListItem Value="2">Grande</asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                            </tr>

                            <tr style="height:10px;"><td></td></tr>

                            <tr style="height:35px;">
                                <td><span class="title"><%= AdvataxesResources.My.Resources.TaxCalculator.ExpenseType%></td>
                                <td>
                                    <asp:DropDownList ID="cboCat" runat="server" Width="150px"   CssClass="update" style="border-radius:5px;height:30px;  ">
                                        <asp:ListItem Value="13">Carburant pour automobiles</asp:ListItem>
                                        <asp:ListItem Value="18">Hôtel</asp:ListItem>
                                        <%--<asp:ListItem Value="2">Allocation repas</asp:ListItem>--%>
                                    </asp:DropDownList>
                                </td>            
                            </tr>

                            <tr style="height:10px;"><td></td></tr>

                            <tr style="height:35px;">
                                <td><span class="title"><%= AdvataxesResources.My.Resources.TaxCalculator.Jurisdiction%></td>
                                <td><asp:DropDownList ID="cboJur" runat="server" DataSourceID="sqlJur"  DataTextField="JUR_NAME" DataValueField="JUR_ID" Height="25px" Width="214px"  CssClass="update"  style="border-radius:5px;height:30px;  "/></td>
                            </tr>

                            <tr style="height:40px">
                                <td><span class="title"><%= AdvataxesResources.My.Resources.Common.DateLabel%></td>
                                <td style="font-size:0.9em;font-weight:bold;" ><%Response.Write(Now.ToShortDateString)%></td>
                            </tr>

                            <tr>
                                <td><span class="title">Montant</td>
                                <td>
                                    <asp:TextBox ID="txtAmt" runat="server" CssClass="numberinput" width="75px" MaxLength="9"  style="border-radius:5px;border:solid thin silver;height:25px; "></asp:TextBox>
                                    <asp:DropDownList ID="cboTaxIE" runat="server" Height="25px" CssClass="update" style="border-radius:5px;height:30px; ">
                                        <asp:ListItem Value="1">Taxes incluses</asp:ListItem>
                                        <asp:ListItem Value="2">Avant la TPS/TVH/TVQ</asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                            </tr>
                        
                            <tr style="height:40px;"><td></td></tr>
                        
                            <tr id="Row-GST">
                                <td><span class="title">TPS/TVH payée</td>                            
                                <td><asp:TextBox ID="txtGST" runat="server"  CssClass="numberinput" width="75px" ReadOnly="true" BackColor="#CDCBCB" BorderStyle="Solid" BorderColor="#C0C0C0" style=" border-radius:5px;height:25px;"></asp:TextBox></td>
                            </tr>

                            <tr style="height:5px;"><td></td></tr>

                            <tr id="Row-QST">
                                <td><span class="title">TVQ payée</td>
                                <td><asp:TextBox ID="txtQST" runat="server"  CssClass="numberinput" width="75px" ReadOnly="true" BackColor="#CDCBCB"   BorderStyle="Solid" BorderColor="#C0C0C0"  style=" border-radius:5px;height:25px;"></asp:TextBox></td>
                            </tr>

                            <tr style="height:5px;"><td></td></tr>

                            <tr>
                                <td><span class="title"><%= AdvataxesResources.My.Resources.TaxCalculator.Total%></td>
                                <td><asp:TextBox ID="txtTotal" runat="server"  CssClass="numberinput"  width="75px" ReadOnly="true" BackColor="#CDCBCB"   BorderStyle="Solid" BorderColor="#C0C0C0" style=" border-radius:5px;height:25px;"></asp:TextBox></td>
                            </tr>

                            <tr style="height:20px;"><td></td></tr>
                        
                            <tr id="Row-ITC">
                                <td><span class="title">CTI</td>
                                <td><asp:TextBox ID="txtITC" runat="server"  CssClass="numberinput"  width="75px" ReadOnly="true" BackColor="#CDCBCB"   BorderStyle="Solid" BorderColor="#C0C0C0" style=" border-radius:5px;height:25px;"></asp:TextBox></td>
                            </tr>

                            <tr style="height:10px;"><td></td></tr>

                            <tr id="Row-ITR">
                                <td><span class="title">RTI</td>
                                <td><asp:TextBox ID="txtITR" runat="server"  CssClass="numberinput"  width="75px" ReadOnly="true" BackColor="#CDCBCB"  BorderStyle="Solid" BorderColor="#C0C0C0" style=" border-radius:5px;height:25px;"></asp:TextBox></td>
                            </tr>

                            <tr style="height:10px;"><td></td></tr>

                            <tr id="Row-RITC" valign="middle" style="height:30px;">
                                <td><span class="title">RCTI</td>
                                <td><asp:TextBox ID="txtRITC" runat="server"  CssClass="numberinput" width="75px" ReadOnly="true"  BackColor="#CDCBCB"  BorderStyle="Solid" BorderColor="#C0C0C0" style=" border-radius:5px;height:25px;"></asp:TextBox></td>
                            </tr>

                            <tr>
                                <td><span class="title">Nette</td>
                                <td><asp:TextBox ID="txtNet" runat="server"  CssClass="numberinput" width="75px" ReadOnly="true"  BackColor="#CDCBCB"  BorderStyle="Solid" BorderColor="#C0C0C0" style=" border-radius:5px;height:25px;"></asp:TextBox></td>
                            </tr>
                    </table>
                    </div>              

                    <table width="100%" style="font-size:1.2em; border-collapse:collapse;">
                            
                            <tr style="height:20px;"><td></td></tr>
                            <tr><td colspan="2"><span style="font-size:1.8em; font-family: Lao UI">Exemple de rapport d'Advataxes</span></td></tr>
                            <tr style="border-top:solid thin #cd1e1e;height:20px;"><td colspan="2"></td></tr> 
                            <tr><td colspan="2" style="font-size:0.9em;text-align:justify;">Le logiciel Advataxes sur les comptes de dépense des employés automatise la TPS/TVH et la TVQ payée, la TPS/TVH et la TVQ recouvrable, et la récupération sur les crédits de taxes sur les intrants en Ontario et à l'IPE essentiellement de la même manière que le calculateur de taxes mais avec la principale différence que les montants précalculés de TPS/TVH payée et de TVQ payée sont modifiables par les usagers. La sélection par l'ensemble des employés du type de dépense, de la jurisdiction et de la date a été préférée à l'approche traditionnelle de la sélection par l'ensemble des employés des codes de taxes. Ainsi l'allocation des responsabilités est plus adéquate. Dans cet exemple d'un rapport de dépense de voyage d'un employé d'une grande entreprise, l'employé doit choisir un numéro de projet qui est lié à un segment comptable, et identifier qu'elle dépense a été directement payée par l'employeur à la compagnie émettrice de la carte de crédit. Le rapport fournit les taxes recouvrables selon la méthode exacte.</td></tr>
                            <tr valign="bottom" style="height:60px;"><td style="font-size:0.9em">Cliquer sur l'image pour l'aggrandir</td></tr>
                            <tr><td colspan="2"><a href="/en/images/comptabilite-rapport 2.jpg" class="openReport"><img src="/en/images/comptabilite-rapport 2.jpg" width="100%" style=" border:solid thin silver;border-radius:5px;" /></a></td></tr>
                    </table>  
                    
                </td>

            </tr>
            <tr style="height:15px;"><td>&nbsp;</td></tr>
            <tr style=" border-top:solid thin #cd1e1e;height:5px;"><td colspan="3">&nbsp;</td></tr>
            <tr valign="top" style="font-weight:normal;"><td colspan="3" style=" text-align:justify;"><span style="color:#cd1e1e;font-size:1.1em;font-weight:bold;">*</span>Le calculateur des taxes sur les dépenses de voyage s’opère sous les assomptions suivantes;  la personne est un inscrit aux fins de la TPS/TVH et de la TVQ. Les ratios d’activités commerciales de la personne sont de 100%.  Le calcul pour les grandes entreprises automatise le calcul de la récupération temporaire sur les crédits de taxes sur intrants (RCTI) en Ontario et à l’IPE et les remboursements de taxes sur les intrants restreints au Québec sur les aliments boissons et divertissements selon le paragraphe 236(1) de la <i>Loi sur la taxe d’accise</i> et de l’article  457.1 de la <i>Loi sur la taxe de vente du Québec</i> et du « carburant autos » à titre de carburant moteur , sauf le diesel, pour être utilisé dans un véhicule de moins de 3000KG immatriculé pour circuler sur les chemins publics. Le calculateur de taxes applique la méthode exacte pour calculer les crédits de taxes sur les intrants (CTI) et les remboursements de taxes sur les intrants (RTI).  Le calculateur de taxes n’est pas conçu pour les personnes utilisant la méthode de comptabilité abrégé ou toute autre méthode ne requérant pas le calcul sur achats des CTI et des RTI. Le calculateur de taxes n’intègre pas les dispositions de la <i>Loi sur les indiens</i> et de la <i>Loi sur la taxes sur les produits et services des premières nations</i>. Le calculateur de taxes ne doit pas être un substitut a obtenir un consultation en taxes indirectes. Il est recommandé de consulter pour comprendre les concepts que le calculateur de taxes automatise.</td></tr>
        </table>    
        <div style="display:none;"><asp:Button ID="cmdDummy" runat="server" Text="Button"  /></div>
    </div>
    </div>
        <asp:Panel ID="pnlShowReport" runat="server" CssClass="modalPopup" style="display:none" Width="950px" Height="375px">
            <div style="text-align:right;width:900px;"><asp:LinkButton ID="LinkButton1" runat="server">Close</asp:LinkButton></div>
            <img src="/images/report-fr.png" width="100%" />   
            
        </asp:Panel>
        
        <act:ModalPopupExtender ID="modalShowReport" runat="server"
                TargetControlID="cmdDummy"
                PopupControlID="pnlShowReport"
                PopupDragHandleControlID="pnlShowReport"
                DropShadow="false"
                BackgroundCssClass="modalBackground"
                BehaviorID="modalShowReport" />
                </form>

            <asp:SqlDataSource ID="sqlJur" runat="server" 
                ConnectionString="<%$ ConnectionStrings:dbadvaloremConnStr %>" 
                SelectCommand="GetJurisdictions" SelectCommandType="StoredProcedure">
            </asp:SqlDataSource>
            
        <script type="text/javascript">
            $(document).ready(function () {
                $("#<%=cboSize.ClientID %>").val(2);
                $("#<%=cboCat.ClientID %>").val(2);
                $("#<%=cboTaxIE.ClientID %>").hide();

                $("#<%=cboJur.ClientID %> option[value='14']").remove();

                $("#Row-RITC").hide();
                $("#Row-QST").hide();
                $("#Row-ITR").hide();


                $("#<%=txtAmt.ClientID %>").keyup(function () {
                    $(".update").change();
                });

                $(".openReport").click(function () {
                    var mpe = $find('modalShowReport');
                    if (mpe) { mpe.show(); }
                });



                $(".update").change(function () {
                    if ($("#<%=cboCat.ClientID %>").val() == 2) {
                        $("#<%=cboTaxIE.ClientID %>").hide();
                        $("#<%=cboTaxIE.ClientID %>").val('1');
                    } else
                        $("#<%=cboTaxIE.ClientID %>").show();

                    var jur_id;
                    var exp_date = '01/01/2050';
                    var cat_id = $("#<%=cboCat.ClientID %>").val();
                    var tax_inc_exc = $("#<%=cboTaxIE.ClientID %>").val();
                    var size = $("#<%=cboSize.ClientID %>").val();
                    var kmRate = 0;

                    jur_id = $("#<%=cboJur.ClientID %>").val();

                    $.ajax({
                        type: "POST",
                        url: "calculatrice-des-taxes-depenses-voyages.aspx/GetTaxRates",
                        data: "{'jurID': '" + jur_id + "','expDate': '" + exp_date + "','catID': '" + cat_id + "','taxIncExc': '" + tax_inc_exc + "','size': '" + size + "'}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (returnVal) {
                            var num;
                            var total;

                            num = $("#<%=txtAmt.ClientID %>").val() * returnVal.d[0];

                            $("#<%=txtGST.ClientID %>").val(num.toFixed(2));
                            num = $("#<%=txtAmt.ClientID %>").val() * returnVal.d[1];
                            $("#<%=txtQST.ClientID %>").val(num.toFixed(2));

                            num = $("#<%=txtAmt.ClientID %>").val() * 1;

                            if ($("#<%=cboTaxIE.ClientID %>").val() == 2) {
                                num = num + $("#<%=txtGST.ClientID %>").val() * 1;
                                num = num + $("#<%=txtQST.ClientID %>").val() * 1;
                            }

                            $("#<%=txtTotal.ClientID %>").val(num.toFixed(2));
                            $("#Row-Total").show();

                            if (jur_id == 1) {
                                $("#Row-QST").fadeIn(1000);
                                $("#Row-ITR").fadeIn(1000);
                            } else {
                                $("#Row-QST").fadeOut(600);
                                $("#Row-ITR").fadeOut(600);
                            }

                            if ((jur_id == 2 || jur_id == 4) && $("#<%=cboSize.ClientID %>").val() == 2)
                                $("#Row-RITC").fadeIn(1000);
                            else
                                $("#Row-RITC").fadeOut(600);

                            if (jur_id == 14) {
                                $("#Row-GST").fadeOut(600);
                                $("#Row-ITC").fadeOut(600);
                            } else {
                                $("#Row-GST").fadeIn(1000);
                                $("#Row-ITC").fadeIn(1000);
                            }


                            var total = $("#<%=txtTotal.ClientID %>").val() * 1;
                            var itc = returnVal.d[2] * $("#<%=txtGST.ClientID %>").val();
                            var itr = returnVal.d[3] * $("#<%=txtQST.ClientID %>").val();
                            var ritc = returnVal.d[4] * $("#<%=txtGST.ClientID %>").val();


                            $("#<%=txtITC.ClientID %>").val(itc.toFixed(2));
                            $("#<%=txtITR.ClientID %>").val(itr.toFixed(2));
                            $("#<%=txtRITC.ClientID %>").val(ritc.toFixed(2));

                            var net = total - itc - itr + ritc;
                            $("#<%=txtNet.ClientID %>").val(net.toFixed(2));
                        },
                        error: function (xhr) {
                            if (xhr.responseText.indexOf('is not a valid value') == -1) //ignore error if user hasnt selected a category yet
                                alert("Error#1001: There was an unexpected error");
                        }
                    });
                });
            });

        </script>    




			</div>
      </div><!-- end row -->
  
    </div><!-- end container -->
        
    <div class="clear"></div>

	<!-- #include file="/fr/inc/footer.inc" -->
    
    <script src="/en/js/bootstrap.js"></script>
    <script src="/en/js/zion.js"></script>
	<script src="/en/js/customSmoothScroll2.js"></script>
	

        <link href="/css/style3.css" rel="stylesheet" type="text/css" />
<!--        <script type="text/javascript" src="/js/jquery-1.7.2.min.js"></script> -->
        <script type="text/javascript" src="/js/jquery-ui-1.8.18.custom.min.js"> </script>
        <script type="text/javascript" src="/js/jquery.js"> </script>

        <style type="text/css">
			tr { color:#616060; }
            .sideTitle { font-size:1.5em; }
            .title { font-size:1.1em; font-weight:bold; }
        </style>

        <script type="text/javascript">
            function image() {
                var img = document.createElement("IMG");
                img.src = "/en/images/comptabilite-rapport.jpg";
                document.getElementById('rpt').appendChild(img);
            }
        </script>   

  </body>
</html>
