# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: "NASA Missions <no-reply@example.com>"

  layout "mailer"
end
