#
# Cookbook:: blog
# Recipe:: default
#
# Copyright:: 2022, The Authors, All Rights Reserved.

document_root = '/var/www/html'
apache_port   = '8080'
host          = 'localhost'

############## Apache ##############

apache2_install 'default' do
    mpm 'prefork'
    listen [ apache_port ]
end

service 'apache2' do
    service_name lazy { apache_platform_service_name }
    supports restart: true, status: true, reload: true
    action :nothing
end

apache2_default_site 'localhost' do
    default_site_name host
    site_action :enable
    template_cookbook 'blog'
    template_source 'virtual-hosts.conf.erb'
    port apache_port
    variables(
      server_name: host,
      document_root: document_root,
      log_dir: lazy { default_log_dir },
      site_name: host
    )
end

apache2_site '000-default' do
    action :disable
end
  
apache2_default_site '' do
    action :disable
end

file '/etc/apache2/sites-available/000-default.conf' do
    action :delete
end

file '/etc/apache2/sites-available/default-ssl.conf' do
    action :delete
end

file "#{document_root}/index.html" do
    action :delete
end

apache2_mod_php

file "#{document_root}/info.php" do
    content "<?php\nphpinfo();\n?>"
end

############## PHP ##############

## TODO: Not necessary because Apache PHP mod installs PHP

############## MySQL ##############

mysql_service 'default' do
    version '8.0'
    action [:create, :start]
end

mysql_client 'default' do
    action :create
end

mysql_database 'default' do
    host 'localhost'
    database_name 'wordpress'
    action :create
end
  
mysql_user 'default' do
    username 'wpuser'
    password 'wppass'
    database_name 'wordpress'
    host 'localhost'
    privileges [:all]
    grant_option true
    action [:create,:grant]
end

############## Wordpress ##############
