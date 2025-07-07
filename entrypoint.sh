#!/bin/bash
set -e

# 本番用のマイグレーション
echo "== Running DB Migrations =="
bundle exec rails db:migrate

# Pumaの起動（PORT環境変数にバインド）
echo "== Starting Puma server =="
exec bundle exec puma -C config/puma.rb

# Remove a potentially pre-existing server.pid for Rails.
# rm -f /profile_app/tmp/pids/server.pid

# Then exec the container's main process (what's set as CMD in the Dockerfile).
# exec "$@"