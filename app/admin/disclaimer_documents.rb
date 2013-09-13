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
    disclaimer_document.segments.each do |segment|
      div do
        links = ['Move: ']
        links << link_to(
                   'Up',
                   move_up_admin_disclaimer_document_path(
                     disclaimer_document,
                     segment_id: segment
                   ),
                   class: 'btn'
                 ) unless disclaimer_document.first?(segment)
        links << link_to(
                   'Down',
                   move_down_admin_disclaimer_document_path(
                     disclaimer_document,
                     segment_id: segment
                   ),
                   class: 'btn'
                 ) unless disclaimer_document.last?(segment)
        header = [content_tag(:strong, segment.title)]
        header << "("
        header << links.join("\n").html_safe
        header << ")"
        html = [header]
        html << content_tag('div', sanitize(segment.body))
        html.join("\n").html_safe
      end
    end
    div sanitize(disclaimer_document.footer)
  end

  member_action :move_up do
    document = Disclaimer::Document.find_by_name(params[:id])
    segment = Disclaimer::Segment.find_by_name(params[:segment_id])
    document.move_higher(segment)
    redirect_to admin_disclaimer_document_path(document)
  end

  member_action :move_down do
    document = Disclaimer::Document.find_by_name(params[:id])
    segment = Disclaimer::Segment.find_by_name(params[:segment_id])
    document.move_lower(segment)
    redirect_to admin_disclaimer_document_path(document)
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
