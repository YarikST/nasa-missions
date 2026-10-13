# frozen_string_literal: true

class Admin::FlashComponent < ViewComponent::Base
  def initialize(notice: nil, alert: nil)
    @notice = notice
    @alert = alert
  end

  attr_reader :notice, :alert

  def render?
    message.present?
  end

  private

  def message
    alert.presence || notice
  end

  def alert_class
    alert.present? ? "alert-danger" : "alert-success"
  end

  def icon_class
    alert.present? ? "bi-exclamation-circle" : "bi-check-circle"
  end
end
