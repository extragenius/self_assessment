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
      loadFixtures("calculator.html");
      field = $('#input_one');
      expect(calculator.valueForField(field)).toEqual(4);
    });

    it("should return 0 for value in a field if no value set", function() {
      field = $('#input_three');
      expect(calculator.valueForField(field)).toEqual(0);
    });
    
    it("should return the value in a field from within text", function() {
      loadFixtures("calculator.html");
      field = $('#input_one');
      field.val('a12.445 bns')
      expect(calculator.valueForField(field)).toEqual(12);
    });
    
    it("should return the value in a field ignoring commas", function() {
      loadFixtures("calculator.html");
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
      expect(calculator.getSetting('something')).toEqual('else')
    });
    
  })
  
  describe('.isCouple', function(){
    
    it("should return true if #couple checkbox ticked", function(){
      $('#couple').prop('checked', true);
      expect(calculator.isCouple()).toBe(true)
    });
    
    it("should return false if #couple checkbox not ticked", function(){
      expect(calculator.isCouple()).toBe(false)
    });
    
  })

  describe('.coupleFactor', function(){
    
    it("should return couple_factor when #couple checkbox ticked", function(){
      $('#couple').prop('checked', true);
      expect(calculator.coupleFactor()).toEqual(mockSettings['couple_factor'])
    });
    
    it("should return one when #couple checkbox not ticked", function(){
      expect(calculator.coupleFactor()).toEqual(1)
    });
    
  })
  
  describe('.minSavings', function(){
    
    it("should return lower_savings_threshold when #couple checkbox not ticked", function(){
      expect(calculator.minSavings()).toEqual(mockSettings['lower_savings_threshold'])
    })
    
    it("should return lower_savings_threshold times couple_factor when #couple checkbox is ticked", function(){
      $('#couple').prop('checked', true);
      var expected = mockSettings['lower_savings_threshold'] * mockSettings['couple_factor']
      expect(calculator.minSavings()).toEqual(expected)
    })
    
  })
  
  describe('.maxSavings', function(){
    
    it("should return upper_savings_threshold when #couple checkbox not ticked", function(){
      expect(calculator.maxSavings()).toEqual(mockSettings['upper_savings_threshold'])
    })
    
    it("should return upper_savings_threshold times couple_factor when #couple checkbox is ticked", function(){
      $('#couple').prop('checked', true);
      var expected = mockSettings['upper_savings_threshold'] * mockSettings['couple_factor']
      expect(calculator.maxSavings()).toEqual(expected)
    })
    
  })
  
});