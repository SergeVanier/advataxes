<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Requirements | Advataxes</title>
	<meta name="description" content="Requirements of the Advataxes software" />
   
	<!-- #include file="/en/inc/header-html.inc" -->

  <body>
  
 	<!-- #include file="/en/inc/header-menu.inc" -->	
	
    <div class="clear"></div>

    <div class="container-wrapper container-top">
      <div class="container container-top">
        <div class="row">
          <div class="col-md-12 center">
            <h1>Requirements</h1>
          </div>
        </div><!-- end row -->
      </div><!-- end container -->
    </div><!-- end container wrapper -->
	

<div class="container">

<div class="row">
<div class="col-md-12">
<p>These are the requirements for the Advataxes software.</p>

<table class="table table-striped table-hover tableRequirements">
<thead>
<tr>
	<th colspan="2">Browser Settings</th>
</tr>
</thead>
<tbody>
<tr>
	<td>JavaScript</td>
	<td>
		<noscript><img src="/en/images/symbol-error.png" alt="error" /> Error, please enable JavaScript.</noscript>
		<span class="requirement_javascript" style="display:none;"><img src="/en/images/symbol-check.png" alt="success" /> Success, it is enabled.</span>
	</td>
</tr>
<tr>
	<td>Cookies</td>
	<td>
		<noscript><img src="/en/images/symbol-question.png" alt="question" /> Unknown, please allow JavaScript first.</noscript>
		<span class="requirement_cookie_ok" style="display:none;"><img src="/en/images/symbol-check.png" alt="success" /> Success, it is enabled.</span>
		<span class="requirement_cookie_error" style="display:none;"><img src="/en/images/symbol-error.png" alt="success" /> Error, you must enable Cookies.</span>
	</td>
</tr>
<tr>
	<td>Window pop-up</td>
	<td>
		<noscript><img src="/en/images/symbol-question.png" alt="question" /> Unknown, please allow JavaScript first.</noscript>
		<span class="requirement_popup_ok" style="display:none;"><img src="/en/images/symbol-check.png" alt="success" /> Success, it is enabled.</span>
		<span class="requirement_popup_error" style="display:none;"><img src="/en/images/symbol-error.png" alt="success" /> Error, you must allow Window pop-up.</span>
	</td>
</tr>
</tbody>
</table>
</div></div>

<div class="row allowPopup" style="display:none;">
<div class="col-md-12">
	<p><strong>How to allow window pop-up</strong></p>
	<div id="accordion" class="panel-group">

            <div class="panel panel-default">
              <div class="panel-heading">
                <a href="#collapseTwo" data-parent="#accordion" data-toggle="collapse" class="panel-toggle collapsed">> Edge</a>
              </div><!-- end panel-heading -->
              <div class="panel-collapse collapse" id="collapseTwo" style="height: auto;">
                <div class="panel-body"><p>Click the button "Always allow" at the bottom.</p><img src="/en/images/popup-edge.png"></div>
              </div><!-- end panel-collapse -->
            </div><!-- end panel -->

            <div class="panel panel-default">
              <div class="panel-heading">
                <a href="#collapseThree" data-parent="#accordion" data-toggle="collapse" class="panel-toggle collapsed">> Firefox</a>
              </div><!-- end panel-heading -->
              <div class="panel-collapse collapse" id="collapseThree">
                <div class="panel-body"><p>Click the Options button at the top-right and select "Allow pop-ups".</p><img src="/en/images/popup-firefox.png"></div>
              </div><!-- end panel-collapse -->
            </div><!-- end panel -->

           <div class="panel panel-default">
              <div class="panel-heading">
                <a href="#collapseFour" data-parent="#accordion" data-toggle="collapse" class="panel-toggle collapsed">> Internet Explorer</a>
              </div><!-- end panel-heading -->
              <div class="panel-collapse collapse" id="collapseFour" style="height: auto;">
                <div class="panel-body"><p>Click the button Options at the bottom and select "Always Allow".</p><img src="/en/images/popup-internet-explorer.png"></div>
              </div><!-- end panel-collapse -->
            </div><!-- end panel -->

	</div><!-- end panel-group -->
</div></div>


<div class="row">
<div class="col-md-12">
<table class="table table-striped table-hover tableRequirements">
<thead>
<tr>
	<th>Browser</th>
	<th>Version</th>
	<th class="tableCenter">Compatibility</th>
</tr>
</thead>
<tbody>
<tr>
	<td>Chrome</td>
	<td>10 or higher</td>
	<td class="tableCenter"><span class="tableCheck">&#x2713;</span></td>
</tr>
<tr>
	<td>Edge</td>
	<td>20 or higher</td>
	<td class="tableCenter"><span class="tableCheck">&#x2713;</span></td>
</tr>
<tr>
	<td>Firefox</td>
	<td>4 or higher</td>
	<td class="tableCenter"><span class="tableCheck">&#x2713;</span></td>
</tr>
<tr>
	<td>Internet Explorer</td>
	<td>9 or higher</td>
	<td class="tableCenter"><span class="tableCheck">&#x2713;</span></td>
</tr>
<tr>
	<td>Safari</td>
	<td>5 or higher</td>
	<td class="tableCenter"><span class="tableCheck">&#x2713;</span></td>
</tr>
<tr>
	<th>Mobile</th>
	<th>Version</th>
	<th class="tableCenter">Compatibility</th>
</tr>

</thead>
<tbody>
<tr>
	<td>Android</td>
	<td>2.1 or higher</td>
	<td class="tableCenter"><span class="tableCheck">&#x2713;</span></td>
</tr>
<tr>
	<td>iPhone and iPad</td>
	<td>iOS 3 or higher</td>
	<td class="tableCenter"><span class="tableCheck">&#x2713;</span></td>
</tr>
</tbody>
</table>

<p>Note that the mobile version has limited functionality such as uploading receipts, adding expenses and submitting your report.</p>
</div></div>


</div><!-- end container -->
        
    <div class="clear"></div>
      
	<!-- #include file="/en/inc/footer.inc" -->
    
	<script src="/en/js/jquery-1.9.0-min.js"></script>
    <script src="/en/js/bootstrap.js"></script>
    <script src="/en/js/zion.js"></script>
	
    <script type="text/javascript">
		$(document).ready(function() { 
			//test javascript
			$('.requirement_javascript').css("display","block");

			//test cookie
			var cookieEnabled = (navigator.cookieEnabled) ? true : false;

			if (typeof navigator.cookieEnabled == "undefined" && !cookieEnabled) { 
				document.cookie="testcookie";
				cookieEnabled = (document.cookie.indexOf("testcookie") != -1) ? true : false;
			}

			if ( cookieEnabled ) {
			$('.requirement_javascript').css("display","block");
				$('.requirement_cookie_ok').css("display","block");
			}
			else {
				$('.requirement_cookie_error').css("display","block");
			}

			//test window popup
			var windowName = 'userConsole'; 
			var isChrome = /Chrome/.test(navigator.userAgent) && /Google Inc/.test(navigator.vendor);
			if ( !isChrome ) {
				var popUp = window.open('/en/blank.html', windowName, 'width=200, height=200, left=200, top=200, scrollbars, resizable');
			}
			
			if ( isChrome ) {
				$('.requirement_popup_ok').css("display","block");
			}
			else if ( popUp == null || typeof(popUp)=='undefined' ) { 	
				$('.allowPopup').css("display","block");
				$('.requirement_popup_error').css("display","block");
			} 
			else { 	
				popUp.close();
				$('.requirement_popup_ok').css("display","block");
			}
		});
    </script>

  </body>
</html>
