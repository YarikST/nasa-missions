# frozen_string_literal: true

class Admin::CardComponentPreview < ViewComponent::Preview
  def default
    render Admin::CardComponent.new(title: "Mission details", description: "Enter the spacecraft mass.") do
      "Card content"
    end
  end
end
