############## PHP ##############

## Only the mysql extension because Apache PHP mod installs PHP

if platform_family?('debian')
    package 'php-mysqli'
end

if platform_family?('rhel')
    package 'php-mysqlnd'
    package 'php-json'
end