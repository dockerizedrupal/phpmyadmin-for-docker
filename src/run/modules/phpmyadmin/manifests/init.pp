class phpmyadmin {
  if ! file_exists('/phpmyadmin/ssl/certs/phpmyadmin.crt') {
    require phpmyadmin::httpd::ssl
  }

  if $mysqld_host {
    file { '/phpmyadmin/data/config.inc.php':
      ensure  => present,
      content => template('phpmyadmin/config.inc.php.erb')
    }
  }
}
