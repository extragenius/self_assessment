class CalculatorController < ApplicationController
  
  def index
    
    @saving_types = [
      :bank,
      :building_society,
      :savings_account,
      :isa_tessa,
      :cash,
      :premium_bonds,
      :property,
      :other
    ]

  end
end
