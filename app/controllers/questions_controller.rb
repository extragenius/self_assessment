class QuestionsController < ApplicationController
  before_filter :new_question, :only => [:new, :create]
  before_filter :get_question, :except => [:new, :create, :index]
  
  def index
    @questions = Question.all
  end

  def show
  end

  def new
  end
  
  def create
    if update_question
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
    @question.destroy
    redirect_to :action => :index
  end
  
  private
  def new_question
    @question = Question.new
  end
  
  def get_question
    @question = Question.find(params[:id])
  end
  
  def update_question
    @question.update_attributes(params[:question])
  end
end
