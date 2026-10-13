# frozen_string_literal: true

class Planet < ApplicationRecord
  has_many :mission_steps, dependent: :restrict_with_error

  validates :name, presence: true, uniqueness: true
  validates :gravity, numericality: { greater_than: 0 }
end
