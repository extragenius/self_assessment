class SettingsController < ApplicationController
  def show
    respond_to do |format|
      format.html { render :text => Setting.for(params[:id])}
      format.json { render :json => {:setting_value => Setting.for(params[:id])}}
    end

  end
end
