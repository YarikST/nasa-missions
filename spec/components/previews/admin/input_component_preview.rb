# frozen_string_literal: true

class Admin::InputComponentPreview < ViewComponent::Preview
  def default
    render Admin::InputComponent.new(name: "mission[name]", title: "Mission name", placeholder: "e.g. Apollo 11")
  end
end
