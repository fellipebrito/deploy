# define paths and filenames
deploy_to   = '/var/www/'
pid_file    = "#{deploy_to}/shared/tmp/pids/unicorn.pid"
socket_file = "#{deploy_to}/shared/tmp/sockets/unicorn.sock"

worker_processes 4
timeout 30

listen socket_file, :backlog => 64
pid pid_file
