class phpmyadmin::packages {
  package {[
      'php5',
      'php5-mysql'
    ]:
    ensure => present
  }
}
