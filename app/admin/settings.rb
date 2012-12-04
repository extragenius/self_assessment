ActiveAdmin.register Setting do

  actions :all, :except => [:destroy]

  index do
    column :description
    column :value
    default_actions
  end

  form do |f|
    f.inputs "Details" do
      f.input :name if action_name == 'new'
      f.input :value
      f.input(
        :value_type,
        :as => :select,
        :collection => Setting.value_types.collect{|t| [t.humanize, t]}
      ) if action_name == 'new'
      f.input :description
    end
    f.buttons
  end

end
