# App´s deploy settings

#IP or name of Server/VPS
set :server_host, "www.xxx.com.br"

# App name
set :application, "name_of_your_app"

# Set deployer SSH user
set :user, "deploy"

# Deploy using git:
set :git_user, "eduardodeoh"
set :git_repo_name, "xxx"
set :scm, "git"
set :repository,  "git@github.com:#{git_user}/#{git_repo_name}.git"
set :branch, "master"

#Database credentials
set :db_user, "xxx"
set :db_pass, "xxxxx"

#Monit alert email
set :monit_alert_email, "xxxxx@gmail.com"

#INSERT YOUR VARS HERE (for .rbenv-vars or .env file) and config/capistrano/recipes/templates/{rbenv_vars,dotenv}.erb
