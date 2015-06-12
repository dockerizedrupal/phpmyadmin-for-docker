class phpmyadmin {
  include phpmyadmin::httpd

  if $mysqld_host {
    file { '/var/www/config.inc.php':
      ensure  => present,
      content => template('phpmyadmin/config.inc.php.erb')
    }
  }
}
