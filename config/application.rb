require_relative 'boot'
require 'rails/all'
Bundler.require(*Rails.groups)

module AmazingTalker
  class Application < Rails::Application
    config.load_defaults 5.2

    config.autoload_paths += Dir[Rails.root.join('app', '*')]

  end
end
