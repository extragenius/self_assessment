// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(function() {
        
  var currentArticle;
  var newCurrentArticle;

  function showRelevantButtons(){
    if (newCurrentArticle.is('.article:first')) {
      $('#previous').hide();
    } else {
      $('#previous').show();
    }
    if (newCurrentArticle.is('.article:last')) {
      $('#next').hide();
    } else {
      $('#next').show();
    }
  }

  function changeCurrent(){
    currentArticle.removeClass('current');
    newCurrentArticle.addClass('current');          
  }

  function displayNewCurrent(){
    if (newCurrentArticle.length) {
      currentArticle.hide();
      changeCurrent();
      newCurrentArticle.show();
      showRelevantButtons();
    }          
  }

  $( "#make_bigger" ).click(function(){
    $( ".normal" ).switchClass( "normal", "expanded", 150 );        
    $('.article').hide();
    $('.current').show();
    $('.nav, #make_smaller').show();
    $('#make_bigger').hide();
    return false;
  });

  $( "#make_smaller" ).click(function(){
    $('.article').show();
    $( ".expanded" ).switchClass( "expanded", "normal", 100 );
    $('.nav, #make_smaller').hide();
    $('#make_bigger').show();
    return false;
  });  

  $( "#next" ).click(function(){
    currentArticle = $('.current');
    newCurrentArticle = currentArticle.next();
    displayNewCurrent();    
    return false;
  });     

  $( "#previous" ).click(function(){
    currentArticle = $('.current');
    newCurrentArticle = currentArticle.prev();
    displayNewCurrent();
    return false;
  });

  $('.article').click(function(){
    currentArticle = $('.current');
    newCurrentArticle = $(this);
    changeCurrent();
    showRelevantButtons();
  })
  
  $( "#calculator_dialog" ).dialog({
    autoOpen: false,
    modal: true,
    height: 700,
    width: 700,
    title: 'Calculator' 
  });
  
  $('.display_calculator').click(function() {
    $( "#calculator_dialog" ).dialog( "open" );
    return false;
  })
});
