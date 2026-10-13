# frozen_string_literal: true

class Admin::SelectMenuComponent < Admin::BaseComponent
  def initialize(
    name:,
    options:,
    title: nil,
    value: nil,
    mandatory: false,
    placeholder: "Select an option",
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

  def trigger_classes
    class_names(
      "form-select",
      "text-start",
      html_attributes[:class],
      "is-invalid": invalid?
    )
  end

  def trigger_html_attributes
    html_attributes.except(
      :id,
      :class,
      :type,
      :data,
      :disabled
    )
  end

  def option_classes(option)
    class_names(
      "dropdown-item",
      "rounded-2",
      "d-flex",
      "align-items-center",
      "gap-3",
      "py-2",
      "select-menu-option-selected": selected?(option)
    )
  end

  def selected_option
    options.find { |option| selected?(option) }
  end

  def selected_label
    return placeholder unless selected_option

    option_label(selected_option)
  end

  def selected?(option)
    return false if value.nil?

    option_value(option).to_s == value.to_s
  end

  def option_label(option)
    return option.fetch(:label) if option.is_a?(Hash)

    option.first
  end

  def option_value(option)
    return option.fetch(:value) if option.is_a?(Hash)

    option.second
  end

  def option_description(option)
    return unless option.is_a?(Hash)

    option[:description]
  end

  def input_data
    data.merge(
      select_menu_target: "input"
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

  def trigger_id
    html_attributes[:id].presence || name.to_s.parameterize(separator: "_")
  end

  def input_id
    "#{trigger_id}_value"
  end

  def menu_id
    "#{trigger_id}_menu"
  end
end
