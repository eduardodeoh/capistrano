namespace :deploy do

  #desc "Checking if exists directory #{rails_dir}/#{application}"
  task :pre_setup do
    run "if ! [ -d #{rails_dir}/#{application} ]; then sudo mkdir -p #{rails_dir}/#{application}; fi"
    run "#{sudo} mkdir -p /var/www/rails"
    run "#{sudo} chown -R #{user}.#{user} /var/www"
    run "#{sudo} chmod -R 775 /var/www"
    #run "#{sudo} adduser #{user} nginx"
  end
  before "deploy:setup", "deploy:pre_setup"


  #Verifica git local atualizado com git remoto
  desc "Make sure local git is in sync with remote."
  task :check_revision, roles: :web do
    unless `git rev-parse HEAD` == `git rev-parse origin/#{branch}`
      puts "WARNING: HEAD is not the same as origin/#{branch}"
      puts "Run `git push` to sync changes."
      exit
    end
  end
  # Verify git local branch updated with remote branch
  before "deploy", "deploy:check_revision"
  before "deploy:migrations", "deploy:check_revision"
  before "deploy:cold", "deploy:check_revision"

end
