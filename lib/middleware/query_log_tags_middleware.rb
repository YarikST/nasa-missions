# frozen_string_literal: true

module Middleware
  class QueryLogTagsMiddleware
    include Sidekiq::ServerMiddleware

    def call(worker, job, queue, &)
      ActiveSupport::ExecutionContext.set(
        sidekiq_job: job_name(worker, job),
        sidekiq_queue: queue, &
      )
    end

    private

    def job_name(worker, job)
      job["wrapped"].presence ||
        active_job_class_name(job).presence ||
        worker.class.name
    end

    def active_job_class_name(job)
      first_arg = job["args"]&.first
      return unless first_arg.is_a?(Hash)

      first_arg["job_class"]
    end
  end
end
