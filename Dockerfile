FROM simpledrupalcloud/base:latest

MAINTAINER Simple Drupal Cloud <support@simpledrupalcloud.com>

ENV DEBIAN_FRONTEND noninteractive

ADD ./src /src

RUN apt-get update

RUN /src/build.sh
RUN /src/clean.sh

VOLUME ["/httpd/ssl/certs"]
VOLUME ["/httpd/ssl/private"]

EXPOSE 80
EXPOSE 443

CMD ["/src/run.sh"]
