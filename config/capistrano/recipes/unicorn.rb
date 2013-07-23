#http://www.rostamizadeh.net/blog/2012/03/09/wrangling-unicorn-usr2-signals-and-capistrano-deployments/

namespace :unicorn do

  desc "Unicorn setup recipe"
  task :setup, roles: :app do
    run "if ! [ -d  #{shared_path}/config ]; then mkdir -p #{shared_path}/config; fi"
    template "unicorn.erb", unicorn_config
    template "unicorn_init.erb", unicorn_tmp_path
    run "chmod +x #{unicorn_tmp_path}"
    run "#{sudo} mv #{unicorn_tmp_path} #{unicorn_initd_path}"
    run "#{sudo} update-rc.d -f unicorn_#{application} defaults"
  end
  after "deploy:setup", "unicorn:setup"


  #Task - Unicorn Application Server
  %w[start stop restart].each do |command|
    desc "#{command} unicorn server"
    task command, roles: :app, except: {no_release: true} do
      run "/etc/init.d/unicorn_#{application} #{command}"
    end
    after "deploy:#{command}", "unicorn:#{command}"
  end

end