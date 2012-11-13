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
  $( "#tabs span.ui-icon-close" ).live( "click", function() {
      var panelId = $( this ).closest( "li" ).remove().attr( "aria-controls" );
      $( "#" + panelId ).remove();
      tabs.tabs( "refresh" );
  });
}
