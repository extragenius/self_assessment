function showAsTabs(element) {
  $(element).tabs({
    beforeLoad: function( event, ui) {
      ui.jqXHR.error(function() {
        ui.panel.html(
          "Could not open this tab"
        );
      });
    }
  });
  
  // close icon: removing the tab on click
  $( "#tabs span.ui-icon-close" ).click(function() {
      var panelId = $( this ).closest( "li" ).remove().attr( "aria-controls" );
      $( "#" + panelId ).remove();
  });
  
  // Changes tab behaviour so that link leads to external page rather than updating page content
  $("li.link_to_external a").unbind('click');
}

$(function(){
  $(".tooltip").tipTip({defaultPosition:'right'});
  
});
