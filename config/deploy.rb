#Main Capistrano Howto
#http://robmclarty.com/blog/how-to-deploy-a-rails-4-app-with-git-and-capistrano
#https://gist.github.com/jrochkind/2161449
#https://help.github.com/articles/deploying-with-capistrano
#https://github.com/capistrano/capistrano/wiki/Capistrano-Tasks

# Automatic "bundle install" after deploy
require 'bundler/capistrano'

#https://github.com/bundler/bundler/blob/master/lib/bundler/deployment.rb
#https://gist.github.com/chrismo/5043420/#comment-786623
#Bundle flags to compatibility with Rails 3 and Rails 4 (binstubs)
set :bundle_flags, "--deployment --quiet --binstubs .bundle/bin"

#Load rbenv environment
set :default_environment, {
  'PATH' => "$HOME/.rbenv/shims:$HOME/.rbenv/bin:$PATH",
  'RBENV_VERSION' => '2.0.0-p247'
}

#Load Capistrano General Settings
load "config/capistrano/settings"

#Load capistrano recipes....
load "config/capistrano/recipes/helpers/methods"
load "config/capistrano/recipes/vars/database"
load "config/capistrano/recipes/vars/logrotate"
load "config/capistrano/recipes/vars/monit"
load "config/capistrano/recipes/vars/nginx"
#load "config/capistrano/recipes/vars/secret_token"
load "config/capistrano/recipes/vars/unicorn"
load "config/capistrano/recipes/base"
load "config/capistrano/recipes/ssh_agent"

#Using vars file via gem dotenv-rails
load "config/capistrano/recipes/dotenv"

#Using vars file via rbenv-vars
#load "config/capistrano/recipes/rbenv_vars"

load "config/capistrano/recipes/database"
##load "config/capistrano/recipes/secret_token"
load "config/capistrano/recipes/nginx"
load "config/capistrano/recipes/unicorn"
load "config/capistrano/recipes/logrotate"
load "config/capistrano/recipes/monit"

#Uncomment #load 'deploy/assets' in Capfile

#Speed up assets pre-compile
#load "config/capistrano/recipes/speed_up_assets"

#Pre-compile assets locally instead on vps server
load "config/capistrano/recipes/compile_assets_locally"


#https://github.com/capistrano/capistrano/blob/master/lib/capistrano/recipes/deploy.rb#L53
set :shared_children,   %w(public/system log tmp/pids tmp/sockets )

#https://github.com/capistrano/capistrano/blob/master/lib/capistrano/recipes/deploy/assets.rb#L11
set :normalize_asset_timestamps, true

# We have all components of the app on the same server
server server_host, :app, :web, :db, :primary => true

#In situation having multiple servers
#role :web, "192.241.194.15"
#role :app, "192.241.194.15"
#role :db, "192.241.194.15", primary: true #Primary database server for migrations

# Application environment
set :rails_env, :production

# Run commands as sudoer ?
set :use_sudo, false

# the ssh port
set :port, 22

#Set Rails Apps Directory
set :rails_dir, "/var/www/rails"

# Must be set for the password prompt from git to work
default_run_options[:pty] = true

#Capistrano forward my private keys for git
ssh_options[:forward_agent] = true

#Default shell
#default_run_options[:shell] = "/bin/bash"

# Checkout, compress and send a local copy
# the application deployment path
set :deploy_via, :remote_cache
set :deploy_to, "#{rails_dir}/#{application}"

#Set SCM(GIT) password
#set :scm_passphrase, "password"

#Git Submodules?
set :git_enable_submodules, 1

# how many releases should be kept in releases directory
set :keep_releases, 3

#Check migrations everty deploy
after 'deploy:update_code', 'deploy:migrate'

# Clean-up old releases
after "deploy", "deploy:cleanup"

#ansible manages server bootstrap
#rbenv manages rubies
#bundler manages gems
#capistrano manages deployments
#monit monitors processes