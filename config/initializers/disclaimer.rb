
if Rails.env == 'production'
  Disclaimer.host_app_root_path= Rails.root.to_s.match(/\/\w+$/)[0]
end
