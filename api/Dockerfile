FROM ruby:3.0.1

ENV RAILS_ENV=production
ARG RAILS_MASTER_KEY
ENV RAILS_MASTER_KEY ${RAILS_MASTER_KEY}
RUN apt-get update -qq && apt-get install -y nodejs
RUN mkdir -p /var/www/hangartalk
RUN mkdir -p /var/www/hangartalk/tmp/sockets
RUN mkdir -p /var/www/hangartalk/tmp/pids
WORKDIR /var/www/hangartalk
COPY ./api/Gemfile /var/www/hangartalk/Gemfile
COPY ./api/Gemfile.lock /var/www/hangartalk/Gemfile.lock
RUN bundle install
RUN curl https://deb.nodesource.com/setup_16.x | bash
RUN curl https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get install -y nodejs yarn

COPY ./api /var/www/hangartalk

# Add a script to be executed every time the container starts.
COPY ./api/entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

RUN bundle exec rails assets:precompile
RUN bundle exec rails tailwindcss:build

VOLUME /var/www/hangartalk/public
VOLUME /var/www/hangartalk/tmp

# Start the main process.
CMD bash -c "rm -f tmp/pids/server.pid && bundle exec puma -C config/puma.rb"