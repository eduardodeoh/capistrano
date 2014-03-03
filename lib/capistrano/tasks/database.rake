namespace :deploy do
  namespace :database do

    desc "Generate the database.yml configuration file."
    task :setup do
      on roles :app do
        file = File.path("lib/capistrano/templates/database.yml")
        info "Uploading #{file} to #{shared_path}/config/database.yml"
        upload! file, "#{shared_path}/config/database.yml"
      end
    end
    after "deploy:started", "deploy:database:setup"


    desc "Symlink the database.yml file into latest release"
    task :symlink do
      on roles :app do
        info "Symlink #{shared_path}/config/database.yml to #{release_path}/config/database.yml"
        execute :ln, '-nfs', "#{shared_path}/config/database.yml", "#{release_path}/config/database.yml"
      end
    end
    before "deploy:updated", "deploy:database:symlink"

    desc "Create database - rake db:create"
    task :create do
      on roles :db do
        within release_path do
          with rails_env: fetch(:rails_env) do
            info "Creating database....."
            execute :rake, "db:create"
          end
        end
      end
    end
    before 'deploy:migrate', 'deploy:database:create'

    desc "Seed database - rake db:seed"
    task :seed do
      on roles :db do
        within release_path do
          with rails_env: fetch(:rails_env) do
            info "Seeding database....."
            execute :rake, "db:seed"
          end
        end
      end
    end
    #Executar db:seed a cada deploy duplicará as entradas no banco
    #Realizar o seed de forma manual somente após o primeiro deploy
    #after 'deploy:migrate', 'deploy:database:seed'

  end
end
