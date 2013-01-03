class ReportsController < ApplicationController
  require 'google_chart'
  
  def index
    
    @charts = charts.keys.collect{|name| chart_for(name)}

  end

  def show
    

    
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
  
  def chart_for(name, size = "400x200")
    GoogleChart::BarChart.new(size, name.to_s.humanize, :vertical, false) do |chart|
      chart.data "Line green", charts[name].values, '00ff00'
      chart.axis :x, :labels => charts[name].keys.collect{|k| @a ||= 0; @a += 1; (@a % 2) == 0 ? k : nil }, :font_size => 12
      chart.show_legend = false
    end
  end
end
