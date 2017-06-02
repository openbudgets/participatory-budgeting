# Ask for branch to deploy if not already set
ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp unless ENV['BRANCH']

# Default deploy_to directory is /var/www/openbudgets/
set :deploy_to, "/var/www/openbudgets/alhama"

# The service to be restarted once the app has been deployed
set :service_name, "openbudgets.alhama"