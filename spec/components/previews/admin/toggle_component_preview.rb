# frozen_string_literal: true

class Admin::ToggleComponentPreview < ViewComponent::Preview
  # @label Default
  def default
    render Admin::ToggleComponent.new(
      name: "workflow[enabled]",
      title: "Workflow enabled"
    )
  end

  # @label Checked
  def checked
    render Admin::ToggleComponent.new(
      name: "workflow[enabled]",
      title: "Workflow enabled",
      checked: true
    )
  end

  # @label With hint
  def with_hint
    render Admin::ToggleComponent.new(
      name: "workflow[public]",
      title: "Visible to creators",
      hint: "Creators will be able to find this workflow."
    )
  end

  # @label Invalid
  def invalid
    render Admin::ToggleComponent.new(
      name: "workflow[enabled]",
      title: "Workflow enabled",
      errors: ["Workflow must be enabled before publishing"]
    )
  end

  # @label Disabled
  def disabled
    render Admin::ToggleComponent.new(
      name: "workflow[enabled]",
      title: "Workflow enabled",
      checked: true,
      disabled: true
    )
  end

  # @label Playground
  #
  # @param title text
  # @param checked toggle
  # @param disabled toggle
  # @param hint text
  # @param invalid toggle
  def playground(
    title: "Workflow enabled",
    checked: false,
    disabled: false,
    hint: "",
    invalid: false
  )
    render Admin::ToggleComponent.new(
      name: "workflow[enabled]",
      title: title,
      checked: checked,
      disabled: disabled,
      hint: hint.presence,
      errors: invalid ? ["This value is invalid"] : []
    )
  end
end
