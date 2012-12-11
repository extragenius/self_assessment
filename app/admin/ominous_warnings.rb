ActiveAdmin.register Ominous::Warning do
  
  actions :all, :except => [:destroy]
  
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
          td t("ominous.warning.#{ominous_warning.name}.#{closer.name}.message")
          td t("ominous.warning.#{ominous_warning.name}.#{closer.name}.link")
        end
      end
    end
    
    para 'Text and link text defined in locale file (e.g. /config/locales/en.yml)'
    
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
    end
    
    f.has_many :closers do |closer_form|
      closer_form.input :name, :label => 'Name used in locale file'
      closer_form.input :url, :label => 'Url: Only for redirects'
      closer_form.input(
        :closure_method, 
        :as => :select, 
        :collection => Ominous::Closer.closure_methods.keys
      )
      closer_form.input :start_hidden
    end
    
    f.buttons
  end
  
end
