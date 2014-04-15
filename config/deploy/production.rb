server '[[PRODUCTION_SERVER]]', user: '[[PRODUCTION_USER]]', roles: %w{web app}

# set custom ssh options
set :ssh_options, {
   keys: %w(config/id_rsa)
}
