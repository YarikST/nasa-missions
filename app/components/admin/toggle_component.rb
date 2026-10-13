# frozen_string_literal: true

class Admin::ToggleComponent < Admin::BaseComponent
  def initialize(
    name:,
    title: nil,
    checked: false,
    value: "1",
    disabled: false,
    hint: nil,
    errors: [],
    data: {},
    html_attributes: {}
  )
    @name = name
    @title = title
    @checked = checked
    @value = value
    @disabled = disabled
    @hint = hint
    @errors = Array(errors).compact
    @data = data
    @html_attributes = html_attributes
  end

  attr_reader :name,
    :title,
    :value,
    :hint,
    :errors,
    :data,
    :html_attributes

  private

  def input_classes
    class_names(
      "form-check-input",
      "is-invalid": invalid?
    )
  end

  def checked?
    @checked
  end

  def disabled?
    @disabled
  end

  def invalid?
    errors.present?
  end

  def input_id
    name.to_s.parameterize(separator: "_")
  end
end
