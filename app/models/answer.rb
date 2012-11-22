class Answer < ActiveRecord::Base
  attr_accessible :value, :question_id, :questionnaire_id
  
  belongs_to :question
  belongs_to :questionnaire
  
  def self.find_first_or_create(attributes)
    where(attributes).first || create(attributes)
  end

  def self.default_values
    ['Yes', 'No', 'Unsure']
  end
end