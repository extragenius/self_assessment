class Question < ActiveRecord::Base
  attr_accessible :title, :description, :ref
  
  has_many :answers
  
  has_many :questionnaires_questions
  
  has_many(
    :questionnaires,
    :through => :questionnaires_questions, 
    :uniq => true
  )
  
  validates :title, :presence => true
end