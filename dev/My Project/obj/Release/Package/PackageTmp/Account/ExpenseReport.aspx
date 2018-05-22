<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ExpenseReport.aspx.vb" Inherits="Advataxes.Report1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">


<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Report</title>
    <link type="text/css" href="../../css/sunny/jquery-ui-1.8.23.custom.css" rel="stylesheet" />
    <script type="text/javascript" src="../../js/jquery-1.7.2.min.js"></script>
    <script type="text/javascript" src="../../js/jquery-ui-1.8.18.custom.min.js"> </script>
    <script type="text/javascript" src="../../js/backbone.js"> </script>
    <script type="text/javascript" src="../../js/tourist.min.js"> </script>
    <link href="../css/style3.css" rel="stylesheet" type="text/css" />
    <link href="../css/tourist.css" rel="stylesheet" type="text/css" />
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />

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

        function export2XL() {
            var dt = new Date();
            var day = dt.getDate();
            var month = dt.getMonth() + 1;
            var year = dt.getFullYear();
            var hour = dt.getHours();
            var mins = dt.getMinutes();
            var postfix = day + "_" + month + "_" + year + "_" + hour + "h" + mins;
            var html;

            if (ie_ver()!=0) {
                var thisTable = document.getElementById("dvData").innerHTML;
                window.clipboardData.setData("Text", thisTable);
                window.location.href = 'report.xls'

            } else {
                //html = document.getElementById('dvData').outerHTML.replace(/ /g, '%20');
                //'data:application/vnd.ms-excel;base64,' + $.base64.encode(html);
                html = document.getElementById('dvData').outerHTML;
                html = html.replace(/●/g, '&bull;');
                html = html.replace(/◊/g, '&loz;');
                html = html.replace(/♦/g, '&diams;');
                document.getElementById('lnkExport').href = 'data:application/vnd.ms-excel;charset=UTF-8,' + escape(html);
                document.getElementById('lnkExport').download = $("#<%=hdnRptName.ClientID %>").val() + postfix + ".xls"
            }
        }
        
        $(document).ready(function () {
            //"use strict"; jQuery.base64 = (function ($) { var _PADCHAR = "=", _ALPHA = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/", _VERSION = "1.0"; function _getbyte64(s, i) { var idx = _ALPHA.indexOf(s.charAt(i)); if (idx === -1) { throw "Cannot decode base64" } return idx } function _decode(s) { var pads = 0, i, b10, imax = s.length, x = []; s = String(s); if (imax === 0) { return s } if (imax % 4 !== 0) { throw "Cannot decode base64" } if (s.charAt(imax - 1) === _PADCHAR) { pads = 1; if (s.charAt(imax - 2) === _PADCHAR) { pads = 2 } imax -= 4 } for (i = 0; i < imax; i += 4) { b10 = (_getbyte64(s, i) << 18) | (_getbyte64(s, i + 1) << 12) | (_getbyte64(s, i + 2) << 6) | _getbyte64(s, i + 3); x.push(String.fromCharCode(b10 >> 16, (b10 >> 8) & 255, b10 & 255)) } switch (pads) { case 1: b10 = (_getbyte64(s, i) << 18) | (_getbyte64(s, i + 1) << 12) | (_getbyte64(s, i + 2) << 6); x.push(String.fromCharCode(b10 >> 16, (b10 >> 8) & 255)); break; case 2: b10 = (_getbyte64(s, i) << 18) | (_getbyte64(s, i + 1) << 12); x.push(String.fromCharCode(b10 >> 16)); break } return x.join("") } function _getbyte(s, i) { var x = s.charCodeAt(i); if (x > 255) { throw "INVALID_CHARACTER_ERR: DOM Exception 5" } return x } function _encode(s) { if (arguments.length !== 1) { throw "SyntaxError: exactly one argument required" } s = String(s); var i, b10, x = [], imax = s.length - s.length % 3; if (s.length === 0) { return s } for (i = 0; i < imax; i += 3) { b10 = (_getbyte(s, i) << 16) | (_getbyte(s, i + 1) << 8) | _getbyte(s, i + 2); x.push(_ALPHA.charAt(b10 >> 18)); x.push(_ALPHA.charAt((b10 >> 12) & 63)); x.push(_ALPHA.charAt((b10 >> 6) & 63)); x.push(_ALPHA.charAt(b10 & 63)) } switch (s.length - imax) { case 1: b10 = _getbyte(s, i) << 16; x.push(_ALPHA.charAt(b10 >> 18) + _ALPHA.charAt((b10 >> 12) & 63) + _PADCHAR + _PADCHAR); break; case 2: b10 = (_getbyte(s, i) << 16) | (_getbyte(s, i + 1) << 8); x.push(_ALPHA.charAt(b10 >> 18) + _ALPHA.charAt((b10 >> 12) & 63) + _ALPHA.charAt((b10 >> 6) & 63) + _PADCHAR); break } return x.join("") } return { decode: _decode, encode: _encode, VERSION: _VERSION} } (jQuery));
            $(".viewReceipt").mousedown(function () {
                var id = $(this).attr("id");
                window.open("Receipt.aspx?id=" + id, "Receipt", "width=1000,height=600,toolbar=yes,scrollbars=yes");
            });
        });

        function printDiv(divName) {
            var printContents = document.getElementById(divName).innerHTML;
            var originalContents = document.body.innerHTML;

            document.body.innerHTML = printContents;
            window.print();
            document.body.innerHTML = originalContents;
        }
    
    </script>

</head>
<body>


    <form id="form1" runat="server">
        <a id="dlink"  style="display:none;"></a>
        <div style="position:absolute;top:10px;left:10px;">
            <a href="#" onclick="printDiv('printableArea')" title="Print"><img src="../images/print.png"  Width="35px" /></a>
        
            &nbsp;&nbsp;&nbsp;&nbsp;<asp:ImageButton ID="cmdExportExcel" runat="server" ImageUrl="../images/excel.png" Width="30px"  style="display:none;" />
            <a id="lnkExport2" href="#" title="Export" onclick="export2XL();" style="display:none;" ><img id="imgExport" src="../images/excel.png" width="35px" alt="Export"/></a>            
            <a id="lnkExport" href="#" title="Export" onclick="export2XL();"><img id="img1" src="../images/excel.png" width="35px" alt="Export" style="cursor:pointer;"/></a>
            
            &nbsp;&nbsp;&nbsp;&nbsp;<asp:ImageButton ID="cmdCSV" runat="server" ImageUrl="../images/csv.png" Width="40px" Visible="true" tooltip="Download comma separated values. This data will be marked as downloaded in the Download Manager." />            
            <asp:Image ID="imgCSV" ImageUrl="../images/csv2.png" Width="40px" visible="false" ToolTip="This data has already been downloaded. Go to Download Manager and clear the Downloaded checkbox(es) to download again." runat="server" />
            &nbsp;&nbsp;&nbsp;&nbsp;<!--<asp:ImageButton ID="cmdTSV" runat="server"  Visible="true" ImageUrl="../images/tsv.png" Width="40px" tooltip="Download tab separated values. This data will be marked as downloaded in the Download Manager." />            
            <asp:Image ID="imgTSV" ImageUrl="../images/tsv2.png" Width="40px"  visible="false" ToolTip="This data has already been downloaded. Go to Download Manager and clear the Downloaded checkbox(es) to download again." runat="server" />
            <!--<a href="#" title="Export"  onclick="tableToExcel('dvData','test')" ><img src="../images/excel.png" width="40px" alt="Export"/></a>    <br />    -->
            <!--<input type="button" onclick="printDiv('printableArea')"  value="Print" style="width:100px;height:40px;" />-->
        </div>
        <asp:HiddenField ID="hdnRptName" runat="server" />
    </form>
</body>
</html>
