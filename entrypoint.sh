#!/bin/bash
set -e

# Puma起動前にmigrateとpid削除
rm -f tmp/pids/server.pid
echo "== Running DB Migrations =="
bundle exec rails db:migrate

# Remove a potentially pre-existing server.pid for Rails.
# rm -f /profile_app/tmp/pids/server.pid

# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"