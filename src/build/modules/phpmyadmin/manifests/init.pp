class phpmyadmin {
  require phpmyadmin::httpd
  require phpmyadmin::php

  file { '/var/www/phpMyAdmin-4.2.12-all-languages.zip':
    ensure => present,
    source => 'puppet:///modules/phpmyadmin/var/www/phpMyAdmin-4.2.12-all-languages.zip'
  }

  exec { 'unzip phpMyAdmin-4.2.12-all-languages.zip':
    cwd => '/var/www',
    path => ['/usr/bin'],
    require => File['/var/www/phpMyAdmin-4.2.12-all-languages.zip']
  }

  exec { 'rm phpMyAdmin-4.2.12-all-languages.zip':
    cwd => '/var/www',
    path => ['/bin'],
    require => Exec['unzip phpMyAdmin-4.2.12-all-languages.zip']
  }

  exec { 'mv phpMyAdmin-4.2.12-all-languages phpmyadmin':
    cwd => '/var/www',
    path => ['/bin'],
    require => Exec['unzip phpMyAdmin-4.2.12-all-languages.zip']
  }
}
