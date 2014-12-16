# docker-phpmyadmin

A [Docker](https://docker.com/) container for [phpMyAdmin](http://www.phpmyadmin.net/home_page/).

## Run the container

Using the `docker` command:

    CONTAINER="phpmyadmindata" && sudo docker run \
      --name "${CONTAINER}" \
      -h "${CONTAINER}" \
      -v /httpd/ssl/certs \
      -v /httpd/ssl/private \
      simpledrupalcloud/data:latest

    CONTAINER="phpmyadmin" && sudo docker run \
      --name "${CONTAINER}" \
      -h "${CONTAINER}" \
      -p 80:80 \
      -p 443:443 \
      --volumes-from phpmyadmindata \
      -e SERVER_NAME="localhost" \
      -d \
      simpledrupalcloud/phpmyadmin:latest
      
Using the `fig` command

    TMP="$(mktemp -d)" \
      && git clone http://git.simpledrupalcloud.com/simpledrupalcloud/docker-phpmyadmin.git "${TMP}" \
      && cd "${TMP}" \
      && sudo fig up

## Connect directly to MySQL server by linking with another Docker container

    CONTAINER="phpmyadmindata" && sudo docker run \
      --name "${CONTAINER}" \
      -h "${CONTAINER}" \
      -v /httpd/ssl/certs \
      -v /httpd/ssl/private \
      simpledrupalcloud/data:latest

    CONTAINER="phpmyadmin" && sudo docker run \
      --name "${CONTAINER}" \
      -h "${CONTAINER}" \
      -p 80:80 \
      -p 443:443 \
      --volumes-from phpmyadmindata \
      -e SERVER_NAME="localhost" \
      --link mysqld:db \
      -e DB_USERNAME="root" \
      -e DB_PASSWORD="root" \
      -d \
      simpledrupalcloud/phpmyadmin:latest

## Build the image

    TMP="$(mktemp -d)" \
      && git clone http://git.simpledrupalcloud.com/simpledrupalcloud/docker-phpmyadmin.git "${TMP}" \
      && cd "${TMP}" \
      && sudo docker build -t simpledrupalcloud/phpmyadmin:latest . \
      && cd -

## License

**MIT**
