# frozen_string_literal: true

source "https://rubygems.org"

gem "rails", "~> 8.1.3"
gem "propshaft"
gem "pg", "~> 1.1"
gem "puma", ">= 5.0"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "tzinfo-data", platforms: %i[windows jruby]
gem "bootsnap", require: false

gem "solid_cable"
gem "sidekiq", "8.0.10"
gem "strong_migrations", "~> 2.8.0"
gem "dotenv-rails", "~> 3.2.0"

gem "view_component", "~> 4.12"
gem "bootstrap-icons", "~> 1.0"
gem "cssbundling-rails"

gem "kamal", require: false
gem "thruster", require: false

group :production do
  gem "redis", ">= 4.0.1"
  gem "rack-timeout", "~> 0.7.0", require: "rack/timeout/base"
  gem "sentry-rails", "~> 6.6.2"
  gem "sentry-sidekiq", "~> 6.6.2"
  gem "datadog", "~> 2.37.0", require: "datadog/auto_instrument"
end

group :development, :test do
  gem "pry-byebug", "~> 3.12.0"
  gem "debug", platforms: %i[mri windows], require: "debug/prelude"

  gem "bundler-audit", require: false
  gem "rubocop", "~> 1.88.1", require: false
  gem "rubocop-performance", "~> 1.26.1", require: false
  gem "rubocop-rails", "~> 2.35.4", require: false
  gem "rubocop-rspec", "~> 3.10.2", require: false
  gem "rubocop-rspec_rails", "~> 2.32.0", require: false
  gem "brakeman", "~> 8.0.5", require: false
  gem "parallel_tests", "~> 5.7.0"
  gem "test-prof", "~> 1.6.1", require: false
end

group :development do
  gem "pry-rails", "~> 0.3.11"
  gem "pry-theme", "~> 1.3.1"
  gem "readline", "~> 0.0.4"
  gem "amazing_print", "~> 3.0.0"
  gem "web-console"
  gem "letter_opener_web", "~> 3.0"
  gem "ruby-lsp-rails", "~> 0.4.8", require: false
  gem "lookbook", ">= 2.3.2"
end

group :test do
  gem "capybara"
  gem "rspec-rails", "~> 8.0.4"
  gem "fuubar", "~> 2.5.1"
  gem "simplecov", "~> 0.22.0", require: false
end
