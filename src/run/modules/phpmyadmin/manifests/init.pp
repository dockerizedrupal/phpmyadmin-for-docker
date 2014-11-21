class phpmyadmin {
  file { '/var/www/phpmyadmin/config.inc.php':
    ensure => present,
    content => template('phpmyadmin/config.inc.php.erb')
  }
}
