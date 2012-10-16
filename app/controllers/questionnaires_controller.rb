class QuestionnairesController < ApplicationController
  before_filter :new_questionnaire, :only => [:new, :create]
  before_filter :get_questionnaire, :except => [:new, :create, :index, :tabs]
  before_filter :get_questions, :only => [:new, :create, :edit, :update]
  before_filter :get_questionnaires, :only => [:index, :tabs, :tab, :answer]
  before_filter :get_rule_sets, :only => [:tabs, :tab]
  
  layout 'tabs', :only => [:tabs, :tab, :answer]
  
  def index
    
  end
  
  def tabs

  end

  def show
  end
  
  def tab
    
  end

  def new
    @questionnaire = Questionnaire.new
  end
  
  def create
    if update_questionnaire
      redirect_to :action => :show, :id => @questionnaire.id
    else
      render :new
    end
  end
  
  def edit
    render :new
  end
  
  def update
    if update_questionnaire
      redirect_to :action => :show, :id => @questionnaire.id
    else
      render :new
    end
  end

  def delete
  end
  
  def destroy
    @questionnaire.destroy
    redirect_to :action => :index
  end
  
  def answer
    add_answers_to_store
    redirect_to tabs_answers_path
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