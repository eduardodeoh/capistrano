#http://www.rostamizadeh.net/blog/2012/07/11/who-watches-the-watchers-using-upstart-to-manage-monit-which-manages-unicorn/
namespace :monit do

  desc "Setup all Monit configuration"
  task :setup do
    unicorn
    syntax
    reload
  end
  after "deploy:setup", "monit:setup"

  task(:unicorn, roles: :app) { monit_config "#{monit_ruby_application_server_template_file}" }

  %w[start stop restart syntax reload].each do |command|
    desc "Run Monit #{command} script"
    task command do
      run "#{sudo} service monit #{command}"
    end
  end

  %w[monitor unmonitor].each do |command|
    desc "monit #{command} unicorn_#{application}"
    task command, roles: :app do
      #run at group level
      run "#{sudo} monit -g unicorn_#{application} #{command}"
    end
  end
  after "deploy", "monit:monitor"
  after "deploy:cold", "monit:monitor"
  before "deploy", "monit:unmonitor"
  before "deploy:cold", "monit:unmonitor"


end

def monit_config(name, destination = nil)
  destination ||= "#{monit_confd_dir}/#{name}.conf"
  template "monit/#{name}.erb", "/tmp/monit_#{name}"
  run "#{sudo} mv /tmp/monit_#{name} #{destination}"
  run "#{sudo} chown root #{destination}"
  run "#{sudo} chmod 600 #{destination}"
end