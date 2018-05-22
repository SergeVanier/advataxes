<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Invoice.aspx.vb" Inherits="Advataxes.Invoice" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <link type="text/css" rel="stylesheet" href="/css/style3.css" />
    <link type="text/css" rel="stylesheet" href="/css/sunny/jquery-ui-1.8.23.custom.css" />
    <script type="text/javascript" src="/js/jquery-1.7.2.min.js"></script>
    <script type="text/javascript" src="/js/jquery-ui-1.8.18.custom.min.js"> </script>    
    
    <style type="text/css">
        td { font-size:1em; }
        .doubleU { text-decoration: underline; border-bottom: 1px solid blue; }
    </style>
    
    <script type="text/javascript" >
        function ie_ver(){  
            var iev=0;
            var ieold = (/MSIE (\d+\.\d+);/.test(navigator.userAgent));
            var trident = !!navigator.userAgent.match(/Trident\/7.0/);
            var rv=navigator.userAgent.indexOf("rv:11.0");

            if (ieold) iev=new Number(RegExp.$1);
            if (navigator.appVersion.indexOf("MSIE 10") != -1) iev=10;
            if (trident&&rv!=-1) iev=11;

            return iev;         
        }
        //////////////////////////////////////////////////////////////////////////////////////////////

        function export2XL() {
            var dt = new Date();
            var day = dt.getDate();
            var month = dt.getMonth() + 1;
            var year = dt.getFullYear();
            var hour = dt.getHours();
            var mins = dt.getMinutes();
            var postfix = day + "_" + month + "_" + year + "_" + hour + "h" + mins;

            if (ie_ver()!=0) {
                var thisTable = document.getElementById("printableArea").innerHTML;
                window.clipboardData.setData("Text", thisTable);
                window.location.href = 'report.xls'

            } else {
                document.getElementById('lnkExport').href = 'data:application/vnd.ms-excel,' + document.getElementById('printableArea').outerHTML.replace(/ /g, '%20');
                document.getElementById('lnkExport').download = getQuerystring('id') + postfix + ".xls"

                //javascript: window.open('data:application/x-msexcel,' + encodeURIComponent(document.getElementById('dvData').outerHTML));
            }
        }

        //////////////////////////////////////////////////////////////////////////////////////////////
        function printDiv(divName) {
            var printContents = document.getElementById(divName).innerHTML;
            var originalContents = document.body.innerHTML;

            document.body.innerHTML = printContents;
            window.print();
            document.body.innerHTML = originalContents;
        }
        //////////////////////////////////////////////////////////////////////////////////////////////

        function getQuerystring(key, default_) {
            if (default_ == null) default_ = "";
            key = key.replace(/[\[]/, "\\\[").replace(/[\]]/, "\\\]");
            var regex = new RegExp("[\\?&]" + key + "=([^&#]*)");
            var qs = regex.exec(window.location.href);
            if (qs == null)
                return default_;
            else
                return qs[1];
        }
        //////////////////////////////////////////////////////////////////////////////////////////////

        function displayInvoice() {
            var puk = $("#<%=hdnPUK.ClientID %>").val();
            var id = getQuerystring('id', '');

            $.ajax({
                type: "POST",
                url: "invoice.aspx/GetInvoiceData",
                data: "{'id': '" + id + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (invoiceData) {
                    if (document.getElementById("InvoiceData")) {
                        var vChild = document.getElementById("InvoiceData");
                        document.getElementById("Invoice").removeChild(vChild);
                    }
                    $(invoiceData.d).appendTo('#Invoice');
                    $("#InvoiceData").show();
                },
                error: function () {
                    alert("error");
                }
            });

            return true;
        }

    </script>
</head>

<body onload="displayInvoice()">
    <form id="form1" runat="server">
        <a id="dlink"  style="display:none;"></a>
        <div style="position:absolute;top:10px;left:10px;">
            <a href="#" onclick="printDiv('printableArea')" title="Print"><img src="/images/print.png"  Width="35px" /></a>
                   
            <div id="printableArea" style=" width:600px;" >
                <table border=0 width="100%" style="border-collapse:collapse;font-size:x-small;">
                    <tr>
                        <td><img src="/images/AdValorem1.png" width="40%" /></td>
                        <td colspan="2" align="right" style=" font-size:1.5em;"><asp:Label ID="lbl533" runat="server" Text="Monthly Invoice" /></td>
                    </tr>

                    <tr>
                        <td>Ad Valorem Inc.</td>
                        <td style="font-weight:bold;"><asp:Label ID="lbl244" runat="server" Text="Period" /></td>
                        <td align="right"  style=" font-size:1.1em;"><asp:Label ID="lblInvoiceDateRange" runat="server" Text=""></asp:Label></td>                        
                    </tr>
                    <tr>
                        <td><asp:Label ID="lbl535" runat="server" Text="1100 Cremazie"></asp:Label></td>
                        <td style="font-weight:bold;">Service</td>
                        <td align="right" >Advataxes</td>
                    </tr>
                    <tr>
                        <td><asp:Label ID="lbl536" runat="server" Text="Suite 708"></asp:Label></td>
                        <td style="font-weight:bold;"><asp:Label ID="lbl531" runat="server" Text="Invoice Number" /></td>
                        <td align="right" ><%=Request.QueryString("id")%></td>
                    </tr>

                    <tr>
                        <td><asp:Label ID="lbl537" runat="server" Text="Montreal"></asp:Label></td>
                        <td style="font-weight:bold;"><asp:Label ID="lbl532" runat="server" Text="Invoice Date" /></td>
                        <td align="right" ><asp:Label ID="lblInvoiceDate" runat="server" Text=""></asp:Label></td>
                    </tr>
                    <tr>
                        <td>H2P 2X2</td>
                        <td><asp:Label ID="lbl290" runat="server" Text="Organization" Font-Bold="true"></asp:Label></td>
                        <td align="right"><asp:Label ID="lblOrg" runat="server" Text=""></asp:Label></td>
                    </tr>                    
                
                    <tr style="border-bottom:solid thin #cd1e1e"><td colspan='3'></td></tr>
                    <tr><td style="font-weight:bold;"><asp:Label ID="lbl538" runat="server" Text="Bill To"></asp:Label></td></tr>
                    <tr><td><asp:Label ID="lblCompanyName" runat="server" Text="Label"></asp:Label></td></tr>
                    <tr><td><asp:Label ID="lblAddress" runat="server" Text="Label"></asp:Label></td></tr>
                    <tr><td><asp:Label ID="lblCity" runat="server" Text="Label"></asp:Label></td></tr>
                    <tr><td><asp:Label ID="lblPostal" runat="server" Text="Label"></asp:Label></td></tr>
                </table>
                <br />
                
                <div id="Invoice"><div id="InvoiceData" style=" text-align:center;"><img src="/images/busy.gif" width="20px" />&nbsp;<asp:Label ID="lbl285" runat="server" Text="Label" CssClass="labelText"></asp:Label></div></div>
            </div>
            <!--<a href="#" title="Export"  onclick="tableToExcel('dvData','test')" ><img src="/images/excel.png" width="40px" alt="Export"/></a>    <br />    -->
            <!--<input type="button" onclick="printDiv('printableArea')"  value="Print" style="width:100px;height:40px;" />-->
        </div>
        
        <asp:HiddenField ID="hdnPUK" runat="server" Value="sadasdasd" />  
    </form>
</body>
</html>
