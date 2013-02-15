class AnswersController < ApplicationController
  
  layout 'tab_content'
  
  def index
    @unanswered = Questionnaire.all
    if @qwester_answer_store
      questionnaires = @qwester_answer_store.questionnaires
      @questionnaires = Hash[questionnaires.collect{|q| [q, (q.answers & @qwester_answer_store.answers)]}]
      @unanswered.delete_if{|q| @questionnaires.keys.collect(&:id).include? q.id}
    else
      @questionnaires = {}
    end
    
    respond_to do |format|
      format.html
      format.pdf do
        pdf = Summary.new(request, @qwester_answer_store)
        send_data(
          pdf.render, 
          filename: "WCC_online_self_support_#{Time.now.to_s(:filename)}.pdf",
          type: "application/pdf"
        )
      end
    end
  end
end
