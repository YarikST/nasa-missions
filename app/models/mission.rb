# frozen_string_literal: true

class Mission < ApplicationRecord
  has_many :mission_steps, -> { order(:position) }, inverse_of: :mission, dependent: :destroy
  accepts_nested_attributes_for :mission_steps, allow_destroy: true

  validates :name, presence: true, uniqueness: true
  validates :equipment_mass, numericality: { greater_than: 0 }
end
