# phpmyadmin-for-docker

A Docker image for [phpMyAdmin](http://www.phpmyadmin.net/home_page/).

## Run the container

    CONTAINER="phpmyadmin-data" && sudo docker run \
      --name "${CONTAINER}" \
      -h "${CONTAINER}" \
      -v /phpmyadmin \
      --entrypoint /bin/echo \
      dockerizedrupal/phpmyadmin:2.0.0 "Data-only container for PhpMyAdmin."

    CONTAINER="phpmyadmin" && sudo docker run \
      --name "${CONTAINER}" \
      -h "${CONTAINER}" \
      -p 80:80 \
      -p 443:443 \
      --volumes-from phpmyadmin-data \
      -e SERVER_NAME="localhost" \
      -e TIMEZONE="Etc/UTC" \
      -e PROTOCOLS="https,http" \
      -e MYSQL_HOST="" \
      -e MYSQL_PORT="3306" \
      -e MYSQL_USERNAME="container" \
      -e MYSQL_PASSWORD="container" \
      -e PHP_INI_MAX_EXECUTION_TIME="900" \
      -e HTTP_BASIC_AUTH="Off" \
      -e HTTP_BASIC_AUTH_USERNAME="container" \
      -e HTTP_BASIC_AUTH_PASSWORD="" \
      -d \
      dockerizedrupal/phpmyadmin:2.0.0

## Connect directly to MySQL server by linking to another Docker container

    CONTAINER="phpmyadmin-data" && sudo docker run \
      --name "${CONTAINER}" \
      -h "${CONTAINER}" \
      -v /phpmyadmin \
      --entrypoint /bin/echo \
      dockerizedrupal/phpmyadmin:2.0.0 "Data-only container for PhpMyAdmin."

    CONTAINER="phpmyadmin" && sudo docker run \
      --name "${CONTAINER}" \
      -h "${CONTAINER}" \
      -p 80:80 \
      -p 443:443 \
      --volumes-from phpmyadmin-data \
      --link mysql:mysql \
      -e SERVER_NAME="localhost" \
      -e TIMEZONE="Etc/UTC" \
      -e PROTOCOLS="https,http" \
      -e MYSQL_USERNAME="container" \
      -e MYSQL_PASSWORD="container" \
      -e PHP_INI_MAX_EXECUTION_TIME="900" \
      -e HTTP_BASIC_AUTH="Off" \
      -e HTTP_BASIC_AUTH_USERNAME="container" \
      -e HTTP_BASIC_AUTH_PASSWORD="" \
      -d \
      dockerizedrupal/phpmyadmin:2.0.0

## Build the image

    TMP="$(mktemp -d)" \
      && git clone https://github.com/dockerizedrupal/phpmyadmin-for-docker.git "${TMP}" \
      && cd "${TMP}" \
      && git checkout 2.0.0 \
      && sudo docker build -t dockerizedrupal/phpmyadmin:2.0.0 . \
      && cd -

## License

**MIT**
