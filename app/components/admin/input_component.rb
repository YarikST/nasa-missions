# frozen_string_literal: true

class Admin::InputComponent < Admin::BaseComponent
  def initialize(
    name:,
    title: nil,
    value: nil,
    type: :text,
    mandatory: false,
    placeholder: nil,
    errors: [],
    disabled: false,
    hint: nil,
    data: {},
    maxlength: 2500,
    autocomplete: "off",
    html_attributes: {}
  )
    @name = name
    @title = title
    @value = value
    @type = type
    @mandatory = mandatory
    @placeholder = placeholder
    @errors = Array(errors).compact
    @disabled = disabled
    @hint = hint
    @data = data
    @maxlength = maxlength
    @autocomplete = autocomplete
    @html_attributes = html_attributes
  end

  attr_reader :name,
    :title,
    :value,
    :type,
    :placeholder,
    :errors,
    :hint,
    :data,
    :maxlength,
    :autocomplete,
    :html_attributes

  private

  def input_classes
    class_names(
      "form-control",
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
    html_attributes[:id].presence || name.to_s.parameterize(separator: "_")
  end
end
