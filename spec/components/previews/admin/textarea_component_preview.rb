# frozen_string_literal: true

class Admin::TextareaComponentPreview < ViewComponent::Preview
  # @label Default
  def default
    render Admin::TextareaComponent.new(
      name: "workflow[description]",
      title: "Description",
      placeholder: "Describe the workflow"
    )
  end

  # @label Required
  def required
    render Admin::TextareaComponent.new(
      name: "workflow[description]",
      title: "Description",
      placeholder: "Describe the workflow",
      mandatory: true
    )
  end

  # @label With value
  def with_value
    render Admin::TextareaComponent.new(
      name: "workflow[description]",
      title: "Description",
      value: "Create a short TikTok video introducing the new product."
    )
  end

  # @label With hint
  def with_hint
    render Admin::TextareaComponent.new(
      name: "workflow[description]",
      title: "Description",
      hint: "This description will be visible to creators."
    )
  end

  # @label Custom limit
  def custom_limit
    render Admin::TextareaComponent.new(
      name: "review[comment]",
      title: "Comment",
      value: "The video looks good, but the product should appear earlier.",
      maxlength: 500,
      rows: 3
    )
  end

  # @label Invalid
  def invalid
    render Admin::TextareaComponent.new(
      name: "workflow[description]",
      title: "Description",
      value: "Too short",
      mandatory: true,
      errors: ["Description is too short"]
    )
  end

  # @label Multiple errors
  def multiple_errors
    render Admin::TextareaComponent.new(
      name: "workflow[description]",
      title: "Description",
      mandatory: true,
      errors: [
        "Description cannot be blank",
        "Description must contain at least 20 characters"
      ]
    )
  end

  # @label Disabled
  def disabled
    render Admin::TextareaComponent.new(
      name: "workflow[description]",
      title: "Description",
      value: "This workflow has already been approved.",
      disabled: true
    )
  end

  # @label Playground
  #
  # @param title text
  # @param value textarea
  # @param placeholder text
  # @param hint text
  # @param maxlength number
  # @param rows number
  # @param mandatory toggle
  # @param disabled toggle
  # @param invalid toggle
  def playground(
    title: "Description",
    value: "",
    placeholder: "Describe the workflow",
    hint: "",
    maxlength: 2500,
    rows: 4,
    mandatory: false,
    disabled: false,
    invalid: false
  )
    render Admin::TextareaComponent.new(
      name: "workflow[description]",
      title: title,
      value: value,
      placeholder: placeholder,
      hint: hint.presence,
      maxlength: maxlength,
      rows: rows,
      mandatory: mandatory,
      disabled: disabled,
      errors: invalid ? ["This value is invalid"] : []
    )
  end
end
