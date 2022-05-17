workers Integer(ENV['WEB_CONCURRENCY'] || 2)
max_threads_count = ENV.fetch("RAILS_MAX_THREADS") { 5 }
min_threads_count = ENV.fetch("RAILS_MIN_THREADS") { max_threads_count }
threads min_threads_count, max_threads_count

preload_app!
# rails_env = ENV.fetch("RAILS_ENV") { "development" }
# environment rails_env
# case rails_env
#   when "development"
#     port ENV.fetch("PORT") { 3000 }
#   when "production"
#     bind "unix:///var/www/hangartalk/tmp/sockets/puma.sock"
# end
environment ENV.fetch("RAILS_ENV") { "development" }
bind "unix:////var/www/hangartalk/tmp/sockets/puma.sock"

pidfile ENV.fetch("PIDFILE") { "tmp/pids/server.pid" }
plugin :tmp_restart

on_worker_boot do
  ActiveRecord::Base.establish_connection
end
