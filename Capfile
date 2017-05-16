# Load DSL and set up stages
require "capistrano/setup"

# Include default deployment tasks
require "capistrano/deploy"

# Include support for Git
require "capistrano/scm/git"
install_plugin Capistrano::SCM::Git

# Include tasks from other gems included in Gemfile
require 'capistrano/nvm'
require 'capistrano/npm'
require 'capistrano/rvm'
require 'capistrano/bundler'
require 'capistrano/rails/assets'
require 'capistrano/rails/migrations'

# Load custom tasks from `lib/capistrano/tasks` if any defined
Dir.glob("lib/capistrano/tasks/*.rake").each { |r| import r }
