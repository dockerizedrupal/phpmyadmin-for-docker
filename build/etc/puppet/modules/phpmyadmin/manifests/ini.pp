class packages {
  package {[
      'unzip'
    ]:
    ensure => present
  }
}

class phpmyadmin {
  include packages

  exec { 'mkdir -p /var/www':
    path => ['/bin'],
  }

  exec { 'wget http://sourceforge.net/projects/phpmyadmin/files/phpMyAdmin/4.2.8/phpMyAdmin-4.2.8-english.zip':
    cwd => '/var/www',
    path => ['/usr/bin'],
    require => Exec['mkdir -p /var/www']
  }

  exec { 'unzip phpMyAdmin-4.2.8-english.zip':
    cwd => '/var/www',
    path => ['/usr/bin'],
    require => Exec['wget http://sourceforge.net/projects/phpmyadmin/files/phpMyAdmin/4.2.8/phpMyAdmin-4.2.8-english.zip']
  }

  exec { 'mv phpMyAdmin-4.2.8-english phpmyadmin':
    cwd => '/var/www',
    path => ['/bin'],
    require => Exec['unzip phpMyAdmin-4.2.8-english.zip']
  }
}
