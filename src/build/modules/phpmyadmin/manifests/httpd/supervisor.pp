class phpmyadmin::httpd::supervisor {
  file { '/etc/supervisor/conf.d/httpd.conf':
    ensure => present,
    source => 'puppet:///modules/phpmyadmin/etc/supervisor/conf.d/httpd.conf'
  }
}
