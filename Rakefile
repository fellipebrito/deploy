desc 'Create alias for the config files in the correct directories'
task :install do
  create_dir '../../config/deploy'
  create_dir '../../lib/capistrano/tasks'

  create_sym_link '../../Capfile', 'vendor/deploy/Capfile'
  create_sym_link '../../config/deploy.rb', '../vendor/deploy/config/deploy.rb'
  create_sym_link '../../config/deploy/lambda.rb', '../../vendor/deploy/deploy/lambda.rb'
  create_sym_link '../../config/deploy/production.rb', '../../vendor/deploy/deploy/production.rb'
  create_sym_link '../../lib/capistrano/tasks/git.cap', '../../../vendor/deploy/lib/capistrano/tasks/git.cap'
end

def create_sym_link source, target
  system %Q{sudo ln -s #{target} #{source} --force}
end

def create_dir path
  system %Q{mkdir -p #{path}}
end
