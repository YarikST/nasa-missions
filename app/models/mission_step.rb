# frozen_string_literal: true

class MissionStep < ApplicationRecord
  ACTIONS = %w[launch land].freeze

  belongs_to :mission
  belongs_to :planet

  validates :action, inclusion: { in: ACTIONS }
  validates :position, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, uniqueness: { scope: :mission_id }
end
