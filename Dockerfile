FROM ruby:3.3.0

ENV PORT 8080
EXPOSE 8080
WORKDIR /app

# nodejs: for Rails assets
# tzdata: fix TZInfo::DataSourceNotFound on start
# linux-headers: for raindrops that is required by Unicorn
# bash: for debugging in production

RUN curl -sL https://deb.nodesource.com/setup_12.x | bash - \
  && apt-get update -qq \
  && apt-get install -y build-essential nodejs tzdata dumb-init \
  && rm -rf /var/lib/apt/lists/*

COPY Gemfile* ./

RUN gem install bundler && bundle update --bundler \
  && bundle

COPY . ./

# Setup Rails shared folders for Puma / Nginx
RUN mkdir /shared
RUN mkdir /shared/config
RUN mkdir /shared/pids
RUN mkdir /shared/sockets
RUN bundle exec rake assets:precompile

ENTRYPOINT ["/usr/bin/dumb-init", "./scripts/load_secrets_and_run.sh"]

CMD ["bundle", "exec", "puma", "-C", "config/puma.config"]
