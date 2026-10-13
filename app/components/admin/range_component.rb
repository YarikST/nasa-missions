# frozen_string_literal: true

class Admin::RangeComponent < Admin::BaseComponent
  def initialize(
    name:,
    title: nil,
    value: nil,
    mandatory: false,
    errors: [],
    step: 1,
    min: 1,
    max: 100,
    disabled: false,
    data: {},
    html_attributes: {}
  )
    @name = name
    @title = title
    @value = value
    @mandatory = mandatory
    @errors = Array(errors).compact
    @step = step
    @min = min
    @max = max
    @disabled = disabled
    @data = data
    @html_attributes = html_attributes
  end

  attr_reader :name,
    :title,
    :value,
    :errors,
    :step,
    :min,
    :max,
    :data,
    :html_attributes

  private

  def input_classes
    class_names(
      "form-range",
      "is-invalid": invalid?
    )
  end

  def invalid?
    errors.present?
  end

  def optional?
    !@mandatory
  end

  def disabled?
    @disabled
  end

  def input_id
    name.to_s.parameterize(separator: "_")
  end
end
