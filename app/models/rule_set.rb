class RuleSet < ActiveRecord::Base
  attr_accessible :title, :description, :answers, :url
  
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
    true if (answers - answers_to_check).empty?
  end
  
  def value_for(question)
    answer = answers.where(:question_id => question.id).first
    answer.value if answer
  end
end
