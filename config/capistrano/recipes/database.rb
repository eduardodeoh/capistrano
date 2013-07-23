namespace :database do

  desc "Generate the database.yml configuration file."
  task :setup, roles: :app do
    run "if ! [ -d  #{shared_path}/config ]; then mkdir -p #{shared_path}/config; fi"
    put "#{File.read(File.expand_path("../templates/database.yml", __FILE__))}", "#{shared_path}/config/database.yml"
  end
  after "deploy:setup", "database:setup"


  desc "Symlink the database.yml file into latest release"
  task :symlink, roles: :app do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  end
  after "deploy:finalize_update", "database:symlink"
end