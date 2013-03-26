describe("calculator", function() {
  
  var mockSettings = {
    'lower_savings_threshold': 110, 
    'upper_savings_threshold': 210, 
    'couple_factor' : 2
  }
  
  beforeEach(function() {
    loadFixtures("calculator.html");
        
    spyOn(calculator, "getSettingFromServer").andCallFake(function(params) {
      return mockSettings[params];
    });
    
  })
  
  describe("Mocked methods - stuff that isn't easy to replicate in the test environment", function() {
  
    describe(".getSettingFromServer", function() {

      it("is mocked to return the mockSetting matching the input name", function(){
        expect(calculator.getSettingFromServer('upper_savings_threshold')).toEqual(mockSettings['upper_savings_threshold']);
      });

    })
  
  });
  
  describe(".valueForField(field)", function() {
  
    it("should return the value in a field", function() {
      field = $('#input_one');
      expect(calculator.valueForField(field)).toEqual(4);
    });

    it("should return 0 for value in a field if no value set", function() {
      field = $('#input_three');
      expect(calculator.valueForField(field)).toEqual(0);
    });
    
    it("should return the value in a field from within text", function() {
      field = $('#input_one');
      field.val('a12.445 bns')
      expect(calculator.valueForField(field)).toEqual(12);
    });
    
    it("should return the value in a field ignoring commas", function() {
      field = $('#input_one');
      field.val('12,445')
      expect(calculator.valueForField(field)).toEqual(12445);
    });
  
  })
  
  describe(".totalSavings", function() {
    
    it("should return the sum of values in 'saving_type_input' inputs", function() {
      expect(calculator.totalSavings()).toEqual(6);
    });
    
    it("should return the sum of values ignoring prepended currency string", function() {
      $('#input_one').val('£3')
      expect(calculator.totalSavings()).toEqual(5);
    });
    
  })
  
  describe(".cachedSettings", function() {
    
    it("should store things", function() {
      calculator.cachedSettings['foo'] = 'bar';
      expect(calculator.cachedSettings['foo']).toEqual('bar');
    });
    
    it("should return undefined when a setting has not been set", function(){
      expect(typeof calculator.cachedSettings['something'] === 'undefined').toBe(true);
    });
    
  })
  
  describe(".getSetting", function() {
    
    it("should return a setting via ajax", function(){
      expect(calculator.getSetting('upper_savings_threshold')).toEqual(mockSettings['upper_savings_threshold']);
    });
    
    it("should return cached value when extant", function(){
      calculator.cachedSettings['something'] = 'else';
      expect(calculator.getSetting('something')).toEqual('else');
    });
    
  })
  
  describe('.isCouple', function(){
    
    it("should return true if #couple checkbox ticked", function(){
      $('#couple').prop('checked', true);
      expect(calculator.isCouple()).toBe(true);
    });
    
    it("should return false if #couple checkbox not ticked", function(){
      expect(calculator.isCouple()).toBe(false);
    });
    
  })

  describe('.coupleFactor', function(){
    
    it("should return couple_factor when #couple checkbox ticked", function(){
      $('#couple').prop('checked', true);
      expect(calculator.coupleFactor()).toEqual(mockSettings['couple_factor']);
    });
    
    it("should return one when #couple checkbox not ticked", function(){
      expect(calculator.coupleFactor()).toEqual(1);
    });
    
  })
  
  describe('.minSavings', function(){
    
    it("should return lower_savings_threshold when #couple checkbox not ticked", function(){
      expect(calculator.minSavings()).toEqual(mockSettings['lower_savings_threshold']);
    })
    
    it("should return lower_savings_threshold times couple_factor when #couple checkbox is ticked", function(){
      $('#couple').prop('checked', true);
      var expected = mockSettings['lower_savings_threshold'] * mockSettings['couple_factor']
      expect(calculator.minSavings()).toEqual(expected);
    })
    
  })
  
  describe('.maxSavings', function(){
    
    it("should return upper_savings_threshold when #couple checkbox not ticked", function(){
      expect(calculator.maxSavings()).toEqual(mockSettings['upper_savings_threshold'])
    })
    
    it("should return upper_savings_threshold times couple_factor when #couple checkbox is ticked", function(){
      $('#couple').prop('checked', true);
      var expected = mockSettings['upper_savings_threshold'] * mockSettings['couple_factor']
      expect(calculator.maxSavings()).toEqual(expected);
    })
    
  })
  
  describe('.ownsProperty', function(){
    
    it("should return true if property field value is greater than zero", function(){
      $('#property').val('10');
      expect(calculator.ownsProperty()).toBe(true);
    })
    
    it("should false true if property field value is not greater than zero", function(){
      $('#property').val('0');
      expect(calculator.ownsProperty()).toBe(false);
    })
    
  })
  
  describe('.propertyValue', function(){
    
    it("should match contents of property input", function(){
      var values = [0, 2, 50, 13.4];
      var value;
      for(value in values){
        $('#property').val(value);
        expect(calculator.propertyValue()).toEqual(value);
      }
    })
    
  })
  
  describe('.nonPropertySavings', function(){
    
    it("should match total savings minus propery value", function(){
      var property = 3;
      $('#property').val(property);
      var totalMinusProperty = calculator.totalSavings() - property;
      expect(calculator.nonPropertySavings()).toEqual(totalMinusProperty);
    })
    
  })
  
  describe('.nonPropertySavingsBelowMax', function(){
    
    beforeEach(function() {
      $('#property').val(calculator.maxSavings() + 1);
    })
    
    it("should return true if savings other than property are below max", function(){
      expect(calculator.nonPropertySavingsBelowMax()).toBe(true)
    })
    
    it("should return false if savings other than property are above max", function(){
      var savings = calculator.maxSavings() + 1;
      $('#input_one').val(savings);
      expect(calculator.nonPropertySavingsBelowMax()).toBe(false)
    })
    
  })
  
  describe('.showOwnsProperty', function(){
    
    it("should return false if property field is zero", function(){
      $('#property').val('0');
      expect(calculator.showOwnsProperty()).toBe(false);
    })
    
    it("should return false if property greater than zero, but other values exceed maximum threashold", function(){
      $('#property').val('100');
      var savings = calculator.maxSavings() + 1;
      $('#input_one').val(savings);
      expect(calculator.showOwnsProperty()).toBe(false);
    })
    
    it("should return true if property greater than zero, and other values do not exceed maximum threashold", function(){
      var savings = calculator.maxSavings() + 1;
      $('#property').val(savings);
      expect(calculator.showOwnsProperty()).toBe(true);
    })
    
  })
  
  describe('.showSupported', function(){
    
    it("should return true if total savings are less than lower threshold", function(){
      var savings = calculator.minSavings() - calculator.totalSavings() - 1;
      $('#input_one').val(savings);
      expect(calculator.showSupported()).toBe(true);
    })
    
    it("should return false is total savings are more than lower threshold", function(){
      var savings = calculator.minSavings() + 1;
      $('#input_one').val(savings);
      expect(calculator.showSupported()).toBe(false);
    })
    
  })
  
  describe('.showMayBeFunded', function(){
    
    it("should return true if total savings are less than upper threshold", function(){
      var savings = calculator.maxSavings() - calculator.totalSavings() - 1;
      $('#input_one').val(savings);
      expect(calculator.showMayBeFunded()).toBe(true);
    })
    
    it("should return false is total savings are more than upper threshold", function(){
      var savings = calculator.maxSavings() + 1;
      $('#input_one').val(savings);
      expect(calculator.showMayBeFunded()).toBe(false);
    })
    
  })
  
  describe('.showSelfFund', function(){
    
    it("should return true", function(){
      expect(calculator.showSelfFund()).toBe(true);
    })
    
  })
  
  describe('.onClickShowAndHide', function(){
    
    beforeEach(function() {
      $('#input_one').hide();
      calculator.onClickShowAndHide($('#couple'), $('#input_one'), $('#input_two'));
      $('#couple').click();
    })
    
    it("should hide one element on click", function(){
      expect($('#input_two').is(':hidden')).toBe(true);
    })
    
    it("should reveal one element on click", function(){
      expect($('#input_one').is(':hidden')).toBe(false);
    })
    
  })
  
  describe('.whenSelectedShow', function(){
    
    beforeEach(function(){
      calculator.whenSelectedShow($('#couple'), $('#input_one'));
    })
    
    it("should reveal target if clicking checkbox makes it checked", function(){
      $('#input_one').hide();
      $('#couple').prop('checked', false);
      $('#couple').click();
      expect($('#couple').is(':checked')).toBe(true);
      expect($('#input_one').is(':hidden')).toBe(false);
    })
    
    it("should hide target if clicking checkbox makes it unchecked", function(){
      $('#input_one').show();
      $('#couple').prop('checked', true);
      $('#couple').click();
      expect($('#couple').is(':checked')).toBe(false);
      expect($('#input_one').is(':hidden')).toBe(true);
    })
    
  })
  
});