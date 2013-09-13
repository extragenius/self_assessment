ActiveAdmin.register Ominous::Warning do
  
  actions :all, :except => [:destroy]
  
  menu :label => "Warnings", :parent => "Under the bonnet"
  
  index do
    column :name
    column :closers do |warning|
      ul do
        warning.closers.collect(&:name).each do |closer|
          li closer
        end
      end
    end
    default_actions
  end
  
  show do
    div :style => 'border:red solid 2px;padding:10px;margin-bottom:10px;' do
      h2 ominous_warning.title
      div sanitize ominous_warning.description

      ominous_warning.closers.each do |closer|
        div :style => 'border:silver solid 2px;padding:10px;' do
          div sanitize closer.message
          para link_to closer.link_text, closer.url
        end
      end
    end
    
    h3 'Closers'
    
    table :class => 'sortable_list' do
      tr do
        th 'Name'
        th 'Closure method'
        th 'Starts hidden'        
        th 'Text'
        th 'Link text'
      end
      ominous_warning.closers.each do |closer|
        tr do
          td closer.name
          td closer.closure_method.humanize
          td (closer.start_hidden? ? 'true' : 'false')        
          td closer.message
          td closer.link_text
        end
      end
    end
    
    h3 'Closure method behaviours'
    table do
      Ominous::Closer.closure_methods.each do |name, behaviour|
        tr do
          td name.to_s.humanize
          td behaviour
        end
      end
    end
  end
  
  form do |f|
    f.inputs "Warning" do
      f.input :name
      f.input :title
      if defined?(Ckeditor)
        f.input :description, :input_html => { :class => "ckeditor", :height => 66  }
      else
        f.input :description, :input_html => { :rows => 2}
      end
    end
    
    f.inputs do
      f.has_many :closers do |closer_form|
        closer_form.input :name
        if defined?(Ckeditor)
          closer_form.input :message, :input_html => { :class => "ckeditor", :height => 66  }
        else
          closer_form.input :message, :input_html => { :rows => 2}
        end
        closer_form.input :link_text
        closer_form.input :url, :label => 'Url: Only for redirects'
        closer_form.input(
          :closure_method, 
          :as => :select, 
          :collection => Ominous::Closer.closure_methods.keys.collect{|m| [m.to_s.humanize, m]}
        )
        closer_form.input :start_hidden
      end
    end
    
    f.buttons
  end
  
  controller do
    
    def new
      @ominous_warning = Ominous::Warning.new
      @ominous_warning.closers = [Ominous::Closer.new]
    end
    
  end
  
end
