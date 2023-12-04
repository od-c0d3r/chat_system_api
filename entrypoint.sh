#!/bin/bash
set -e

# Remove a potentially pre-existing server.pid for Rails.
rm -f ./tmp/pids/server.pid

echo '================ Creating and seeding application database...'
bundle exec rails db:create db:migrate db:seed

# Start rails server in development mode
echo '================ Starting Rails Server in development mode...'
bundle exec rails server -b 0.0.0.0
