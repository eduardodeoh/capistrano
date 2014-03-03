#http://www.rostamizadeh.net/blog/2012/07/11/who-watches-the-watchers-using-upstart-to-manage-monit-which-manages-unicorn/
namespace :deploy do
  namespace :monit do

    desc "Setup all Monit configuration"
    task :setup do
      on roles :app do
        Rake::Task["deploy:monit:unicorn"].invoke
        Rake::Task["deploy:monit:syntax"].invoke
        Rake::Task["deploy:monit:reload"].invoke
      end
    end
    after "deploy:started", "deploy:monit:setup"

    desc "Monit setup Unicorn"
    task :unicorn do
      on roles :app do
        monit_config "unicorn"
      end
    end

    %w[start stop restart syntax reload].each do |command|
      desc "Run Monit #{command} script"
      task command do
        on roles :app do
          execute :sudo, "service monit #{command}"
        end
      end
    end

    %w[monitor unmonitor].each do |command|
      desc "monit #{command} unicorn_#{fetch(:application)}"
      task command do
        on roles :app do
          #run at group level
          execute :sudo, "monit -g unicorn_#{fetch(:application)} #{command}"
          execute :sudo, "monit -g unicorn_#{fetch(:application)}_workers #{command}"
        end
      end
    end
    before "deploy:starting", "deploy:monit:unmonitor"
    after "deploy:finished", "deploy:monit:monitor"
  end
end

def monit_config(name, destination = nil)
  destination ||= "#{fetch(:monit_confd_dir)}/#{name}.conf"
  smart_template "monit_#{name}"
  execute :sudo, "mv #{shared_path}/config/monit_#{name} #{destination}"
  execute :sudo, "chown root #{destination}"
  execute :sudo, "chmod 600 #{destination}"
end