FROM ruby:2.7.1

ENV APP_HOME /app

RUN apt-get install wget ca-certificates && \
  wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
RUN sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ bionic-pgdg main" > /etc/apt/sources.list.d/pgdg.list'

RUN apt-get update -qq \
  && apt-get install -y \
  build-essential \
  postgresql-client-13 \
  libpq-dev \
  vim \
  less \
  unzip \
  libnss3 \
  libgconf-2-4

# The following are used to trim down the size of the image by removing unneeded data
RUN apt-get clean autoclean \
  && apt-get autoremove -y \
  && rm -rf \
  /var/lib/apt \
  /var/lib/dpkg \
  /var/lib/cache \
  /var/lib/log

RUN mkdir $APP_HOME
WORKDIR $APP_HOME

ADD . $APP_HOME
