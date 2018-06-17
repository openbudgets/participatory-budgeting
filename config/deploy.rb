# Config valid only for current version of Capistrano
lock "3.11.0"

set :application, "openbudgets"
set :repo_url, "git@github.com:openbudgets/participatory-budgeting.git"

# Default branch is :master
set :branch, ENV['BRANCH'] if ENV['BRANCH']

# Default value for linked_dirs is []
append :linked_dirs, "public/uploads", "log", "tmp/pids", "tmp/cache", "tmp/sockets"

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
set :nvm_node, 'v8.12.0'
set :nvm_custom_path, '/usr/local/nvm'
set :npm_flags, '--silent --no-progress'
append :linked_dirs, "node_modules"
before 'deploy:reverted', 'npm:install'

# Ruby config
set :rvm_ruby_version, "2.5.1"
set :bundle_path, "vendor/bundle"
append :linked_dirs, "vendor/cache", "vendor/bundle"

task :bundle_pack do
  on roles(:app) do
    within release_path do
      execute :bundle, :package, "--all", "--path #{fetch(:bundle_path)}", "--quiet"
    end
  end
end
before 'bundler:install', 'bundle_pack'

# Restarts the application server
task :application_restart do
  on roles(:app) do
    execute "passenger-config", "restart-app", fetch(:app_path, :deploy_to)
  end
end
before 'deploy:finished', 'application_restart'
