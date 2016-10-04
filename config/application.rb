require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

module OpenBudgets
  class Application < Rails::Application
  end
end
