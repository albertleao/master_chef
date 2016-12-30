execute "disable_mpm_event" do
  action :nothing
  user "root"
  command "a2dismod mpm_event"
  notifies :run, 'execute[enable_mpm_prefork]', :delayed
end

execute "enable_mpm_prefork" do
  action :nothing
  user "root"
  command "a2enmod mpm_prefork"
  notifies :run, 'execute[restart_server]', :delayed
end

execute "restart_server" do
  action :nothing
  user "root"
  command "service apache2 restart"
end