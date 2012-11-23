class Answer < ActiveRecord::Base
  attr_accessible :value, :question_id, :position, :cope_index

  DEFAULT_VALUE = 'Not applicable'
  STANDARD_VALUES = ['Yes', 'No', DEFAULT_VALUE]

  belongs_to :question

  acts_as_list :scope => :question

  def self.find_first_or_create(attributes)
    where(attributes).first || create(attributes)
  end

  def self.standard_values
    STANDARD_VALUES
  end
end