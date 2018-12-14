#Download base image Ubuntu 16.04
FROM ubuntu:16.04
# File Author / Maintainer
MAINTAINER EGW-Postfix-DockerImage ChandraBhanSingh

# Environment variables for configuration
ENV JILTER_HOST 127.0.0.1
ENV JILTER_PORT 1121
ENV PORT 25

# Install packages
ENV DEBIAN_FRONTEND="noninteractive"

RUN apt-get update && apt-get install -y \
    mailutils \
    rsyslog \
    zip \
    unzip \
    iputils-ping \
    netcat \
    gettext-base

#copy postfix main.cf to '/etc/postfix/' and replace the default main.cf with this one
COPY main.cf "/etc/postfix/main.cf.tmpl"

COPY run.sh /root/run.sh

RUN chmod +x /root/run.sh

CMD  /root/run.sh 

#Keep an empty line at the end of dockerfile

