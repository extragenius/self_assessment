// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(function() {

  $('.warning .close').click(function() {
    $(this).closest('.warning').hide();
  });

  $('.warning .hide_options').click(function() {
    send_data_to_server($(this).attr('href'));
    $(this).closest('.options').hide('fade');
    $('.hide_at_start').show('fade');
    return false;
  });

  function send_data_to_server(url) {
    $.ajax({
      type: "PUT",
      url: url,

      success: function (data) {
        // console.log(data);
      },
      error: function () {
        // console.log('Error updating');
      }
    })
  }

})
