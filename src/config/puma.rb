workers Integer(ENV['WEB_CONCURRENCY'] || 2)
max_threads_count = ENV.fetch("RAILS_MAX_THREADS") { 5 }
min_threads_count = ENV.fetch("RAILS_MIN_THREADS") { max_threads_count }
threads min_threads_count, max_threads_count

preload_app!
rails_env = ENV.fetch("RAILS_ENV") { "development" }
environment rails_env
case rails_env
  when "development"
    port ENV.fetch("PORT") { 3000 }
  when "production"
    bind "unix:/var/www/hangartalk/src/tmp/sockets/puma.sock"
end

pidfile ENV.fetch("PIDFILE") { "tmp/pids/server.pid" }
plugin :tmp_restart

on_worker_boot do
  # Worker specific setup for Rails 4.1+
  # See: https://devcenter.heroku.com/articles/deploying-rails-applications-with-the-puma-web-server#on-worker-boot
  ActiveRecord::Base.establish_connection
end
