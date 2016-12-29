directory "/etc/var/apache2/sites-enabled/" do
  recursive true
  action :delete
end

directory "/etc/var/apache2/sites-available/" do
  recursive true
  action :delete
end

directory '/srv/www' do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

search("aws_opsworks_app").each do |app|
  application "/srv/www/#{app['shortname']}" do
    # Application resource properties.
    owner 'root'
    group 'root'

    # Subresources, like normal recipe code.
    application_git "/srv/www/#{app['shortname']}" do
      repository app['app_source']['url']
      deploy_key app['app_source']['ssh_key']
      revision app['app_source']['revision']
    end
    
    web_app "#{app['shortname']}" do
       server_name "#{app['shortname']}"
       server_aliases app['domains']
       docroot "/srv/www/#{app['shortname']}/#{app['attributes']['document_root']}"
       env_vars app['environment']
       template 'web_app.conf.erb'
    end
  end
end

service "apache2" do
  action :restart
end