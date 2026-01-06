#!/usr/bin/env bash

set -o errexit

bundle install
bin/rails assets:precompile
bin/rails assets:clean

bin/rails db:migrate

bin/rails runner "
conn = ActiveRecord::Base.connection

# Solid Queue
unless conn.table_exists?('solid_queue_jobs')
  puts 'Loading queue schema...'
  system('bin/rails db:queue:schema:load') or exit(1)
end

# Solid Cache
unless conn.table_exists?('solid_cache_entries')
  puts 'Loading cache schema...'
  system('bin/rails db:cache:schema:load') or exit(1)
end

# Solid Cable
unless conn.table_exists?('solid_cable_messages')
  puts 'Loading cable schema...'
  system('bin/rails db:cable:schema:load') or exit(1)
end
"