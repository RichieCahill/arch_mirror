FROM debian:11

ARG DEBIAN_FRONTEND=noninteractive

WORKDIR /config

RUN echo "Updating" && apt update && apt upgrade -y

RUN echo "installing pacages" && apt install -y apache2 rsync w3m

ADD 000-default.conf /etc/apache2/sites-enabled/000-default.conf

CMD ["/usr/sbin/apachectl", "-D", "FOREGROUND"]

ADD Arch.sh /config/Arch.sh

ADD syncrepo-template.sh /config/syncrepo-template.sh

RUN /config/Arch.sh

ENV PORT=80

EXPOSE 80

