class phpmyadmin {
  include phpmyadmin::apache
  include phpmyadmin::timezone

  if $mysql_host {
    file { '/var/www/config.inc.php':
      ensure  => present,
      content => template('phpmyadmin/config.inc.php.erb')
    }
  }
}
