# frozen_string_literal: true

class Admin::ButtonComponentPreview < ViewComponent::Preview
  def default
    render Admin::ButtonComponent.new(icon: "plus-lg") do
      "New mission"
    end
  end

  def delete
    render Admin::ButtonComponent.new(path: "#", method: :delete, variant: :outline_danger) do
      "Delete"
    end
  end
end
