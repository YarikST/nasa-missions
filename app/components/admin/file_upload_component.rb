# frozen_string_literal: true

class Admin::FileUploadComponent < Admin::BaseComponent
  def initialize(
    name:,
    title: nil,
    prompt: "Choose a file or drag it here",
    mandatory: false,
    accept: nil,
    multiple: false,
    preview: false,
    errors: [],
    disabled: false,
    hint: nil,
    data: {},
    html_attributes: {}
  )
    @name = name
    @title = title
    @prompt = prompt
    @mandatory = mandatory
    @accept = accept
    @multiple = multiple
    @preview = preview
    @errors = Array(errors).compact
    @disabled = disabled
    @hint = hint
    @data = data
    @html_attributes = html_attributes
  end

  attr_reader :name,
    :title,
    :prompt,
    :accept,
    :errors,
    :hint,
    :data,
    :html_attributes

  private

  def container_data
    {
      controller: "file-upload",
      file_upload_accept_value: accept,
      file_upload_multiple_value: multiple?,
      file_upload_preview_value: preview?
    }
  end

  def input_data
    custom_action = data[:action] || data["action"]

    data.except(:action, "action").merge(
      file_upload_target: "fileInput",
      action: [
        "change->file-upload#filesChanged",
        custom_action
      ].compact.join(" ")
    )
  end

  def dropzone_classes
    class_names(
      "border",
      "border-2",
      "border-dashed",
      "rounded-3",
      "p-4",
      "text-center",
      "d-block",
      "bg-body-tertiary",
      "border-danger": invalid?,
      "opacity-50 pe-none": disabled?
    )
  end

  def invalid?
    errors.present?
  end

  def optional?
    !@mandatory
  end

  def multiple?
    @multiple
  end

  def preview?
    @preview
  end

  def disabled?
    @disabled
  end

  def input_id
    name.to_s.parameterize(separator: "_")
  end
end
