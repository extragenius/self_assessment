// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

var calculator = {
  valueForField: function(field) {
    return parseInt(field.val()) || 0;
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
        //console.log('Successfully retrieved ' + name);
      },
      error: function () {
        //console.log('Error retrieving ' + name);
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
    var couple = $('#couple').attr('checked');
    return couple == 'checked';
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
  } 
}


$(function() {
  
  function onClickShowAndHide(clickOn, reveal, remove) {
    $(clickOn).click(function(){
      $(remove).hide();
      $(reveal).show();
    })
  }
  
  function whenSelectedShow(checkBox, reveal) {
    $(checkBox).click(function(){
      if (this.checked) {
        $(reveal).show("highlight", {color:'#C2EBFF'}, 1500)
      } else {
        $(reveal).hide();
      }
      
    })
  }
  
  onClickShowAndHide(
    '#calculator #understand', 
    '#calculator #two',
    '#calculator #one'
  );
    
  whenSelectedShow(
    '#calculator #couple', 
    '#calculator .spouse'
  );
  
  var supported = I18n.t('calculator.output.supported');

  var mayBeFunded = I18n.t('calculator.output.may_be_funded');
  
  var selfFund = I18n.t('calculator.output.self_fund');
  
  var disclaimer = I18n.t('calculator.output.disclaimer');

  var calc
  
  function ownsProperty() {
    return $('#property').attr('checked') == 'checked';
  }
  
  function showOwnsProperty() {
    if (ownsProperty()) {
      calc = I18n.t('calculator.output.owns_property');
      displayOutput(selfFund, calc);
      return true;
    } else {
      return false;
    }
  }
  
  function showSupported() {
    if (calculator.totalSavings() < calculator.minSavings()) {
      calc = I18n.t('calculator.output.calc.below_lower_threshold', {amount: calculator.minSavings()});
      displayOutput(supported, prependSavings(calc));
      return true;
    } else {
      return false;
    }
  }
  
  function showMayBeFunded() {
    if (calculator.totalSavings() < calculator.maxSavings()) {
      calc = I18n.t('calculator.output.calc.between_thresholds', {lower: calculator.minSavings(), upper: calculator.maxSavings()})
      displayOutput(mayBeFunded, prependSavings(calc));
      return true;
    } else {
      return false;
    }     
  }
  
  function showSelfFund() {
    calc = calc = I18n.t('calculator.output.calc.above_upper_threshold', {amount: calculator.maxSavings()});
    displayOutput(selfFund, prependSavings(calc));
    return true;
  }
  
  function prependSavings(text) {
    return I18n.t('calculator.output.prepend_savings', {total_savings: calculator.totalSavings(), calc: text});
  }
  
  function displayOutput(outcome, calc) {
    
    var output = '<p>' + calc + '</p>';
    output += '<p>' + outcome + '</p>';
    output += '<p>' + disclaimer + '</p>';
    output += '<p><button id="restart">' + I18n.t('calculator.output.reopen_button') + '</button></p>'

    $('#output').html(output);
    $('#output').show("highlight", {color:'#C2EBFF'});
    $('#calculator #two').hide('fade');

    onClickShowAndHide(
      '#calculator #restart',
      '#calculator #two',
      '#calculator #output'
    );
  }
  
    
  $('#calculate').click(function(){
    
    showOwnsProperty() || showSupported() || showMayBeFunded() || showSelfFund();

  });
  


  
});
