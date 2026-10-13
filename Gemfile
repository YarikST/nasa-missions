# frozen_string_literal: true

source "https://rubygems.org"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 8.1.3"
# The modern asset pipeline for Rails [https://github.com/rails/propshaft]
gem "propshaft"
# Use postgresql as the database for Active Record
gem "pg", "~> 1.1"
# Use the Puma web server [https://github.com/puma/puma]
gem "puma", ">= 5.0"
# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem "importmap-rails"
# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem "turbo-rails"
# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem "stimulus-rails"
# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem "jbuilder"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[windows jruby]

# Use the database-backed adapters for Rails.cache, Active Job, and Action Cable
gem "solid_cache"
gem "solid_queue"
gem "solid_cable"

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Deploy this application anywhere as a Docker container [https://kamal-deploy.org]
gem "kamal", require: false

# paginate any collection
gem "pagy", "~> 43.5.6"

# Add HTTP asset caching/compression and X-Sendfile acceleration to Puma [https://github.com/basecamp/thruster/]
gem "thruster", require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
gem "image_processing", "~> 1.2"

# active storage convenient validations
gem "active_storage_validations", "~> 3.0.5"

# better console
gem "pry-rails", "~> 0.3.11"
gem "pry-theme", "~> 1.3.1"

# Readline was removed as gem in Ruby 4.0.0, pry needs it to be loaded to work correctly currently
# https://github.com/deivid-rodriguez/pry-byebug/issues/460
gem "readline", "~> 0.0.4"

# nice printing
gem "amazing_print", "~> 2.0.0"

# catch unsafe migrations in development
gem "strong_migrations", "~> 2.8.0"

# make http requests with faraday
gem "faraday", "~> 2.14.3"
gem "faraday-follow_redirects", "~> 0.3"
gem "faraday-http-cache", "~> 2.7.0"
gem "faraday-typhoeus", "~> 2.0.0"

# Image Uploaders
gem "shrine", "~> 3.7.1"

# FTP client
gem "net-ftp", "~> 0.3.9"

# Detect content type
gem "marcel", "~> 1.0"
gem "mime-types", "~> 3.6"

# generate sitemap for search services
gem "sitemap_generator", "~> 7.0.1"

# memoize methods
gem "memo_wise", "~> 1.13.0"
gem "mustermann-contrib", "~> 3.0"

# store data globally per request
gem "request_store", "~> 1.7.0"

# Simple, efficient background processing for Ruby
gem "sidekiq", "8.0.10"

# scheduler / Cron for Sidekiq jobs
gem "sidekiq-cron", "~> 2.4.0"

# prevents duplicate Sidekiq jobs
gem "sidekiq-unique-jobs", "~> 8.1.0"

# Concurrency and threshold throttling for Sidekiq.
gem "sidekiq-throttled", "~> 2.1.0"

# simple, fast, and declarative serialization library
gem "blueprinter", "~> 1.2.1"

# rack middleware for handling Cross-Origin Resource Sharing (CORS), which makes cross-origin AJAX possible.
gem "rack-cors", "3.0.0"

# i18n support for rails
gem "rails-i18n", "~> 8.1.0"

# OAuth 2.0 library for authorization
gem "oauth2", "2.0.24"

# soft deletes for ActiveRecord
gem "discard", "~> 2.0.0"

# track changes to your rails models
gem "audited", "~> 5.8.0"

# a library for bulk insertion of data into your database using ActiveRecord.
gem "activerecord-import", "~> 2.2.0"

# enumerated attributes with I18n and ActiveRecord/Mongoid support
gem "enumerize", "~> 2.8.1"

# minimal authorization through OO design and pure Ruby classes
gem "pundit", "~> 2.5.0"

# role management library with resource scoping
gem "rolify", "~> 6.0.1"

# organise ActiveRecord model into a tree structure
gem "ancestry", "~> 5.1.0"

# DSL for building class initializer with params and options
gem "dry-initializer", "~> 3.2.0"

# rails plugin to dry-initializer gem
gem "dry-initializer-rails", "~> 3.1.1"

# validation library with type-safe schemas and rules
gem "dry-validation", "~> 1.11.1"

# DSL for defining typed struct classes
gem "dry-struct", "~> 1.8.0"

# build slugs for ActiveRecord models
gem "friendly_id", "~> 5.7.0"

# SDK for google auth
gem "googleauth", "~> 1.17.1"

# Ruby extension to parse, deparse and normalize SQL queries using the PostgreSQL query parser
gem "pg_query", "~> 6.2.2"

# generic connection pooling for Ruby
gem "connection_pool", "~> 2.5.5"

# Counter caches for Rails
gem "counter_culture", "~> 3.12.2"

# retriable is an simple DSL to retry failed code blocks with randomized exponential backoff.
gem "retriable", "~> 4.2.0"

# Respond in user's preferred language
gem "http_accept_language", "~> 2.1.1"

# throttling abusive requests
gem "rack-attack", "~> 6.8.0"

# next generation CRuby profiler
gem "vernier", "~> 1.10.0"

# load environment variables from `.env`.
gem "dotenv-rails", "~> 3.2.0"

# OTP solution
gem "rotp", "~> 6.3"

# use AWS S3 for ActiveStorage
gem "aws-sdk-s3", "~> 1.226.0", require: false

# UI components
gem "view_component", "~> 4.12"
gem "bootstrap-icons", "~> 1.0"
gem "bootstrap-email"

# CSS/JS bundling
gem "cssbundling-rails"
gem "jsbundling-rails"

group :production do
  # timeout long-running requests
  gem "rack-timeout", "~> 0.7.0", require: "rack/timeout/base"

  # exception tracking
  gem "sentry-ruby", "~> 6.6.2"
  gem "sentry-rails", "~> 6.6.2"
  gem "sentry-sidekiq", "~> 6.6.2"

  # datadog as apm and loggingg service
  gem "datadog", "~> 2.37.0", require: "datadog/auto_instrument"

  # custom metric client for datadog
  gem "dogstatsd-ruby", "~> 5.7"

  # lograge for JSON logging
  gem "lograge", "~> 0.14.0"
  gem "lograge-sql", "~> 2.6.1"
end

group :development, :test do
  # debugging
  gem "pry-byebug", "~> 3.12.0"

  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[mri windows], require: "debug/prelude"

  # Audits gems for known security defects (use config/bundler-audit.yml to ignore issues)
  gem "bundler-audit", require: false

  # check code style
  gem "rubocop", "~> 1.88.1", require: false
  gem "rubocop-performance", "~> 1.26.1", require: false
  gem "rubocop-rails", "~> 2.35.4", require: false
  gem "rubocop-rspec", "~> 3.10.2", require: false
  gem "rubocop-rspec_rails", "~> 2.32.0", require: false
  gem "rubocop-factory_bot", "~> 2.28.0", require: false
  gem "rubocop-slim", "~> 0.3.1", require: false

  # detect non-atomic interactions within DB transactions
  gem "isolator", "~> 1.2.0", require: false

  # A static analysis security vulnerability scanner for Ruby on Rails applications
  gem "brakeman", "~> 8.0.5", require: false

  # parallel tests
  gem "parallel_tests", "~> 5.7.0"

  # UI Kit
  gem "lookbook", ">= 2.3.2"
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem "web-console"

  # preview mail in the browser instead of sending.
  gem "letter_opener", "~> 1.10.0"

  gem "letter_opener_web", "~> 3.0"

  # A Ruby LSP add-on for Rails
  gem "ruby-lsp-rails", "~> 0.4.8", require: false
end

group :test do
  # DOM assertions for ViewComponent specs
  gem "capybara"

  # test framework
  gem "rspec-rails", "~> 8.0.4"

  # nice rspec output
  gem "fuubar", "~> 2.5.1"

  # create real-looking fake data
  gem "faker", "~> 3.8.0"

  # adds factories for rspec
  gem "factory_bot_rails", "~> 6.5.1"

  # generate coverage reports after each spec run
  gem "simplecov", "~> 0.22.0", require: false

  # pofile rspec tests
  gem "test-prof", "~> 1.6.1"

  # library for stubbing and setting expectations on HTTP requests in Ruby.
  gem "webmock", "~> 3.27.0"

  # record your test suite's HTTP interactions and replay them
  gem "vcr", "~> 6.4.0"

  # test helpers and cleaning for sidekiq jobs
  gem "rspec-sidekiq", "~> 5.3.0"

  # A more helpful way to view differences between complex data structures in RSpec.
  gem "super_diff", "~> 0.19.0"

  # RSpec compatible one-liners
  gem "shoulda-matchers", "~> 8.0.1"

  # Modify your ENV variables in specs for the duration of a block
  gem "climate_control", "~> 1.2.0"

  # Ruby implementation of the ICU (International Components for Unicode) that uses the Common Locale Data Repository to
  # sort strings, format dates, plurals, and more.
  gem "twitter_cldr", "~> 6.14.0"

  # retry randomly failing rspec examples again
  gem "rspec-rebound", "~> 0.2.1"
end
