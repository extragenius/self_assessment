class ReportsController < ApplicationController
  
  def index
    @charts = charts
    @max_labels = 5
    
  end
  
  def show
    chart = params[:id].respond_to?(:to_sym) ? params[:id].to_sym : nil
    
    begin 
      @chart = charts[chart]
      @width = 600
      @max_labels = 10
    rescue RuntimeError
      flash[:alert] = "Chart '#{params[:id]}' not found"
      redirect_to :action => :index
    end
  end
  
  private
  def charts
    {
      :questionnaires_per_session => Report::Chart.new(:questionnaires_per_session),
      :answers_per_session => Report::Chart.new(:answers_per_session),
      :most_used_questionnaires => Report::DataList.new(:most_used_questionnaires),
      :most_used_answers => Report::DataList.new(:most_used_answers)
    }
  end
  
end
