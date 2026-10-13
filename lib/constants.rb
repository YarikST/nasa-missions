# frozen_string_literal: true

module Constants
  EMAIL_REGEX = /\A[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+\z/
  CYRILLIC_NAME_REGEX = /\A[\p{Cyrillic}\s\-_'’\ʼ]+\z/
  SLUG_REGEX = /\A[0-9a-z_-]+\z/
end
