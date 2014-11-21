#!/usr/bin/env bash

dnsLookup() {
  echo "$(host "${1}" | awk '/has address/ { print $4 }')"
}

# MySQL

if [ -z "${MYSQL_PORT_3306_TCP}" ] && [ -n "${MYSQL_PORT_3306_TCP_ADDR}" ] && [ -n "${MYSQL_PORT_3306_TCP_PORT}" ]; then
  IP="$(dnsLookup "${MYSQL_PORT_3306_TCP_ADDR}")"

  if [ ! -z "${IP}" ]; then
    MYSQL_PORT_3306_TCP_ADDR="${IP}"
  fi

  MYSQL_PORT_3306_TCP="tcp://${MYSQL_PORT_3306_TCP_ADDR}:${MYSQL_PORT_3306_TCP_PORT}"
fi

export FACTER_MYSQL_PORT_3306_TCP="$(echo "${MYSQL_PORT_3306_TCP}" | sed 's/tcp:\/\///')"

puppet apply /etc/puppet/manifests/run.pp

/usr/bin/supervisord
