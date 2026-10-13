# frozen_string_literal: true

class Admin::InputComponent < ViewComponent::Base
  def initialize(name:, title:, value: nil, type: :text, placeholder: nil, errors: [], hint: nil,
    data: {}, html_attributes: {})
    @name = name
    @title = title
    @value = value
    @type = type
    @placeholder = placeholder
    @errors = Array(errors)
    @hint = hint
    @data = data
    @html_attributes = html_attributes
  end

  attr_reader :name, :title, :value, :type, :placeholder, :errors, :hint, :data, :html_attributes

  def input_id
    name.to_s.parameterize(separator: "_")
  end
end
