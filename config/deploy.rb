# Config valid only for current version of Capistrano
lock "3.8.1"

set :application, "openbudgets"
set :repo_url, "git@github.com:openbudgets/participatory-budgeting.git"

# Default branch is :master
set :branch, ENV['BRANCH'] if ENV['BRANCH']

# Default value for linked_dirs is []
append :linked_dirs, "public/uploads", "node_modules"

# Server config
server ENV['CAP_SERVER'],
  user: ENV['CAP_USER'],
  port: ENV['CAP_PORT'],
  roles: %w{web app db},
  ssh_options: {
    forward_agent: false,
    auth_methods: %w(publickey)
 }

# Force production environment for Rails
set :rails_env, :production

# Node config
set :nvm_node, 'v6.10.3'
set :nvm_custom_path, '/usr/local/nvm'
set :npm_flags, '--silent --no-progress'
append :linked_dirs, "public/uploads", "node_modules"
before 'deploy:reverted', 'npm:install'

# Ruby config
set :rvm_ruby_version, "2.4.1"
set :bundle_path, "vendor/bundle"
append :linked_dirs, "vendor/cache", "vendor/bundle"

task :bundle_pack do
  on roles(:app) do
    execute "bundle pack --all"
  end
end
before 'bundler:install', 'bundle_pack'