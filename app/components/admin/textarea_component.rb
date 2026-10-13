# frozen_string_literal: true

class Admin::TextareaComponent < Admin::BaseComponent
  def initialize(
    name:,
    title: nil,
    value: nil,
    mandatory: false,
    placeholder: nil,
    errors: [],
    disabled: false,
    hint: nil,
    data: {},
    maxlength: 2500,
    autocomplete: "off",
    rows: 4,
    html_attributes: {}
  )
    @name = name
    @title = title
    @value = value
    @mandatory = mandatory
    @placeholder = placeholder
    @errors = Array(errors).compact
    @disabled = disabled
    @hint = hint
    @data = data
    @maxlength = maxlength
    @autocomplete = autocomplete
    @rows = rows
    @html_attributes = html_attributes
  end

  attr_reader :name,
    :title,
    :value,
    :placeholder,
    :errors,
    :hint,
    :data,
    :maxlength,
    :autocomplete,
    :rows,
    :html_attributes

  private

  def input_classes
    class_names(
      "form-control",
      "is-invalid": invalid?
    )
  end

  def input_data
    data.merge(
      textarea_counter_target: "source",
      action: [
        "input->textarea-counter#count",
        data[:action]
      ].compact.join(" ")
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

  def current_length
    value.to_s.length
  end
end
