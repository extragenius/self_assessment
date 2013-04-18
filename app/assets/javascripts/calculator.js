// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

var calculator = {
  valueForField: function(field) {
    var value = /\d[\,\d+]*(\.d+)?/.exec(field.val());
    if (value) {
      value = value[0].replace(/\,/g, '');
      return parseInt(value);
    } else {
      return 0;
    }
  },
  
  totalSavings: function() {
    var sum = 0;
    $('.saving_type_input input').each(function(index, value) {
      sum += calculator.valueForField($(value));
    });
    return sum;
  },
  
  getSettingFromServer: function(name) {
    var json = $.ajax({
      type: "GET",
      url: '/settings/' + name + '.json',
      async: false,  // Without this rest of process continues before the data is returned
      dataType: 'json',

      success: function () {
        //console.log('Successfully retrieved ' + name); // Causes errors in IE if enabled
      },
      error: function () {
        //console.log('Error retrieving ' + name); // Causes errors in IE if enabled
      }
    }).responseText;

    var data = $.parseJSON(json);
    return data.setting_value;
  },
  
  cachedSettings: {},
  
  getSetting: function(name) {
    if (typeof calculator.cachedSettings[name] === "undefined") {
      calculator.cachedSettings[name] = calculator.getSettingFromServer(name);
    }
    return calculator.cachedSettings[name];
  },
  
  isCouple: function() {
    return $('#couple').is(':checked');
  },
  
  coupleFactor: function() {
    if (calculator.isCouple()) {
      return calculator.getSetting('couple_factor');
    } else {
      return 1;
    }
  },
  
  minSavings: function() {
    var minThreashold = calculator.getSetting('lower_savings_threshold');
    return minThreashold * calculator.coupleFactor();
  },
  
  maxSavings: function() {    
    var maxThreashold = calculator.getSetting('upper_savings_threshold');
    return maxThreashold * calculator.coupleFactor();
  },
  
  ownsProperty: function() {
    return parseInt(calculator.propertyValue()) > 0;
  },
  
  propertyValue: function() {
    return $('#property').val();
  },
  
  nonPropertySavings: function(){
    return calculator.totalSavings() - calculator.propertyValue();
  },
  
  nonPropertySavingsBelowMax: function() {
    return calculator.nonPropertySavings() < calculator.maxSavings();
  },
  
  savingsExeceedMax: function(){
    return calculator.totalSavings() > calculator.maxSavings();
  },
  
  showOwnsProperty: function() {
    if (calculator.savingsExeceedMax() && calculator.ownsProperty() && calculator.nonPropertySavingsBelowMax()) {
      var calc = I18n.t('calculator.output.property_pushes_saving_over_max');
      var ownsProperty = I18n.t('calculator.output.owns_property');
      calculator.displayOutput(ownsProperty, calc);
      return true;
    } else {
      return false;
    }
  },
  
  showSupported: function() {
    if (calculator.totalSavings() < calculator.minSavings()) {
      var calc = I18n.t('calculator.output.calc.below_lower_threshold', {amount: calculator.minSavings()});
      var supported = I18n.t('calculator.output.supported');
      calculator.displayOutput(supported, calculator.prependSavings(calc));
      return true;
    } else {
      return false;
    }
  },
  
  showMayBeFunded: function() {
    if (calculator.totalSavings() < calculator.maxSavings()) {
      var calc = I18n.t('calculator.output.calc.between_thresholds', {lower: calculator.minSavings(), upper: calculator.maxSavings()});
      var mayBeFunded = I18n.t('calculator.output.may_be_funded');
      calculator.displayOutput(mayBeFunded, calculator.prependSavings(calc));
      return true;
    } else {
      return false;
    }     
  },
  
  showSelfFund: function() {
    var calc = I18n.t('calculator.output.calc.above_upper_threshold', {amount: calculator.maxSavings()});
    var selfFund = I18n.t('calculator.output.self_fund');
    calculator.displayOutput(selfFund, calculator.prependSavings(calc));
    return true;
  },
  
  prependSavings: function(text) {
    return I18n.t('calculator.output.prepend_savings', {total_savings: calculator.totalSavings(), calc: text});
  },
  
  onClickShowAndHide: function(clickOn, reveal, remove) {
    $(clickOn).click(function(){
      $(remove).hide();
      $(reveal).show();
    });
  },
  
  whenSelectedShow: function(checkBox, reveal) {
    $(checkBox).click(function(){
      if (this.checked) {
        $(reveal).show("highlight", {color:'#C2EBFF'}, 1500);
      } else {
        $(reveal).hide();
      }
      
    });
  },
  
  displayOutput: function(outcome, calc) {
    
    var paragraph = calculator.paragraph;
    
    var disclaimer = I18n.t('calculator.output.disclaimer');
    
    var disclaimer_link = 'href="http://www.warwickshire.gov.uk/socialcarecharges"';
    disclaimer_link = '<a ' + disclaimer_link + ' target="_blank">';
    disclaimer_link += I18n.t('calculator.output.disclaimer_link');
    disclaimer_link += '</a>';
    
    var output = paragraph(calc);
    output += paragraph(outcome);
    output += paragraph(disclaimer);
    output += paragraph(disclaimer_link);
    output += paragraph('<button id="restart">' + I18n.t('calculator.output.reopen_button') + '</button>');

    $('#output').html(output);
    $('#output').show("highlight", {color:'#C2EBFF'});
    $('#calculator #two').hide('fade');

    calculator.onClickShowAndHide(
      '#calculator #restart',
      '#calculator #two',
      '#calculator #output'
    );
  },
          
  paragraph: function(text) {
    if (/^\s*<p>.*<\/p>\s*$/.test(text)) {
      return text;
    } else {
      return '<p>' + text + '</p>';
    };
  }
  
};


$(function() {
  
  calculator.onClickShowAndHide(
    '#calculator #understand', 
    '#calculator #two',
    '#calculator #one'
  );
    
  calculator.whenSelectedShow(
    '#calculator #couple', 
    '#calculator .spouse'
  );
  
  $('#calculate').click(function(){
    
    calculator.showOwnsProperty()     || 
      calculator.showSupported()      || 
        calculator.showMayBeFunded()  || 
          calculator.showSelfFund();

  });
  


  
});
