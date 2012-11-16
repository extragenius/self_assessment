class Question < ActiveRecord::Base
  attr_accessible :title, :description, :ref
  
  has_many :answers
  has_and_belongs_to_many :questionnaires
  
  validates :title, :presence => true
end