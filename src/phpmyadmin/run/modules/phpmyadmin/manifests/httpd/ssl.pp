class phpmyadmin::httpd::ssl {
  bash_exec { 'mkdir -p /phpmyadmin/ssl': }

  bash_exec { 'mkdir -p /phpmyadmin/ssl/private':
    require => Bash_exec['mkdir -p /phpmyadmin/ssl']
  }

  bash_exec { 'mkdir -p /phpmyadmin/ssl/certs':
    require => Bash_exec['mkdir -p /phpmyadmin/ssl/private']
  }

  file { '/root/opensslCA.cnf':
    ensure => present,
    content => template('phpmyadmin/opensslCA.cnf.erb'),
    require => Bash_exec['mkdir -p /phpmyadmin/ssl/certs']
  }

  bash_exec { 'openssl genrsa -out /phpmyadmin/ssl/private/phpmyadminCA.key 4096':
    timeout => 0,
    require => File['/root/opensslCA.cnf']
  }

  bash_exec { "openssl req -sha256 -x509 -new -days 3650 -extensions v3_ca -config /root/opensslCA.cnf -key /phpmyadmin/ssl/private/phpmyadminCA.key -out /phpmyadmin/ssl/certs/phpmyadminCA.crt":
    timeout => 0,
    require => Bash_exec['openssl genrsa -out /phpmyadmin/ssl/private/phpmyadminCA.key 4096']
  }

  bash_exec { 'openssl genrsa -out /phpmyadmin/ssl/private/phpmyadmin.key 4096':
    timeout => 0,
    require => Bash_exec["openssl req -sha256 -x509 -new -days 3650 -extensions v3_ca -config /root/opensslCA.cnf -key /phpmyadmin/ssl/private/phpmyadminCA.key -out /phpmyadmin/ssl/certs/phpmyadminCA.crt"]
  }

  file { '/root/openssl.cnf':
    ensure => present,
    content => template('phpmyadmin/openssl.cnf.erb'),
    require => Bash_exec['openssl genrsa -out /phpmyadmin/ssl/private/phpmyadmin.key 4096']
  }

  bash_exec { "openssl req -sha256 -new -config /root/openssl.cnf -key /phpmyadmin/ssl/private/phpmyadmin.key -out /phpmyadmin/ssl/certs/phpmyadmin.csr":
    timeout => 0,
    require => File['/root/openssl.cnf']
  }

  bash_exec { "openssl x509 -req -sha256 -CAcreateserial -days 3650 -extensions v3_req -extfile /root/opensslCA.cnf -in /phpmyadmin/ssl/certs/phpmyadmin.csr -CA /phpmyadmin/ssl/certs/phpmyadminCA.crt -CAkey /phpmyadmin/ssl/private/phpmyadminCA.key -out /phpmyadmin/ssl/certs/phpmyadmin.crt":
    timeout => 0,
    require => Bash_exec["openssl req -sha256 -new -config /root/openssl.cnf -key /phpmyadmin/ssl/private/phpmyadmin.key -out /phpmyadmin/ssl/certs/phpmyadmin.csr"]
  }
}
