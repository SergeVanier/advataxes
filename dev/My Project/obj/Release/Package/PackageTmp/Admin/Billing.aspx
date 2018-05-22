<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="Billing.aspx.vb" Inherits="Advataxes.Billing" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="act" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server" >
    <asp:ScriptManager id="ScriptManager1" runat="server"  /> 
    <script type="text/javascript" src="../../js/jquery-ui-1.8.18.custom.min.js"> </script>
    <script type="text/javascript" src="../../js/jquery.js"> </script>
    <br />
    <table width="100%" border=0>
        <tr>
            <td><asp:Label ID="lbl525" runat="server" Text="Transaction History"  Font-Size="Large" CssClass="labelText"></asp:Label></td>
            <td align="right" width="40%"><asp:DropDownList ID="cboOrg" runat="server" DataSourceID="sqlActiveOrgs" DataTextField="ORG_NAME" DataValueField="ORG_ID" Width="200px" onchange ="getDates(displayBilling)"></asp:DropDownList></td>
            <td align="right" width="15%">
                
                <select id="cboDateRange">
                    <!--<option value="0">Custom Range</option>-->
                    <!--<option value="1"><asp:Label ID="lbl539" runat="server" Text="Label" /></option>-->
                    <!--<option value="2">Last Month</option>-->
                    <option selected="selected" value="3"><asp:Label ID="lbl527" runat="server" Text="Last 3 months" /></option>
                    <option value="6"><asp:Label ID="lbl528" runat="server" Text="Last 6 months" /></option>
                    <option value="98"><asp:Label ID="lbl529" runat="server" Text="This year" /></option>
                    <option value="99"><asp:Label ID="lbl530" runat="server" Text="All time" /></option>
                </select>
                
                
                <asp:TextBox ID="txtFrom" runat="server" Width="75px"></asp:TextBox>
                <asp:TextBox ID="txtTo" runat="server" Width="75px"></asp:TextBox>
                <a id="refresh" href="#" onclick="getDates(displayBilling)"><img src="../images/refresh.png" width="25px" height="30px" title="Refresh" style="position:relative;top:10px;"/></a>
            </td>
        </tr>
    </table>


    <a href="#" onclick="printDiv('printableArea')" title="Print"><img src="../images/print.png"  Width="35px" style="display:none;" /></a>

    
    <br /><br />
    <div id="printableArea">
        <table width='100%' border=1 style='border-collapse:collapse;'>
            <tr style='height:30px;background-color:#EAF2FA; font-weight:bold;border-bottom-style:hidden;border-top:solid thin silver;border-left:solid thin silver;border-right:solid thin silver;'><td align='center' width='15%' style="border-right-style:hidden;"><asp:Label ID="lbl78" runat="server" Text="Finalized" /></td><td width="30%"  style="border-right-style:hidden;"><asp:Label ID="lbl73" runat="server" Text="Employee" /></td><td width="42%" colspan="2"  style="border-right-style:hidden;"><asp:Label ID="lbl74" runat="server" Text="Report Name" /></td><td align='center' width="15%">Total</td>      
            </tr>
        </table>
        
        <div id="Billing" style="height:900px"> 
            <div id="processing" class="labelText" style=" text-align:center;"><br /><img src="../images/busy.gif" /> <asp:Label ID="lbl285" runat="server" Text="Processing, please wait ..." /> </div>
        </div>
    </div>
   
    <asp:HiddenField ID="hdnPUK" runat="server" Value="" />  
    <asp:HiddenField ID="hdnParentOrg" runat="server" Value="" />  

    <div style="display:none;"><asp:Button ID="cmdDummy" runat="server" Text="Button"  /></div>
    
    <asp:SqlDataSource ID="sqlActiveOrgs" runat="server" 
        ConnectionString="<%$ ConnectionStrings:dbadvaloremConnStr %>" 
        SelectCommand="GetActiveOrgs" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="hdnParentOrg" Name="OrgID" PropertyName="value" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>

        <script type="text/javascript">
            function popup(url) {
                var iMyWidth;
                var iMyHeight;
                //half the screen width minus half the new window width (plus 5 pixel borders).
                iMyWidth = (window.screen.width / 2) - (500 + 10);
                //half the screen height minus half the new window height (plus title and status bars).
                iMyHeight = (window.screen.height / 2) - (300 + 50);
                //Open the window.

                var popupWindow = window.open(url, 'popUpWindow', "status=no,height=600,width=650,resizable=yes,left=" + iMyWidth + ",top=" + iMyHeight + ",screenX=" + iMyWidth + ",screenY=" + iMyHeight + ",toolbar=no,menubar=no,scrollbars=yes,location=no,directories=no");
                popupWindow.focus();
            }

            function printDiv(divName) {
                var printContents = document.getElementById(divName).innerHTML;
                var originalContents = document.body.innerHTML;

                document.body.innerHTML = printContents;
                window.print();
                document.body.innerHTML = originalContents;
            }

            function displayBilling() {
                var puk = $("#<%=hdnPUK.ClientID %>").val();
                var fromDate = $("#<%=txtFrom.ClientID %>").val();
                var toDate = $("#<%=txtTo.ClientID %>").val();
                var org = $("#<%=cboOrg.ClientID %>").val();

                $.ajax({
                    type: "POST",
                    url: "Billing.aspx/GetBillingData",
                    data: "{'orgID': '" + org + "','puk': '" + puk + "','fromDate': '" + fromDate + "','toDate': '" + toDate + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (returnVal) {
                        var s;

                        s = returnVal.d;

                        $(s).appendTo('#Billing');
                        $("#BillingData").fadeIn(500);

                        $("#processing").hide();
                        return true;
                    },
                    error: function () {
                        alert("error");
                        return false;
                    }
                });

                return true;
            }


            function getDates(callback) {

                //v1.02 => Quick-fix in js to avoid recompile
                //we'll roll our own getDate in javascript, because its gonna be lighter and a lot better! Anyway we only care about month and year
                var selectedRange = $("#cboDateRange").val();
                var now = new Date();
                var beginningDate ,beginningDateString, nowDateString;

                switch (selectedRange) {
                    case "3": //3 months prior
                        beginningDate = new Date(new Date(now.getFullYear(), now.getMonth(), 1).setMonth(now.getMonth() - 3));
                        break;
                    case "6": //6 months prior
                        beginningDate = new Date(new Date(now.getFullYear(), now.getMonth(), 1).setMonth(now.getMonth() - 6));
                        break;
                    case "98": //this whole year
                        beginningDate = new Date(now.getFullYear(), 0, 1);
                        break;
                    case "99": //forever. Start date is 2012-01-01, end date is today, now
                        beginningDate = new Date(2012, 0, 1)
                        break;
                    default:
                        beginningDate = new Date();
                        break;
                }
                beginningDateString = beginningDate.getFullYear() + '';
                nowDateString = now.getFullYear() + '';

                if (beginningDate.getMonth() < 9) {
                    beginningDateString += '0' + (beginningDate.getMonth() + 1);
                } else {
                    beginningDateString += (beginningDate.getMonth() + 1) + '';
                }

                if (now.getMonth() < 9) {
                    nowDateString += '0' + (now.getMonth() + 1);
                } else {
                    nowDateString += (now.getMonth() + 1) + '';
                }

                $("#<%=txtFrom.ClientID %>").val(beginningDateString);
                $("#<%=txtTo.ClientID %>").val(nowDateString);

                if (callback)
                    callback();
            }


            $(document).ready(function () {
                $("#<%=txtTo.ClientID %>").datepicker({ dateFormat: "dd/mm/yy", maxDate: new Date() });
                $("#<%=txtFrom.ClientID %>").datepicker({ dateFormat: "dd/mm/yy", maxDate: new Date() });

                $("#<%=txtFrom.ClientID %>").hide();
                $("#<%=txtTo.ClientID %>").hide();
                $("#refresh").hide();
                $("#cboDateRange").val(3);
                getDates(displayBilling);


                $("#cboDateRange").change(function () {
                    if ($("#cboDateRange").val() == '0') {
                        $("#<%=txtFrom.ClientID %>").val('');
                        $("#<%=txtTo.ClientID %>").val('');
                        $("#<%=txtFrom.ClientID %>").fadeIn(800);
                        $("#<%=txtTo.ClientID %>").fadeIn(800);
                        $("#refresh").fadeIn(800);
                    } else {
                        $("#<%=txtFrom.ClientID %>").fadeOut(800);
                        $("#<%=txtTo.ClientID %>").fadeOut(800);
                        $("#refresh").fadeOut(800);
                        getDates(displayBilling);
                    }
                });
            });

    </script>
</asp:Content>
