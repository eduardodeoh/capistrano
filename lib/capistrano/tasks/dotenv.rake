namespace :deploy do
  namespace :dotenv do

    desc "Generate the .env vars file"
    task :setup do
      on roles :app do
        #https://github.com/capistrano/sshkit/blob/master/EXAMPLES.md#upload-a-file-from-a-stream
        info "Uploading #{shared_path}/config/.env"
        file = "dotenv"
        smart_template file, ".env"
      end
    end
    after "deploy:started", "deploy:dotenv:setup"

    desc "Symlink the .rbenv-vars file into latest release"
    task :symlink do
      on roles :app do
        execute :ln, '-nfs', "#{shared_path}/config/.env", "#{release_path}/.env"
      end
    end
    before "deploy:updated", "deploy:dotenv:symlink"

  end
end
