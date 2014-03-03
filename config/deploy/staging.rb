#INSERT IN THIS FILE SPECIFIC VARIABLES FOR STAGING ENVIRONMENT

#Set stage
set :stage, :staging

#For task deploy:database:seed this var doesn't is setting (capistrano-rails)
set :rails_env, :staging

#IP or name of Server/VPS
#set :server_host, "mydomainnameforproductionserver"

#NGINX
#set :nginx_domain_name, "mydomainnameforproductionserver"

#DATABASE CREDENTIALS
#set :db_user, "mydbuser"
#set :db_pass, "mydbpass"
#set :db_name, "mydbname"
#set :db_adapter, "postgresql"
#set :db_encoding, "unicode"
#set :db_pool, 5

#AWS CREDENTIALS
#set :aws_s3_key, "myawskey"
#set :aws_s3_secret, "myawssecret"
#set :aws_s3_region, "myawsregion"
#set :aws_s3_bucket, "myawsbucket"
#set :aws_s3_asset_url, "myawsurl"

#RAILS SECRET TOKEN - Genereted by "rake secret" or "openssl rand -hex 64"
#set :rails_secret_token, "insertyoursecrettoken"


# Simple Role Syntax
# ==================
# Supports bulk-adding hosts to roles, the primary
# server in each group is considered to be the first
# unless any hosts have the primary property set.
#role :app, %w{deploy@example.com}
#role :web, %w{deploy@example.com}
#role :db,  %w{deploy@example.com}

# Extended Server Syntax
# ======================
# This can be used to drop a more detailed server
# definition into the server list. The second argument
# something that quacks like a hash can be used to set
# extended properties on the server.
#server 'example.com', user: 'deploy', roles: %w{web app}, my_property: :my_value
#server "#{fetch(:server_host)}", user: "#{fetch(:user)}", roles: %w{web app db}

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

# fetch(:default_env).merge!(rails_env: :staging)
