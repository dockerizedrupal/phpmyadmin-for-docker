class phpmyadmin::php {
  require phpmyadmin::packages

  file { '/etc/php5/apache2/php.ini':
    ensure => present,
    source => 'puppet:///modules/phpmyadmin/etc/php5/apache2/php.ini',
    mode => 644
  }
}
