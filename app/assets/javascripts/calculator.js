// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(function() {
  
  function onClickShowAndHide(clickOn, reveal, remove) {
    $(clickOn).click(function(){
      $(remove).hide('drop', {direction:'up'}, 300);
      $(reveal).show('fade');
    })
  }
  
  function whenSelectedShow(checkBox, reveal) {
    $(checkBox).click(function(){
      if (this.checked) {
        $(reveal).show("highlight", {color:'#C2EBFF'}, 1500)
      } else {
        $(reveal).hide('fade', {}, 500);
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
  
  function valueForField(field){
    return parseInt($(field).val()) || 0;
  }
  
  function totalSavings() {
    var bank = valueForField('#bank');
    var shares = valueForField('#shares');
    var post_office = valueForField('#post_office');
    var capital = valueForField('#capital')
    return bank + shares + post_office + capital;
  }

  function getSettingFromServer(name) {
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
  }

  var cachedSettings = {};

  function getSetting(name) {
    if (typeof cachedSettings[name] === "undefined") {
      cachedSettings[name] = getSettingFromServer(name);
    }
    return cachedSettings[name];
  }
  
  function isCouple() {
    var couple = $('#couple').attr('checked');
    return couple == 'checked';
  }
  
  function coupleFactor() {
    if (isCouple()) {
      return getSetting('couple_factor');
    } else {
      return 1;
    }
  }

  function minSavings() {
    var minThreashold = getSetting('lower_savings_threshold');
    return minThreashold * coupleFactor();
  }
  
  function maxSavings() {    
    var maxThreashold = getSetting('upper_savings_threshold');
    return maxThreashold * coupleFactor();
  }  
  
  var supported = I18n.t('calculator.output.supported');

  var mayBeFunded = I18n.t('calculator.output.may_be_funded');
  
  var selfFund = I18n.t('calculator.output.self_fund');

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
    if (totalSavings() < minSavings()) {
      calc = I18n.t('calculator.output.calc.below_lower_threshold', {amount: minSavings()});
      displayOutput(supported, prependSavings(calc));
      return true;
    } else {
      return false;
    }
  }
  
  function showMayBeFunded() {
    if (totalSavings() < maxSavings()) {
      calc = I18n.t('calculator.output.calc.between_thresholds', {lower: minSavings(), upper: maxSavings()})
      displayOutput(mayBeFunded, prependSavings(calc));
      return true;
    } else {
      return false;
    }     
  }
  
  function showSelfFund() {
    calc = calc = I18n.t('calculator.output.calc.above_upper_threshold', {amount: maxSavings()});
    displayOutput(selfFund, prependSavings(calc));
    return true;
  }
  
  function prependSavings(text) {
    return I18n.t('calculator.output.prepend_savings', {total_savings: totalSavings(), calc: text});
  }
  
  function displayOutput(outcome, calc) {
    
    var output = '<p>' + calc + '</p>';
    output += '<p>Result - ' + outcome + '</p>';
    output += '<p><button id="restart">' + I18n.t('calculator.output.reopen_button') + '</button></p>'

    $('#output').html(output);
    $('#output').show("highlight", {color:'#C2EBFF'}, 1500);
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