class Guide < ActiveRecord::Base
  attr_accessible :name, :title, :summary, :details
 
  validates(
    :name, 
    :presence => true, 
    :uniqueness => true, 
    :format => {
      :with => /^[a-z0-9_]+$/,
      :message => 'must comprise lower case letters, numbers and/or underscores.'
    }
  )
  
  acts_as_list
  
  default_scope order('position')

  def to_param
    name
  end
end
