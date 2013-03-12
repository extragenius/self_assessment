class Setting < ActiveRecord::Base

  attr_accessible :name, :value, :value_type, :description
  
  acts_as_mournful_setting
  
  def encrypted?
    false
  end

end
