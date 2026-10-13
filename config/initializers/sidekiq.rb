# frozen_string_literal: true

require "sidekiq/job_logger"

Sidekiq.transactional_push!

SIDEKIQ_WILL_PROCESSES_JOBS_FILE = Rails.root
  .join("tmp/sidekiq_process_has_started_and_will_begin_processing_jobs").freeze

Sidekiq.default_job_options = {
  backtrace: true,
  retry: true
}

Sidekiq.configure_client do |config|
  config.redis = { url: ENV.fetch("SIDEKIQ_REDIS_URL", nil), driver: :ruby }

  config.logger = Rails.logger if Rails.env.test?
end

Sidekiq.configure_server do |config|
  config.error_handlers.presence&.[]=(0, proc {})
  config[:skip_default_job_logging] = true
  config.logger.formatter = Sidekiq::Logger::Formatters::JSON.new

  config.redis = { url: ENV.fetch("SIDEKIQ_REDIS_URL", nil), driver: :ruby }

  config.server_middleware do |chain|
    chain.add Middleware::QueryLogTagsMiddleware
    chain.add Middleware::CustomLogsMiddleware
  end

  config.on(:startup) do
    FileUtils.touch(SIDEKIQ_WILL_PROCESSES_JOBS_FILE)
  end

  config.on(:shutdown) do
    FileUtils.rm_f(SIDEKIQ_WILL_PROCESSES_JOBS_FILE)
  end
end
