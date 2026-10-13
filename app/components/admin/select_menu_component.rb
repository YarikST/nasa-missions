# frozen_string_literal: true

class Admin::SelectMenuComponent < ViewComponent::Base
  def initialize(name:, title:, options:, id:, value: nil, errors: [])
    @name = name
    @title = title
    @options = options
    @id = id
    @value = value
    @errors = Array(errors)
  end

  attr_reader :name, :title, :options, :id, :value, :errors
end
