#!/usr/bin/env bash
cd /app

# Install Gems
if [ -f /app/Gemfile ]; then
	bundle install
fi

echo "Running: $@"
exec "$@"
