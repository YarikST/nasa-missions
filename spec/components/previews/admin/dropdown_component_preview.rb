# frozen_string_literal: true

class Admin::DropdownComponentPreview < ViewComponent::Preview
  STATUSES = [
    ["Draft", "draft"],
    ["Active", "active"],
    ["Completed", "completed"]
  ].freeze

  # @label Default
  def default
    render Admin::DropdownComponent.new(
      name: "workflow[status]",
      title: "Status",
      placeholder: "Select status",
      options: STATUSES
    )
  end

  # @label Required
  def required
    render Admin::DropdownComponent.new(
      name: "workflow[status]",
      title: "Status",
      placeholder: "Select status",
      options: STATUSES,
      mandatory: true
    )
  end

  # @label With selected value
  def with_value
    render Admin::DropdownComponent.new(
      name: "workflow[status]",
      title: "Status",
      placeholder: "Select status",
      options: STATUSES,
      value: "active"
    )
  end

  # @label With hint
  def with_hint
    render Admin::DropdownComponent.new(
      name: "workflow[status]",
      title: "Status",
      placeholder: "Select status",
      options: STATUSES,
      hint: "Only active workflows are visible to creators."
    )
  end

  # @label Invalid
  def invalid
    render Admin::DropdownComponent.new(
      name: "workflow[status]",
      title: "Status",
      placeholder: "Select status",
      options: STATUSES,
      mandatory: true,
      errors: ["Status must be selected"]
    )
  end

  # @label Multiple errors
  def multiple_errors
    render Admin::DropdownComponent.new(
      name: "workflow[status]",
      title: "Status",
      options: STATUSES,
      errors: [
        "Status must be selected",
        "Status transition is not allowed"
      ]
    )
  end

  # @label Disabled
  def disabled
    render Admin::DropdownComponent.new(
      name: "workflow[status]",
      title: "Status",
      options: STATUSES,
      value: "completed",
      disabled: true
    )
  end

  # @label Playground
  #
  # @param title text
  # @param placeholder text
  # @param value select { choices: [None, draft, active, completed] }
  # @param hint text
  # @param mandatory toggle
  # @param disabled toggle
  # @param invalid toggle
  def playground(
    title: "Status",
    placeholder: "Select status",
    value: "None",
    hint: "",
    mandatory: false,
    disabled: false,
    invalid: false
  )
    render Admin::DropdownComponent.new(
      name: "workflow[status]",
      title: title,
      placeholder: placeholder.presence,
      options: STATUSES,
      value: value == "None" ? nil : value,
      hint: hint.presence,
      mandatory: mandatory,
      disabled: disabled,
      errors: invalid ? ["This value is invalid"] : []
    )
  end
end
