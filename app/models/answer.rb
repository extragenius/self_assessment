class Answer < ActiveRecord::Base
  attr_accessible :value, :question_id, :position, :cope_index

  DEFAULT_VALUE = 'Not applicable'
  STANDARD_VALUES = ['Yes', 'No', DEFAULT_VALUE]

  has_and_belongs_to_many :rule_sets
  has_and_belongs_to_many :answer_stores
  
  belongs_to :question

  acts_as_list :scope => :question

  validates :value, :presence => true

  def self.find_first_or_create(attributes)
    where(attributes).first || create(attributes)
  end

  def self.standard_values
    STANDARD_VALUES
  end

  def self.default_value
    DEFAULT_VALUE
  end
end