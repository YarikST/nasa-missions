# frozen_string_literal: true

require "active_support/core_ext/numeric/conversions"

require "shrine"
require "shrine/storage/s3"
require "shrine/storage/file_system"
require "shrine/storage/memory"

s3_options = {
  bucket: ENV.fetch("ACTIVE_STORAGE_S3_BUCKET", "nasa-missions-dev"),
  region: ENV.fetch("ACTIVE_STORAGE_S3_REGION", "eu-central-1"),
  access_key_id: ENV.fetch("ACTIVE_STORAGE_ACCESS_KEY_ID", ""),
  secret_access_key: ENV.fetch("ACTIVE_STORAGE_ACCESS_KEY", ""),
  upload_options: { acl: "public-read" },
  public: true
}

shared_s3_options = {
  bucket: ENV.fetch("ACTIVE_STORAGE_S3_SHARED_BUCKET", "nasa-missions-dev"),
  region: ENV.fetch("ACTIVE_STORAGE_S3_REGION", "eu-central-1"),
  access_key_id: ENV.fetch("ACTIVE_STORAGE_ACCESS_KEY_ID", ""),
  secret_access_key: ENV.fetch("ACTIVE_STORAGE_ACCESS_KEY", ""),
}

if Rails.env.production?
  Shrine.storages = {
    store: Shrine::Storage::S3.new(**s3_options),
    shared_store: Shrine::Storage::S3.new(**shared_s3_options),
    cache: Shrine::Storage::FileSystem.new("tmp", prefix: "shrine")
  }
elsif Rails.env.development?
  Shrine.storages = {
    store: Shrine::Storage::FileSystem.new("public", prefix: "assets"),
    shared_store: Shrine::Storage::FileSystem.new("public", prefix: "shared"),
    cache: Shrine::Storage::FileSystem.new("public", prefix: "assets/cache")
  }
elsif Rails.env.test?
  Shrine.storages = {
    cache: Shrine::Storage::Memory.new,
    shared_store: Shrine::Storage::Memory.new,
    store: Shrine::Storage::Memory.new,
  }
end

TOP_LEVEL_MIME_TYPES = [
  "text/plain", # Plain text
  "application/octet-stream", # Binary data
  "application/zip", # ZIP archive
  "application/gzip" # GZIP compressed data
].freeze

Shrine.plugin :activerecord
Shrine.plugin :derivatives, create_on_promote: true
Shrine.plugin :pretty_location
Shrine.plugin :remove_invalid
Shrine.plugin :validation
Shrine.plugin :validation_helpers, default_messages: {
  max_size: ->(max) { I18n.t("shrine.file.max_size", max: ActiveSupport::NumberHelper.number_to_human_size(max)) },
  min_size: ->(min) { I18n.t("shrine.file.min_size", min: ActiveSupport::NumberHelper.number_to_human_size(min)) },
  max_width: ->(max) { I18n.t("shrine.file.max_width", max:) },
  min_width: ->(min) { I18n.t("shrine.file.min_width", min:) },
  max_height: ->(max) { I18n.t("shrine.file.max_height", max:) },
  min_height: ->(min) { I18n.t("shrine.file.min_height", min:) },
  max_dimensions: ->(dims) { I18n.t("shrine.file.max_dimensions", dims:) },
  min_dimensions: ->(dims) { I18n.t("shrine.file.min_dimensions", dims:) },
  mime_type_inclusion: ->(list) { I18n.t("shrine.file.mime_type_inclusion", list:) },
  mime_type_exclusion: ->(list) { I18n.t("shrine.file.mime_type_exclusion", list:) },
  extension_inclusion: ->(list) { I18n.t("shrine.file.extension_inclusion", list:) },
  extension_exclusion: ->(list) { I18n.t("shrine.file.extension_exclusion", list:) },
}
Shrine.plugin :determine_mime_type, analyzer: lambda { |io, analyzers|
  mime_type = analyzers[:marcel].call(io, filename_fallback: true)
  mime_type = analyzers[:mime_types].call(io) if TOP_LEVEL_MIME_TYPES.include?(mime_type)
  mime_type
}
Shrine.plugin :signature
Shrine.plugin :add_metadata
Shrine.plugin :tempfile
Shrine.plugin :type_predicates, mime: :marcel
Shrine.plugin :url_options,
  store: { host: ENV.fetch("CDN_URL", nil) },
  cache: { host: ENV.fetch("CDN_URL", nil) }
