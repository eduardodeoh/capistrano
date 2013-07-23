namespace :secret_token do
  desc "Generate the new secret token for sign cookies"
  task :setup, roles: :app do
    if capture("[ -f #{secret_token_app_shared_file_path} ] || echo missing").start_with?('missing')
      run "if ! [ -d  #{shared_path}/config ]; then mkdir -p #{shared_path}/config; fi"
      run "cat #{secret_token_app_file_path} | grep secret_token | cut -f1 -d'=' > /tmp/secret_tmp"
      run "echo `cat /tmp/secret_tmp` =  \\'$(#{secret_token_rake_task})\\' > #{secret_token_app_shared_file_path}"
      run "rm -f /tmp/secret_tmp"
    end
  end


  desc "Symlink the secret_token.rb file into latest release"
  task :symlink, roles: :app do
    setup
    run "ln -nfs #{secret_token_app_shared_file_path} #{secret_token_app_file_path}"
  end
  after "deploy:finalize_update", "secret_token:symlink"


end