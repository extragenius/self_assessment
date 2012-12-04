// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(function() {

  $('.warning .close').click(function() {
    $(this).closest('.warning').hide();
  });

  $('.warning .hide_options').click(function() {
    $(this).closest('.options').hide('fade');
    $('.hide_at_start').show('fade');
  });

})
