module QuestionnairesHelper
  
  def answers_radio_buttons(question)
    button_name = "question_id[#{question.id}][answer_ids][]"
    answers = question.answers
    buttons = answers.collect do |answer|
      checked = @answer_store and @answer_store.answers.include? answer
      if question.multi_answer?
        button = check_box_tag(button_name, answer.id, answer_checked(answer))
      else
        button = radio_button_tag(button_name, answer.id, answer_checked(answer))
      end
      content_tag('li', "#{button}#{answer.value}".html_safe)
    end
    buttons.join.html_safe
  end

  def answer_checked(answer)
    answer_store_answers.include? answer
  end
  
  def answer_store_answers
    @answer_store_answers ||= get_answer_store_answers
  end
  
  def get_answer_store_answers
    @answer_store ? @answer_store.answers : []
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
  
  def questionnaire_button_classes(questionnaire)
    classes = %w{button}
    classes << 'visited' if @answer_store and @answer_store.questionnaires.include? questionnaire
    classes.join(" ")
  end

end
