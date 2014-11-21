node default {
  if $mysql_port_3306_tcp {
    include phpmyadmin
  }
}
