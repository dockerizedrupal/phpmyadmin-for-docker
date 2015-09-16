class phpmyadmin::timezone {
  bash_exec { "timedatectl set-timezone $timezone": }
}
