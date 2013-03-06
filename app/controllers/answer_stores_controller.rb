class AnswerStoresController < ApplicationController
  
  before_filter :get_answer_store_from_params
  
  def show
    unless @answer_store
      flash[:alert] = "Unable to retrieve previous answers."
      redirect_to root_path
    end
  end
  
  def update
    set_qwester_answer_store(@answer_store.restore)
    flash[:notice] = "Answers restored"
    redirect_to root_path
  end

  private
  def get_answer_store_from_params
     @answer_store = AnswerStore.find_by_session_id(params[:id])
  end
end
