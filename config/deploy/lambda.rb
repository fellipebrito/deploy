server '[[LAMBDA_SERVER]]', user: '[[LAMBDA_USER]]', roles: %w{web app}

# set custom ssh options
set :ssh_options, {
   keys: %w(config/id_rsa)
}
