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

  
  // Changes tab behaviour so that link leads to external page rather than updating page content
  $("li.link_to_external a").unbind('click');
}

function tellServerTabClosed(panelId) {
  var idClosed = panelId.replace(/\D+/g, '');
  $.post('rule_sets/' + idClosed + '/hide_tab');
}

function closeTabActions() {
  // close icon: removing the tab on click
  $( "#tabs span.ui-icon-close" ).click(function() {
      var panelId = $( this ).closest( "li" ).remove().attr( "aria-controls" );
      $( "#" + panelId ).remove();
      tellServerTabClosed(panelId);
  });

}

$(function(){
  $(".tooltip").tipTip({defaultPosition:'right'});
  
});
