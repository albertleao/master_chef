execute "install_latest_php" do
  user "root"
  command "apt-get install php7.0 libapache2-mod-php7.0 php7.0-mysql mcrypt php7.0-mcrypt php-imagick php7.0-curl php7.0-gd php7.0-intl php7.0-imap php7.0-xmlrpc  php7.0-pspell php7.0-recode php7.0-tidy php-apcu php7.0-json php7.0-mbstring php7.0-xml php7.0-bcmath php-redis php-gettext php-pear php7.0-fpm -y --force-yes"
  notifies :run, 'execute[enable_php_mods]', :immediately
end

execute "enable_php_mods" do
  user "root"
  command "a2enmod php7.0"
  command "a2dismod mpm_event"
  command "a2enmod mpm_prefork"
  notifies :run, 'execute[cleanup_install]', :immediately
end

execute "cleanup_install" do
  user "root"
  command "apt-get autoremove -y --force-yes"
  notifies :run, 'execute[restart_server]', :immediately
end

execute "restart_server" do
  user "root"
  command "service apache2 restart"
  action :nothing
end