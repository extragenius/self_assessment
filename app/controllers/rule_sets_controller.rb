class RuleSetsController < ApplicationController
  before_filter :new_rule_set, :only => [:new, :create]
  before_filter :get_rule_set, :except => [:new, :create, :index]
  before_filter :get_questions, :only => [:new, :create, :edit, :update]
  
  before_filter :authenticate_admin_user!
  
  def index
    @rule_sets = RuleSet.all
  end

  def show
  end

  def new
  end
  
  def create
    if update_rule_set
      redirect_to :action => :index
    else
      render :new
    end
  end

  def edit
    render :new
  end
  
  def update
    create
  end

  def delete
  end
  
  def destroy
    @rule_set.destroy
    redirect_to :action => :index
  end
  
  private
  def new_rule_set
    @rule_set = RuleSet.new
  end
  
  def get_rule_set
    @rule_set = RuleSet.find(params[:id])
  end
  
  def update_rule_set
    @rule_set.attributes = params[:rule_set]
    @rule_set.answers = answers_in_params if answers_in_params
    @rule_set.save
  end
  
  def answers_in_params
    @answers_in_params ||= extract_answers_from_params
  end
  
  def answers_in_params?
    params[:answers] and params[:answers][:question_id]
  end
  
  def extract_answers_from_params
    if answers_in_params?
      questions = extract_questions_from_params
      questions.collect do |question|
        value = params[:answers][:question_id][question.id.to_s.to_sym]
        attributes = {
          :question_id => question.id,
          :value => value          
        }
        Answer.find_first_or_create(attributes)
      end
    end    
  end
end
