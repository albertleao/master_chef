execute "restart_server" do
  user "root"
  command "service apache2 graceful"
  notifies :run, 'execute[restart_fpm]', :immediately
end

execute "restart_fpm" do
  action :nothing
  user "root"
  command "service php7.0-fpm restart"
end