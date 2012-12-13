ActiveAdmin.register Translation, :as => 'Translations' do
  
  menu :label => "Translations", :parent => "Under the bonnet"
  
  config.sort_order = "key_desc"
  
  index do
    column :locale
    column :key do |translation|
      translation.key.gsub(/\./, ".<br/>").html_safe
    end
    column :value
  end
  
  form do |f|
    f.inputs "Details" do
      f.input :locale
      f.input :key
      f.input :value
    end
    f.buttons
  end
  
end
