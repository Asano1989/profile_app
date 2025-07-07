#!/bin/bash
set -e

echo "== Running DB Migrations =="
bundle exec rails db:migrate
exec bundle exec puma -C config/puma.rb

# Remove a potentially pre-existing server.pid for Rails.
# rm -f /profile_app/tmp/pids/server.pid

# Then exec the container's main process (what's set as CMD in the Dockerfile).
# exec "$@"