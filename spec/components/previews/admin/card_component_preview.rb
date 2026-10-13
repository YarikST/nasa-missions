# frozen_string_literal: true

class Admin::CardComponentPreview < ViewComponent::Preview
  # @label Default
  def default
    render Admin::CardComponent.new(
      title: "Campaign summary",
      description: "Review the campaign before publishing.",
      html_attributes: { style: "max-width: 32rem;" }
    ) do
      "Card content"
    end
  end

  # @label With slots
  def with_slots
    render_with_template(
      template: "admin/card_component_preview/with_slots"
    )
  end
end
