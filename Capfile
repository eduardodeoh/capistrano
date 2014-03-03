# Load DSL and Setup Up Stages
require 'capistrano/setup'

# Includes default deployment tasks
require 'capistrano/deploy'

# Includes tasks from other gems included in your Gemfile
#
# For documentation on these, see for example:
#
#   https://github.com/capistrano/rbenv
#   https://github.com/capistrano/bundler
#   https://github.com/capistrano/rails/tree/master/assets
#   https://github.com/capistrano/rails/tree/master/migrations

require 'capistrano/rbenv'
require 'capistrano/bundler'
# Compile assets on server
#require 'capistrano/rails/assets'
require 'capistrano/rails/migrations'
require 'capistrano/console'

#Future test
#require 'capistrano/maintenance'

# Loads custom tasks from `lib/capistrano/tasks' if you have any defined.
Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }

#Load custom helpers from 'lib/capistrano/helpers' if you have any defined.
Dir.glob('lib/capistrano/shared/*.rb').each { |r| import r }

#Load custom common settings for environments
Dir.glob('config/deploy/shared/*.rb').each { |r| import r }