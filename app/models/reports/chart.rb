require_relative 'base'

module Report
  class Chart < Base
    require 'google_chart'

    attr_reader :title, :data



    def graph(args = {})
      width = args[:width] || 300
      height = args[:height] || width / 2
      size = args[:size] || "#{width}x#{height}"
      label_control = args[:label_control] || max_labels(args[:max_labels]) || all_labels
      GoogleChart::BarChart.new(size, title, :vertical, false) do |chart|
        chart.data "Line green", data.values, '00ff00'
        chart.axis :x, :labels => data.keys.collect(&label_control), :font_size => 12, :alignment => :center
        chart.axis :y, :range => [0, data.values.max]
        chart.show_legend = false
        chart_margin = 20
        bar_width = ((width - chart_margin) / data.values.length) - 5
        chart.width_spacing_options(:bar_width => bar_width.to_i, :bar_spacing => 1, :group_spacing => 1)
      end
    end

    private

    def answers_per_session
      @x_axis_label = 'Occurances'
      @y_axis_label = 'Answers in session'
      answers_per_session = AnswerStore.joins(:answers).group('answer_stores.id').count.values
      Hash[answers_per_session.uniq.sort.collect{|n| [n, answers_per_session.count(n)]}]
    end

    def questionnaires_per_day
      @x_axis_label = 'Questionnaires'
      @y_axis_label = 'Day'
      AnswerStore.joins(:questionnaires).group("DATE_FORMAT(answer_stores.updated_at, '%d%b%y')").count
    end

    def max_labels(number)
      if number
        interval = interval_for_max_labels(data.values.length, number)
        label_every(interval)
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

    def interval_for_max_labels(data_length, max_labels)
      ((data_length - 1)/ max_labels) + 1
    end      
  end
end
