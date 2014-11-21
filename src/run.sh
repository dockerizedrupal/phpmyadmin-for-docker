#!/usr/bin/env bash

export FACTER_MYSQLD_HOST="$(echo "${MYSQLD_PORT}" | sed 's/tcp:\/\///')"
export FACTER_MYSQLD_USERNAME="${MYSQLD_USERNAME}"
export FACTER_MYSQLD_PASSWORD="${MYSQLD_PASSWORD}"

puppet apply --modulepath=/src/run/modules /src/run/run.pp

/usr/bin/supervisord
