module QuestionnairesHelper
  
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
    classes << 'visited' if @qwester_answer_store and @qwester_answer_store.questionnaires.include? questionnaire
    classes.join(" ")
  end

end
