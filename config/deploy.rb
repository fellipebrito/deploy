# config valid only for Capistrano 3.1
lock '3.1.0'

set :application, '[[APP_NAME]]'
set :log_level, :info #debug
#set :rvm_ruby_version, '2.0.0-p451'

set :repo_url, '[[GIT_REPOSITORY]]'
set :branch,   proc { `git rev-parse --abbrev-ref HEAD`.chomp }
set :deploy_to, '/var/www/[[APP_NAME]]'

# Aliases
set :linked_files, %w{ config/settings.yml }
set :linked_dirs, %w{ bin log tmp/pids tmp/cache tmp/sockets vendor/bundle }

# Unicorn Defs
set :unicorn_config_path, "#{current_path}/config/unicorn.rb"
set :unicorn_pid, "#{deploy_to}/shared/tmp/pids/unicorn.pid"

# Rails Defs
# set :rails_env, 'production'
# set :unicorn_rack_env, 'production'

after 'deploy:publishing', 'deploy:restart'

namespace :deploy do
  task :restart do
    invoke 'unicorn:restart'
  end

  # Use this sample to create links to config files on submodules.
  # after :restart, :create_config_links do
  #   on roles(:app) do
  #     execute :ln, '-s', "#{deploy_to}/shared/config/settings.yml #{current_path}/vendor/rumblefish/database/config/settings.yml"
  #   end
  # end
end
