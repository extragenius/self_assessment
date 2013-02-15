class AnswerStoresController < ApplicationController
  
  before_filter :get_answer_store_from_params
  
  def show
   
  end
  
  def update
    set_qwester_answer_store(@answer_store)
    redirect_to root_path
  end

  def new
  end
  
  private
  def get_answer_store_from_params
     @answer_store = AnswerStore.find_by_session_id(params[:id])
  end
end
