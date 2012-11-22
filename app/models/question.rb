class Question < ActiveRecord::Base
  attr_accessible :title, :description, :ref, :answers_attributes
  
  has_many :answers, :order => 'position'
  accepts_nested_attributes_for :answers
  
  has_many :questionnaires_questions
  
  has_many(
    :questionnaires,
    :through => :questionnaires_questions, 
    :uniq => true
  )
  
  validates :title, :presence => true

  def build_default_answers
    created_answers = Array.new
    Answer.default_values.each_with_index do |value, index|
      answer = answers.find_or_initialize_by_value(value)
      answer.position = index + 1
      created_answers << answer
    end
    return created_answers
  end

  def create_default_answers
    build_default_answers.each(&:save)
  end
end