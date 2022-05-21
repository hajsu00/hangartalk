#!/bin/bash
set -e

# Remove a potentially pre-existing server.pid for Rails.
rm -f /hangartalk/tmp/pids/server.pid

# if [ "${RAILS_ENV}" = "production"]
# then
#   bundle exec rails assets:precompile
#   bundle exec rails tailwindcss:build
# fi

# bundle exec rails assets:precompile
# bundle exec rails tailwindcss:build

# bundle exec rails db:create RAILS_ENV=development
# bundle exec rails db:migrate RAILS_ENV=development
# bundle exec rails db:seed RAILS_ENV=development

# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"