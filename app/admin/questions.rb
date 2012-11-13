ActiveAdmin.register Question do

  index do
    column :title do |question|
      link_to(question.title, '#', :title => question.description, :class => 'no_decoration')
    end
    default_actions
  end

  form do |f|
    f.inputs "Details" do
      f.input :title
      f.input :description, :input_html => { :rows => 2}
    end
    f.buttons
  end

end
