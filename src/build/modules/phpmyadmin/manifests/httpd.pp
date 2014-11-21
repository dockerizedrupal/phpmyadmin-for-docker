class phpmyadmin::httpd {
  require phpmyadmin::packages
  require phpmyadmin::httpd::supervisor

  exec { '/bin/bash -c "a2enmod ssl"': }

  file { '/etc/apache2/sites-enabled/000-default':
    ensure => absent
  }

  file { '/var/www/index.html':
    ensure => absent
  }

  file { '/etc/apache2/sites-available/default':
    ensure => present,
    source => 'puppet:///modules/phpmyadmin/etc/apache2/sites-available/default',
    mode => 644
  }

  file { '/etc/apache2/sites-enabled/default':
    ensure => link,
    target => '/etc/apache2/sites-available/default',
    require => File['/etc/apache2/sites-available/default']
  }

  file { '/etc/apache2/sites-available/default-ssl':
    ensure => present,
    source => 'puppet:///modules/phpmyadmin/etc/apache2/sites-available/default-ssl',
    mode => 644
  }

  file { '/etc/apache2/sites-enabled/default-ssl':
    ensure => link,
    target => '/etc/apache2/sites-available/default-ssl',
    require => File['/etc/apache2/sites-available/default-ssl']
  }
}
