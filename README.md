# docker-phpmyadmin

A [Docker](https://docker.com/) container for [phpMyAdmin](http://www.phpmyadmin.net/home_page/).

## Run the container

Using the `docker` command:

    CONTAINER="phpmyadmin-data" && sudo docker run \
      --name "${CONTAINER}" \
      -h "${CONTAINER}" \
      -v /phpmyadmin \
      dockerizedrupal/data:1.0.3

    CONTAINER="phpmyadmin" && sudo docker run \
      --name "${CONTAINER}" \
      -h "${CONTAINER}" \
      -p 80:80 \
      -p 443:443 \
      --volumes-from phpmyadmin-data \
      -e SERVER_NAME="localhost" \
      -e TIMEZONE="Etc/UTC" \
      -e TIMEOUT="300" \
      -e PROTOCOLS="https,http" \
      -e MYSQL_HOST="" \
      -e MYSQL_PORT="3306" \
      -e MYSQL_USERNAME="root" \
      -e MYSQL_PASSWORD="root" \
      -e HTTP_BASIC_AUTH_USERNAME="admin" \
      -e HTTP_BASIC_AUTH_PASSWORD="" \
      -d \
      dockerizedrupal/phpmyadmin:1.0.6
      
Using the `docker-compose` command

    TMP="$(mktemp -d)" \
      && git clone https://github.com/dockerizedrupal/docker-phpmyadmin.git "${TMP}" \
      && cd "${TMP}" \
      && git checkout 1.0.6 \
      && sudo docker-compose up

## Connect directly to MySQL server by linking with another Docker container

    CONTAINER="phpmyadmin-data" && sudo docker run \
      --name "${CONTAINER}" \
      -h "${CONTAINER}" \
      -v /phpmyadmin \
      dockerizedrupal/data:1.0.3

    CONTAINER="phpmyadmin" && sudo docker run \
      --name "${CONTAINER}" \
      -h "${CONTAINER}" \
      -p 80:80 \
      -p 443:443 \
      --volumes-from phpmyadmin-data \
      --link mysql:mysql \
      -e SERVER_NAME="localhost" \
      -e TIMEZONE="Etc/UTC" \
      -e TIMEOUT="300" \
      -e PROTOCOLS="https,http" \
      -e MYSQL_USERNAME="root" \
      -e MYSQL_PASSWORD="root" \
      -e HTTP_BASIC_AUTH_USERNAME="admin" \
      -e HTTP_BASIC_AUTH_PASSWORD="" \
      -d \
      dockerizedrupal/phpmyadmin:1.0.6

## Build the image

    TMP="$(mktemp -d)" \
      && git clone https://github.com/dockerizedrupal/docker-phpmyadmin.git "${TMP}" \
      && cd "${TMP}" \
      && git checkout 1.0.6 \
      && sudo docker build -t simpledrupalcloud/phpmyadmin:1.0.6 . \
      && cd -

## License

**MIT**
