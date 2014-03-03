namespace :deploy do
  namespace :git do

    #Verifica git local atualizado com git remoto
    desc "Make sure local git is in sync with remote."
    task :check_revision do
      run_locally do
        unless `git rev-parse HEAD` == `git rev-parse origin/#{fetch(:branch)}`
          puts "WARNING: HEAD is not the same as origin/#{fetch(:branch)}"
          puts "Run `git push` to sync changes."
          exit 1
        end
      end
    end
    # Verify git local branch updated with remote branch
    before "deploy", "deploy:git:check_revision"

  end
end