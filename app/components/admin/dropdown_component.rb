# frozen_string_literal: true

class Admin::DropdownComponent < Admin::BaseComponent
  def initialize(
    name:,
    options:,
    title: nil,
    value: nil,
    mandatory: false,
    placeholder: nil,
    errors: [],
    disabled: false,
    hint: nil,
    data: {},
    html_attributes: {}
  )
    @name = name
    @options = options
    @title = title
    @value = value
    @mandatory = mandatory
    @placeholder = placeholder
    @errors = Array(errors).compact
    @disabled = disabled
    @hint = hint
    @data = data
    @html_attributes = html_attributes
  end

  attr_reader :name,
    :options,
    :title,
    :value,
    :placeholder,
    :errors,
    :hint,
    :data,
    :html_attributes

  private

  def select_classes
    class_names(
      "form-select",
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
