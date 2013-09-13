/*
 * Based on original code from:
 * 
 * jQuery jFontSize Plugin
 * Examples and documentation: http://jfontsize.com
 * Author: Frederico Soares Vanelli
 *         fredsvanelli@gmail.com
 *         http://twitter.com/fredvanelli
 *         http://facebook.com/fred.vanelli
 *
 * Copyright (c) 2011
 * Version: 1.0 (2011-07-13)
 * Dual licensed under the MIT and GPL licenses.
 * http://jfontsize.com/license
 * Requires: jQuery v1.2.6 or later
 * 
 * Updated by Rob Nichols
 * Adds facility for changes to be remembered from page to page
 * Requires: https://github.com/carhartl/jquery-cookie
 * 2013-05-10
 */

(function($){
    $.fn.jfontsize = function(options) {
      var $this=$(this);
	    var defaults = {
		    btnMinusClasseId: '#jfontsize-minus',
		    btnDefaultClasseId: '#jfontsize-default',
		    btnPlusClasseId: '#jfontsize-plus',
        btnMinusMaxHits: 10,
        btnPlusMaxHits: 10,
        sizeChange: 1
	    };
      
      var change = 0;
      var increase = 1;
      var decrease = -1;
      
      function changeSize(context, currentIndex, changeType) {
        fontsize=$(context).css('font-size');
        fontsize=parseInt(fontsize);
        fontsize_standard[currentIndex]=fontsize-(limit[currentIndex]*options.sizeChange);
        fontsize=fontsize+(changeType*options.sizeChange);               
        limit[currentIndex] = limit[currentIndex] + changeType;
        $(context).css('font-size', fontsize+'px');
      };
      
      function trackChange(step) {
        change = getChange() + step;
        setChange(change);
      };
      
      function getChange() {
        change = parseInt($.cookie('jfontsizeChange'));
        if(change === undefined || isNaN(change)) {
          return 0;
        } else {
          return change;
        }
      };
      
      function setChange(value) {
        $.cookie('jfontsizeChange', value.toString(), {path: '/'});
      };
      
      function recallSize() {
        $this.each(function(i){
          changeSize(this, i, getChange());
        });
      };

	    if(($.isArray(options))||(!options)){
            options = $.extend(defaults, options);
	    } else {
            defaults.sizeChange = options;
		    options = defaults;
	    }

      var limit=new Array();
      var fontsize_standard=new Array();

      $(this).each(function(i){
          limit[i]=0;
          fontsize_standard[i];
      });
      
      if(getChange() !== undefined){
        recallSize();
      };

      $('#jfontsize-minus, #jfontsize-default, #jfontsize-plus').removeAttr('href');
      $('#jfontsize-minus, #jfontsize-default, #jfontsize-plus').css('cursor', 'pointer');

      $('#jfontsize-minus').click(function(){
          trackChange(decrease);
          $this.each(function(i){
              if (limit[i]>(-(options.btnMinusMaxHits))){
                  changeSize(this, i, decrease);
              }
          });
      });

      $('#jfontsize-default').click(function(){
          setChange(0);
          $this.each(function(i){
              limit[i]=0;
              $(this).css('font-size', fontsize_standard[i]+'px');
          });
      });

      $('#jfontsize-plus').click(function(){
          trackChange(increase);
          $this.each(function(i){
              if (limit[i]<options.btnPlusMaxHits){
                  changeSize(this, i, increase);
              }
          });
      });
    };
})(jQuery);