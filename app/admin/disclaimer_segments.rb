ActiveAdmin.register Disclaimer::Segment do
  
  menu :parent => 'Disclaimer', :label => 'Segments'
  
  controller do
    defaults :finder => :find_by_name
  end
  
  show do
    h2 disclaimer_segment.title
    div sanitize(disclaimer_segment.body)
  end
  
    
  form do |f|
    f.inputs do
      f.input :name
      f.input :title
      if defined?(Ckeditor)
        f.input :body, :input_html => { :class => "ckeditor", :height => 100  }
      else
        f.input :body, :input_html => { :rows => 3}
      end
    end
    
    f.buttons
  end
end
