FROM debian:11

ARG DEBIAN_FRONTEND=noninteractive

WORKDIR /scripts

RUN echo "Updating" && apt update && apt upgrade -y

RUN echo "installing pacages" && apt install -y apache2 rsync w3m cron

ADD 000-default.conf /etc/apache2/sites-enabled/000-default.conf

ADD Setup.sh /scripts/Setup.sh

ADD Rank.sh /scripts/Rank.sh

ADD syncrepo-template.sh /scripts/	-template.sh

RUN /scripts/Setup.sh

ENV PORT=80

EXPOSE 80

RUN echo "ServerName 127.0.0.1" >> /etc/apache2/apache2.conf
 
CMD cron && /usr/sbin/apachectl -D FOREGROUND

