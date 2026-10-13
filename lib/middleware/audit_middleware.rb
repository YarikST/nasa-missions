# frozen_string_literal: true

module Middleware
  class AuditMiddleware
    include Sidekiq::ServerMiddleware

    def call(job_instance, _job_payload, _queue, &)
      Audited.audit_class.as_user(job_instance.class.name, &)
    end
  end
end
