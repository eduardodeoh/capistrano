namespace :dotenv do
  desc "Generate the .env vars file"
  task :setup, roles: :app do
    run "if ! [ -d  #{shared_path}/config ]; then mkdir -p #{shared_path}/config; fi"
    template "dotenv.erb", "#{shared_path}/config/.env"
  end
  after "deploy:setup", "dotenv:setup"

  desc "Symlink the .rbenv-vars file into latest release"
  task :symlink, roles: :app do
    run "ln -nfs #{shared_path}/config/.env #{release_path}/.env"
  end
  after "deploy:finalize_update", "dotenv:symlink"
end