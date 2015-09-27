# docker-phpmyadmin

A Docker image for [phpMyAdmin](http://www.phpmyadmin.net/home_page/) that is used in the [Dockerized Drupal](https://dockerizedrupal.com/) project.

## Run the container

    CONTAINER="phpmyadmin-data" && sudo docker run \
      --name "${CONTAINER}" \
      -h "${CONTAINER}" \
      -v /phpmyadmin \
      dockerizedrupal/data:1.1.0

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
      dockerizedrupal/phpmyadmin:1.1.0

## Connect directly to MySQL server by linking to another Docker container

    CONTAINER="phpmyadmin-data" && sudo docker run \
      --name "${CONTAINER}" \
      -h "${CONTAINER}" \
      -v /phpmyadmin \
      dockerizedrupal/data:1.1.0

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
      dockerizedrupal/phpmyadmin:1.1.0

## Build the image

    TMP="$(mktemp -d)" \
      && git clone https://github.com/dockerizedrupal/docker-phpmyadmin.git "${TMP}" \
      && cd "${TMP}" \
      && git checkout 1.1.0 \
      && sudo docker build -t dockerizedrupal/phpmyadmin:1.1.0 . \
      && cd -

## Changing the container behaviour on runtime through environment variables

    // TODO

## License

**MIT**
