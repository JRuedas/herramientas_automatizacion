#
# Cookbook:: blog
# Recipe:: default
#
# Copyright:: 2022, The Authors, All Rights Reserved.

document_root = '/var/www/html'
apache_port   = '80'
host          = 'localhost'
db_name = 'wordpress'
wp_owner = 'vagrant'

############## Apache ##############

apache2_install 'default' do
    mpm 'prefork'
    apache_user 'vagrant'
    apache_group 'vagrant'
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

############## Firewall ##############

if platform_family?('rhel')
    execute 'Add HTPP firewall rule' do
        command "sudo firewall-cmd --permanent --zone=public --add-port=80/tcp"
    end
    execute 'Add MySQL firewall rule' do
        command "sudo firewall-cmd --permanent --zone=public --add-port=3306/tcp"
    end
    execute 'Reload firewall rules' do
        command "sudo firewall-cmd --reload"
    end
end

############## SELinux ##############

if platform_family?('rhel')
    execute 'Add SELinux rule to allow MySQL connections' do
        command "sudo setsebool -P httpd_can_network_connect_db 1"
    end
end

############## PHP ##############

## Only the mysql extension because Apache PHP mod installs PHP

if platform_family?('debian')
    package 'php-mysqli'
end

if platform_family?('rhel')
    package 'php-mysqlnd'
    package 'php-json'
end

############## MySQL ##############

if platform_family?('rhel')
    yum_mysql_community_repo 'default' do
        version '8.0'
        gpgcheck true
        mysql_community_server true
    end
end  

mysql_service 'default' do
    version '8.0'
    initial_root_password 'root'
    action [:create, :start]
end

mysql_client 'default' do
    action :create
end

# mysql_config 'default' do
#     source 'security_stuff.cnf.erb'
#     variables(:foo => 'bar')
#     action :create
#     notifies :restart, 'mysql_service[default]'
# end

# cookbook_file "/tmp/disable_root_auth_socket.sql" do
#     source 'disable_root_auth_socket.sql'
#     not_if do
#         File.exist?("/tmp/disable_root_auth_socket.sql")
#     end
# end

# execute "enable native password mysql auth" do
#     command "mysql -u root -proot < /tmp/disable_root_auth_socket.sql"
#     user "root"
# end

mysql_database 'default' do
    host 'localhost'
    user 'root'
    password 'root'
    database_name 'wordpress'
    action :create
end
  
mysql_user 'default' do
    ctrl_user 'root'
    ctrl_password 'root'
    username 'wpuser'
    password 'wppass'
    database_name 'wordpress'
    host 'localhost'
    privileges [:all]
    grant_option true
    action [:create,:grant]
end

############## Wordpress ##############

bash 'install wordpress' do
    cwd '/tmp'
    code <<-EOH
    curl -O https://wordpress.org/wordpress-5.7.tar.gz
    tar xzvf wordpress-5.7.tar.gz
    cp ./wordpress/wp-config-sample.php ./wordpress/wp-config.php
    sudo cp -a ./wordpress/. /var/www/html
    EOH
end

file '/var/www/html/wp-config.php' do
    action :delete
end

cookbook_file "#{document_root}/wp-config.php" do
    source 'wp-config.php'
    not_if do
        File.exist?("#{document_root}/wp-config.php")
    end
end

############## Wordpress CLI ##############

bash 'install wordpress cli' do
    cwd '/tmp'
    code <<-EOH
    curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
    chmod +x wp-cli.phar
    sudo mv wp-cli.phar /usr/bin/wp
    EOH
end

execute 'configure wordpress' do
    command "sudo -u #{wp_owner} -i -- wp core install --path=#{document_root} --url=http://localhost:80 --title=Test --admin_name=jonatan --admin_password=password --admin_email=jonatan@example.com"
end

execute 'configure wordpress' do
    command "sudo -u #{wp_owner} -i -- wp post create --path=#{document_root} --post_type=post --post_title='First post' --post_author='1' --post_content='Finally working!' --post_status=publish"
end