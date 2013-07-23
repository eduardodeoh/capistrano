set_default(:logrotate_rails_app_period, 30)
set_default(:logrotate_rails_app_unicorn_period, 30)


set_default(:logrotate_rails_app_log) { "#{shared_path}/log/production.log" }
set_default(:logrotate_confd_dir, "/etc/logrotate.d")
set_default(:logrotate_template_rails_app, "logrotate_rails_app.erb")
set_default(:logrotate_rails_app_name) { "rails_app_#{application}" }
set_default(:logrotate_tmp_file) { "/tmp/#{logrotate_rails_app_name}" }
set_default(:logrotate_template_rails_app_unicorn, "logrotate_rails_app_unicorn.erb")
set_default(:logrotate_rails_app_name_unicorn) { "rails_app_unicorn_#{application}" }
set_default(:logrotate_tmp_file_unicorn) { "/tmp/#{logrotate_rails_app_name_unicorn}" }
