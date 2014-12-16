class phpmyadmin {
  require adminer::php
  require adminer::httpd

  file { '/tmp/phpMyAdmin-4.2.12-all-languages.zip':
    ensure => present,
    source => 'puppet:///modules/phpmyadmin/tmp/phpMyAdmin-4.2.12-all-languages.zip'
  }

  exec { 'unzip phpMyAdmin-4.2.12-all-languages.zip':
    cwd => '/tmp',
    path => ['/usr/bin'],
    require => File['/tmp/phpMyAdmin-4.2.12-all-languages.zip']
  }

  exec { 'rsync -avz phpMyAdmin-4.2.12-all-languages/ /phpmyadmin/data':
    cwd => '/tmp',
    path => ['/usr/bin'],
    require => Exec['unzip phpMyAdmin-4.2.12-all-languages.zip']
  }
}
