# frozen_string_literal: true

class Admin::Auth::CardComponent < Admin::BaseComponent
  renders_one :footer

  def initialize(title:, description: nil)
    @title = title
    @description = description
  end

  attr_reader :title, :description
end
