class phpmyadmin {
  if ! file_exists('/phpmyadmin/ssl/certs/phpmyadmin.crt') {
    require phpmyadmin::httpd::ssl
  }

  if $mysqld_host {
    file { '/var/www/config.inc.php':
      ensure  => present,
      content => template('phpmyadmin/config.inc.php.erb')
    }
  }
}
