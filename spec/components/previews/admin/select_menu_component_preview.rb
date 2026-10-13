# frozen_string_literal: true

class Admin::SelectMenuComponentPreview < ViewComponent::Preview
  SIMPLE_OPTIONS = [
    ["Draft", "draft"],
    ["Active", "active"],
    ["Completed", "completed"]
  ].freeze

  RICH_OPTIONS = [
    {
      label: "Private",
      value: "private",
      description: "Only NASA Missions administrators can access this workflow."
    },
    {
      label: "Invited creators",
      value: "invited",
      description: "Only invited creators can access this workflow."
    },
    {
      label: "Public",
      value: "public",
      description: "All eligible creators can discover this workflow."
    }
  ].freeze

  # @label Default
  def default
    render Admin::SelectMenuComponent.new(
      name: "workflow[status]",
      title: "Status",
      placeholder: "Select status",
      options: SIMPLE_OPTIONS
    )
  end

  # @label Required
  def required
    render Admin::SelectMenuComponent.new(
      name: "workflow[status]",
      title: "Status",
      placeholder: "Select status",
      options: SIMPLE_OPTIONS,
      mandatory: true
    )
  end

  # @label Selected
  def selected
    render Admin::SelectMenuComponent.new(
      name: "workflow[status]",
      title: "Status",
      options: SIMPLE_OPTIONS,
      value: "active"
    )
  end

  # @label Rich options
  def rich_options
    render Admin::SelectMenuComponent.new(
      name: "workflow[visibility]",
      title: "Visibility",
      placeholder: "Select visibility",
      options: RICH_OPTIONS,
      value: "invited"
    )
  end

  # @label With hint
  def with_hint
    render Admin::SelectMenuComponent.new(
      name: "workflow[visibility]",
      title: "Visibility",
      options: RICH_OPTIONS,
      hint: "Controls which creators can access the workflow."
    )
  end

  # @label Invalid
  def invalid
    render Admin::SelectMenuComponent.new(
      name: "workflow[status]",
      title: "Status",
      placeholder: "Select status",
      options: SIMPLE_OPTIONS,
      mandatory: true,
      errors: ["Status must be selected"]
    )
  end

  # @label Disabled
  def disabled
    render Admin::SelectMenuComponent.new(
      name: "workflow[status]",
      title: "Status",
      options: SIMPLE_OPTIONS,
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
    render Admin::SelectMenuComponent.new(
      name: "workflow[status]",
      title: title,
      placeholder: placeholder,
      options: SIMPLE_OPTIONS,
      value: value == "None" ? nil : value,
      hint: hint.presence,
      mandatory: mandatory,
      disabled: disabled,
      errors: invalid ? ["This value is invalid"] : []
    )
  end
end
