class QuestionnairesController < ApplicationController
  before_filter :get_questionnaire, :except => [:index, :reset]
  before_filter :get_rule_sets, :only => [:index, :show]
  before_filter :get_questionnaires, :only => [:index]
  
  layout 'tabs'
  
  def index

  end
  

  def show
  end

  def update
    add_answers_to_store
    redirect_to :action => :index
  end
  
  def reset
    get_answer_store
    @answer_store.answers.clear
    redirect_to :action => :index
  end
  
  private
  
  def new_questionnaire
    @questionnaire = Questionnaire.new
  end
  
  def get_questionnaire
    @questionnaire = Questionnaire.find(params[:id])
  end
  
  def update_questionnaire
    @questionnaire.attributes = params[:questionnaire]
    @questionnaire.questions = extract_questions_from_params
    @questionnaire.save
  end
  
  def add_answers_to_store
    get_answer_store(true)
    if params[:answers]
      params[:answers][:question_id].each do |question_id, value|
        attributes = {
          :question_id => question_id, 
          :value => value
        }
        answer = Answer.find_first_or_create(attributes)
        @answer_store.add_answer(answer)
      end
    end
  end
end