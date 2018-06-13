#FROM phusion/baseimage:0.9.22
FROM ubuntu:xenial
MAINTAINER Bikram Dhoju <bikram.dhoju@olenepal.org>

# Tell the container there is no tty
ENV DEBIAN_FRONTEND noninteractive

ENV DEFAULT_CONTAINER_TIMEZONE Asia/Kathmandu

# Automatic choose local mirror for sources list
#COPY sources.list /etc/apt/sources.list

# Update to latest packages and tidy up
RUN apt-get update \
  && apt-get -y upgrade \
  && apt-get install -y --no-install-recommends \
      vim.tiny wget tzdata iputils-ping curl   \
      git-core logrotate  locales \
  && apt-get -y autoremove \
  && apt-get -y clean \
  && rm -rf /tmp/* /var/tmp/* /var/lib/apt/lists/*

COPY . /app

RUN chmod +x /app/bin/*

#Set timezone
ENV TZ=Asia/Kathmandu
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

#RUN ln -s /app/bin/set_timezone.sh /etc/my_init.d/00_set_timezone.sh

CMD ["bash"]
