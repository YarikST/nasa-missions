# frozen_string_literal: true

class Admin::CardComponent < ViewComponent::Base
  def initialize(title:, description: nil)
    @title = title
    @description = description
  end

  attr_reader :title, :description
end
