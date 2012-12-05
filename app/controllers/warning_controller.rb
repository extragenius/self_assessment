class WarningController < ApplicationController

  def update
    warning = "warning_#{params[:id]}"
    setting = params[:set]
    session[warning.to_sym] = setting
    render :text => "Added instruction to #{setting} #{warning} to session"
  end

end
