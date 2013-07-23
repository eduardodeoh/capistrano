set_default(:unicorn_user) { user }
set_default(:unicorn_workers, 1)
set_default(:unicorn_timeout, 30)
set_default(:unicorn_zero_downtime, true)


set_default(:unicorn_path) { "#{current_path}" }
set_default(:unicorn_tmp_path) { "/tmp/unicorn_init_#{application}" }
set_default(:unicorn_initd_path) { "/etc/init.d/unicorn_#{application}" }
set_default(:unicorn_pid) { "#{current_path}/tmp/pids/unicorn.pid" }
set_default(:unicorn_socket) { "#{current_path}/tmp/sockets/unicorn.socket" }
set_default(:unicorn_config) { "#{shared_path}/config/unicorn.rb" }
set_default(:unicorn_log) { "#{shared_path}/log/unicorn.log" }
