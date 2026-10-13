# frozen_string_literal: true

require "rails_helper"
require "rake"

RSpec.describe Rake::Task do
  it "runs missions:seed_examples without duplicating planets or missions" do
    Rails.application.load_tasks
    task = Rake::Task["missions:seed_examples"]

    2.times do
      task.reenable
      task.invoke
    end

    expect(Planet.order(:name).pluck(:name, :gravity)).to eq([
      ["Earth", BigDecimal("9.807")],
      ["Mars", BigDecimal("3.711")],
      ["Moon", BigDecimal("1.62")]
    ])
    expect(MissionStep.count).to eq(14)
    expect(Mission.order(:name).to_h { |mission| [mission.name, FuelCalculator.new(mission: mission).call] }).to eq(
      "Apollo 11 Mission" => 51_898,
      "Mars Mission" => 33_388,
      "Passenger Ship Mission" => 212_161
    )
  end
end
