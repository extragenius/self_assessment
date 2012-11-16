class SettingsController < ApplicationController
  def show
    render :text => Setting.for(params[:id])
  end
end
