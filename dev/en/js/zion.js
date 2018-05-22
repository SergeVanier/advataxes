$(document).ready(function() {
  $('#navbar').affix();
  $('.dropdown-toggle').dropdown();
  $('[data-toggle=tooltip]').tooltip();
  function parallax(){
    var scrolled = $(window).scrollTop();
    if(scrolled >= 0) {
      $('.container-wrapper-home .summary').css('top', (scrolled * 0.5) + 'px');
      var opacity = scrolled / 100;
      var opacity = opacity / 2;
      $('.container-wrapper-home .summary').css('opacity', 1 - opacity);
    }
  }
  var x = $(window).width();
  if(x > 767) {
    $(window).scroll(function(e){
      parallax();
    });
  }
  
var urlSite = $(location).attr('hostname');
urlSite = 'https://' + urlSite + '/';
var url_array=window.location.pathname.split("/");
var url_page = url_array[url_array.length-1];
var url_lang = url_array[url_array.length-2];

if ( url_lang == 'en' ) {
  url_lang = 'fr';
       if  ( url_page == "accounting-and-management.aspx" ) { $(".language").attr("href", urlSite + url_lang + "/comptabilite-et-gestion.aspx"); }
  else if  ( url_page == "coming-soon.aspx" ) { $(".language").attr("href", urlSite + url_lang + "/a-venir.aspx"); }
  else if  ( url_page == "contact.aspx" ) { $(".language").attr("href", urlSite + url_lang + "/nous-contacter.aspx"); }
  else if  ( url_page == "demo.aspx" ) { $(".language").attr("href", urlSite + url_lang + "/demo.aspx"); }
  else if  ( url_page == "free-travel-expense-software.aspx" ) { $(".language").attr("href", urlSite + url_lang + "/logiciel-depense-de-voyage-gratuit.aspx"); }
  else if  ( url_page == "get-one-month-free.aspx" ) { $(".language").attr("href", urlSite + url_lang + "/obtenez-un-mois-gratuit.aspx"); }
  else if  ( url_page == "live-demo.aspx" ) { $(".language").attr("href", urlSite + url_lang + "/demonstration.aspx"); }
  else if  ( url_page == "parameters.aspx" ) { $(".language").attr("href", urlSite + url_lang + "/parametres.aspx"); }
  else if  ( url_page == "order-free-employee-expense-software.aspx" ) { $(".language").attr("href", urlSite + url_lang + "/commander-gratuit-logiciel-rapport-depense.aspx"); }
  else if  ( url_page == "order-large-business.aspx" ) { $(".language").attr("href", urlSite + url_lang + "/commander-grande-entreprise.aspx"); }
  else if  ( url_page == "order-small-medium-business.aspx" ) { $(".language").attr("href", urlSite + url_lang + "/commander-petite-moyenne-entreprise.aspx"); }
  else if  ( url_page == "parameters.aspx" ) { $(".language").attr("href", urlSite + url_lang + "/parametres.aspx"); }
  else if  ( url_page == "privacy-policy.aspx" ) { $(".language").attr("href", urlSite + url_lang + "/politique-de-confidentialite.aspx"); }
  else if  ( url_page == "productivity.aspx" ) { $(".language").attr("href", urlSite + url_lang + "/productivite.aspx"); }
  else if  ( url_page == "requirements.aspx" ) { $(".language").attr("href", urlSite + url_lang + "/exigences.aspx"); }
  else if  ( url_page == "simulation.aspx" ) { $(".language").attr("href", urlSite + url_lang + "/simulation.aspx"); }
  else if  ( url_page == "tax-calculator-for-travel-expenses.aspx" ) { $(".language").attr("href", urlSite + url_lang + "/calculatrice-des-taxes-depenses-voyages.aspx"); }
  else if  ( url_page == "terms-of-use.aspx" ) { $(".language").attr("href", urlSite + url_lang + "/conditions-utilisation.aspx"); }
  else     {   $(".language").attr("href", urlSite + "fr/index.aspx");
  }
}
else if ( url_lang == 'fr' ) {
  url_lang = 'en';
       if  ( url_page == "a-venir.aspx" ) { $(".language").attr("href", urlSite + url_lang + "/coming-soon.aspx"); }
  else if  ( url_page == "calculatrice-des-taxes-depenses-voyages.aspx" ) { $(".language").attr("href", urlSite + url_lang + "/tax-calculator-for-travel-expenses.aspx"); }
  else if  ( url_page == "commander-grande-entreprise.aspx" ) { $(".language").attr("href", urlSite + url_lang + "/order-large-business.aspx"); }
  else if  ( url_page == "commander-gratuit-logiciel-rapport-depense.aspx" ) { $(".language").attr("href", urlSite + url_lang + "/order-free-employee-expense-software.aspx"); }
  else if  ( url_page == "commander-petite-moyenne-entreprise.aspx" ) { $(".language").attr("href", urlSite + url_lang + "/order-small-medium-business.aspx"); }
  else if  ( url_page == "comptabilite-et-gestion.aspx" ) { $(".language").attr("href", urlSite + url_lang + "/accounting-and-management.aspx"); }
  else if  ( url_page == "conditions-utilisation.aspx" ) { $(".language").attr("href", urlSite + url_lang + "/terms-of-use.aspx"); }
  else if  ( url_page == "demo.aspx" ) { $(".language").attr("href", urlSite + url_lang + "/demo.aspx"); }
  else if  ( url_page == "demonstration.aspx" ) { $(".language").attr("href", urlSite + url_lang + "/live-demo.aspx"); }
  else if  ( url_page == "exigences.aspx" ) { $(".language").attr("href", urlSite + url_lang + "/requirements.aspx"); }
  else if  ( url_page == "logiciel-depense-de-voyage-gratuit.aspx" ) { $(".language").attr("href", urlSite + url_lang + "/free-travel-expense-software.aspx"); }
  else if  ( url_page == "nous-contacter.aspx" ) { $(".language").attr("href", urlSite + url_lang + "/contact.aspx"); }
  else if  ( url_page == "obtenez-un-mois-gratuit.aspx" ) { $(".language").attr("href", urlSite + url_lang + "/get-one-month-free.aspx"); }
  else if  ( url_page == "parametres.aspx" ) { $(".language").attr("href", urlSite + url_lang + "/parameters.aspx"); }
  else if  ( url_page == "politique-de-confidentialite.aspx" ) { $(".language").attr("href", urlSite + url_lang + "/privacy-policy.aspx"); }
  else if  ( url_page == "productivite.aspx" ) { $(".language").attr("href", urlSite + url_lang + "/productivity.aspx"); }
  else if  ( url_page == "simulation.aspx" ) { $(".language").attr("href", urlSite + url_lang + "/simulation.aspx"); }
  else     { $(".language").attr("href", urlSite); }
}
else {
  $(".language").attr("href", urlSite + "fr/index.aspx");
}


});
