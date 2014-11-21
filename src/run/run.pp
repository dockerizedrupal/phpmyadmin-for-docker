node default {
  if $mysqld_host {
    include phpmyadmin
  }
}
