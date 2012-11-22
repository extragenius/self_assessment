class Answer < ActiveRecord::Base
  attr_accessible :value, :question_id, :questionnaire_id

  DEFAULT_VALUES = ['Yes', 'No', 'Unsure']

  belongs_to :question
  belongs_to :questionnaire
  
  def self.find_first_or_create(attributes)
    where(attributes).first || create(attributes)
  end

  def self.default_values
    DEFAULT_VALUES
  end
end