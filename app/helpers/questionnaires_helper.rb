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
    classes = %w{button btn}
    classes << 'visited btn-success' if @qwester_answer_store and @qwester_answer_store.questionnaires.include? questionnaire
    classes.join(" ")
  end

  def presentation_description
    if @presentation and @presentation.description?
      content = [content_tag(
        'h2',
        @presentation.title
      )]
      content << content_tag(
                   'div',
                   sanitize(@presentation.description),
                   :class => 'description'
                 ) if @presentation.description?
      content_tag 'div', content.join("\n").html_safe, :class => 'presentation'
    end
  end

end
