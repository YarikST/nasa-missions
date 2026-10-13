# frozen_string_literal: true

require "rails_helper"

RSpec.describe FuelCalculator do
  before do
    Planet.create!(name: "Earth", gravity: "9.807")
    Planet.create!(name: "Moon", gravity: "1.62")
    Planet.create!(name: "Mars", gravity: "3.711")
  end

  def build_mission(mass:, path:)
    mission = Mission.create!(name: "Test mission", equipment_mass: mass)

    path.each_with_index do |(action, planet_name), position|
      mission.mission_steps.create!(
        action: action,
        planet: Planet.find_by!(name: planet_name),
        position: position
      )
    end

    mission
  end

  it "includes the fuel needed to carry landing fuel" do
    mission = build_mission(mass: 28_801, path: [["land", "Earth"]])

    expect(described_class.new(mission: mission).call).to eq(13_447)
  end

  it "rounds each additional fuel amount down and stops at zero" do
    mission = build_mission(mass: 100, path: [["launch", "Earth"]])

    expect(described_class.new(mission: mission).call).to eq(8)
  end

  it "accounts for fuel needed by later steps when calculating earlier ones" do
    mission = build_mission(mass: 28_801, path: [
      ["launch", "Earth"], ["land", "Moon"], ["launch", "Moon"], ["land", "Earth"]
    ])

    expect(described_class.new(mission: mission).call).to eq(51_898)
  end

  it "returns zero for a mission with no steps" do
    mission = build_mission(mass: 28_801, path: [])

    expect(described_class.new(mission: mission).call).to eq(0)
  end
end
