class packages {
  package {[
      'apache2',
      'php5'
    ]:
    ensure => present
  }
}

class apache_supervisor {
  file { '/etc/supervisor/conf.d/apache.conf':
    ensure => present,
    source => '/tmp/build/etc/supervisor/conf.d/apache.conf'
  }
}

class apache {
  include apache_supervisor
}

node default {
  file { '/etc/puppet/manifests':
    ensure => directory,
    recurse => true,
    purge => true,
    force => true,
    source => '/tmp/build/etc/puppet/manifests',
    mode => 644
  }

  file { '/etc/puppet/modules':
    ensure => directory,
    recurse => true,
    purge => true,
    force => true,
    source => '/tmp/build/etc/puppet/modules',
    mode => 644
  }

  file { '/run.sh':
    ensure => present,
    source => '/tmp/build/run.sh',
    mode => 755
  }

  include packages
  include apache

  Class['packages'] -> Class['apache']

  exec { 'apt-get update':
    path => ['/usr/bin'],
    before => Class['packages']
  }
}
