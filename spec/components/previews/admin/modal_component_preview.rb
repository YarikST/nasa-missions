# frozen_string_literal: true

class Admin::ModalComponentPreview < ViewComponent::Preview
  # @label Default
  def default
    render_with_template(
      template: "admin/modal_component_preview/modal",
      locals: {
        modal_id: "default-modal",
        title: "Create workflow",
        hint: nil,
        size: nil,
        backdrop: true,
        closeable: true,
        show_footer: true
      }
    )
  end

  # @label With hint
  def with_hint
    render_with_template(
      template: "admin/modal_component_preview/modal",
      locals: {
        modal_id: "hint-modal",
        title: "Invite creator",
        hint: "The creator will receive an invitation by email.",
        size: nil,
        backdrop: true,
        closeable: true,
        show_footer: true
      }
    )
  end

  # @label Large
  def large
    render_with_template(
      template: "admin/modal_component_preview/modal",
      locals: {
        modal_id: "large-modal",
        title: "Review submission",
        hint: nil,
        size: "modal-lg",
        backdrop: true,
        closeable: true,
        show_footer: true
      }
    )
  end

  # @label Static backdrop
  def static_backdrop
    render_with_template(
      template: "admin/modal_component_preview/modal",
      locals: {
        modal_id: "static-modal",
        title: "Processing workflow",
        hint: "This modal cannot be closed by clicking outside.",
        size: nil,
        backdrop: :static,
        closeable: false,
        show_footer: false
      }
    )
  end

  # @label Without footer
  def without_footer
    render_with_template(
      template: "admin/modal_component_preview/modal",
      locals: {
        modal_id: "without-footer-modal",
        title: "Workflow details",
        hint: nil,
        size: nil,
        backdrop: true,
        closeable: true,
        show_footer: false
      }
    )
  end

  # @label Custom header
  def custom_header
    render_with_template(
      template: "admin/modal_component_preview/custom_header"
    )
  end

  # @label Playground
  #
  # @param title text
  # @param hint text
  # @param size select { choices: [Default, modal-sm, modal-lg, modal-xl] }
  # @param closeable toggle
  # @param static_backdrop toggle
  # @param show_footer toggle
  def playground(
    title: "Create workflow",
    hint: "",
    size: "Default",
    closeable: true,
    static_backdrop: false,
    show_footer: true
  )
    render_with_template(
      template: "admin/modal_component_preview/modal",
      locals: {
        modal_id: "playground-modal",
        title: title,
        hint: hint.presence,
        size: size == "Default" ? nil : size,
        backdrop: static_backdrop ? :static : true,
        closeable: closeable,
        show_footer: show_footer
      }
    )
  end
end
