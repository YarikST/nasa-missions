# frozen_string_literal: true

class Admin::InputComponentPreview < ViewComponent::Preview
  # @label Default
  def default
    render Admin::InputComponent.new(
      name: "workflow[title]",
      title: "Workflow title",
      placeholder: "Enter workflow title"
    )
  end

  # @label Required
  def required
    render Admin::InputComponent.new(
      name: "staff[email]",
      title: "Email",
      type: :email,
      placeholder: "name@example.com",
      mandatory: true,
      autocomplete: "email"
    )
  end

  # @label With value
  def with_value
    render Admin::InputComponent.new(
      name: "workflow[title]",
      title: "Workflow title",
      value: "Summer TikTok campaign"
    )
  end

  # @label With hint
  def with_hint
    render Admin::InputComponent.new(
      name: "workflow[title]",
      title: "Workflow title",
      hint: "This title will be visible to creators."
    )
  end

  # @label Invalid
  def invalid
    render Admin::InputComponent.new(
      name: "staff[email]",
      title: "Email",
      type: :email,
      value: "invalid-email",
      mandatory: true,
      errors: ["Email is invalid"]
    )
  end

  # @label Multiple errors
  def multiple_errors
    render Admin::InputComponent.new(
      name: "staff[password]",
      title: "Password",
      type: :password,
      mandatory: true,
      errors: [
        "Password is too short",
        "Password must contain at least one number"
      ]
    )
  end

  # @label Disabled
  def disabled
    render Admin::InputComponent.new(
      name: "workflow[status]",
      title: "Status",
      value: "Approved",
      disabled: true
    )
  end

  # @label Password
  def password
    render Admin::InputComponent.new(
      name: "staff[password]",
      title: "Password",
      type: :password,
      mandatory: true,
      autocomplete: "current-password"
    )
  end

  # @label Number
  def number
    render Admin::InputComponent.new(
      name: "workflow[budget]",
      title: "Budget",
      type: :number,
      placeholder: "0",
      html_attributes: {
        min: 0,
        step: 100
      }
    )
  end

  # @label Playground
  #
  # @param title text
  # @param value text
  # @param placeholder text
  # @param type select { choices: [text, email, password, number, url] }
  # @param mandatory toggle
  # @param disabled toggle
  # @param hint text
  # @param invalid toggle
  def playground(
    title: "Workflow title",
    value: "",
    placeholder: "Enter workflow title",
    type: "text",
    mandatory: false,
    disabled: false,
    hint: "",
    invalid: false
  )
    render Admin::InputComponent.new(
      name: "workflow[title]",
      title: title,
      value: value,
      placeholder: placeholder,
      type: type,
      mandatory: mandatory,
      disabled: disabled,
      hint: hint.presence,
      errors: invalid ? ["This field is invalid"] : []
    )
  end
end
