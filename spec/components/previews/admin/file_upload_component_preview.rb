# frozen_string_literal: true

class Admin::FileUploadComponentPreview < ViewComponent::Preview
  # @label Default
  def default
    render Admin::FileUploadComponent.new(
      name: "workflow[attachment]",
      title: "Attachment"
    )
  end

  # @label Image preview
  def image_preview
    render Admin::FileUploadComponent.new(
      name: "workflow[cover]",
      title: "Workflow cover",
      prompt: "Choose an image or drag it here",
      accept: "image/jpeg,image/png,image/webp",
      preview: true
    )
  end

  # @label Video preview
  def video_preview
    render Admin::FileUploadComponent.new(
      name: "submission[video]",
      title: "Submission video",
      prompt: "Choose a video or drag it here",
      accept: "video/mp4,video/quicktime",
      preview: true,
      mandatory: true
    )
  end

  # @label Multiple files
  def multiple
    render Admin::FileUploadComponent.new(
      name: "workflow[attachments][]",
      title: "Attachments",
      prompt: "Choose files or drag them here",
      accept: "image/*,video/*",
      multiple: true,
      preview: true
    )
  end

  # @label With hint
  def with_hint
    render Admin::FileUploadComponent.new(
      name: "workflow[cover]",
      title: "Workflow cover",
      accept: "image/jpeg,image/png",
      hint: "Upload a JPG or PNG image."
    )
  end

  # @label Invalid
  def invalid
    render Admin::FileUploadComponent.new(
      name: "submission[video]",
      title: "Submission video",
      mandatory: true,
      errors: ["Video must be attached"]
    )
  end

  # @label Disabled
  def disabled
    render Admin::FileUploadComponent.new(
      name: "workflow[attachment]",
      title: "Attachment",
      disabled: true
    )
  end

  # @label Playground
  #
  # @param title text
  # @param prompt text
  # @param accept text
  # @param hint text
  # @param mandatory toggle
  # @param multiple toggle
  # @param preview toggle
  # @param disabled toggle
  # @param invalid toggle
  def playground(
    title: "Attachment",
    prompt: "Choose files or drag them here",
    accept: "image/*",
    hint: "",
    mandatory: false,
    multiple: false,
    preview: true,
    disabled: false,
    invalid: false
  )
    render Admin::FileUploadComponent.new(
      name: multiple ? "workflow[attachments][]" : "workflow[attachment]",
      title: title,
      prompt: prompt,
      accept: accept.presence,
      hint: hint.presence,
      mandatory: mandatory,
      multiple: multiple,
      preview: preview,
      disabled: disabled,
      errors: invalid ? ["This file is invalid"] : []
    )
  end
end
