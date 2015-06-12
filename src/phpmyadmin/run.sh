#!/usr/bin/env bash

puppet apply --modulepath=/src/phpmyadmin/run/modules /src/phpmyadmin/run/run.pp

supervisord -c /etc/supervisor/supervisord.conf
