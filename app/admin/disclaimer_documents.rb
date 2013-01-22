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
    div disclaimer_document.header
    disclaimer_document.segments.each do |s|
      div do
        "#{content_tag(:strong, s.title)}<br>#{s.body}".html_safe
      end
    end
    div disclaimer_document.footer
  end
  
  form do |f|
    f.inputs do
      f.input :name
      f.input :title
      f.input :header
     
      f.input(
          :segments, 
          :as => :check_boxes, 
          :collection => Disclaimer::Segment.all
      ) if Disclaimer::Segment.exists?
    
      f.input :footer
    end
    
    f.buttons
  end
  
end
