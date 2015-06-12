class phpmyadmin::httpd::packages {
  package {[
      'apache2'
    ]:
    ensure => present
  }
}
