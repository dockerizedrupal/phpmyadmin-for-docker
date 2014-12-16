class phpmyadmin::httpd::ssl {
  exec { 'openssl genrsa -out /phpmyadmin/ssl/private/phpmyadminCA.key 4096':
    timeout => 0,
    path => ['/usr/bin']
  }

  $subj = "/C=/ST=/L=/O=/CN=$server_name"

  exec { "openssl req -x509 -new -nodes -key /phpmyadmin/ssl/private/phpmyadminCA.key -days 365 -subj $subj -out /phpmyadmin/ssl/certs/phpmyadminCA.crt":
    timeout => 0,
    path => ['/usr/bin'],
    require => Exec['openssl genrsa -out /phpmyadmin/ssl/private/phpmyadminCA.key 4096']
  }

  exec { 'openssl genrsa -out /phpmyadmin/ssl/private/phpmyadmin.key 4096':
    timeout => 0,
    path => ['/usr/bin'],
    require => Exec["openssl req -x509 -new -nodes -key /phpmyadmin/ssl/private/phpmyadminCA.key -days 365 -subj $subj -out /phpmyadmin/ssl/certs/phpmyadminCA.crt"]
  }

  exec { "openssl req -new -key /phpmyadmin/ssl/private/phpmyadmin.key -subj $subj -out /phpmyadmin/ssl/certs/phpmyadmin.csr":
    timeout => 0,
    path => ['/usr/bin'],
    require => Exec['openssl genrsa -out /phpmyadmin/ssl/private/phpmyadmin.key 4096']
  }

  exec { "openssl x509 -req -in /phpmyadmin/ssl/certs/phpmyadmin.csr -CA /phpmyadmin/ssl/certs/phpmyadminCA.crt -CAkey /phpmyadmin/ssl/private/phpmyadminCA.key -CAcreateserial -out /phpmyadmin/ssl/certs/phpmyadmin.crt -days 365":
    timeout => 0,
    path => ['/usr/bin'],
    require => Exec["openssl req -new -key /phpmyadmin/ssl/private/phpmyadmin.key -subj $subj -out /phpmyadmin/ssl/certs/phpmyadmin.csr"]
  }
}
