# encoding: utf-8

VENDOR_PATH       = File.dirname(__FILE__) + '/..'
APPLICATION_PATH  = "#{VENDOR_PATH}/../.."

desc 'Make deploy app instalation, prompting to user data about app and git repository'
task :install do
  show_start_message
  prompt_if_continues if capified?

  # Opts to run production environment
  opts  = { app_name: input_app_name, git_repository: input_repository, production_server: input_production_server, production_user: input_production_user }

  # Define if needs to configure lambda env
  opts[:configure_lambda] = configure_lambda_env?

  # Read lambda configs only if user wants.
  if opts[:configure_lambda]
    opts[:lambda_server]    = input_lambda_server
    opts[:lambda_user]      = input_lambda_user
  else
    opts[:lambda_server]    = ''
    opts[:lambda_user]      = ''
  end

  puts "\nStarting copy of files..."

  create_dirs
  copy_files files, opts
  copy_files lambda_files, opts if opts[:configure_lambda]

  show_end_message
end

# Clear screen, show beauty head image.
def show_start_message
  puts "\e[H\e[2J"
  puts 'Start Deploy Self-Installing.'
  puts '#' * 100
  puts "\n"
end

def show_end_message
  puts "\n"
  puts 'Done.'
  puts 'All files was created with initial data. You can complete or change with your preferences.'
  puts "\n"
  puts 'For more information see Capistrano documentation: http://capistranorb.com'

  puts "\n\n"
end

# Verify if project is already capified.
def capified?
  File.exists? "#{APPLICATION_PATH}/Capfile"
end

def prompt_if_continues
  puts 'WARNING: Apparently this project already capified. Do you wish to continue AND OVERWRITE all deploy files? [y/N]'
  exit unless %w{ y Y }.include? $stdin.gets.chomp

  puts 'Yes. Proceding with instalation...'
end

def configure_lambda_env?
  puts 'Do you wish to configure a Lambda (dev) environment to? [Y/n]'

  $stdin.gets.chomp != 'n'
end

def input_app_name
  puts "Type your Application Name (Ex. my-github-project): \r"
  input  = $stdin.gets.chomp
  if input.empty?
    input  = 'my_undefined_app'
    puts "*** WARNING: App name not informed! Assuming **#{input}**"
  end

  puts "\n"

  input.strip.gsub /\s/, '_'
end

def input_repository
  puts "Type your Application's git repository (Ex. git@github.com:my-account/my-project.git): \r"
  input = $stdin.gets.chomp

  if input.empty?
    puts "*** ERROR: Repository not informed!"
    exit
  end

  puts "\n"

  input.strip
end

def input_lambda_server
  puts "Type your Lambda (dev) server name or IP: [localhost] \r"
  input  = $stdin.gets.chomp
  if input.empty?
    input  = 'localhost'
    puts "*** WARNING: Lambda server name not informed! Assuming **#{input}**"
  end

  puts "\n"

  input.strip.gsub /\s/, '_'
end

def input_lambda_user
  puts "Lambda (dev) user with ssh access allowed: [ubuntu] "
  input  = $stdin.gets.chomp
  if input.empty?
    input  = 'ubuntu'
    puts "*** WARNING: Lambda (dev) user not informed! Assuming **#{input}**"
  end

  puts "\n"

  input.strip.gsub /\s/, '_'
end

def input_production_server
  puts "Type your Production server name or IP: \r"
  input  = $stdin.gets.chomp

  if input.empty?
    puts "*** ERROR: Production server name not informed!"
    exit
  end

  puts "\n"

  input.strip.gsub /\s/, '_'
end

def input_production_user
  puts "Production user with ssh access allowed: [ubuntu] "
  input  = $stdin.gets.chomp
  if input.empty?
    input  = 'ubuntu'
    puts "*** WARNING: Production user not informed! Assuming **#{input}**"
  end

  puts "\n"

  input.strip.gsub /\s/, '_'
end

# DEfine files to copy to project with replacements
def files
  %w{ Capfile config/deploy.rb config/deploy/production.rb lib/capistrano/tasks/git.cap config/unicorn.rb }
end

def lambda_files
  %w{ config/deploy/lambda.rb }
end

# Define dirs that needs to exists
def dirs
  %w{ config/deploy lib/capistrano/tasks }
end

def create_dirs
  # Create dirs
  dirs.each do |dir|
    Dir.mkdir "#{APPLICATION_PATH}/#{dir}" unless File.directory? "#{APPLICATION_PATH}/#{dir}"
    puts "Dir #{dir} created."
  end
end

# Copy received files array from vendor to app making replacements.
def copy_files(files_array, opts)
  files_array.each do |file|
    origin      = File.new "#{VENDOR_PATH}/#{file}", 'r'
    destination = File.new "#{APPLICATION_PATH}/#{file}", 'w'

    destination.write origin.read.gsub(/\[\[APP_NAME\]\]/, opts[:app_name])
                                 .gsub(/\[\[GIT_REPOSITORY\]\]/, opts[:git_repository])
                                 .gsub(/\[\[PRODUCTION_SERVER\]\]/, opts[:production_server])
                                 .gsub(/\[\[PRODUCTION_USER\]\]/, opts[:production_user])
                                 .gsub(/\[\[LAMBDA_SERVER\]\]/, opts[:lambda_server])
                                 .gsub(/\[\[LAMBDA_USER\]\]/, opts[:lambda_user])

    origin.close
    destination.close

    puts "File #{file} created."
  end
end

