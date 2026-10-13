# frozen_string_literal: true

class Admin::CardComponent < Admin::BaseComponent
  renders_one :header
  renders_one :footer

  def initialize(
    title: nil,
    description: nil,
    html_attributes: {},
    header_html_attributes: {},
    body_html_attributes: {},
    footer_html_attributes: {}
  )
    @title = title
    @description = description
    @html_attributes = html_attributes
    @header_html_attributes = header_html_attributes
    @body_html_attributes = body_html_attributes
    @footer_html_attributes = footer_html_attributes
  end

  attr_reader :title,
    :description,
    :html_attributes,
    :header_html_attributes,
    :body_html_attributes,
    :footer_html_attributes

  private

  def card_classes
    class_names("card", html_attributes[:class])
  end

  def card_html_attributes
    html_attributes.except(:class)
  end

  def header_classes
    class_names("card-header", header_html_attributes[:class])
  end

  def header_attributes
    header_html_attributes.except(:class)
  end

  def body_classes
    class_names("card-body", body_html_attributes[:class])
  end

  def body_attributes
    body_html_attributes.except(:class)
  end

  def footer_classes
    class_names("card-footer", footer_html_attributes[:class])
  end

  def footer_attributes
    footer_html_attributes.except(:class)
  end

  def default_header?
    title.present? || description.present?
  end
end
