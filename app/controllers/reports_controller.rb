class ReportsController < ApplicationController
  require 'google_chart'
  
  def index
    
    @charts = Hash.new
    charts.keys.each{|chart| @charts[chart] = chart_for(chart)}
  end

  def show
    
    chart = params[:id].respond_to?(:to_sym) ? params[:id].to_sym : nil
    
    if chart
      @chart = chart_for(chart, '600x400')
    else
      flash[:alert] = "Chart '#{params[:id]}' not found"
      redirect_to :action => :index
    end

    
  end
  
  private
  def charts
    {
      :questionnaires_per_session => questionnaires_per_session,
      :answers_per_session => answer_per_session
    }
  end
  
  def answer_per_session
    answers_per_session = AnswerStore.joins(:answers).group('answer_stores.id').count.values
    Hash[answers_per_session.uniq.sort.collect{|n| [n, answers_per_session.count(n)]}]
  end
  
  def questionnaires_per_session
    AnswerStore.joins(:questionnaires).group("DATE_FORMAT(answer_stores.updated_at, '%d%b%y')").count
  end
  
  def chart_for(name, size = "300x150")
    GoogleChart::BarChart.new(size, name.to_s.humanize, :vertical, false) do |chart|
      chart.data "Line green", charts[name].values, '00ff00'
      chart.axis :x, :labels => charts[name].keys.collect{|k| @a ||= 0; @a += 1; (@a % 2) == 0 ? k : nil }, :font_size => 12
      chart.show_legend = false
    end
  end
end
