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
    
    f.inputs do
      f.has_many :closers do |closer_form|
        closer_form.input :name, :label => 'Name used in locale file'
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
  
#  controller do
#    
#    def new
#      @ominous_warning = Ominous::Warning.new
#      @ominous_warning.closers = [Ominous::Closer.new]
#    end
#    
#  end
  
end
