  
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
}
