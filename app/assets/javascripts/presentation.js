$(function(){
  var showText = 'Show information';
  var hideText = 'Hide information';
  var buttonClass = 'desc_hide_show';
  var lastAction = 'lastPresentationDesc';
  var nextAction = 'nextPresentationDesc';

  $('.presentation h2').before( '<button class="'+ buttonClass + ' btn btn-info">' + showText + '</button>');
  
  function showPresentationDesc(action) {
    var presentation = $('.presentation');
    var description = presentation.find('.description');
    var button = presentation.find("." + buttonClass);
    var speed = 400;

    if (action === 'hide') {
      description.hide(speed);
      button.html(showText);
      $.cookie(nextAction, 'show', {path: '/'});
      $.cookie(lastAction, 'hide', {path: '/'});
    }
    else {
      description.show(speed);
      button.html(hideText);
      $.cookie(nextAction, 'hide', {path: '/'});
      $.cookie(lastAction, 'show', {path: '/'});
    }

    console.log('This action = ' + action);
    console.log('Last action = ' + $.cookie(lastAction));
    console.log('Next action = ' + $.cookie(nextAction));
  }
  
  $('.presentation .' + buttonClass).click(function() {
    showPresentationDesc($.cookie(nextAction));
  });

  showPresentationDesc($.cookie(lastAction));
});


