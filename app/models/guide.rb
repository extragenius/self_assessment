class Guide < ActiveRecord::Base
  attr_accessible :name, :title, :summary, :details
 
  validates :name, :presence => true, :uniqueness => true
  
  acts_as_list
  
  default_scope order('position')

  def to_param
    name
  end
end
