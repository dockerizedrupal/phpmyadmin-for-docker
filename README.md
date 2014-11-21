# docker-phpmyadmin

A [Docker](https://docker.com/) container for [phpMyAdmin](http://www.phpmyadmin.net/home_page/).

## phpMyAdmin (DEVELOPMENT BRANCH)

### Run the container

Using the `docker` command:

    CONTAINER="phpmyadmin" && sudo docker run \
      --name "${CONTAINER}" \
      -h "${CONTAINER}" \
      -p 80:80 \
      -d \
      simpledrupalcloud/phpmyadmin:dev
      
Using the `fig` command

    TMP="$(mktemp -d)" \
      && git clone http://git.simpledrupalcloud.com/simpledrupalcloud/docker-phpmyadmin.git "${TMP}" \
      && cd "${TMP}" \
      && git checkout dev \
      && fig up

#### Connect automatically to MySQL server by linking with another Docker container

    CONTAINER="phpmyadmin" && sudo docker run \
      --name "${CONTAINER}" \
      -h "${CONTAINER}" \
      -p 80:80 \
      --link mysqld:db \
      -e DB_USERNAME="root" \
      -e DB_PASSWORD="root" \
      -d \
      simpledrupalcloud/phpmyadmin:dev

### Build the image

    TMP="$(mktemp -d)" \
      && git clone http://git.simpledrupalcloud.com/simpledrupalcloud/docker-phpmyadmin.git "${TMP}" \
      && cd "${TMP}" \
      && git checkout dev \
      && sudo docker build -t simpledrupalcloud/phpmyadmin:dev . \
      && cd -

## License

**MIT**
