# frozen_string_literal: true

require "bigdecimal"

class FuelCalculator < BaseService
  FORMULAS = {
    "launch" => [BigDecimal("0.042"), 33],
    "land" => [BigDecimal("0.033"), 42]
  }.freeze

  def initialize(mission:)
    @mission = mission
  end

  def call
    mission_steps.to_a.reverse_each.reduce(0) do |fuel, step|
      fuel + fuel_for(mission.equipment_mass + fuel, step)
    end
  end

  private

  attr_reader :mission

  def mission_steps
    mission.mission_steps.includes(:planet).order(:position)
  end

  def fuel_for(mass, step)
    coefficient, offset = FORMULAS.fetch(step.action)
    gravity = step.planet.gravity
    total = 0
    fuel = (mass * gravity * coefficient - offset).floor

    while fuel.positive?
      total += fuel
      fuel = (fuel * gravity * coefficient - offset).floor
    end

    total
  end
end
