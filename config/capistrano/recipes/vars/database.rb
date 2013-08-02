#set_default(:database_host, "localhost")
set_default(:db_port, 5432)
set_default(:db_name) { "#{application}_production" }
set_default(:db_adapter, "postgresql")
set_default(:db_encoding, "unicode")
set_default(:db_pool, 5)
set_default(:db_version, "9.2")
set_default(:db_pid_file, "/var/run/postgresql/#{db_version}-main.pid")
