#Capistrano 3 Flow - Must Read
#http://www.capistranorb.com/documentation/getting-started/flow/

### ALERT ####
#DON'T PUT SECRET INFORMATION HERE#

# config valid only for Capistrano 3.1
lock 3.1


#Set Rbenv Environment - capistrano-rbenv
#set :rbenv_ruby, '2.0.0-p353'
set :rbenv_ruby, -> { File.read(".ruby-version").chomp }
set :rbenv_type, :user # or :system, depends on your rbenv setup


#Set Bundler - capistrano-bundler
# set :bundle_gemfile, -> { release_path.join('Gemfile') }
# set :bundle_dir, -> { shared_path.join('bundle') }
# set :bundle_flags, '--deployment --quiet'
# set :bundle_without, %w{development test}.join(' ')
# set :bundle_binstubs, -> { shared_path.join('bin') }
# set :bundle_roles, :all
# set :bundle_bins, %w(gem rake ruby)

# APPLICATION NAME
set :application, "fpp"

# Set deployer SSH user
set :user, "deploy"

# Deploy using git:
set :git_user, "mygituser"
set :git_repo_name, "mygitreponame"
set :scm, "git"
set :repo_url,  "git@github.com:#{fetch(:git_user)}/#{fetch(:git_repo_name)}.git"
set :branch, "mygitbranch"
#ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

#Set Rails Apps Directory
set :rails_dir, "/var/www/rails"
set :deploy_to, "#{fetch(:rails_dir)}/#{fetch(:application)}"
set :scm, :git

# Run commands as sudoer ?
set :use_sudo, false

set :format, :pretty
set :log_level, :info
#set :log_level, :debug

# Must be set for the password prompt from git to work
#set :pty, true

#Capistrano forward my private keys for git
set :ssh_options, { forward_agent: true }

#set :linked_files, %w{config/database.yml}
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets uploads}

#Default Enviroment for commands executed by SSHKit
set :default_env, { path: "$HOME/.rbenv/shims:$PATH" }

# how many releases should be kept in releases directory
set :keep_releases, 5

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      # execute :touch, release_path.join('tmp/restart.txt')
      Rake::Task["deploy:unicorn:restart"].invoke
    end
  end
  after :publishing, :restart

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end
  after :finishing, 'deploy:cleanup'
end
