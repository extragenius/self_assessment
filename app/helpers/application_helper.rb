module ApplicationHelper
  
  def error_messages_for(item)
    if item.errors.any? 
      messages = item.errors.full_messages.collect{|m| content_tag('li', m)}
      title = content_tag('h2', "#{item.class.to_s}: Error detected")
      list = content_tag('ul', messages.join.html_safe)
      content_tag('div', [title, list].join.html_safe, :class => 'error_explanation')
    end  
  end
end
