class Answer < ActiveRecord::Base
  attr_accessible :value, :question_id, :position, :cope_index

  DEFAULT_VALUES = ['Yes', 'No', 'Not applicable']

  belongs_to :question

  acts_as_list :scope => :question

  def self.find_first_or_create(attributes)
    where(attributes).first || create(attributes)
  end

  def self.default_values
    DEFAULT_VALUES
  end
end