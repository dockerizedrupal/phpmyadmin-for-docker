#!/usr/bin/env bash

DB_PORT="$(echo "${DB_PORT}" | sed 's/tcp:\/\///')"

export FACTER_DB_HOST="$(echo "${DB_PORT}" | cut -d ":" -f1)"
export FACTER_DB_PORT="$(echo "${DB_PORT}" | cut -d ":" -f2)"

export FACTER_DB_USERNAME="${DB_USERNAME}"
export FACTER_DB_PASSWORD="${DB_PASSWORD}"

puppet apply --modulepath=/src/run/modules /src/run/run.pp

/usr/bin/supervisord
