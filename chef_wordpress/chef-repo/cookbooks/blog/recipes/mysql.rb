############## MySQL ##############

if platform_family?('debian')
    mysql_service 'default' do
        version node['blog']['mysql_version']
        action [:create, :start]
    end

    mysql_client 'default' do
        action :create
    end

    mysql_database 'default' do
        host node['blog']['wp_host']
        database_name node['blog']['db_name']
        action :create
    end
      
    mysql_user 'default' do
        username node['blog']['db_user']
        password node['blog']['db_pass']
        database_name node['blog']['db_name']
        host node['blog']['wp_host']
        privileges [:all]
        grant_option true
        action [:create,:grant]
    end
end  

if platform_family?('rhel')
    yum_mysql_community_repo 'default' do
        version node['blog']['mysql_version']
        gpgcheck true
        mysql_community_server true
    end

    mysql_service 'default' do
        version node['mysql']['version']
        initial_root_password 'root'
        action [:create, :start]
    end

    mysql_client 'default' do
        action :create
    end

    mysql_database 'default' do
        host node['blog']['wp_host']
        user 'root'
        password 'root'
        database_name node['blog']['db_name']
        action :create
    end
      
    mysql_user 'default' do
        ctrl_user 'root'
        ctrl_password 'root'
        username node['blog']['db_user']
        password node['blog']['db_pass']
        database_name node['blog']['db_name']
        host node['blog']['wp_host']
        privileges [:all]
        grant_option true
        action [:create,:grant]
    end
end