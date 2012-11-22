class Question < ActiveRecord::Base
  attr_accessible :title, :description, :ref, :answers_attributes
  
  has_many :answers
  accepts_nested_attributes_for :answers
  
  has_many :questionnaires_questions
  
  has_many(
    :questionnaires,
    :through => :questionnaires_questions, 
    :uniq => true
  )
  
  validates :title, :presence => true
end