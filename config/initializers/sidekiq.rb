# frozen_string_literal: true

require "sidekiq-unique-jobs"
require "sidekiq/job_logger"
require "sidekiq/throttled"

Sidekiq.transactional_push!

SIDEKIQ_WILL_PROCESSES_JOBS_FILE = Rails.root
  .join("tmp/sidekiq_process_has_started_and_will_begin_processing_jobs").freeze

Sidekiq.default_job_options = {
  backtrace: true,
  retry: true
}

Sidekiq.configure_client do |config|
  config.redis = { url: ENV.fetch("SIDEKIQ_REDIS_URL", nil), driver: :ruby }

  config.client_middleware do |chain|
    chain.add SidekiqUniqueJobs::Middleware::Client
  end

  config.logger = Rails.logger if Rails.env.test?
end

Sidekiq.configure_server do |config|
  config.error_handlers.presence&.[]=(0, proc {})
  config[:skip_default_job_logging] = true
  config.logger.formatter = Sidekiq::Logger::Formatters::JSON.new

  config.redis = { url: ENV.fetch("SIDEKIQ_REDIS_URL", nil), driver: :ruby }

  config.server_middleware do |chain|
    chain.add SidekiqUniqueJobs::Middleware::Server
    chain.add Middleware::QueryLogTagsMiddleware
    chain.add Middleware::CustomLogsMiddleware
    chain.add Middleware::AuditMiddleware
  end

  config.client_middleware do |chain|
    chain.add SidekiqUniqueJobs::Middleware::Client
  end

  config.on(:startup) do
    FileUtils.touch(SIDEKIQ_WILL_PROCESSES_JOBS_FILE)
  end

  config.on(:shutdown) do
    FileUtils.rm_f(SIDEKIQ_WILL_PROCESSES_JOBS_FILE)
  end

  SidekiqUniqueJobs::Server.configure(config)
end

SidekiqUniqueJobs.configure do |config|
  # according to https://github.com/mhenrixon/sidekiq-unique-jobs/?tab=readme-ov-file#testing
  config.enabled = !Rails.env.test?
  config.lock_ttl = 1.hour.seconds.to_i # Expire locks after 1 hour
end

Sidekiq::Throttled.configure do |config|
  # Period in seconds to exclude queue from polling in case it returned
  # {config.cooldown_threshold} amount of throttled jobs in a row. Set
  # this value to `nil` to disable cooldown manager completely.
  # Default: 1.0
  config.cooldown_period = 1.0

  # Exclude queue from polling after it returned given amount of throttled
  # jobs in a row.
  # Default: 100 (cooldown after hundredth throttled job in a row)
  config.cooldown_threshold = 100
end
