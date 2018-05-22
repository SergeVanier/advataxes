<%@ Page Language="VB" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Sales Tax Parameters | Advataxes</title>
    <meta name="description" content="">
	<!-- #include file="/en/inc/header-html.inc" -->

  <body>
  
 	<!-- #include file="/en/inc/header-menu.inc" -->	
	
    <div class="clear"></div>

    <div class="container-wrapper container-top">
      <div class="container container-top">
        <div class="row">
          <div class="col-md-12 center">
            <h1>Sales Tax Parameters</h1>
          </div>
        </div><!-- end row -->
      </div><!-- end container -->
    </div><!-- end container wrapper -->

	
    <div class="container">

<div class="row">
<div class="col-md-12">
<div class="tile tile-horizontal">
	<span class="fa fa-group pull-left"></span>
	<div class="tile-details">
		<h2>GST registrant and/or QST registrant</h2>
		<p>Whether your organisation is solely a GST registrant or both a GST and a QST registrant, our software will apply the tax calculation once you select the GST/HST/QST profile applicable to your case. Input Tax Credit (ITC), which is the GST and the HST claimable on your purchases, and Input Tax Refunds (ITR), which is the QST claimable on your purchases, will be calculated accordingly.</p>
	</div>
</div>
</div>
</div>

<div class="row">
<div class="col-md-12">
<h2>Large business - GST/QST purposes</h2>
<p>Organizations that are large businesses for GST purposes are subject to recapture of input tax credits on some specified properties and services in <b>Ontario</b>, and in the <b>Prince Edward Island</b>. Generally, a large business refers to those making taxable supplies worth more than $10 million annually. As the case may be, taxable supplies made by associated person have to be included in determining the $10 million threshold amount.</p>

<p>For more details, see:</p>
<ul class="notopmargin">
<li><a href="http://www.cra-arc.gc.ca/E/pub/gm/b-104/README.html">Technical Information Bulletin (TIB B-104): Harmonized Sales Tax - Temporary Recapture of Input Tax Credits in Ontario and British Columbia</a></li>
<li><a href="http://www.taxandland.pe.ca/index.php3?number=1046728&lang=E">RTG: 186 Temporary Recapture of Certain Provincial Input Tax Credits</a>.</li>
</ul>

<p>Our software has preconfigured these categories of expenses in order to calculate the recapture of input tax credit applicable to the provincial component of the HST in Ontario, and in Prince Edward Island. These amounts are calculated and provided separately, as it is required for compliance purposes, under the current online GST reporting process.</p>

<p>Generally speaking, the specified property and services in Ontario described within TIB 104 are:</p>
<ol>
  <li>Meals and entertainment subject to the 50% limitation under the <i>Income Tax Act</i></li>
  <li>Motor vehicles weighing less than 3,000 kilograms</li>
  <li>Motive fuel (other than diesel fuel) for used in motor vehicles</li>
  <li>Telecommunication services, excluding internet access, web site hosting and toll-free telephone services</li>
  <li>Energy not used directly in the production of goods for sale</li>
</ol>
<br />

<p>The recaptures rates on Input tax credits in <b>Ontario</b> are as follows:</p>
<ul class="notopmargin">
<li>July 1<sup>st</sup>, 2010 to June 30 2015: 100%</li>
<li>July 1<sup>st</sup>, 2015 to June 30 2016: 75%</li>
<li>July 1<sup>st</sup>, 2016 to June 30 2017: 50%</li>
<li>July 1<sup>st</sup>, 2017 to June 30 2018: 25%</li>
<li>July 1<sup>st</sup>, 2018 and after: none</li>
</ul>

<p>The recaptures rates on Input tax credits in <b>Prince Edward Island</b> are as follows:</p>
<ul class="notopmargin">
<li>April 1<sup>st</sup>, 2013 to March 31, 2018: 100%</li>
<li>April 1<sup>st</sup>, 2018 to March 31, 2019: 75%</li>
<li>April 1<sup>st</sup>, 2019 to March 31, 2020: 50%</li>
<li>April 1<sup>st</sup>, 2020 to March 31, 2021: 25%</li>
<li>April 1<sup>st</sup>, 2021 & after: 0%</li>
</ul>

<p>Finally under the <b>QST regime</b> there will be a phasing out of the restricted ITR starting on January 1, 2018. The manner to manage the tax 
recovery differs from the HST in Ontario and Prince Edward Island, since registrants will simply have to claim more taxes according to the 
following rates:</p>
<ul class="notopmargin">
<li>January 1<sup>st</sup>, 2018 to 31 December 31, 2018: 25%</li>
<li>January 1<sup>st</sup>, 2019 to 31 December 31, 2019: 50%</li>
<li>January 1<sup>st</sup>, 2020 to 31 December 31, 2020: 75%</li>
<li>January 1<sup>st</sup>, 2011 & after: 100%</li>
</ul>

<p>Generally speaking for other provinces, the recovery of inputs is done fully as well as the GST in Québec.</p>

<p>Advataxes is not asking your employees to select tax codes but simply to select a transaction date, an expense category and the province. The accounting posting is done automatically.</p>


</div>
</div>


<div class="row">
<div class="col-md-12">
<h2>Small/medium business - GST/QST purposes</h2>
<p>Organisations that are small and medium businesses for GST and/or QST purposes are governed by a different set of rules from large businesses. These organizations are not covered by the recapture of input tax credits under the GST regime or by the restricted input under the QST regime. The setting functionalities have integrated this GST/HST and QST specificity for you to choose from.</p>
</div>
</div>


<div class="row">
	<div class="col-md-5">
	<h2>GST/QST ratios of commercial activities</h2>
	<p>Organizations that are engaged in both commercial and exempt activities have to apportion their input tax according to their ratio of commercial activities. Again, simply pick the ratio of commercial activities in the setting that is applicable to your employee expenses under the GST regime and under the QST regime in order that these ratios are taken into account in the calculation of input tax claimable and remittable.</p>
	</div>

	<div class="col-md-5 col-md-offset-2">
	<h2>Financial institutions for GST and/or QST purposes</h2>
	<p>Financial institutions under the GST regime are governed by a specific set of rules with respect to apportionment of ITCs; the input tax to claim equals the ratio of commercial activities. It is this particular rule applicable to financial institutions that is automated. Also, with the harmonisation of the QST regime with the GST since January 1, 2013 with respect to financial institutions, the same is applicable for QST purposes.</p>
	</div>
</div>


</div><!-- end container -->
    
    <div class="clear"></div>
      
	<!-- #include file="/en/inc/footer.inc" -->
    
	<script src="/en/js/jquery-1.9.0-min.js"></script>
    <script src="/en/js/bootstrap.js"></script>
    <script src="/en/js/zion.js"></script>
	
    <script type="text/javascript">
    </script>

  </body>
</html>
