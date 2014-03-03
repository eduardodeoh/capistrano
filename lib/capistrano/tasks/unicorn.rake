#http://www.rostamizadeh.net/blog/2012/03/09/wrangling-unicorn-usr2-signals-and-capistrano-deployments/

namespace :deploy do
  namespace :unicorn do

    desc "Setup Unicorn Application Server"
    task :setup do
      on roles :app do   
        info "Uploading unicorn.rb"
        file = "unicorn.rb"
        smart_template file

        info "Uploading init script unicorn_#{fetch(:application)}"
        file = "unicorn_init"
        smart_template file
        
        execute :chmod, '+x', "#{shared_path}/config/#{file}"
        execute :sudo, "mv #{shared_path}/config/#{file}", "/etc/init.d/unicorn_#{fetch(:application)}"
        execute :sudo, "update-rc.d -f unicorn_#{fetch(:application)} defaults"
      end
    end
    after "deploy:started", "deploy:unicorn:setup"


    #Task - Unicorn Application Server
    %w[start stop restart].each do |command|
      desc "#{command} unicorn server"
      task command do
        on roles :app do
          execute :bash, "/etc/init.d/unicorn_#{fetch(:application)} #{command}"
        end
      end
    end

  end
end
