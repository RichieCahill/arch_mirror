FROM ghcr.io/linuxserver/baseimage-mono:LTS

ARG DEBIAN_FRONTEND=noninteractive

ADD 000-default.conf /etc/apache2/sites-enabled/000-default.conf

RUN echo "Updating" && apt update && apt upgrade -y

RUN apt install -y apache2 rsync w3m

CMD ["/usr/sbin/apachectl", "-D", "FOREGROUND"]

RUN mkdir /data

ENV PORT=80

EXPOSE 80

