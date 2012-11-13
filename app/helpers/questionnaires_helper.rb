module QuestionnairesHelper
  
  def answers_radio_buttons(object, args = {})
    button_name = "answers[#{object.class.to_s.underscore}_id[#{object.id}]]"
    buttons = args[:options].collect do |option|
      button = radio_button_tag(button_name, option, option == args[:checked])
      "#{option.humanize}#{button}".html_safe
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
