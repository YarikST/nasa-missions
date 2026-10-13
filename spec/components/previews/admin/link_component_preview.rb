# frozen_string_literal: true

class Admin::LinkComponentPreview < ViewComponent::Preview
  # @label Default
  def default
    render Admin::LinkComponent.new(
      path: "#"
    ) do
      "View workflows"
    end
  end

  # @label Primary
  def primary
    render Admin::LinkComponent.new(
      path: "#",
      html_attributes: {
        class: "link-primary fw-medium"
      }
    ) do
      "Create workflow"
    end
  end

  # @label With icon
  def with_icon
    render_with_template(
      template: "admin/link_component_preview/with_icon"
    )
  end

  # @label External
  def external
    render Admin::LinkComponent.new(
      path: "https://example.com",
      target: "_blank"
    ) do
      "Open creator profile"
    end
  end

  # @label Disabled
  def disabled
    render Admin::LinkComponent.new(
      path: "#",
      disabled: true
    ) do
      "Unavailable action"
    end
  end

  # @label With data attributes
  def with_data
    render Admin::LinkComponent.new(
      path: "#",
      data: {
        controller: "navigation",
        action: "click->navigation#track"
      }
    ) do
      "Tracked link"
    end
  end

  # @label Playground
  #
  # @param label text
  # @param path text
  # @param target select { choices: [Default, _blank] }
  # @param disabled toggle
  # @param bold toggle
  def playground(
    label: "View workflows",
    path: "#",
    target: "Default",
    disabled: false,
    bold: false
  )
    render Admin::LinkComponent.new(
      path: path,
      target: target == "Default" ? nil : target,
      disabled: disabled,
      html_attributes: {
        class: bold ? "fw-semibold" : nil
      }
    ) do
      label
    end
  end
end
