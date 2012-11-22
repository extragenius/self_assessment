class AnswerStore < ActiveRecord::Base

  has_and_belongs_to_many :answers
  
  before_save :generate_session_id
  
  def add_answer(answer)
    remove_answer_for(answer.question)
    answers << answer
  end
  
  def answer_for(question)
    answers.where(:question_id => question.id).first
  end
  
  def remove_answer_for(question)
    current_answer = answer_for(question)
    answers.delete(current_answer) if current_answer
  end

  def cope_index_sum
    answers.sum(:cope_index)
  end
  
  private
  
  def generate_session_id
    if !self.session_id or self.session_id.empty?
      self.session_id = RandomString.new(15)
    end
  end
end
