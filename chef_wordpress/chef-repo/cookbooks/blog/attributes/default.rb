# # The name of your site
# default['wordpress']['server_name'] ='test'
# # The root directory of your site, it will be /var/www/yoursitename.com
# default['wordpress']['document_root'] = "/var/www/html"
# # The default config file
# default['wordpress']['default_conf'] = '/var/www/html/virtual-host.conf'
# # e-mail for the server admin
# default['wordpress']['server_admin'] ='jonatan@example.com'
# # log dir for the site
# default['wordpress']['log_dir'] = '/var/log/www'
# # Error log for the site, it will be /var/log/wwwyoursitename-error.log
# default['wordpress']['error_log'] = "#{node['wordpress']['log_dir']}/""#{node['wordpress']['server_name']}-error.log"
# # Access log for the site, it will be /var/log/wwwyoursitename-access.log
# default['wordpress']['custom_log'] = "#{node['wordpress']['log_dir']}/""#{node['wordpress']['server_name']}-access.log"
# # The root password for MySQL
# default['wordpress']['mysql_password'] = 'wordpress_pass'
# # The name of the Wordpress database
# default['wordpress']['wordpress_database'] = 'wordpress'
# # The default username for the Wordpress database
# default['wordpress']['wordpress_username'] = 'wordpress_user'
# # The default password for the Wordpress database
# default['wordpress']['wordpress_password'] = 'wordpress_pass'