class phpmyadmin {
  require phpmyadmin::php

  file { '/tmp/phpMyAdmin-4.2.12-all-languages.zip':
    ensure => present,
    source => 'puppet:///modules/phpmyadmin/tmp/phpMyAdmin-4.2.12-all-languages.zip'
  }

  exec { 'unzip phpMyAdmin-4.2.12-all-languages.zip':
    cwd => '/tmp',
    path => ['/usr/bin'],
    require => File['/tmp/phpMyAdmin-4.2.12-all-languages.zip']
  }

  exec { 'rm -rf /httpd/data':
    path => ['/bin'],
    require => Exec['unzip phpMyAdmin-4.2.12-all-languages.zip']
  }

  exec { 'mv phpMyAdmin-4.2.12-all-languages /httpd/data':
    cwd => '/tmp',
    path => ['/bin'],
    require => Exec['rm -rf /httpd/data']
  }
}
