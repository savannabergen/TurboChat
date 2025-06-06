require_relative "boot"
require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_mailbox/engine"
require "action_text/engine"
require "action_view/railtie"
require "action_cable/engine"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module TurboChat
  class Application < Rails::Application
    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins %r{https://[a-zA-Z0-9-]+\.savannagrace\.dev}, 'http://localhost:3000'
        resource "*", headers: :any, methods: [:get, :post, :put, :patch, :delete, :options, :head], credentials: true, expose: ['Authorization']
      end
    end

    config.action_cable.allowed_request_origins = %r{https://[a-zA-Z0-9-]+\.savannagrace\.dev}, 'http://localhost:3000'
  end
end