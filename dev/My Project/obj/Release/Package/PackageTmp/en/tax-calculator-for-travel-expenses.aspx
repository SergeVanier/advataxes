<%@ Page Title="" Language="vb" AutoEventWireup="false" CodeBehind="TaxCalculator.aspx.vb" Inherits="Advataxes.TaxCalculator" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="act" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Tax Calculator for Travel Expenses | Advataxes</title>
    <meta name="description" content="">
   
	<!-- #include file="/en/inc/header-html.inc" -->
	<script src="/en/js/jquery-1.9.0-min.js"></script>

  <body>
  
 	<!-- #include file="/en/inc/header-menu.inc" -->	
	
    <div class="clear"></div>

    <div class="container-wrapper container-top">
      <div class="container container-top">
        <div class="row">
          <div class="col-md-12 center">
            <h1>Tax Calculator for Travel Expenses</h1>
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
                <td colspan="3"><asp:Label ID="Label10" runat="server" Text="Tax Calculator for Travel Expenses" Font-Size="2.2em" style=" font-family:Lao UI"></asp:Label></td>            
            </tr>
            <tr valign="top" style="height:10px;"><td colspan="3"><span style="color:red; font-size:1.1em;">Take into consideration the lowering of RITC in Ontario to 25% from July 1<sup>st</sup> 2017 to June 30<sup>th</sup> 2018 on specified properties and services for large businesses.</span><br><br></td></tr>
            <tr valign="top" style="height:10px;"><td colspan="3"><span style="color:red; font-size:1.1em;">Advataxes will automate the QST input recoveries at the rate of 25% for large businesses on restricted input tax refund for the period of January 1<sup>st</sup>, 2018 to December 31, 2018. For more details on this tax change please consult the article "<a href="https://blog.advataxes.ca/qst-phasing-out-the-restricted-itr-starting-on-january-2018/">QST Phasing out the Restricted ITR Starting on January 1, 2018</a>". </span></td></tr>
        </table>
		<br />    
    <div style="width:98%; padding:10px; border:solid thin silver;border-radius:10px;">
         <table width="100%" border=0 style=" border-collapse:collapse;height:500px;">
            <tr style="height:5px;"><td></td></tr>
            <tr valign="middle" style=" height:40px;">
                <td style="font-size:0.9em" ><asp:Label ID="lbl" runat="server" Text="Label" Font-Bold="true"><%= AdvataxesResources.My.Resources.TaxCalculator.PageMainTitle%></asp:Label> <span style="color:#cd1e1e; font-weight:bold; font-size:1.4em;"> *</span><br /><br /></td>
                <td rowspan="2" valign="top"  width="30%" style="font-weight:normal;">
                    <table>
                        <tr><td width="20px"></td><td class="sideTitle"><%= AdvataxesResources.My.Resources.TaxCalculator.BusinessSize%></td></tr>
                        <tr><td></td></tr>
                        <tr><td></td><td style="font-size:0.9em; text-align:justify;"><%= AdvataxesResources.My.Resources.TaxCalculator.BusinessSize_Instructions %></td></tr>
                        <tr style="height:20px"><td></td></tr>
                        <tr style="border-top: solid thin #cd1e1e"><td></td><td class="sideTitle"><%= AdvataxesResources.My.Resources.TaxCalculator.ExpenseType%></td></tr>
                        <tr><td></td></tr>
                        <tr><td></td><td style="font-size:0.9em; text-align:justify;"><%= AdvataxesResources.My.Resources.TaxCalculator.ExpenseType_Instructions%></td></tr>
                        <tr style="height:20px"><td></td></tr>
                        <tr><td></td><td class="sideTitle"><%= AdvataxesResources.My.Resources.TaxCalculator.Jurisdiction%></td></tr>
                        <tr><td></td></tr>
                        <tr style="border-top: solid thin #cd1e1e"><td></td><td style="font-size:0.9em; text-align:justify;"><%= AdvataxesResources.My.Resources.TaxCalculator.Jurisdiction_Instructions%></td></tr>
                        <tr style="height:20px"><td></td></tr>
                        <tr><td></td><td class="sideTitle"><%= AdvataxesResources.My.Resources.Common.DateLabel%></td></tr>
                        <tr><td></td></tr>
                        <tr style="border-top: solid thin #cd1e1e"><td></td><td style="font-size:0.9em; text-align:justify;"><%= AdvataxesResources.My.Resources.TaxCalculator.Date_Instructions%></td></tr>
                        <tr style="height:20px"><td></td></tr>

                        <tr><td></td><td class="sideTitle"><%= AdvataxesResources.My.Resources.TaxCalculator.Amount%></td></tr>
                        <tr><td></td></tr>
                        <tr style="border-top: solid thin #cd1e1e"><td></td><td style="font-size:0.9em; text-align:justify;"><%= AdvataxesResources.My.Resources.TaxCalculator.Amount_Instructions%></td></tr>
                        <tr style="height:20px"><td></td></tr>

                        <tr><td></td><td class="sideTitle">Tax Included</td></tr>
                        <tr><td></td></tr>
                        <tr style="border-top: solid thin #cd1e1e"><td></td><td style="font-size:0.9em; text-align:justify;">The amount should include Canadian taxes collected; GST, HST, QST, MANPST, SASKPST & BCPST.</td></tr>
                        <tr style="height:20px"><td></td></tr>

                        <tr><td></td><td class="sideTitle"><%= AdvataxesResources.My.Resources.TaxCalculator.GST_HST_Paid%></td></tr>
                        <tr><td></td></tr>
                        <tr style="border-top: solid thin #cd1e1e"><td></td><td style="font-size:0.9em; text-align:justify;"><%= AdvataxesResources.My.Resources.TaxCalculator.GST_HST_Paid_Instructions%></td></tr>
                        <tr style="height:20px"><td></td></tr>
                        <tr><td></td><td class="sideTitle"><%= AdvataxesResources.My.Resources.TaxCalculator.QST_Paid%></td></tr>
                        <tr><td></td></tr>
                        <tr style="border-top: solid thin #cd1e1e"><td></td><td style="font-size:0.9em; text-align:justify;"><%= AdvataxesResources.My.Resources.TaxCalculator.QST_Paid_Instructions%></td></tr>
                        <tr style="height:20px"><td></td></tr>
                        <tr><td></td><td class="sideTitle"><%= AdvataxesResources.My.Resources.TaxCalculator.Total%></td></tr>
                        <tr><td></td></tr>
                        <tr style="border-top: solid thin #cd1e1e"><td></td><td style="font-size:0.9em; text-align:justify;"><%= AdvataxesResources.My.Resources.TaxCalculator.Total_Instructions%></td></tr>
                        <tr style="height:20px"><td></td></tr>
                        <tr><td></td><td class="sideTitle"><%= AdvataxesResources.My.Resources.TaxCalculator.ITC%></td></tr>
                        <tr><td></td></tr>
                        <tr style="border-top: solid thin #cd1e1e"><td></td><td style="font-size:0.9em; text-align:justify;"><%= AdvataxesResources.My.Resources.TaxCalculator.ITC_Instructions%><i><%= AdvataxesResources.My.Resources.TaxCalculator.ExciseTaxAct%></i> </td></tr>
                        <tr style="height:20px"><td></td></tr>
                        <tr><td></td><td class="sideTitle"><%= AdvataxesResources.My.Resources.TaxCalculator.ITR%></td></tr>
                        <tr><td></td></tr>
                        <tr style="border-top: solid thin #cd1e1e"><td></td><td style="font-size:0.9em; text-align:justify;"><%= AdvataxesResources.My.Resources.TaxCalculator.ITR_Instructions%><i><%= AdvataxesResources.My.Resources.TaxCalculator.QuebecSalesTaxAct%></i> </td></tr>
                        <tr style="height:20px"><td></td></tr>
                        <tr><td></td><td class="sideTitle"><%= AdvataxesResources.My.Resources.TaxCalculator.RITC%></td></tr>
                        <tr><td></td></tr>
                        <tr style="border-top: solid thin #cd1e1e"><td></td><td style="font-size:0.9em; text-align:justify;"><%= AdvataxesResources.My.Resources.TaxCalculator.RITC_Instructions%><i><%= AdvataxesResources.My.Resources.TaxCalculator.ExciseTaxAct%></i></td></tr>
                        <tr style="height:20px"><td></td></tr>
                        <tr><td></td><td class="sideTitle"><%= AdvataxesResources.My.Resources.TaxCalculator.Net%></td></tr>
                        <tr><td></td></tr>
                        <tr><td></td><td style="font-size:0.9em; text-align:justify;"><%= AdvataxesResources.My.Resources.TaxCalculator.Net_Instructions%></td></tr>          
                    </table>
                    <br /><br />
                </td>
            </tr>
        
            <tr>
                <td valign="top" width="70%">
                <div style=" padding:10px; background-color:#E6E3E3;border-radius:8px;">
                    <table width="100%" style="font-size:1.2em; border-collapse:collapse;">
                            <tr style="height:35px;">
                                <td width="30%"><span class="title"><%= AdvataxesResources.My.Resources.TaxCalculator.BusinessSize%></span></td>
                                <td>
                                    <asp:DropDownList ID="cboSize" runat="server" Width="150px" CssClass="update" style="border-radius:5px;height:30px;  ">
                                        <asp:ListItem Value="1">Small/Medium</asp:ListItem>
                                        <asp:ListItem Value="2">Large</asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                            </tr>

                            <tr style="height:10px;"><td></td></tr>

                            <tr style="height:35px;">
                                <td><span class="title"><%= AdvataxesResources.My.Resources.TaxCalculator.ExpenseType%></td>
                                <td>
                                    <asp:DropDownList ID="cboCat" runat="server" Width="150px"   CssClass="update" style="border-radius:5px;height:30px;  ">
                                        <asp:ListItem Value="13">Gas for Cars</asp:ListItem>
                                        <asp:ListItem Value="18">Lodging</asp:ListItem>
                                        <asp:ListItem Value="2">Meal Allowance</asp:ListItem>
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
                                <td><span class="title"><%= AdvataxesResources.My.Resources.TaxCalculator.Amount%></td>
                                <td>
                                    <asp:TextBox ID="txtAmt" runat="server" CssClass="numberinput" width="75px" MaxLength="9"  style="border-radius:5px;border:solid thin silver;height:25px; "></asp:TextBox>
                                    <asp:DropDownList ID="cboTaxIE" runat="server" Height="25px" CssClass="update" style="border-radius:5px;height:30px; ">
                                        <asp:ListItem Value="1">Tax Included</asp:ListItem>
                                        <asp:ListItem Value="2">Before GST HST QST</asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                            </tr>
                        
                            <tr style="height:40px;"><td></td></tr>
                        
                            <tr id="Row-GST">
                                <td><span class="title"><%= AdvataxesResources.My.Resources.TaxCalculator.GST_HST_Paid%></td>                            
                                <td><asp:TextBox ID="txtGST" runat="server"  CssClass="numberinput" width="75px" ReadOnly="true" BackColor="#CDCBCB" BorderStyle="Solid" BorderColor="#C0C0C0" style=" border-radius:5px;height:25px;"></asp:TextBox></td>
                            </tr>

                            <tr style="height:5px;"><td></td></tr>

                            <tr id="Row-QST">
                                <td><span class="title"><%= AdvataxesResources.My.Resources.TaxCalculator.QST_Paid%></td>
                                <td><asp:TextBox ID="txtQST" runat="server"  CssClass="numberinput" width="75px" ReadOnly="true" BackColor="#CDCBCB"   BorderStyle="Solid" BorderColor="#C0C0C0"  style=" border-radius:5px;height:25px;"></asp:TextBox></td>
                            </tr>

                            <tr style="height:5px;"><td></td></tr>

                            <tr>
                                <td><span class="title"><%= AdvataxesResources.My.Resources.TaxCalculator.Total%></td>
                                <td><asp:TextBox ID="txtTotal" runat="server"  CssClass="numberinput"  width="75px" ReadOnly="true" BackColor="#CDCBCB"   BorderStyle="Solid" BorderColor="#C0C0C0" style=" border-radius:5px;height:25px;"></asp:TextBox></td>
                            </tr>

                            <tr style="height:20px;"><td></td></tr>
                        
                            <tr id="Row-ITC">
                                <td><span class="title"><%= AdvataxesResources.My.Resources.TaxCalculator.ITC%></td>
                                <td><asp:TextBox ID="txtITC" runat="server"  CssClass="numberinput"  width="75px" ReadOnly="true" BackColor="#CDCBCB"   BorderStyle="Solid" BorderColor="#C0C0C0" style=" border-radius:5px;height:25px;"></asp:TextBox></td>
                            </tr>

                            <tr style="height:10px;"><td></td></tr>

                            <tr id="Row-ITR">
                                <td><span class="title"><%= AdvataxesResources.My.Resources.TaxCalculator.ITR%></td>
                                <td><asp:TextBox ID="txtITR" runat="server"  CssClass="numberinput"  width="75px" ReadOnly="true" BackColor="#CDCBCB"  BorderStyle="Solid" BorderColor="#C0C0C0" style=" border-radius:5px;height:25px;"></asp:TextBox></td>
                            </tr>

                            <tr style="height:10px;"><td></td></tr>

                            <tr id="Row-RITC" valign="middle" style="height:30px;">
                                <td><span class="title"><%= AdvataxesResources.My.Resources.TaxCalculator.RITC%></td>
                                <td><asp:TextBox ID="txtRITC" runat="server"  CssClass="numberinput" width="75px" ReadOnly="true"  BackColor="#CDCBCB"  BorderStyle="Solid" BorderColor="#C0C0C0" style=" border-radius:5px;height:25px;"></asp:TextBox></td>
                            </tr>

                            <tr>
                                <td><span class="title"><%= AdvataxesResources.My.Resources.TaxCalculator.Net%></td>
                                <td><asp:TextBox ID="txtNet" runat="server"  CssClass="numberinput" width="75px" ReadOnly="true"  BackColor="#CDCBCB"  BorderStyle="Solid" BorderColor="#C0C0C0" style=" border-radius:5px;height:25px;"></asp:TextBox></td>
                            </tr>
                    </table>
                    </div>              

                    <table width="100%" style="font-size:1.2em; border-collapse:collapse;">
                            
                            <tr style="height:20px;"><td></td></tr>
                            <tr><td colspan="2"><span style="font-size:1.8em; font-family: Lao UI"><%= AdvataxesResources.My.Resources.TaxCalculator.SampleReportTitle%></span></td></tr>
                            <tr style="border-top:solid thin #cd1e1e;height:20px;"><td colspan="2"></td></tr> 
                            <tr><td colspan="2" style="font-size:0.9em;text-align:justify;">Advataxes is an employee expense software that automates the GST ⁄ HST & QST paid, GST ⁄ HST & QST recoverable and the recapture of input tax credits in Ontario and PEI, in the same manner as the tax calculator with the major exception that the precalculated GST/HST Paid and QST Paid are editable by users. Selecting an expense type, a jurisdiction and a date is the preferred system instead of the traditional one requiring all employees to select from a list of tax codes. This is a more efficient responsibility allocation structure. In the example below, you have a travel expense report for an employee of a large business. The employee selected a project number, which is linked to an account segment, and has identified which expense has been directly paid by the employer to the credit card company. The current expense report displays the recoverable taxes based on the exact method.</td></tr>
                            <tr valign="bottom" style="height:60px;"><td style="font-size:0.9em"><%= AdvataxesResources.My.Resources.TaxCalculator.ClickImageToEnlarge%></td></tr>
                            <tr><td colspan="2"><a href="/en/images/tax-calculator-report-en.png" class="openReport"><img src="/en/images/tax-calculator-report-en.png" width="100%" style=" border:solid thin silver;border-radius:5px;" /></a></td></tr>
                    </table>  
                    
                </td>

            </tr>
            <tr style="height:15px;"><td>&nbsp;</td></tr>
            <tr style=" border-top:solid thin #cd1e1e;height:5px;"><td colspan="3">&nbsp;</td></tr>
            <tr valign="top" style="font-weight:normal;"><td colspan="3" style=" text-align:justify;"><span style="color:#cd1e1e;font-size:1.1em;font-weight:bold;">*</span> <%= AdvataxesResources.My.Resources.TaxCalculator.TaxCalculator_Assumptions%></td></tr>
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
                        url: "tax-calculator-for-travel-expenses.aspx/GetTaxRates",
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

	<!-- #include file="/en/inc/footer.inc" -->
    
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
                img.src = "/en/images/tax-calculator-report-en.png";
                document.getElementById('rpt').appendChild(img);
            }
        </script>   

  </body>
</html>
