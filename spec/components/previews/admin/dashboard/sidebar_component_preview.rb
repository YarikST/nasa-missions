# frozen_string_literal: true

class Admin::Dashboard::SidebarComponentPreview < ViewComponent::Preview
  # @label Default
  def default
    render Admin::Dashboard::SidebarComponent.new
  end
end
