class phpmyadmin::apache::packages {
  package {[
      'apache2'
    ]:
    ensure => present
  }
}
