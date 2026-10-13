# frozen_string_literal: true

class Admin::ButtonComponent < ViewComponent::Base
  def initialize(path: nil, method: :get, type: :button, variant: :primary, size: nil, icon: nil,
    disabled: false, confirm: nil)
    @path = path
    @method = method
    @type = type
    @variant = variant
    @size = size
    @icon = icon
    @disabled = disabled
    @confirm = confirm
  end

  attr_reader :path, :method, :type, :disabled, :confirm

  private

  attr_reader :variant, :size, :icon

  def button_classes
    class_names(
      "btn",
      "btn-#{variant.to_s.tr('_', '-')}",
      ("btn-sm" if size == :sm),
      "d-inline-flex align-items-center justify-content-center gap-2": icon.present?
    )
  end

  def button_content
    return content if icon.blank?

    safe_join([tag.i(class: "bi bi-#{icon}", aria: { hidden: true }), tag.span(content)])
  end
end
