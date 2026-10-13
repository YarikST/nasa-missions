# frozen_string_literal: true

class Admin::ModalComponent < Admin::BaseComponent
  renders_one :header
  renders_one :footer

  def initialize(
    name:,
    title: nil,
    hint: nil,
    backdrop: true,
    closeable: true,
    size: nil,
    data: {},
    html_attributes: {}
  )
    @name = name
    @title = title
    @hint = hint
    @backdrop = backdrop
    @closeable = closeable
    @size = size
    @data = data
    @html_attributes = html_attributes
  end

  attr_reader :name,
    :title,
    :hint,
    :size,
    :data,
    :html_attributes

  private

  def modal_classes
    class_names(
      "modal",
      "fade",
      html_attributes[:class]
    )
  end

  def dialog_classes
    class_names(
      "modal-dialog",
      "modal-dialog-centered",
      size
    )
  end

  def modal_data
    {
      bs_backdrop: @backdrop.to_s
    }.merge(data)
  end

  def modal_html_attributes
    html_attributes.except(:id, :class, :data, :aria)
  end

  def modal_aria
    {
      hidden: true,
      labelledby: title.present? ? title_id : nil
    }.compact
  end

  def title_id
    "#{name}_title"
  end

  def closeable?
    @closeable
  end
end
