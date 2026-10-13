# frozen_string_literal: true

class Admin::ButtonComponent < Admin::BaseComponent
  VARIANTS = {
    primary: "btn-primary",
    secondary: "btn-secondary",
    outline_secondary: "btn-outline-secondary",
    danger: "btn-danger",
    outline_danger: "btn-outline-danger",
    link: "btn-link"
  }.freeze

  SIZES = {
    sm: "btn-sm",
    lg: "btn-lg"
  }.freeze

  METHODS = %i[get post patch put delete].freeze
  TYPES = %i[button submit reset].freeze
  ICON_POSITIONS = %i[start end].freeze

  def initialize(
    path: nil,
    method: :get,
    type: :button,
    variant: :primary,
    size: nil,
    icon: nil,
    icon_position: :start,
    disabled: false,
    confirm: nil,
    data: {},
    params: {},
    form_attributes: {},
    html_attributes: {}
  )
    @path = path
    @method = method.to_sym
    @type = type.to_sym
    @variant = variant.to_sym
    @size = size&.to_sym
    @icon = icon
    @icon_position = icon_position.to_sym
    @disabled = disabled
    @confirm = confirm
    @data = data
    @params = params
    @form_attributes = form_attributes
    @html_attributes = html_attributes

    validate_options
  end

  attr_reader :path,
    :method,
    :type,
    :variant,
    :size,
    :icon,
    :icon_position,
    :confirm,
    :data,
    :params,
    :form_attributes,
    :html_attributes

  private

  def button_classes
    class_names(
      "btn",
      VARIANTS.fetch(variant),
      SIZES[size],
      html_attributes[:class],
      "d-inline-flex align-items-center justify-content-center gap-2": icon.present?
    )
  end

  def button_content
    safe_join(
      [
        (icon_tag if icon_position == :start),
        (content_tag(:span, content) if content.present?),
        (icon_tag if icon_position == :end)
      ].compact
    )
  end

  def icon_tag
    return if icon.blank?

    content_tag(
      :i,
      nil,
      class: "bi bi-#{icon}",
      aria: { hidden: true }
    )
  end

  def link?
    path.present? && method == :get
  end

  def request_button?
    path.present? && method != :get
  end

  def disabled_link?
    link? && disabled?
  end

  def disabled?
    @disabled
  end

  def link_data
    data.merge(
      turbo_confirm: confirm
    ).compact
  end

  def request_form_attributes
    attributes = {
      class: "d-inline"
    }.merge(form_attributes)

    return attributes if confirm.blank?

    attributes[:data] = attributes.fetch(:data, {}).merge(
      turbo_confirm: confirm
    )

    attributes
  end

  def element_html_attributes
    html_attributes.except(
      :class,
      :data,
      :disabled,
      :type,
      :method,
      :form,
      :form_class,
      :params,
      :href
    )
  end

  def disabled_link_html_attributes
    attributes = element_html_attributes

    attributes[:aria] = attributes.fetch(:aria, {}).merge(
      disabled: true
    )
    attributes[:tabindex] = -1

    attributes
  end

  def validate_options
    raise ArgumentError, "Unknown button variant: #{variant}" unless VARIANTS.key?(variant)
    raise ArgumentError, "Unknown request method: #{method}" unless METHODS.include?(method)
    raise ArgumentError, "Unknown button type: #{type}" unless TYPES.include?(type)
    raise ArgumentError, "Unknown button size: #{size}" if size.present? && !SIZES.key?(size)

    return if ICON_POSITIONS.include?(icon_position)

    raise ArgumentError, "Unknown icon position: #{icon_position}"
  end
end
