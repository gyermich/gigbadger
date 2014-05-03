# Simple Role Syntax
# ==================
# Supports bulk-adding hosts to roles, the primary
# server in each group is considered to be the first
# unless any hosts have the primary property set.
# Don't declare `role :all`, it's a meta role
role :app, %w{ubuntu@ec2-54-187-108-120.us-west-2.compute.amazonaws.com}
role :web, %w{ubuntu@ec2-54-187-108-120.us-west-2.compute.amazonaws.com
}
role :db,  %w{ubuntu@ec2-54-187-108-120.us-west-2.compute.amazonaws.com
}

role :resque_worker, "ubuntu@ec2-54-187-108-120.us-west-2.compute.amazonaws.com
"
role :resque_scheduler, "ubuntu@ec2-54-187-108-120.us-west-2.compute.amazonaws.com
"

set :workers, { "*" => 1 }
set :resque_environment_task, true


# Uncomment this line if your workers need access to the Rails environment:
# set :resque_environment_task, true

# Extended Server Syntax
# ======================
# This can be used to drop a more detailed server
# definition into the server list. The second argument
# something that quacks like a hash can be used to set
# extended properties on the server.
server 'ec2-54-187-108-120.us-west-2.compute.amazonaws.com
', user: 'ubuntu', roles: %w{gigbadger}, my_property: :my_value

server 'ec2-54-187-108-120.us-west-2.compute.amazonaws.com
',
  user: 'ubuntu',
  roles: %w{webapp},
  ssh_options: {
    keys: %w(/Users/ashagolveo/.ssh/gbadger.pem),
    forward_agent: false,
    auth_methods: %w(publickey)
  }

namespace :figaro do
  desc "SCP transfer figaro configuration to the shared folder"
  task :setup do
    on roles(:app) do
      upload! "config/application.yml", "#{shared_path}/config/application.yml", via: :scp
    end
  end
end

namespace :resque do
  desc "create temp pid directory"
  task :create_pid_dir do
    on roles(:app) do
      execute "mkdir -p #{current_path}/tmp/pids"
    end
  end
end

after "deploy:check:directories", "figaro:setup"
after "resque:stop", "resque:create_pid_dir"
after "deploy:restart", "resque:restart"
# you can set custom ssh options
# it's possible to pass any option but you need to keep in mind that net/ssh understand limited list of options
# you can see them in [net/ssh documentation](http://net-ssh.github.io/net-ssh/classes/Net/SSH.html#method-c-start)
# set it globally
#  set :ssh_options, {
#    keys: %w(/home/rlisowski/.ssh/id_rsa),
#    forward_agent: false,
#    auth_methods: %w(password)
#  }
# and/or per server
# server 'example.com',
#   user: 'user_name',
#   roles: %w{web app},
#   ssh_options: {
#     user: 'user_name', # overrides user setting above
#     keys: %w(/home/user_name/.ssh/id_rsa),
#     forward_agent: false,
#     auth_methods: %w(publickey password)
#     # password: 'please use keys'
#   }
# setting per server overrides global ssh_options
