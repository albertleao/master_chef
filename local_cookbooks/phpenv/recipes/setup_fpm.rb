ruby_block "insert_php_ini" do
  block do
    file = Chef::Util::FileEdit.new("/etc/php/7.0/fpm/php.ini")
    file.insert_line_if_no_match("/upload_max_filesize=20M/", "upload_max_filesize=20M")
    file.insert_line_if_no_match("/memory_limit=64M/", "memory_limit=64M")
    file.insert_line_if_no_match("/post_max_size=20M/", "post_max_size=20M")
    file.insert_line_if_no_match("/short_open_tag=On/", "short_open_tag=On")
    file.write_file
  end
end

template '/etc/php/7.0/fpm/pool.d/www.conf' do
  source 'fpm_conf.erb'
  mode '0440'
  owner 'root'
  group 'root'
end

execute "enable_proxy" do
  user "root"
  command "a2enmod proxy_fcgi setenvif"
end

execute "enable_fpm" do
  user "root"
  command "a2enconf php7.0-fpm"
end