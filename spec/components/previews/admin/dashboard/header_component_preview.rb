# frozen_string_literal: true

class Admin::Dashboard::HeaderComponentPreview < ViewComponent::Preview
  # @label Default
  def default
    render Admin::Dashboard::HeaderComponent.new(
      title: "Dashboard",
      current_staff: Struct.new(:name).new("Jane Doe"),
      logout_path: "#"
    )
  end
end
