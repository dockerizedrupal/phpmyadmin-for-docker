node default {
  if $db_host {
    include phpmyadmin
  }
}
