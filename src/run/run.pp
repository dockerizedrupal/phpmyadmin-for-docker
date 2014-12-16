node default {
  include httpd

  if $db_host {
    include phpmyadmin
  }
}
