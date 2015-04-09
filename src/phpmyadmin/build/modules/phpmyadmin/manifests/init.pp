class phpmyadmin {
  require phpmyadmin::php
  require phpmyadmin::httpd

  file { '/tmp/phpMyAdmin-4.3.6-all-languages.zip':
    ensure => present,
    source => 'puppet:///modules/phpmyadmin/tmp/phpMyAdmin-4.3.6-all-languages.zip'
  }

  bash_exec { 'cd /tmp && unzip phpMyAdmin-4.3.6-all-languages.zip':
    require => File['/tmp/phpMyAdmin-4.3.6-all-languages.zip']
  }

  bash_exec { 'rsync -avz /tmp/phpMyAdmin-4.3.6-all-languages/ /var/www':
    require => Bash_exec['cd /tmp && unzip phpMyAdmin-4.3.6-all-languages.zip']
  }
}
