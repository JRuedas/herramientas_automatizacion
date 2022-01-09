############## Apache ##############

apache2_install 'default' do
    mpm 'prefork'
    apache_user node['blog']['wp_owner']
    apache_group node['blog']['wp_owner']
    listen [ node['blog']['apache_port'] ]
end

service 'apache2' do
    service_name lazy { apache_platform_service_name }
    supports restart: true, status: true, reload: true
    action :nothing
end

apache2_default_site 'localhost' do
    default_site_name node['blog']['wp_host']
    site_action :enable
    template_cookbook 'blog'
    template_source 'virtual-hosts.conf.erb'
    port node['blog']['apache_port']
    variables(
      server_name: node['blog']['wp_host'],
      document_root: node['blog']['document_root']
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

file "#{node['blog']['document_root']}/index.html" do
    action :delete
end

apache2_mod_php

############## Firewall & SELinux ##############

if platform_family?('rhel')
    execute 'Add HTPP firewall rule' do
        command "sudo firewall-cmd --permanent --zone=public --add-port=#{node['blog']['apache_port']}/tcp"
        ignore_failure true
    end

    execute 'Add MySQL firewall rule' do
        command "sudo firewall-cmd --permanent --zone=public --add-port=#{node['blog']['mysql_port']}/tcp"
        ignore_failure true
    end
    
    execute 'Reload firewall rules' do
        command "sudo firewall-cmd --reload"
        ignore_failure true
    end

    execute 'Add SELinux rule to allow MySQL connections' do
        command "sudo setsebool -P httpd_can_network_connect_db 1"
    end
end