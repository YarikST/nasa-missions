# frozen_string_literal: true

module MissionPlanRendering
  private

  def render_mission_plan(mission:, new_step: MissionStep.new, errors: [], status: :ok)
    mission.reload
    fuel = FuelCalculator.new(mission: mission).call
    planets = Planet.order(:name)

    render turbo_stream: [
      turbo_stream.replace(
        "flight_path",
        partial: "missions/flight_path",
        locals: { mission: mission, planets: planets, new_step: new_step, errors: errors }
      ),
      turbo_stream.replace("fuel_estimate", partial: "missions/fuel_estimate", locals: { fuel: fuel })
    ], status: status
  end
end
