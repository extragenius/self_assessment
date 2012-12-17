class CalculatorController < ApplicationController
  
  def index
    
    @saving_types = [
      :bank,
      :building_society,
      :savings_account,
      :isa_tessa,
      :cash,
      :premium_bonds,
      :builings_and_land,
      :other
    ]

  end
end
