class ReckonerController < ApplicationController
  def index
    @couple_factor = Setting.for(:couple_factor) || 0
    @lower_savings_threshold = Setting.for(:lower_savings_threshold)  || 0
    @upper_savings_threshold = Setting.for(:upper_savings_threshold) || 0
  end
end
