<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ExpenseReport.aspx.vb" Inherits="WebApplication1.Report1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">




<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Report</title>
    <link type="text/css" href="../../css/sunny/jquery-ui-1.8.23.custom.css" rel="stylesheet" />
    <script type="text/javascript" src="../../js/jquery-1.7.2.min.js"></script>
    <script type="text/javascript" src="../../js/jquery-ui-1.8.18.custom.min.js"> </script>
    <link href="../css/style3.css" rel="stylesheet" type="text/css" />

    <style type="text/css">
        td  
        {
             font-size:0.9em;
             font-family: Calibri; 
        }      
    </style>

    <script type="text/javascript" >
        function export2XL() {

            //window.attachEvent is only supported in IE so if it fails, we're not using IE
            if (window.attachEvent) {
                var thisTable = document.getElementById("dvData").innerHTML;
                window.clipboardData.setData("Text", thisTable);
                window.location.href = 'report.xls'
                //alert('Data has been copied. You can now do a paste in Excel');
                //var objExcel = new ActiveXObject("Excel.Application");
                //objExcel.visible = true;
                //var objWorkbook = objExcel.Workbooks.Add;
                //var objWorksheet = objWorkbook.Worksheets(1);
                //objWorksheet.Paste;               
            } else {
                javascript: window.open('data:application/vnd.ms-excel,' + encodeURIComponent(document.getElementById('dvData').outerHTML));
            }
        }
           
        $(document).ready(function () {
            $(".export").mousedown(function () {
                var id = $(this).attr("id");
                window.open("expensereport.aspx?id=" + id + "&action=export", "export", "width=1000,height=600,toolbar=yes,scrollbars=yes");
            });
            
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
        <div style="position:absolute;top:10px;left:10px;">
            <a href="#" onclick="printDiv('printableArea')" title="Print"><img src="../images/print.png" /></a>
        
            &nbsp;&nbsp;&nbsp;&nbsp;<asp:ImageButton ID="cmdExportExcel" runat="server" ImageUrl="../images/excel.png" Width="40px"  style="display:none;" />
            <a id="lnkExport" href="#" title="Export" onclick="export2XL();" ><img id="imgExport" src="../images/excel.png" width="40px" alt="Export"/></a>
            <!--<a href="#" title="Export"  onclick="tableToExcel('dvData','test')" ><img src="../images/excel.png" width="40px" alt="Export"/></a>    <br />    -->
        
            <!--<input type="button" onclick="printDiv('printableArea')"  value="Print" style="width:100px;height:40px;" />-->
        </div>
    
    </form>
</body>
</html>
