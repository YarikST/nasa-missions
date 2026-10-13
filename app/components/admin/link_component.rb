# frozen_string_literal: true

class Admin::LinkComponent < Admin::BaseComponent
  def initialize(
    path:,
    target: nil,
    disabled: false,
    data: {},
    html_attributes: {}
  )
    @path = path
    @target = target
    @disabled = disabled
    @data = data
    @html_attributes = html_attributes
  end

  attr_reader :path,
    :target,
    :data,
    :html_attributes

  private

  def link_classes
    class_names(
      html_attributes[:class],
      "text-decoration-none"
    )
  end

  def link_html_attributes
    html_attributes.except(:class, :href, :target, :rel, :data)
  end

  def disabled_html_attributes
    attributes = link_html_attributes

    attributes[:aria] = attributes.fetch(:aria, {}).merge(
      disabled: true
    )

    attributes
  end

  def disabled_classes
    class_names(
      link_classes,
      "text-body-secondary",
      "opacity-50"
    )
  end

  def disabled?
    @disabled
  end

  def rel
    return html_attributes[:rel] if html_attributes[:rel].present?
    return unless target == "_blank"

    "noopener noreferrer"
  end
end
