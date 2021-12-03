FROM ruby:3.0.2-slim
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

ENV INSTALL_PATH /api
RUN mkdir -p $INSTALL_PATH
WORKDIR $INSTALL_PATH
COPY Gemfile $INSTALL_PATH/Gemfile
RUN bundle install
COPY . $INSTALL_PATH

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]