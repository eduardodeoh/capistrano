namespace :deploy do
  namespace :myconf do

  desc 'Check config directory exist in shared'
  task :check_shared_config do
    on roles :app do
      execute :mkdir, '-pv', "#{shared_path}/config"
    end
  end

  end
end
#https://github.com/capistrano/capistrano/blob/master/lib/capistrano/tasks/deploy.rake#L43
before "deploy:started", "deploy:myconf:check_shared_config"
