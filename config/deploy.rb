# config valid only for Capistrano 3.1
lock '3.1.0'

set :application, '[[APP_NAME]]'
set :log_level, :info #debug
#set :rvm_ruby_version, '2.0.0-p451'

set :repo_url, "[[GIT_REPOSITORY]]"
set :branch,   proc { `git rev-parse --abbrev-ref HEAD`.chomp }
set :deploy_to, "/var/www/[[APP_NAME]]"

# Aliases
#set :linked_files, %w{config/database.yml vendor/database/config/settings.yml}
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle}

# Unicorn Defs
set :unicorn_config_path, -> { File.join(current_path, "vendor", "deploy", "unicorn.rb") }
set :unicorn_pid, "#{deploy_to}/shared/tmp/pids/unicorn.pid"

# Rails Defs
# set :rails_env, 'production'
# set :unicorn_rack_env, 'production'

after 'deploy:publishing', 'deploy:restart'

namespace :deploy do
  task :restart do
    invoke 'unicorn:restart'
  end
end
