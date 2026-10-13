# frozen_string_literal: true

# rack attack request interrupts request processing in early stages, so we need to log request manually
ActiveSupport::Notifications.subscribe("throttle.rack_attack") do |_name, start, finish, _instrumenter_id, payload|
  request = payload[:request]
  match_data = request.env["rack.attack.match_data"]

  match_discriminator = request.env["rack.attack.match_discriminator"]
  masked_match_discriminator = if match_discriminator.start_with?("bearer")
    "bearer #{match_discriminator.dup&.tap { |c| c[0..-7] = '****' }}"
  else
    match_discriminator
  end

  Rails.logger.info({
    method: request.request_method,
    path: request.path,
    status: 429,
    event: "rack_attack_throttle",
    rack_rate_limit: match_data[:limit],
    rack_rate_period: match_data[:period],
    match_type: request.env["rack.attack.match_type"],
    matched: request.env["rack.attack.matched"],
    match_discriminator: masked_match_discriminator,
    start:,
    finish:,
    http: {
      user_agent: request.env["HTTP_USER_AGENT"],
      url_details: {
        path: request.env["REQUEST_PATH"],
        params: request.params&.except("controller", "action", "format"),
      }
    },
    request: {
      id: request.env["action_dispatch.request_id"],
      hit_ingress: request.env["HTTP_X_HIT_INGRESS"],
      hit_rails: request.env["HTTP_X_HIT_RAILS"]&.as_json,
      body_wait: request.env["puma.request_body_wait"].try(:round, 3),
    },
    host: request.host,
    network: { client: { ip: request.ip } },
    user: {
      auth_token: request.env["HTTP_AUTHORIZATION"]&.dup&.tap { |c| c[0..-7] = "****" }
    },
    dd: {
      service: "nasa-missions-backend",
    },
    ddsource: "ruby"
  }.to_json)
end
