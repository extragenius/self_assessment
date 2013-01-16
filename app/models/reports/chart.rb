require_relative 'base'

module Report
  class Chart < Base
    require 'lazy_high_charts'

    attr_reader :x_axis_label, :y_axis_label, :x_axis_title, :y_axis_title

    def x_axis_rotation
      @x_axis_rotation || 0
    end

    private

    def answers_per_session
      @y_axis_label = 'Occurance'
      @x_axis_label = 'Answer'
      @y_axis_title = 'Occurances'
      @x_axis_title = 'Answers per session'
      answers_per_session = AnswerStore.joins(:answers).group('qwester_answer_stores.id').count.values
      Hash[answers_per_session.uniq.sort.collect{|n| [n, answers_per_session.count(n)]}]
    end

    def questionnaires_per_day
      @y_axis_label = 'Questionnaires'
      @x_axis_label = 'Day'
      @y_axis_title = 'Questionnaires'
      @x_axis_rotation = 90
      AnswerStore.joins(:questionnaires).group("DATE_FORMAT(qwester_answer_stores.updated_at, '%d-%b-%y')").count
    end
     
  end
end
