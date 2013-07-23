namespace :rbenv_vars do
  desc "Generate the .rbenv-vars"
  task :setup, roles: :app do
    run "if ! [ -d  #{shared_path}/config ]; then mkdir -p #{shared_path}/config; fi"
    template "rbenv_vars.erb", "#{shared_path}/config/.rbenv-vars"
  end
  after "deploy:setup", "rbenv_vars:setup"

  desc "Symlink the .rbenv-vars file into latest release"
  task :symlink, roles: :app do
    run "ln -nfs #{shared_path}/config/.rbenv-vars #{release_path}/.rbenv-vars"
  end
  after "deploy:finalize_update", "rbenv_vars:symlink"
end