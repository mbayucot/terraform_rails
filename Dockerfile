FROM ruby:3.0.0-slim
RUN apt-get update && apt-get install -y --fix-missing \
  build-essential \
  curl \
  gcc \
  git \
  libcurl4-openssl-dev \
  libpq-dev \
  libxml2-dev \
  ssh \
  supervisor \
  vim \
  bash-completion\
  wget \
  lsb-release \
  libvips \
  libsqlite3-dev

RUN curl -sL https://deb.nodesource.com/setup_16.x | bash - && \
    apt-get install nodejs

RUN apt-get update && apt-get install -y curl apt-transport-https wget && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && apt-get install -y yarn

ENV INSTALL_PATH /api
RUN mkdir -p $INSTALL_PATH
WORKDIR $INSTALL_PATH
COPY Gemfile $INSTALL_PATH/Gemfile
RUN bundle install
COPY . $INSTALL_PATH

EXPOSE 80

RUN rm -f /api/tmp/pids/server.pid
CMD ["rails", "server", "-b", "0.0.0.0", "-p", "80"]