# frozen_string_literal: true

class Mission < ApplicationRecord
  has_many :mission_steps, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :equipment_mass, numericality: { greater_than_or_equal_to: 0 }
end
