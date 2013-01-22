ActiveAdmin.register Disclaimer::Segment do
  
  menu :parent => 'Disclaimer', :label => 'Segments'
  
  controller do
    defaults :finder => :find_by_name
  end
end
