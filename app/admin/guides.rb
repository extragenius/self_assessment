ActiveAdmin.register Guide do
  
  menu :parent => "Under the bonnet"
  
  controller do
    defaults :finder => :find_by_name
  end
  
  config.sort_order = "position_asc"
  
  form do |f|
    f.inputs "Guide" do
      f.input :name
      f.input :title
      f.input :summary, :input_html => { :rows => 3 }
      if defined?(Ckeditor)
        f.input :details, :input_html => { :class => "ckeditor", :height => 66  }
      else
        f.input :details, :input_html => { :rows => 6 }
      end
    end
    
    f.buttons
  end
  
  show do
    h3 guide.title
    div do
      simple_format guide.summary
    end
    
    div do
      sanitize guide.details
    end
    
    active_admin_comments
  end
  
  index do
    column "Name" do |guide|
      link_to guide.name, admin_guide_path(guide)
    end
    column :title
    column :summary
    column "Position" do |guide|
      text = [guide.position]
      text << 'Move:'
      text << link_to('Up', move_up_admin_guide_path(guide)) unless guide.first?
      text << link_to('Down', move_down_admin_guide_path(guide)) unless guide.last?
      text.join("\n").html_safe
    end
    
    default_actions
  end
  
  member_action :move_up do
    guide = Guide.find_by_name(params[:id])
    guide.insert_at(guide.send('bottom_position_in_list')) unless guide.position? 
    guide.move_higher
    guide.save
    redirect_to admin_guides_path  
  end

  member_action :move_down do
    guide = Guide.find_by_name(params[:id])
    guide.insert_at unless guide.position? 
    guide.move_lower
    guide.save
    redirect_to admin_guides_path    
  end
  
end
