#
# Cookbook:: blog
# Recipe:: default
#
# Copyright:: 2022, The Authors, All Rights Reserved.

document_root = '/var/www/html'
apache_port   = '8080'
mysql_port    = '3306'
mysql_version = '8.0'
wp_version    = '5.7'
wp_owner      = 'vagrant'
wp_host       = 'localhost'
db_name       = 'wordpress'
db_user       = 'wpuser'
db_pass       = 'wppass'

############## Apache ##############

apache2_install 'default' do
    mpm 'prefork'
    apache_user wp_owner
    apache_group wp_owner
    listen [ apache_port ]
end

service 'apache2' do
    service_name lazy { apache_platform_service_name }
    supports restart: true, status: true, reload: true
    action :nothing
end

apache2_default_site 'localhost' do
    default_site_name wp_host
    site_action :enable
    template_cookbook 'blog'
    template_source 'virtual-hosts.conf.erb'
    port apache_port
    variables(
      server_name: wp_host,
      document_root: document_root
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
apache2_module "rewrite"

file "#{document_root}/info.php" do
    content "<?php\nphpinfo();\n?>"
end

############## Firewall ##############

if platform_family?('rhel')
    execute 'Add HTPP firewall rule' do
        command "sudo firewall-cmd --permanent --zone=public --add-port=#{apache_port}/tcp"
    end
    execute 'Add MySQL firewall rule' do
        command "sudo firewall-cmd --permanent --zone=public --add-port=#{mysql_port}/tcp"
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
    package 'php-curl'
    package 'php-gd'
    package 'php-mbstring'
    package 'php-xml'
    package 'php-xmlrpc'
    package 'php-soap'
    package 'php-intl'
    package 'php-zip'
end

if platform_family?('rhel')
    package 'php-mysqlnd'
    package 'php-json'
    package 'php-gd'
end

############## MySQL ##############

if platform_family?('rhel')
    yum_mysql_community_repo 'default' do
        version mysql_version
        gpgcheck true
        mysql_community_server true
    end
end  

if platform_family?('debian')
    mysql_service 'default' do
        version mysql_version
        action [:create, :start]
    end

    mysql_client 'default' do
        action :create
    end

    mysql_database 'default' do
        host wp_host
        database_name db_name
        action :create
    end
      
    mysql_user 'default' do
        username db_user
        password db_pass
        database_name db_name
        host wp_host
        privileges [:all]
        grant_option true
        action [:create,:grant]
    end
end  

if platform_family?('rhel')
    mysql_service 'default' do
        version mysql_version
        initial_root_password 'root'
        action [:create, :start]
    end

    mysql_client 'default' do
        action :create
    end

    mysql_database 'default' do
        host wp_host
        user 'root'
        password 'root'
        database_name db_name
        action :create
    end
      
    mysql_user 'default' do
        ctrl_user 'root'
        ctrl_password 'root'
        username db_user
        password db_pass
        database_name db_name
        host wp_host
        privileges [:all]
        grant_option true
        action [:create,:grant]
    end
end

############## Wordpress CLI ##############

execute 'change owner and group' do
    command "sudo chown -R #{wp_owner}:#{wp_owner} #{document_root}"
end

bash 'Install Wordpress CLI' do
    cwd '/tmp'
    code <<-EOH
    curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
    chmod +x wp-cli.phar
    sudo mv wp-cli.phar /usr/bin/wp
    EOH
end

execute 'Download Wordpress' do
    command "sudo -u #{wp_owner} -i -- wp core download --path=#{document_root} --version=#{wp_version}"
end

execute 'Create Wordpress configuration' do
    command "sudo -u #{wp_owner} -i -- wp config create --path=#{document_root} --dbname=#{db_name} --dbuser=#{db_user} --dbpass=#{db_pass}"
end

execute 'Wordpress initial setup' do
    command "sudo -u #{wp_owner} -i -- wp core install --path=#{document_root} --url=http://#{wp_host}:#{apache_port} --title=Test --admin_name=jonatan --admin_password=password --admin_email=jonatan@example.com"
end

execute 'Add post' do
    command "sudo -u #{wp_owner} -i -- wp post create --path=#{document_root} --post_type=post --post_title='First post' --post_author='1' --post_content='Finally working!' --post_status=publish"
end