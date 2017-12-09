FROM ruby:2.4.2
MAINTAINER Sergey Homenko <xoma.serg@gmail.com>

RUN apt-get update -qq && apt-get install -y build-essential libxml2-dev libxslt1-dev \
    libpq-dev postgresql-client bc --fix-missing --no-install-recommends

ENV APP_HOME /app

RUN mkdir $APP_HOME
WORKDIR $APP_HOME

COPY Gemfile $APP_HOME
COPY Gemfile.lock $APP_HOME

RUN bundle install --retry 3

CMD /bin/bash

COPY . ./

EXPOSE 3000

ENTRYPOINT ["bundle exec puma -C config/puma.rb"]
