ActiveAdmin.register Disclaimer::Document do
  
  menu :parent => 'Disclaimer', :label => 'Documents' 
  
  controller do
    defaults :finder => :find_by_name
  end
  
  index do
    column :name
    column :title
    column :segments do |document|
      document.segments.collect(&:name).join(', ')
    end
    column :created_at
    default_actions
  end
  
  show do
    h2 disclaimer_document.title
    div sanitize(disclaimer_document.header)
    disclaimer_document.segments.each do |s|
      div do
        "#{content_tag(:strong, s.title)}<br>#{sanitize(s.body)}".html_safe
      end
    end
    div sanitize(disclaimer_document.footer)
  end
  
  form do |f|
    f.inputs do
      f.input :name
      f.input :title
      if defined?(Ckeditor)
        f.input :header, :input_html => { :class => "ckeditor", :height => 100  }
      else
        f.input :header, :input_html => { :rows => 3}
      end
     
      f.input(
          :segments, 
          :as => :check_boxes, 
          :collection => Disclaimer::Segment.all
      ) if Disclaimer::Segment.exists?
    
      if defined?(Ckeditor)
        f.input :footer, :input_html => { :class => "ckeditor", :height => 100  }
      else
        f.input :footer, :input_html => { :rows => 3}
      end
    end
    
    f.buttons
  end
  
end
