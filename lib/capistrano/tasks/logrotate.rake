namespace :deploy do
  namespace :logrotate do
   
    desc "Generate rails app logrotate configuration file"
    task :rails_app do
      on roles :app do
        file = "logrotate_rails_app"
        smart_template file
        execute :sudo, "mv #{shared_path}/config/#{file} #{fetch(:logrotate_confd_dir)}/#{fetch(:logrotate_rails_app_name)}"
      end
    end
    after "deploy:started", "deploy:logrotate:rails_app"

    desc "Generate rails app Unicorn logrotate configuration file"
    task :rails_app_unicorn do
      on roles :app do
        file = "logrotate_rails_app_unicorn"
        smart_template file
        execute :sudo, "mv #{shared_path}/config/#{file} #{fetch(:logrotate_confd_dir)}/#{fetch(:logrotate_rails_app_name_unicorn)}"
      end
    end
    after "deploy:started", "deploy:logrotate:rails_app_unicorn"
  end
end