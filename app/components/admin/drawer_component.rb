# frozen_string_literal: true

class Admin::DrawerComponent < Admin::BaseComponent
  def initialize(
    name:,
    title: nil,
    hint: nil,
    placement: :end,
    scroll: false,
    backdrop: true,
    auto_open: false,
    closeable: true,
    data: {},
    html_attributes: {}
  )
    @name = name
    @title = title
    @hint = hint
    @placement = placement
    @scroll = scroll
    @backdrop = backdrop
    @auto_open = auto_open
    @closeable = closeable
    @data = data
    @html_attributes = html_attributes
  end

  attr_reader :name,
    :title,
    :hint,
    :placement,
    :data,
    :html_attributes

  private

  def drawer_classes
    class_names(
      "offcanvas",
      "offcanvas-#{placement}",
      html_attributes[:class]
    )
  end

  def drawer_data
    custom_controller = data[:controller] || data["controller"]

    controllers = [
      ("drawer" if auto_open?),
      custom_controller
    ].compact.join(" ").presence

    {
      bs_scroll: scroll?,
      bs_backdrop: backdrop_value,
      controller: controllers
    }.compact.merge(
      data.except(:controller, "controller")
    )
  end

  def drawer_html_attributes
    html_attributes.except(:id, :class, :data, :aria)
  end

  def scroll?
    @scroll
  end

  def auto_open?
    @auto_open
  end

  def closeable?
    @closeable
  end

  def backdrop_value
    @backdrop == :static ? "static" : @backdrop
  end

  def title_id
    "#{name}_title"
  end
end
