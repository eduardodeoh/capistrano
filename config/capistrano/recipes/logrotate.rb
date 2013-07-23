namespace :logrotate do
  desc "Generate rails app logrotate configuration file"
  task :rails_app, roles: :app do
    template "#{logrotate_template_rails_app}", "#{logrotate_tmp_file}"
    run "sudo mv #{logrotate_tmp_file} #{logrotate_confd_dir}/#{logrotate_rails_app_name}"
  end
  after "deploy:setup", "logrotate:rails_app"

  desc "Generate rails app Unicorn logrotate configuration file"
  task :rails_app_unicorn, roles: :app do
    template "#{logrotate_template_rails_app_unicorn}", "#{logrotate_tmp_file_unicorn}"
    run "sudo mv #{logrotate_tmp_file_unicorn} #{logrotate_confd_dir}/#{logrotate_rails_app_name_unicorn}"
  end
  after "deploy:setup", "logrotate:rails_app_unicorn"

end

