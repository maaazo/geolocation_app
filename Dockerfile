
FROM ruby:3.2.2-bullseye as base

RUN apt-get update -qq && apt-get install -y build-essential apt-utils libpq-dev nodejs
WORKDIR /app
ENV BUNDLER_VERSION 2.4.21
RUN gem install bundler
COPY Gemfile* ./
RUN bundle install
ADD . /app

COPY bin/docker-entrypoint /usr/local/bin/
# EXPOSE 8080

# ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"] 
ENTRYPOINT ["sh", "/usr/local/bin/docker-entrypoint"]

ARG DEFAULT_PORT 3000
EXPOSE ${DEFAULT_PORT}

CMD ["rails", "server", "-b", "0.0.0.0"]
