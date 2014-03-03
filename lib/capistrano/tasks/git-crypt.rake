namespace :deploy do
  namespace :gitcrypt do
    desc "Setting git-crypt"
    task :setup do
      on roles :app do
        if test("[ ! -f #{shared_path}/config/#{fetch(:git_crypt_key)} ]")
          #invoke "deploy:myconf:check_shared_config"
          Rake::Task["deploy:myconf:check_shared_config"].invoke
          info "File #{shared_path}/config/#{fetch(:git_crypt_key)} doesn't exist. Uploading..."
          ask :git_crypt_key_path, "Insert absolute path and name for git-crypt key"
          upload! "#{fetch(:git_crypt_key_path)}", "#{shared_path}/config/#{fetch(:git_crypt_key)}"
          info "Executing task git:clone, then we can activate git-crypt at first deploy"
          Rake::Task["git:clone"].invoke
          info "Activating git-crypt...."
          #Capistrano git check uses --mirror .... and repo_path not is real git clone
          #execute "cd #{repo_path} && git-crypt init #{shared_path}/config/#{fetch(:git_crypt_key)}"
          #Manual "git-crypt init key_file" because capistrano bare repository
          execute "cd #{repo_path} && git config filter.git-crypt.smudge \"git-crypt smudge #{shared_path}/config/#{fetch(:git_crypt_key)}\""
          execute "cd #{repo_path} && git config filter.git-crypt.clean \"git-crypt clean #{shared_path}/config/#{fetch(:git_crypt_key)}\""
          execute "cd #{repo_path} && git config diff.git-crypt.textconv \"git-crypt diff #{shared_path}/config/#{fetch(:git_crypt_key)}\""
        else
          info "File #{shared_path}/config/#{fetch(:git_crypt_key)} exist. Skipping task..."
        end
      end
    end
    before "deploy:updating", "deploy:gitcrypt:setup"
  end
end