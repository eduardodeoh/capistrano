#http://www.capistranorb.com/documentation/getting-started/cold-start/
namespace :deploy do
  desc "Check that we can access ...."
  task :check_permissions do
    on roles :all do |host|
      if test("[ -w #{fetch(:deploy_to)} ]")
        info "#{fetch(:deploy_to)} is writable on #{host}"
      else
        error "#{fetch(:deploy_to)} is NOT writable on #{host}"
      end
    end
  end
end
