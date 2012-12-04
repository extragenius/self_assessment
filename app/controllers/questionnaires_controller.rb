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
    update_answer_store
    redirect_to :action => :index
  end
  
  def reset
    get_answer_store
    @answer_store.reset
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
  
  def update_answer_store
    get_answer_store(true)
    add_answers_to_answer_store
    add_questionnaire_to_answer_store
  end
  
  def add_answers_to_answer_store
    answers = params[:question_id].values.collect do |question_values|
      question_values[:answer_ids].collect{|id| Answer.find(id)}
    end
    @answer_store.answers = answers.flatten
  end
  
  def add_questionnaire_to_answer_store
    @answer_store.questionnaires << @questionnaire
  end
end