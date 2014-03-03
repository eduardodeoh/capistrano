#Help from:
#https://gist.github.com/basti/9232976
#https://github.com/TalkingQuickly/capistrano-3-rails-template/blob/master/lib/capistrano/tasks/compile_assets_locally.cap

namespace :deploy do
  desc "compiles assets locally then rsyncs"
  task :compile_assets_locally do
    run_locally do
      execute "bundle exec rake assets:precompile"
    end
    on roles(:app) do |role|
      run_locally do
        execute "rsync -avzrh ./public/assets/ #{role.user}@#{role.hostname}:#{release_path}/public/assets/;" 
      end
    end
    run_locally do
      execute "rm -rf ./public/assets"
      # execute "rm -rf tmp/cache/assets" # in case you are not seeing changes
    end
  end
  # compile assets locally then rsync
  after 'deploy:symlink:shared', 'deploy:compile_assets_locally'
end