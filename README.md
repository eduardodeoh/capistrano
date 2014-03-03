Capistrano 3.x
==========

Capistrano 3.x recipes for Rails Apps

1 - First, check my pre-setup via ansible: https://github.com/eduardodeoh/ansible

2 - cd your_app_dir

3 - git clone https://github.com/eduardodeoh/capistrano .

4 - check files:
	- config/deploy/production.rb
	- config/deploy/staging.rb
	- config/deploy/shared/common_settings.rb

5 - Insert in your Gemfile
	
	#For Deploy
	#https://github.com/capistrano/capistrano/blob/master/README.md

	gem 'capistrano', '~> 3.1'
	
	#https://github.com/capistrano/bundler
	gem 'capistrano-bundler'

	#https://github.com/capistrano/rails
	gem 'capistrano-rails'

	#https://github.com/capistrano/rbenv
	gem 'capistrano-rbenv', github: "capistrano/rbenv"

	#https://github.com/capistrano/maintenance
	#gem 'capistrano-maintenance', github: "capistrano/capistrano-maintenance"

7 - bundle exec cap production deploy
