namespace :nginx do

  desc "Nginx setup recipe"
  task :setup, roles: :web do
    run "if ! [ -d #{nginx_path} ]; then #{sudo} mkdir -p #{nginx_path}; fi"
    template "nginx.erb", nginx_tmp_path
    run "sudo mv #{nginx_tmp_path} #{nginx_path}/#{application}.conf"
    restart
  end
  after "deploy:setup", "nginx:setup"


  #Task - Nginx HTTP Server
  desc "Start/Stop/Restart Nginx"
  %w[start stop restart].each do |command|
    desc "#{command} nginx server"
    task command, roles: :web, except: {no_release: true} do
      run "sudo service nginx #{command}"
    end
  end

end
