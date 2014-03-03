namespace :deploy do
  namespace :nginx do

    desc "Nginx setup recipe"
    task :setup do
      on roles :web do
        if test("[ ! -d #{fetch(:nginx_root_path)} ]")
          execute :mkdir, "#{fetch(:nginx_root_path)}"
        end
        info "Uploading Nginx file conf"
        file = "nginx_conf"
        smart_template file
        execute :sudo, "mv #{shared_path}/config/#{file} #{fetch(:nginx_conf_path)}/#{fetch(:application)}.conf"
      end
    end
    after "setup", "restart"


    #Task - Nginx HTTP Server
    desc "Start/Stop/Restart Nginx"
    %w[start stop restart].each do |command|
      desc "#{command} nginx server"
      task :restart do
        on roles :web do
          execute :sudo, :bash, "service nginx restart"
        end
      end
    end

  end
end
