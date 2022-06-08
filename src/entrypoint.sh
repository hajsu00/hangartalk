#!/bin/bash
set -e

# Remove a potentially pre-existing server.pid for Rails.
rm -f /hangartalk/tmp/pids/server.pid

bundle exec rails db:drop DISABLE_DATABASE_ENVIRONMENT_CHECK=1
bundle exec rails db:create RAILS_ENV=production
bundle exec rails db:migrate RAILS_ENV=production
bundle exec rails db:seed RAILS_ENV=production
# if [ "${RAILS_ENV}" = 'production' ]; then
# fi

# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"