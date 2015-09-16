class phpmyadmin::apache::packages {
  package {[
      'apache2',
      'apache2-utils'
    ]:
    ensure => present
  }
}
