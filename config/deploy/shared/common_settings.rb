#INSERT IN THIS FILE COMMON VARIABLES FOR ALL ENVIRONMENTS

#UNICORN
set :unicorn_workers, 1
set :unicorn_timeout, 30
set :unicorn_zero_downtime, true
set :unicorn_pid, -> { "#{current_path}/tmp/pids/unicorn.pid" }
set :unicorn_socket, -> { "#{current_path}/tmp/sockets/unicorn.socket" }
set :unicorn_log, -> { "#{shared_path}/log/unicorn.log" }
set :unicorn_config, -> { "#{shared_path}/config/unicorn.rb" }

#NGINX
set :nginx_root_path, "/etc/nginx"
set :nginx_conf_path, "/etc/nginx/sites-enabled"
set :nginx_log_path, "/var/log/nginx"

#MONIT
set :monit_confd_dir, "/etc/monit/conf.d"
set :monit_alert_email, "myalertemail@bar.com"

#GIT-CRYPT KEY
#https://github.com/AGWA/git-crypt
set :git_crypt_key, "mygit.key"

#LOGROTATE
set :logrotate_rails_app_period, 30
set :logrotate_rails_app_unicorn_period, 30
set :logrotate_rails_app_log, -> { "#{shared_path}/log/production.log" }
set :logrotate_confd_dir, "/etc/logrotate.d"
set :logrotate_rails_app_name, -> { "rails_#{fetch(:application)}" }
set :logrotate_rails_app_name_unicorn, -> { "rails_#{fetch(:application)}_unicorn" }
