require 'array_logic'

class RuleSet < ActiveRecord::Base
  attr_accessible :title, :description, :answers, :url, :rule, :answer_ids
  
  before_save :generate_default_rule
  
  DEFAULT_RULE_JOIN = 'or'
  ANSWERS_LIMIT = 10
  
  has_and_belongs_to_many :answers, :uniq => true
  accepts_nested_attributes_for :answers
  
  has_many(
    :questions,
    :through => :answers
  )
  
  validates :title, :presence => true
  validates :url, :presence => true
  
  def self.matching(answers)
    all.collect{|rule_set| rule_set if rule_set.match(answers)}.compact
  end
  
  def match(answers_to_check = nil)
    return unless answers_to_check
    generate_default_rule && save
    logic.match(answers_to_check)
  end
  
  def value_for(question)
    answer = answers.where(:question_id => question.id).first
    answer.value if answer
  end
  
  def logic
    @logic ||= get_logic
  end
  
  def matching_answer_sets
    @matching_answer_sets ||= logic.matching_combinations 
  end
  
  def blocking_answer_sets
    @blocking_answer_set ||= logic.blocking_combinations
  end
  
  def default_rule
    answers.collect(&:rule_label).join(" #{DEFAULT_RULE_JOIN} ")
  end
  
  private
  def get_logic
    array_logic_rule = ArrayLogic::Rule.new
    array_logic_rule.rule = rule
    return array_logic_rule
  end
  
  def generate_default_rule
    if (!self.rule or self.rule.empty?) and answers.length > 0
      self.rule = default_rule
    end
  end  
end
