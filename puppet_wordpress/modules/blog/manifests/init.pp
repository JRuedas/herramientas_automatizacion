class blog {

  file { '/usr/local/bin/wp':
    ensure  => present,
    source  => "puppet:///modules/blog/wp",
    mode    => '0755',
    require => Class['wordpress']
  }

  exec { 'configure_wordpress':
    command => "/usr/bin/sudo -u ${wp_owner} -i -- /usr/local/bin/wp core install --path=${document_root} --url=http://localhost:8080 --title=Test --admin_name=jonatan --admin_password=password --admin_email=jonatan@example.com",
    require => File['/usr/local/bin/wp']
  }

  exec { 'create_first_post':
    command => "/usr/bin/sudo -u ${wp_owner} -i -- /usr/local/bin/wp post create --path=${document_root} --post_type=post --post_title='First post' --post_author='1' --post_content='Finally working!' --post_status=publish",
    require => Exec['configure_wordpress']
  }

  exec { 'create_bye_post':
    command => "/usr/bin/sudo -u ${wp_owner} -i -- /usr/local/bin/wp post create --path=${document_root} --post_type=post --post_title='Second post' --post_author='1' --post_content='Bye World!' --post_status=publish",
    require => Exec['create_first_post']
  }  
}
