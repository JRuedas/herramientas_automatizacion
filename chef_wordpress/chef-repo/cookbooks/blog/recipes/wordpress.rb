############## Wordpress CLI ##############

execute 'change owner and group' do
    command "sudo chown -R #{node['blog']['wp_owner']}:#{node['blog']['wp_owner']} #{node['blog']['document_root']}"
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
    command "sudo -u #{node['blog']['wp_owner']} -i -- wp core download --path=#{node['blog']['document_root']} --version=#{node['blog']['wp_version']} --force"
end

execute 'Create Wordpress configuration' do
    command "sudo -u #{node['blog']['wp_owner']} -i -- wp config create --path=#{node['blog']['document_root']} --dbname=#{node['blog']['db_name']} --dbuser=#{node['blog']['db_user']} --dbpass=#{node['blog']['db_pass']} --dbhost=127.0.0.1" # Not localhost because of a bug in MySQL cookbook
end

execute 'Wordpress initial setup' do
    command "sudo -u #{node['blog']['wp_owner']} -i -- wp core install --path=#{node['blog']['document_root']} --url=http://#{node['blog']['wp_host']}:#{node['blog']['apache_port']} --title=Test --admin_name=admin --admin_password=password --admin_email=admin@example.com"
end

execute 'Add post' do
    command "sudo -u #{node['blog']['wp_owner']} -i -- wp post create --path=#{node['blog']['document_root']} --post_type=post --post_title='First post' --post_author='1' --post_content='Finally working!' --post_status=publish"
end