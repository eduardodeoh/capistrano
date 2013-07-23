#https://github.com/digineo/secret_token_replacer/blob/master/lib/secret_token_replacer/recipes.rb
set_default(:secret_token_file_name, "secret_token.rb")
set_default(:secret_token_app_file_path) { "#{release_path}/config/initializers/#{secret_token_file_name}" }
set_default(:secret_token_app_shared_file_path) { "#{shared_path}/config/#{secret_token_file_name}" }
set_default(:secret_token_rake_task) { "cd #{current_path}; bundle exec rake secret" }