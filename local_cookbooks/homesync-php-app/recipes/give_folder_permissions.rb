search("aws_opsworks_app").each do |app|
  if app['deploy'] == true
    app_root = "/srv/www/#{app[:shortname]}"
    execute "chmod -R g+rw #{app_root}" do
    end
    execute "chmod -R 0777 #{app_root}/vendor" do
    end
    execute "chmod -R 0777 #{app_root}/storage" do
    end
  end
end