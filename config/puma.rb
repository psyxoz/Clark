# Puma can serve each request in a thread from an internal thread pool.
# The `threads` method setting takes two numbers a minimum and maximum.
# Any libraries that use thread pools should be configured to match
# the maximum value specified for Puma. Default is set to 5 threads for minimum
# and maximum, this matches the default thread size of Active Record.
#
threads_count = ENV.fetch('RAILS_MAX_THREADS') { 5 }.to_i
threads threads_count, threads_count
port ENV.fetch('PORT') { 3000 }
workers Integer(ENV['PUMA_WORKERS'] || 2)

rails_env = ENV.fetch('RAILS_ENV') { 'development' }
environment rails_env

if %w[development test].include?(rails_env)
  preload_app!
else
  prune_bundler
end

plugin :tmp_restart
