# docker-phpmyadmin

A [Docker](https://docker.com/) container for [phpMyAdmin](http://www.phpmyadmin.net/home_page/).

## Run the container

Using the `docker` command:

    CONTAINER="phpmyadmindata" && sudo docker run \
      --name "${CONTAINER}" \
      -h "${CONTAINER}" \
      -v /phpmyadmin \
      simpledrupalcloud/data:dev

    CONTAINER="phpmyadmin" && sudo docker run \
      --name "${CONTAINER}" \
      -h "${CONTAINER}" \
      -p 80:80 \
      -p 443:443 \
      --volumes-from phpmyadmindata \
      -e SERVER_NAME="localhost" \
      -d \
      simpledrupalcloud/phpmyadmin:dev
      
Using the `fig` command

    TMP="$(mktemp -d)" \
      && git clone http://git.simpledrupalcloud.com/simpledrupalcloud/docker-phpmyadmin.git "${TMP}" \
      && cd "${TMP}" \
      && git checkout dev \
      && sudo fig up

## Connect directly to MySQL server by linking with another Docker container

    CONTAINER="phpmyadmindata" && sudo docker run \
      --name "${CONTAINER}" \
      -h "${CONTAINER}" \
      -v /phpmyadmin \
      simpledrupalcloud/data:dev

    CONTAINER="phpmyadmin" && sudo docker run \
      --name "${CONTAINER}" \
      -h "${CONTAINER}" \
      -p 80:80 \
      -p 443:443 \
      --volumes-from phpmyadmindata \
      --link mysqld:mysqld \
      -e SERVER_NAME="localhost" \
      -e MYSQLD_USERNAME="root" \
      -e MYSQLD_PASSWORD="root" \
      -d \
      simpledrupalcloud/phpmyadmin:dev

## Build the image

    TMP="$(mktemp -d)" \
      && git clone http://git.simpledrupalcloud.com/simpledrupalcloud/docker-phpmyadmin.git "${TMP}" \
      && cd "${TMP}" \
      && git checkout dev \
      && sudo docker build -t simpledrupalcloud/phpmyadmin:dev . \
      && cd -

## Back up phpMyAdmin data

    sudo docker run \
      --rm \
      --volumes-from phpmyadmindata \
      -v $(pwd):/backup \
      simpledrupalcloud/base:dev tar czvf /backup/phpmyadmindata.tar.gz /phpmyadmin

## Restore phpMyAdmin data from a backup

    sudo docker run \
      --rm \
      --volumes-from phpmyadmindata \
      -v $(pwd):/backup \
      simpledrupalcloud/base:dev tar xzvf /backup/phpmyadmindata.tar.gz

## License

**MIT**
