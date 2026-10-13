# frozen_string_literal: true

namespace :missions do
  desc "Create supported planets and example missions"
  task seed_examples: :environment do
    planets = {
      "Earth" => "9.807",
      "Moon" => "1.62",
      "Mars" => "3.711"
    }.to_h do |name, gravity|
      planet = Planet.find_or_initialize_by(name: name)
      planet.update!(gravity: gravity)
      [name, planet]
    end

    examples = {
      "Apollo 11 Mission" => {
        mass: 28_801,
        path: [%w[launch Earth], %w[land Moon], %w[launch Moon], %w[land Earth]]
      },
      "Mars Mission" => {
        mass: 14_606,
        path: [%w[launch Earth], %w[land Mars], %w[launch Mars], %w[land Earth]]
      },
      "Passenger Ship Mission" => {
        mass: 75_432,
        path: [
          %w[launch Earth], %w[land Moon], %w[launch Moon],
          %w[land Mars], %w[launch Mars], %w[land Earth]
        ]
      }
    }

    examples.each do |name, details|
      mission = Mission.find_or_initialize_by(name: name)
      mission.update!(equipment_mass: details.fetch(:mass))

      details.fetch(:path).each_with_index do |(action, planet_name), position|
        step = mission.mission_steps.find_or_initialize_by(position: position)
        step.update!(action: action, planet: planets.fetch(planet_name))
      end
    end
  end
end
