class packages {
  package {[
      'unzip'
    ]:
    ensure => present
  }
}

class apache2 {
  exec { 'mkdir -p /var/www':
    path => ['/bin'],
  }

  exec { 'wget http://sourceforge.net/projects/phpmyadmin/files/phpMyAdmin/4.2.8/phpMyAdmin-4.2.8-english.zip':
    cwd => '/var/www',
    path => ['/usr/bin'],
  }

  exec { 'unzip phpMyAdmin-4.2.8-english.zip':
    cwd => '/var/www',
    path => ['/usr/bin'],
    require => Exec['wget http://sourceforge.net/projects/phpmyadmin/files/phpMyAdmin/4.2.8/phpMyAdmin-4.2.8-english.zip']
  }

  exec { 'mv phpMyAdmin-4.2.8-english phpmyadmin':
    cwd => '/var/www',
    path => ['/bin'],
    require => Exec['unzip phpMyAdmin-4.2.8-english.zip']
  }
}

node default {
  file { '/run.sh':
    ensure => present,
    source => '/tmp/build/run.sh',
    mode => 755
  }

  include packages
  include phpmyadmin

  Class['packages'] -> Class['phpmyadmin']

  exec { 'apt-get update':
    path => ['/usr/bin'],
    before => Class['packages']
  }
}