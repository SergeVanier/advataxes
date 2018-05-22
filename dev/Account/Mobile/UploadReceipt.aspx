<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="UploadReceipt.aspx.vb" Inherits="Advataxes.UploadReceipt" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link href="../../css/style3.css" rel="stylesheet" type="text/css" />    
    <meta name="HandheldFriendly" content="True" />
    <meta name="MobileOptimized" content="320" />
    <meta name="viewport" content="width=device-width" />
    <link type="text/css" href="../../css/sunny/jquery-ui-1.8.23.custom.css" rel="stylesheet" /> 
    <script type="text/javascript" src="../../js/jquery-1.7.2.min.js"></script>
    <script type="text/javascript" src="../../js/jquery-ui-1.8.18.custom.min.js"> </script>
    <style type ="text/css">
                            .abc img{
                            width: 149px;
                            height: 100px;
                            }
                            .btnUpload {
                            width: 250px;
                            height: 72px;
                           min-width: 60%;   

    -moz-box-shadow:inset 0px 1px 0px 0px #f29c93;
	-webkit-box-shadow:inset 0px 1px 0px 0px #f29c93;
	box-shadow:inset 0px 1px 0px 0px #f29c93;
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #fe1a00), color-stop(1, #ce0100));
	background:-moz-linear-gradient(top, #fe1a00 5%, #ce0100 100%);
	background:-webkit-linear-gradient(top, #fe1a00 5%, #ce0100 100%);
	background:-o-linear-gradient(top, #fe1a00 5%, #ce0100 100%);
	background:-ms-linear-gradient(top, #fe1a00 5%, #ce0100 100%);
	background:linear-gradient(to bottom, #fe1a00 5%, #ce0100 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#fe1a00', endColorstr='#ce0100',GradientType=0);
	background-color:#fe1a00;
	-moz-border-radius:6px;
	-webkit-border-radius:6px;
	border-radius:6px;
	border:1px solid #d83526;
	display:inline-block;
	cursor:pointer;
	color:#ffffff;
	font-family:Arial;
	font-size:15px;
	font-weight:bold;
	padding:6px 24px;
	text-decoration:none;
	text-shadow:0px 1px 0px #b23e35;
     }
                            
    .btnCancel {
    width: 200px;
    height: 100px;
    min-width: 60%;                

    -moz-box-shadow:inset 0px 1px 0px 0px #f29c93;
	-webkit-box-shadow:inset 0px 1px 0px 0px #f29c93;
	box-shadow:inset 0px 1px 0px 0px #f29c93;
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #fe1a00), color-stop(1, #ce0100));
	background:-moz-linear-gradient(top, #fe1a00 5%, #ce0100 100%);
	background:-webkit-linear-gradient(top, #fe1a00 5%, #ce0100 100%);
	background:-o-linear-gradient(top, #fe1a00 5%, #ce0100 100%);
	background:-ms-linear-gradient(top, #fe1a00 5%, #ce0100 100%);
	background:linear-gradient(to bottom, #fe1a00 5%, #ce0100 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#fe1a00', endColorstr='#ce0100',GradientType=0);
	background-color:#fe1a00;
	-moz-border-radius:6px;
	-webkit-border-radius:6px;
	border-radius:6px;
	border:1px solid #d83526;
	display:inline-block;
	cursor:pointer;
	color:#ffffff;
	font-family:Arial;
	font-size:15px;
	font-weight:bold;
	padding:6px 24px;
	text-decoration:none;
	text-shadow:0px 1px 0px #b23e35;
     }

     .lbutton{
     min-width: 57%;   
     text-align: center;
    -moz-box-shadow:inset 0px 1px 0px 0px #f29c93;
	-webkit-box-shadow:inset 0px 1px 0px 0px #f29c93;
	box-shadow:inset 0px 1px 0px 0px #f29c93;
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#fe1a00', endColorstr='#ce0100',GradientType=0);
	background-color:#fe1a00;
	-moz-border-radius:6px;
	-webkit-border-radius:6px;
	border-radius:6px;
	border:1px solid #d83526;
	display:inline-block;
	cursor:pointer;
	color:#ffffff;
	font-family:Arial;
	font-size:15px;
	font-weight:bold;
	padding:6px 24px;
	text-decoration:none;
	text-shadow:0px 1px 0px #b23e35;
     }

    .fileUpload{
      display:none;                   
     

     }

    </style>
    <title></title>
    
    <script>
        $(document).ready(function () {
            
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

            if (getQuerystring('upload', '0') == '0')
                $("#msg").hide();
            else
                $("#msg").show();


            $("#<%=cmdCancel.ClientID %>").click(function () {
                //alert($("#<%=FileUpload1.ClientID %>").text());
            });

            $("#<%=FileUpload1.ClientID %>").change(function () {
                $("#txtMsg").val('File is ready. Click Upload.');
                $("#msg").show();

            });

        });       
    </script>
</head>

    <body>
      <div id="fgb" class="abc" >
        <form id="form1" runat="server">
            <table width="95%" style="border-collapse:collapse;">
                  
                <tr style=" border-bottom:medium solid #cd1e1e;"><td style=" color:#cd1e1e; font-size:1.3em;">
                    <asp:Label ID="lblUploadTitle" runat="server" Text="Upload Receipt"></asp:Label></td>
                    <td align="right"><img src="../../images/av.png" height="60px" /></td>
                </tr>

            </table>
            
            
            <div id="msg" class="ui-widget" >
		        <div class="ui-state-highlight ui-corner-all" style="margin-top:0px; padding: 0 .7em; height:25px;"> 
			        <p style="position:relative;top:-15px;"><span class="ui-icon ui-icon-info" style="float: left; margin-right: .3em;"></span>                        
                            <input id="txtMsg" value="<%=session("msg") %>" type="text" style=" border-style: none; border-color: inherit; border-width: medium; font-size:1.5em;width:914px; background-color:transparent;" /></p>                        
		        </div>
	        </div>
            

            <%Session("msg") = Nothing%>

            <div class="buttons" style="width:100%;text-align:center;">
                <br />
                <asp:FileUpload ID="FileUpload1" CssClass="fileUpload" runat="server" Height="100px" Width="600px" size="50" /><br />
                  <asp:LinkButton ID="LinkButton1" runat="server" CssClass="lbutton" Height="72px" Width="34%">Select File</asp:LinkButton><br /><br /><br /><br /><br />
                <!--  <div style=" position:relative;top:450px;">-->
                    <asp:Button ID="cmdUpload" CssClass="btnUpload" runat="server" Text="Upload"  Height="72px" style="width:50%" /><br /><br /><br /><br /><br /><br />
                    <asp:Button ID="cmdCancel" CssClass="btnCancel" runat="server" Text="Close"  Height="72px" style="position:relative;left:-4px; width:50%; top: 1px;" />
                <!--</div>-->
            </div>

        </form>
      </div>
    </body>
</html>
