module AnswersHelper
  
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
