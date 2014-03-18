# config valid only for Capistrano 3.1
lock '3.1.0'

set :application, 'bingapi'
set :log_level, :debug

set :repo_url, "__YOUR_GIT_REPO__"
set :branch,   proc { `git rev-parse --abbrev-ref HEAD`.chomp }
set :deploy_to, "/var/www"

# Aliases
# set :linked_files, %w{config/database.yml}
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle}

# Unicorn Defs
set :unicorn_config_path, -> { File.join(current_path, "vendor", "deploy", "unicorn.rb") }
set :unicorn_pid, "#{deploy_to}/shared/tmp/pids/unicorn.pid"

after 'deploy:publishing', 'deploy:restart'

namespace :deploy do
  task :restart do
    invoke 'unicorn:restart'
  end
end
