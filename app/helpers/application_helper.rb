module ApplicationHelper
  
  def error_messages_for(item)
    if item.errors.any? 
      messages = item.errors.full_messages.collect{|m| content_tag('li', m)}
      title = content_tag('h2', "#{item.class.to_s}: Error detected")
      list = content_tag('ul', messages.join.html_safe)
      content_tag('div', [title, list].join.html_safe, :class => 'error_explanation')
    end  
  end
  
  def page_title(root_text)
    title = Setting.for(:site_name, root_text)
    return title if current_page?(root_path)
    [title, controller_name.humanize, params[:id]].compact.join(": ")
  end
end
