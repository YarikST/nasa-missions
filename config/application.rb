# frozen_string_literal: true

require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module NasaMissions
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 8.1

    # Please, add to the `ignore` list any other `lib` subdirectories that do
    # not contain `.rb` files, or that should not be reloaded or eager loaded.
    # Common ones are `templates`, `generators`, or `middleware`, for example.
    config.autoload_lib(ignore: %w[assets tasks])

    # autoload lib/middleware for sidekiq server middleware
    Rails.root.glob("lib/middleware/*.rb").each { |file| require file }

    # ignore custom cops for rubocop
    Rails.autoloaders.main.ignore(Rails.root.join("lib/rubocop"))

    config.time_zone = "UTC"
    config.active_record.default_timezone = :utc

    # Use sidekiq for ActiveJob
    config.active_job.queue_adapter = :sidekiq
    config.active_storage.queues.purge = :low_priority
    config.active_storage.variant_processor = :disabled

    config.generators do |g|
      g.test_framework :rspec, fixture: false, model_specs: false
      g.helper false
      g.assets false
      g.orm :active_record
    end

    config.i18n.default_locale = :en

    # Index nested errors in the order of params assigned to the model, not the database order
    ActiveRecord.index_nested_attribute_errors = :nested_attributes_order

    config.view_component.previews.paths << Rails.root.join("spec/components/previews")
    config.view_component.previews.default_layout = "component_preview"

    config.view_component.generate.preview = true
    config.view_component.generate.preview_path = "spec/components/previews"
  end
end
