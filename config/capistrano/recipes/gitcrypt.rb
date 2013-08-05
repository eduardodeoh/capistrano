set_default(:gitcrypt_salt) { Capistrano::CLI.password_prompt "Type gitcrypt salt: " }
set_default(:gitcrypt_password) { Capistrano::CLI.password_prompt "Type gitcrypt password: " }

#https://github.com/shadowhand/git-encrypt/tree/master
namespace :gitcrypt do
#
  desc "Setting gitcrypt"
  task :setup, roles: :app do
    if capture("[ -f #{shared_path}/config/.gitcrypt ] || echo missing").start_with?('missing')
      logger.info "File #{shared_path}/config/.gitcrypt doesn't exist. Creating..."
      run "touch #{shared_path}/config/.gitcrypt"
      cmd = "cd #{shared_path}/cached-copy"
      run "#{cmd}; git config gitcrypt.salt #{gitcrypt_salt}"
      run "#{cmd}; git config gitcrypt.pass #{gitcrypt_password}"
      run %Q{#{cmd}; git config filter.encrypt.smudge "gitcrypt smudge"}
      run %Q{#{cmd}; git config filter.encrypt.clean "gitcrypt clean"}
      run %Q{#{cmd}; git config diff.encrypt.textconv "gitcrypt diff"}
    else
      logger.info "File #{shared_path}/config/.gitcrypt exist. Skipping task..."
    end
  end
  after "deploy:update_code", "gitcrypt:setup"
end
