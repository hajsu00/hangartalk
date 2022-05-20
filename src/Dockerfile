FROM ruby:3.0.1

RUN apt-get update -qq && apt-get install -y nodejs
RUN mkdir -p /var/www/hangartalk
WORKDIR /var/www/hangartalk
COPY /src/Gemfile /var/www/hangartalk/Gemfile
COPY /src/Gemfile.lock /var/www/hangartalk/Gemfile.lock
RUN bundle install
COPY . /var/www/hangartalk

# Add a script to be executed every time the container starts.
COPY /src/entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]
CMD ["tailwindcss", "build"]