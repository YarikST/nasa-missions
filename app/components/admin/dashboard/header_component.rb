# frozen_string_literal: true

class Admin::Dashboard::HeaderComponent < Admin::BaseComponent
  def initialize(title:, current_staff:, logout_path:)
    @title = title
    @current_staff = current_staff
    @logout_path = logout_path
  end

  private

  attr_reader :title, :current_staff, :logout_path
end
