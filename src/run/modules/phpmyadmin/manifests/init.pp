class phpmyadmin {
  file { '/httpd/data/config.inc.php':
    ensure => present,
    content => template('phpmyadmin/config.inc.php.erb')
  }
}
