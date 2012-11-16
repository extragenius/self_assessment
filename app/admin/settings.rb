ActiveAdmin.register Setting do

  index do
    column :name
    column :description
    column :value
    default_actions
  end

  form do |f|
    f.inputs "Details" do
      f.input :name
      f.input :value
      f.input(
        :value_type,
        :as => :select,
        :collection => Setting.value_types.collect{|t| [t.humanize, t]}
      )
      f.input :description
    end
    f.buttons
  end

end
