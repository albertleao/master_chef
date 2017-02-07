apt_package ['php7.0-mysql', 'mcrypt', 'php7.0-mcrypt', 'php-imagick', 'php7.0-curl', 'php7.0-gd', 'php7.0-intl', 'php7.0-imap', 'php7.0-xmlrpc', 'php7.0-pspell', 'php7.0-recode', 'php7.0-tidy', 'php-apcu', 'php7.0-json', 'php7.0-mbstring', 'php7.0-xml', 'php7.0-bcmath', 'php-redis', 'php-gettext', 'php-pear', 'php7.0-fpm'] do
  retries 3
  retry_delay 5
  notifies :run, 'execute[cleanup_install]', :delayed
end

execute "cleanup_install" do
  action :nothing
  user "root"
  command "apt-get autoremove -y --force-yes"
end