class GuidesController < ApplicationController
  
  before_filter :get_guides
  
  def index
    @guide = @guides.first
    render :show
  end

  def show
    @guide = Guide.find_by_name(params[:id])
  end
  
  private
  def get_guides
    @guides = Guide.all
  end
end
