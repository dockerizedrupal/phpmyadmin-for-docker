#!/usr/bin/env bash

puppet apply --modulepath=/src/phpmyadmin/run/modules /src/phpmyadmin/run/run.pp

/usr/bin/supervisord
