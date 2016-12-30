search("aws_opsworks_app").each do |app|
  if app['deploy'] == false do
    directory "/srv/www/#{app['shortname']}" do
      recursive true
      action :delete
    end

    file "/etc/apache2/sites-enabled/#{app['shortname']}.conf" do
      action :delete
      only_if { File.exist? "/etc/apache2/sites-enabled/#{app['shortname']}.conf" }
    end
  end
end