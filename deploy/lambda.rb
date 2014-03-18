server __YOUR_DEV_SERVER__, user: __YOUR_DEV_SERVER_USER__, roles: %w{web app}

# set custom ssh options
set :ssh_options, {
   keys: %w(config/id_rsa)
}
