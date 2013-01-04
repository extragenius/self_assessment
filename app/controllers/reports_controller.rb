class ReportsController < ApplicationController
  require 'google_chart'
  
  def index
    @charts = Hash.new
    charts.keys.each do|chart| 
      interval = interval_for_max_labels chart, 5
      label_control = label_every(interval)
      @charts[chart] = report_for(chart, :label_control => label_control)
      
    end
  end
  
  def show
    chart = params[:id].respond_to?(:to_sym) ? params[:id].to_sym : nil
    
    if chart
      interval = interval_for_max_labels chart, 10
      label_control = label_every(interval)
      @chart = report_for(chart, :width => 600, :label_control => label_control)
    else
      flash[:alert] = "Chart '#{params[:id]}' not found"
      redirect_to :action => :index
    end
  end
  
  private
  def charts
    {
      :questionnaires_per_session => questionnaires_per_session,
      :answers_per_session => answer_per_session,
      :most_used_questionnaires => most_used_questionnaires,
      :most_used_answers => most_used_answers
    }
  end
  
  def answer_per_session
    answers_per_session = AnswerStore.joins(:answers).group('answer_stores.id').count.values
    Hash[answers_per_session.uniq.sort.collect{|n| [n, answers_per_session.count(n)]}]
  end
  
  def questionnaires_per_session
    AnswerStore.joins(:questionnaires).group("DATE_FORMAT(answer_stores.updated_at, '%d%b%y')").count
  end
  
  def most_used_answers
    answers = Answer.joins(:answer_stores).group('answers.id').order('COUNT(*) DESC').limit(10).count
    answers.keys.collect do |id|
      answer = Answer.find(id)
      "[#{answers[id]}] #{answer.value} :- '#{answer.question.title}'"
    end
  end
  
  def most_used_questionnaires
    questionnaires = Questionnaire.joins(:answer_stores).group('questionnaires.id').order('COUNT(*) DESC').limit(10).count
    questionnaires.keys.collect do |id|
      questionnaire = Questionnaire.find(id)
      "[#{questionnaires[id]}] #{questionnaire.title}"
    end
  end
  
  def report_for(chart, args = {})
    if charts[chart].kind_of? Hash
      chart_for(chart, args)
    else
      charts[chart]
    end
  end
  
  def chart_for(name, args = {})
    width = args[:width] || 300
    height = args[:height] || width / 2
    size = args[:size] || "#{width}x#{height}"
    label_control = args[:label_control] || all_labels
    GoogleChart::BarChart.new(size, name.to_s.humanize, :vertical, false) do |chart|
      data = charts[name]
      chart.data "Line green", data.values, '00ff00'
      chart.axis :x, :labels => data.keys.collect(&label_control), :font_size => 12, :alignment => :center
      chart.axis :y, :range => [0, data.values.max]
      chart.show_legend = false
      chart_margin = 20
      bar_width = ((width - chart_margin) / data.values.length) - 5
      chart.width_spacing_options(:bar_width => bar_width.to_i, :bar_spacing => 1, :group_spacing => 1)
    end
  end
  
  def all_labels
    lambda {|k| k}
  end
  
  def every_other_label
    label_every 2
  end
  
  def label_every(points)
    return all_labels if points == 0
    
    lambda {|k| @a ||= 0; @a += 1; (@a % points) == 0 ? k : nil }
  end
  
  def interval_for_max_labels(chart_name, max_labels)
    ((charts[chart_name].length - 1)/ max_labels) + 1
  end  
end
