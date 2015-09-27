class phpmyadmin::apache {
  include phpmyadmin::apache::server_name
  include phpmyadmin::apache::timeout

  if $http_basic_auth == "On" {
    include phpmyadmin::apache::http_basic_auth
  }

  if $http and $https {
    if ! file_exists('/phpmyadmin/ssl/certs/phpmyadmin.crt') {
      require phpmyadmin::apache::ssl
    }

    file { '/etc/apache2/sites-available/http_https.conf':
      ensure => present,
      content => template('phpmyadmin/http_https.conf.erb'),
      mode => 644
    }

    file { '/etc/apache2/sites-enabled/http_https.conf':
      ensure => link,
      target => '/etc/apache2/sites-available/http_https.conf',
      require => File['/etc/apache2/sites-available/http_https.conf']
    }

    file { '/etc/apache2/sites-available/http_https-ssl.conf':
      ensure => present,
      content => template('phpmyadmin/http_https-ssl.conf.erb'),
      mode => 644
    }

    file { '/etc/apache2/sites-enabled/http_https-ssl.conf':
      ensure => link,
      target => '/etc/apache2/sites-available/http_https-ssl.conf',
      require => File['/etc/apache2/sites-available/http_https-ssl.conf']
    }
  }
  elsif $http {
    file { '/etc/apache2/sites-available/http.conf':
      ensure => present,
      content => template('phpmyadmin/http.conf.erb'),
      mode => 644
    }

    file { '/etc/apache2/sites-enabled/http.conf':
      ensure => link,
      target => '/etc/apache2/sites-available/http.conf',
      require => File['/etc/apache2/sites-available/http.conf']
    }
  }
  elsif $https {
    if ! file_exists('/phpmyadmin/ssl/certs/phpmyadmin.crt') {
      require phpmyadmin::apache::ssl
    }

    file { '/etc/apache2/sites-available/https.conf':
      ensure => present,
      content => template('phpmyadmin/https.conf.erb'),
      mode => 644
    }

    file { '/etc/apache2/sites-enabled/https.conf':
      ensure => link,
      target => '/etc/apache2/sites-available/https.conf',
      require => File['/etc/apache2/sites-available/https.conf']
    }

    file { '/etc/apache2/sites-available/https-ssl.conf':
      ensure => present,
      content => template('phpmyadmin/https-ssl.conf.erb'),
      mode => 644
    }

    file { '/etc/apache2/sites-enabled/https-ssl.conf':
      ensure => link,
      target => '/etc/apache2/sites-available/https-ssl.conf',
      require => File['/etc/apache2/sites-available/https-ssl.conf']
    }
  }
}
