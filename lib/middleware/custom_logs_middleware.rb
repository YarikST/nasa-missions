# frozen_string_literal: true

module Middleware
  class CustomLogsMiddleware
    include Sidekiq::ServerMiddleware

    def call(_job_instance, job_payload, queue)
      start = ::Process.clock_gettime(::Process::CLOCK_MONOTONIC)

      default_data = {
        queue: queue,
        args: args(job_payload),
        created_at: Time.at(job_payload["created_at"] / 1000.0).utc,
        enqueued_at: Time.at(job_payload["enqueued_at"] / 1000.0).utc
      }

      yield
      Sidekiq::Context.add(:elapsed, elapsed(start))
      logger.info({ msg: "Done" }.merge(default_data))
    rescue StandardError => e
      Sidekiq::Context.add(:elapsed, elapsed(start))
      logger.error(
        {
          msg: "Fail",
          exception_message: e.message,
          backtrace: e.backtrace&.take(7)
        }.merge(default_data)
      )

      raise e
    end

    private

    def elapsed(start)
      (::Process.clock_gettime(::Process::CLOCK_MONOTONIC) - start).round(3)
    end

    def args(job_payload)
      params = job_payload["class"].constantize.new.method(:perform).parameters
      args = job_payload["args"]

      ActiveSupport::ParameterFilter
        .new(Rails.application.config.filter_parameters)
        .filter(params.map(&:last).zip(args).to_h)
    end
  end
end
