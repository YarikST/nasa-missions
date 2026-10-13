# frozen_string_literal: true

class Admin::DrawerComponentPreview < ViewComponent::Preview
  # @label Default
  def default
    render_with_template(
      template: "admin/drawer_component_preview/drawer",
      locals: {
        drawer_id: "default-drawer",
        title: "Workflow details",
        hint: nil,
        placement: :end,
        scroll: false,
        backdrop: true,
        closeable: true,
        auto_open: false
      }
    )
  end

  # @label With hint
  def with_hint
    render_with_template(
      template: "admin/drawer_component_preview/drawer",
      locals: {
        drawer_id: "hint-drawer",
        title: "Workflow details",
        hint: "Review the workflow settings before publishing.",
        placement: :end,
        scroll: false,
        backdrop: true,
        closeable: true,
        auto_open: false
      }
    )
  end

  # @label Start placement
  def start
    render_with_template(
      template: "admin/drawer_component_preview/drawer",
      locals: {
        drawer_id: "start-drawer",
        title: "Filters",
        hint: nil,
        placement: :start,
        scroll: false,
        backdrop: true,
        closeable: true,
        auto_open: false
      }
    )
  end

  # @label Top placement
  def top
    render_with_template(
      template: "admin/drawer_component_preview/drawer",
      locals: {
        drawer_id: "top-drawer",
        title: "Notification",
        hint: nil,
        placement: :top,
        scroll: false,
        backdrop: true,
        closeable: true,
        auto_open: false
      }
    )
  end

  # @label Scroll without backdrop
  def scrollable
    render_with_template(
      template: "admin/drawer_component_preview/drawer",
      locals: {
        drawer_id: "scrollable-drawer",
        title: "Filters",
        hint: "The page remains scrollable while this drawer is open.",
        placement: :end,
        scroll: true,
        backdrop: false,
        closeable: true,
        auto_open: false
      }
    )
  end

  # @label Static
  def static
    render_with_template(
      template: "admin/drawer_component_preview/drawer",
      locals: {
        drawer_id: "static-drawer",
        title: "Review submission",
        hint: "Complete the review before continuing.",
        placement: :end,
        scroll: false,
        backdrop: :static,
        closeable: false,
        auto_open: false
      }
    )
  end

  # @label Auto open
  def auto_open
    render_with_template(
      template: "admin/drawer_component_preview/drawer",
      locals: {
        drawer_id: "auto-open-drawer",
        title: "Workflow details",
        hint: "This drawer opens automatically.",
        placement: :end,
        scroll: false,
        backdrop: true,
        closeable: true,
        auto_open: true
      }
    )
  end

  # @label Playground
  #
  # @param title text
  # @param hint text
  # @param placement select { choices: [start, end, top, bottom] }
  # @param scroll toggle
  # @param backdrop toggle
  # @param closeable toggle
  # @param auto_open toggle
  def playground(
    title: "Workflow details",
    hint: "",
    placement: "end",
    scroll: false,
    backdrop: true,
    closeable: true,
    auto_open: false
  )
    render_with_template(
      template: "admin/drawer_component_preview/drawer",
      locals: {
        drawer_id: "playground-drawer",
        title: title,
        hint: hint.presence,
        placement: placement,
        scroll: scroll,
        backdrop: backdrop,
        closeable: closeable,
        auto_open: auto_open
      }
    )
  end
end
