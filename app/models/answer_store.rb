class AnswerStore < ActiveRecord::Base

  has_and_belongs_to_many :answers
  
  before_save :generate_session_id
  
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
