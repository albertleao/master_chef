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
  if app['deploy'] == true
    Chef::Log.info("********** #{app['shortname']} is being deployed **********")
    
    #delete current .conf file
    file "/etc/var/apache2/sites-enabled/#{app['shortname']}.conf" do
      action :delete
    end

    #Delete the current project directory
    directory "/srv/www/#{app['shortname']}" do
      recursive true
      action :delete
    end

    #Deploy the application
    application "/srv/www/#{app['shortname']}" do
      # Application resource properties.
      owner 'root'
      group 'root'

      # Pull from GIT
      application_git "/srv/www/#{app['shortname']}" do
        repository app['app_source']['url']
        deploy_key app['app_source']['ssh_key']
        revision app['app_source']['revision']
      end
      
      # Setup apache2
      web_app "#{app['shortname']}" do
         server_name "#{app['domains'].first}"

         unless app['domains'][1, app['domains'].size].empty?
           server_aliases app['domains'][1, app['domains'].size]
         end
         docroot "/srv/www/#{app['shortname']}/#{app['attributes']['document_root']}"
         env_vars app['environment']
         template 'web_app.conf.erb'

         apache_module "mpm-event" do
          conf false
        end
      end

      #Run Composer
      composer_project "/srv/www/#{app['shortname']}" do
          dev false
          quiet true
          prefer_dist false
          optimize_autoloader true
          action :install
      end
    end
  end
end