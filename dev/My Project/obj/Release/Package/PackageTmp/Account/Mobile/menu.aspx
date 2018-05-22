<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="menu.aspx.vb" Inherits="Advataxes.menu" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
        <meta name="HandheldFriendly" content="True" />
        <meta name="MobileOptimized" content="320" />
        <meta name="viewport" content="width=device-width" />
    <title></title>
    <!--
<script type = "text/javascript" >
    function preventBack() {
        window.history.forward();
    }
    setTimeout("preventBack()", 0);
    window.onunload = function () { null };
</script>
        -->

</head>
<body>
    <form id="form1" runat="server">
    <div style="position:relative;left:50%;text-align:center;width:250px;margin-left: -125px;">
        <table width="100%" style=" text-align:center;border:thin solid #cd1e1e; height:200px;">
            <tr><td><img src="../../images/logo-advataxes-en-indirect-280x73.png" width="175px" /></td></tr>
            <!--<tr><td valign="top"><asp:Button ID="cmdMyExpenses" runat="server" Text="My Expenses" Height="60px" Width="100%" /></td></tr>-->
            <tr style="height:20px"><td></td></tr>
            <tr><td valign="top"><a href="mreports.aspx"><img src="../../images/myexpenses.png" /></a> </td></tr>
            <!--<tr><td valign="top"><a href="addExpense.aspx"><img src="../../images/addExpense.png" /></a></td></tr>-->
            <tr><td valign="top"><a href="uploadreceipt.aspx"><img src="../../images/uploadreceipt.png" /></a></td></tr>
            <tr><td valign="top"><asp:ImageButton ID="cmdLogout" ImageUrl="../../images/logout.png" runat="server" /></td></tr>
            <!--<tr><td valign="top"><asp:Button ID="cmdUploadReceipt" runat="server" Text="Upload Receipt"  Height="60px" Width="100%" /></td></tr>-->
            <tr style="height:20px"><td></td></tr>
        </table>
    </div>
    </form>
</body>
<script>
    $(document).ready(function () {
        function disableBack() { window.history.forward() }
        window.onload = disableBack();
        window.onpageshow = function (evt) { if (evt.persisted) disableBack() }
    });
</script>
</html>
