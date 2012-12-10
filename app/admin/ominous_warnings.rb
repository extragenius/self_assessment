ActiveAdmin.register Ominous::Warning do
  
  index do
    column :name
    column :closers do |warning|
      ul do
        warning.closers.collect(&:name).each do |closer|
          li closer
        end
      end
    end
  end
  
end
