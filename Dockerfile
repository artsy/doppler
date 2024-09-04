FROM ruby:2.7.5

ENV PORT 8080
EXPOSE 8080
WORKDIR /app

# nodejs: for Rails assets
# tzdata: fix TZInfo::DataSourceNotFound on start
# linux-headers: for raindrops that is required by Unicorn
# bash: for debugging in production

RUN curl -sL https://deb.nodesource.com/setup_12.x | bash - \
  && apt-get update -qq \
  && apt-get install -y build-essential nodejs tzdata \
  && rm -rf /var/lib/apt/lists/*

COPY .ruby-version Gemfile* ./

RUN gem install bundler -v 1.17.3 \
  && bundle

COPY . ./

# Setup Rails shared folders for Puma / Nginx
RUN mkdir /shared
RUN mkdir /shared/config
RUN mkdir /shared/pids
RUN mkdir /shared/sockets
RUN bundle exec rake assets:precompile

CMD ["bundle", "exec", "puma", "-C", "config/puma.config"]
