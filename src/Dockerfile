FROM ruby:3.0.1

ENV RAILS_ENV=production
RUN apt-get update -qq && apt-get install -y nodejs
RUN mkdir -p /var/www/hangartalk
RUN mkdir -p /var/www/hangartalk/tmp/sockets
RUN mkdir -p /var/www/hangartalk/tmp/pids
WORKDIR /var/www/hangartalk
COPY Gemfile /var/www/hangartalk/Gemfile
COPY Gemfile.lock /var/www/hangartalk/Gemfile.lock
RUN bundle install
RUN curl https://deb.nodesource.com/setup_16.x | bash
RUN curl https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get install -y nodejs yarn

COPY . /var/www/hangartalk

# Add a script to be executed every time the container starts.
COPY ./entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

RUN bundle exec rails assets:precompile

VOLUME /var/www/hangartalk/public
VOLUME /var/www/hangartalk/tmp

# Start the main process.
CMD bash -c "rm -f tmp/pids/server.pid && bundle exec puma -e production"