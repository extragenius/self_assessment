class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :get_answer_store

  private
  def get_answer_store(create_new = false)
    if session[:answer_store]
      currect_answer_store
    elsif create_new
      new_answer_store
    end
  end
  
  def currect_answer_store
    @answer_store = AnswerStore.find_by_session_id(session[:answer_store])
  end
  
  def new_answer_store
    @answer_store = AnswerStore.create
    session[:answer_store] = @answer_store.session_id
  end
  
  def get_rule_sets
    @rule_sets = matching_rule_sets || []
  end
  
  def matching_rule_sets
    if get_answer_store
      RuleSet.matching(@answer_store.answers)
    end
  end
  
  def get_questions
    @questions = Question.all
  end
  
  def get_questionnaires
    @questionnaires = Questionnaire.all
  end
  
  def extract_questions_from_params
    questions = Array.new
    if params[:questions]
      question_ids = params[:questions][:id]
      question_ids.each do |id, value|
        if value == '1'
          questions << Question.find(id)
        end
      end
    end
    questions.uniq
  end
end
