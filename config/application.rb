require_relative 'boot'
require 'rails/all'

Bundler.require(*Rails.groups)

module ChatSystemApi
  class Application < Rails::Application
    config.session_store :cookie_store, key: '_interslice_session'
    config.middleware.use ActionDispatch::Cookies
    config.middleware.use config.session_store, config.session_options
    config.load_defaults 7.0
    config.active_job.queue_adapter = :sidekiq
    config.api_only = true
  end
end
