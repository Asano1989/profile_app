#!/usr/bin/env bash
# bin/render-build.sh

set -e

echo "Running database migrations..."
bundle exec rails db:migrate

echo "Precompiling assets..."
bundle exec rails assets:precompile