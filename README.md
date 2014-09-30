# docker-phpmyadmin

## phpMyAdmin 4.2.8

### Run the container

    CONTAINER="phpmyadmin" && sudo docker run \
      --name "${CONTAINER}" \
      -h "${CONTAINER}" \
      -p 80:80 \
      --link mysql:mysql \
      -d \
      simpledrupalcloud/phpmyadmin:4.2.8

### Build the image

    TMP="$(mktemp -d)" \
      && git clone http://git.simpledrupalcloud.com/simpledrupalcloud/docker-phpmyadmin.git "${TMP}" \
      && cd "${TMP}" \
      && git checkout 4.2.8 \
      && sudo docker build -t simpledrupalcloud/phpmyadmin:4.2.8 . \
      && cd -
