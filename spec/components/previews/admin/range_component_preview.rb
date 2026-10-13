# frozen_string_literal: true

class Admin::RangeComponentPreview < ViewComponent::Preview
  # @label Default
  def default
    render Admin::RangeComponent.new(
      name: "workflow[priority]",
      title: "Priority",
      value: 50
    )
  end

  # @label Required
  def required
    render Admin::RangeComponent.new(
      name: "workflow[priority]",
      title: "Priority",
      value: 50,
      mandatory: true
    )
  end

  # @label Custom range
  def custom_range
    render Admin::RangeComponent.new(
      name: "workflow[rating]",
      title: "Minimum creator rating",
      value: 4,
      min: 1,
      max: 5,
      step: 0.5
    )
  end

  # @label Invalid
  def invalid
    render Admin::RangeComponent.new(
      name: "workflow[priority]",
      title: "Priority",
      value: 100,
      mandatory: true,
      errors: ["Priority is outside the allowed range"]
    )
  end

  # @label Disabled
  def disabled
    render Admin::RangeComponent.new(
      name: "workflow[priority]",
      title: "Priority",
      value: 50,
      disabled: true
    )
  end

  # @label Playground
  #
  # @param title text
  # @param value range { min: 1, max: 100, step: 1 }
  # @param mandatory toggle
  # @param disabled toggle
  # @param invalid toggle
  def playground(
    title: "Priority",
    value: 50,
    mandatory: false,
    disabled: false,
    invalid: false
  )
    render Admin::RangeComponent.new(
      name: "workflow[priority]",
      title: title,
      value: value,
      mandatory: mandatory,
      disabled: disabled,
      errors: invalid ? ["This value is invalid"] : []
    )
  end
end
