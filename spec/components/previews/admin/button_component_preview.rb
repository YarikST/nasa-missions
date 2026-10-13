# frozen_string_literal: true

class Admin::ButtonComponentPreview < ViewComponent::Preview
  # @label Primary
  def default
    render Admin::ButtonComponent.new do
      "Primary button"
    end
  end

  # @label Secondary
  def secondary
    render Admin::ButtonComponent.new(
      variant: :secondary
    ) do
      "Secondary button"
    end
  end

  # @label Cancel
  def cancel
    render Admin::ButtonComponent.new(
      variant: :outline_secondary
    ) do
      "Cancel"
    end
  end

  # @label Submit
  def submit
    render Admin::ButtonComponent.new(
      type: :submit,
      icon: "check-lg"
    ) do
      "Save"
    end
  end

  # @label GET request
  def get_request # rubocop:disable Naming/AccessorMethodName
    render Admin::ButtonComponent.new(
      path: "#",
      icon: "arrow-right",
      icon_position: :end
    ) do
      "View workflow"
    end
  end

  # @label POST request
  def post_request
    render Admin::ButtonComponent.new(
      path: "#",
      method: :post,
      icon: "send"
    ) do
      "Publish"
    end
  end

  # @label PATCH request
  def patch_request
    render Admin::ButtonComponent.new(
      path: "#",
      method: :patch,
      variant: :secondary,
      icon: "archive"
    ) do
      "Archive"
    end
  end

  # @label DELETE request
  def delete_request
    render Admin::ButtonComponent.new(
      path: "#",
      method: :delete,
      variant: :danger,
      icon: "trash",
      confirm: "Delete this workflow?"
    ) do
      "Delete"
    end
  end

  # @label With icon
  def with_icon
    render Admin::ButtonComponent.new(
      icon: "plus-lg"
    ) do
      "Add workflow"
    end
  end

  # @label Icon on right
  def icon_on_right
    render Admin::ButtonComponent.new(
      icon: "arrow-right",
      icon_position: :end
    ) do
      "Continue"
    end
  end

  # @label Icon only
  def icon_only
    render Admin::ButtonComponent.new(
      variant: :outline_secondary,
      icon: "pencil",
      html_attributes: {
        aria: {
          label: "Edit workflow"
        }
      }
    )
  end

  # @label Disabled
  def disabled
    render Admin::ButtonComponent.new(
      disabled: true
    ) do
      "Unavailable"
    end
  end

  # @label Playground
  #
  # @param label text
  # @param variant select { choices: [primary, secondary, outline_secondary, danger, outline_danger, link] }
  # @param size select { choices: [Default, sm, lg] }
  # @param icon text
  # @param icon_position select { choices: [start, end] }
  # @param disabled toggle
  def playground(
    label: "Button",
    variant: "primary",
    size: "Default",
    icon: "",
    icon_position: "start",
    disabled: false
  )
    render Admin::ButtonComponent.new(
      variant: variant,
      size: size == "Default" ? nil : size,
      icon: icon.presence,
      icon_position: icon_position,
      disabled: disabled
    ) do
      label
    end
  end
end
