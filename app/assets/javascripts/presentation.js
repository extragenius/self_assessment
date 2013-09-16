$(function(){
  var showText = 'Show information';
  var hideText = 'Hide information';
  var buttonClass = 'desc_hide_show';
  var startHeight = '0';
  var endHeight = $('.presentation .description').height();
  $('.presentation .description').css({height:startHeight, overflow:'hidden'});
  $('.presentation h2').before( '<button class="'+ buttonClass + ' btn btn-info">' + showText + '</botton>');
  $('.presentation .' + buttonClass).click(function() {
      $this = $(this);
      if ($this.data('open')) {
          $this.parent().find('.description').animate({height:startHeight});
          $this.data('open', 0);
          $this.html(showText);
      }
      else {
          $this.parent().find('.description').animate({height:endHeight});
          $this.data('open', 1);
          $this.html(hideText);
      }
  });
});


