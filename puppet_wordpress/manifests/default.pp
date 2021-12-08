$document_root = '/var/www/html'
$wp_db         = 'wordpress'
$wp_user       = 'wordpress_user'
$wp_pass       = 'wordpress_pass'
$host          = 'localhost'
$wp_admin_user = 'jonatan'
$wp_admin_pass = 'password'
$wp_owner      = 'vagrant'

include blog

class { 'apache': 
  mpm_module    => 'prefork',
  default_vhost => false
}

apache::vhost { 'localhost':
  port          => '80',
  docroot       => "${document_root}",
  docroot_owner => "${wp_owner}",
  docroot_group => "${wp_owner}",
}

class { 'apache::mod::php': }

file { "${document_root}/index.html":
  ensure => absent
}

class { '::php':
  extensions => {
    mysqli   => {},
  },
  require    => [Class['apache::mod::php'],File["${document_root}/index.html"]],
  notify     => Service['apache2']
}

class { 'mysql::server':
  root_password           => "${wp_pass}",
  remove_default_accounts => true,
  restart                 => true
}

mysql::db { "${wp_db}":
  user     => "${wp_user}",
  password => "${wp_pass}",
  host     => "${host}",
  grant    => ['ALL'],
  require  => Class['mysql::server']
}

class { 'wordpress':
  install_dir    => "${document_root}",
  version        => '5.7',
  wp_owner       => "${wp_owner}",
  wp_group       => "${wp_owner}",
  db_user        => "${wp_user}",
  db_password    => "${wp_pass}",
  db_name        => "${wp_db}",
  db_host        => "${host}",
  create_db      => false,
  create_db_user => false,
  require => [Class['mysql::server'], Class['::php']]
}
