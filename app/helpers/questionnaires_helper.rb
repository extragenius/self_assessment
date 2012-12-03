module QuestionnairesHelper
  
  def answers_radio_buttons(question)
    button_name = "question_id[#{question.id}][answer_ids][]"
    answers = question.answers
    buttons = answers.collect do |answer|
      
      button = radio_button_tag(button_name, answer.id)
      content_tag('li', "#{button}#{answer.value.humanize}".html_safe)
    end
    buttons.join.html_safe
  end
  
  def current_answer_for(question, default)
    current_answer_from_store_for(question) || default
  end
  
  def current_answer_from_store_for(question)
    if @answer_store
      answer = @answer_store.answer_for(question)
      answer.value if answer
    end
  end
  
  def tag_page(name, url)
    content_tag(
        'div',
        content_tag(
          'iframe',
          nil,
          :src => url,
          :width => '100%',
          :height => '800px'
        ),
        :id => name
      ) 
  end
  
end
