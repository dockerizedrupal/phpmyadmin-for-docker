#!/usr/bin/env bash

case "${1}" in
  build)
    /bin/su - root -mc "apt-get update && /src/phpmyadmin/build.sh && /src/phpmyadmin/clean.sh"
    ;;
  run)
    /bin/su - root -mc "source /src/phpmyadmin/variables.sh && /src/phpmyadmin/run.sh"
    ;;
esac
