class Questionnaire < ActiveRecord::Base
  attr_accessible :title, :description
  
  has_and_belongs_to_many :questions
  
  validates :title, :presence => true
  
end
