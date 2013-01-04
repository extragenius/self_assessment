class ReportsController < ApplicationController
  require 'google_chart'
  
  def index
    max_labels = 2
    @charts = Hash.new
    charts.keys.each{|chart| @charts[chart] = chart_for(chart, :label_control => label_every(charts[chart].length / max_labels))}
  end

  def show
    
    chart = params[:id].respond_to?(:to_sym) ? params[:id].to_sym : nil
    
    if chart
      @chart = chart_for(chart, :width => 600, :height => 400)
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
  
  def chart_for(name, args = {})
    width = args[:width] || 300
    height = args[:height] || width / 2
    size = args[:size] || "#{width}x#{height}"
    label_control = args[:label_control] || all_labels
    GoogleChart::BarChart.new(size, name.to_s.humanize, :vertical, false) do |chart|
      chart.data "Line green", charts[name].values, '00ff00'
      chart.axis :x, :labels => charts[name].keys.collect(&label_control), :font_size => 12, :alignment => :center
      chart.show_legend = false
      bar_width = (width / charts[name].values.length) - 5
      @bar_widths ||= []
      @bar_widths << bar_width
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
    lambda {|k| @a ||= 0; @a += 1; (@a % points) == 0 ? k : nil }
  end
end
