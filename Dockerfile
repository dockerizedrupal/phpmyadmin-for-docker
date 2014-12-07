FROM simpledrupalcloud/httpd:dev

MAINTAINER Simple Drupal Cloud <support@simpledrupalcloud.com>

ENV DEBIAN_FRONTEND noninteractive

ADD ./src /src

RUN chmod +x /src/build.sh
RUN /src/build.sh

RUN rm -rf /tmp/*
RUN rm -rf /var/lib/apt/lists/*

RUN apt-get clean

EXPOSE 80
EXPOSE 443

ENTRYPOINT ["/src/run.sh"]
