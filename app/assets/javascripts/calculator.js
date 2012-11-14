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
  
  function isCouple() {
    var couple = $('#couple').attr('checked');
    return couple == 'checked'
  }
  
  function coupleFactor() {
    if (isCouple()) {
      return 2;
    } else {
      return 1;
    }
  }
  
  function minSavings() {   
    var minThreashold = 14250;
    return minThreashold * coupleFactor();
  }
  
  function maxSavings() {    
    var maxThreashold = 23250;
    return maxThreashold * coupleFactor();
  }  
  
  var supported = 'Yes you are eligible for funding by WCC';

  var mayBeFunded = 'You may be eligible for some funding by WCC';
  
  var selfFund = 'You will need to fund the full cost'; 

  var calc
  
  function ownsProperty() {
    return $('#property').attr('checked') == 'checked'
  }
  
  function showOwnsProperty() {
    if (ownsProperty()) {
      calc = 'You are not eligible for WCC funding because you own property';
      displayOutput(selfFund, calc);
      return true;
    } else {
      return false;
    }
  }
  
  function showSupported() {
    if (totalSavings() < minSavings()) {
      calc = "below the lower limit of &pound;" + minSavings();
      displayOutput(supported, prependSavings(calc));
      return true;
    } else {
      return false;
    }
  }
  
  function showMayBeFunded() {
    if (totalSavings() < maxSavings()) {
      calc = "above the lower limit of &pound;" + minSavings();
      calc += " and below the upper limit of &pound;" + maxSavings();
      displayOutput(mayBeFunded, prependSavings(calc));
      return true;
    } else {
      return false;
    }     
  }
  
  function showSelfFund() {
    calc = "above the upper limit of &pound;" + maxSavings();
    displayOutput(selfFund, prependSavings(calc));
    return true;
  }
  
  function prependSavings(text) {
    return "Your capital and savings of &pound;" + totalSavings() + " are " + text;
  }
  
  function displayOutput(outcome, calc) {
    
    var output = '<p>' + calc + '</p>';
    output += '<p>Result - ' + outcome + '</p>';
    output += '<p><button id="restart">Calculate again</button></p>'

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