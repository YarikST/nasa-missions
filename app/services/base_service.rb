# frozen_string_literal: true

class BaseService
  prepend MemoWise

  extend Dry::Initializer

  module Types
    include Dry.Types()
  end

  private

  def cast_bool(value)
    ActiveModel::Type::Boolean.new.cast(value)
  end
end
