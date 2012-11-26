require 'array_logic'

class RuleSet < ActiveRecord::Base
  attr_accessible :title, :description, :answers, :url, :rule
  
  has_and_belongs_to_many :answers
  
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
    if answers.present?
      true if (answers - answers_to_check).empty?
    else
      logic.match(answers_to_check)
    end
  end
  
  def value_for(question)
    answer = answers.where(:question_id => question.id).first
    answer.value if answer
  end
  
  def logic
    @logic ||= get_logic
  end
  
  private
  def get_logic
    array_logic_rule = ArrayLogic::Rule.new
    array_logic_rule.rule = rule
    return array_logic_rule
  end
end
