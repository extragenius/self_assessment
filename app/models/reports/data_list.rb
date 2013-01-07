require_relative 'base'
module Report
  class DataList < Base

    attr_reader :title, :data, :headings


    private
    def most_used_answers
      @headings = ['Freq.', 'Answer', 'Question']
      answers = Answer.joins(:answer_stores).group('answers.id').order('COUNT(*) DESC').limit(10).count
      answers.keys.collect do |id|
        answer = Answer.find(id)
        [answers[id], answer.value, answer.question.title]
      end
    end

    def most_used_questionnaires
      @headings = ['Freq.', 'Questionnaire']
      questionnaires = Questionnaire.joins(:answer_stores).group('questionnaires.id').order('COUNT(*) DESC').limit(10).count
      questionnaires.keys.collect do |id|
        questionnaire = Questionnaire.find(id)
        [questionnaires[id], questionnaire.title]
      end
    end
  end
end
