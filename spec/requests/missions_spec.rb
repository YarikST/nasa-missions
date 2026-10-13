# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Missions" do
  let!(:earth) { Planet.create!(name: "Earth", gravity: "9.807") }
  let!(:moon) { Planet.create!(name: "Moon", gravity: "1.62") }
  let!(:mars) { Planet.create!(name: "Mars", gravity: "3.711") }

  def create_mission(name: "Apollo 11 Mission", mass: 28_801)
    Mission.create!(name: name, equipment_mass: mass)
  end

  def add_apollo_steps(mission)
    path = [["launch", earth], ["land", moon], ["launch", moon], ["land", earth]]
    path.each_with_index do |(action, planet), position|
      mission.mission_steps.create!(action: action, planet: planet, position: position)
    end
    mission
  end

  def expect_plan_streams
    expect(response.media_type).to eq("text/vnd.turbo-stream.html")
    expect(response.body).to include('target="flight_path"', 'target="fuel_estimate"')
  end

  describe "GET /missions/new" do
    it "locks the flight path until the mission is saved" do
      get new_mission_path

      expect(response).to have_http_status(:ok)
      expect(response.body).to include("Create a mission", "Equipment mass (kg)")
      expect(response.body).to include("Create the mission to start adding route steps")
      expect(response.parsed_body.at_css("button[disabled]").text).to include("Add step")
      expect(response.body).not_to include("mission_step[action]")
    end
  end

  describe "POST /missions" do
    it "creates a mission without steps and opens its editor" do
      expect do
        post missions_path, params: { mission: { name: "Apollo 11 Mission", equipment_mass: "28801" } }
      end.to change(Mission, :count).by(1)

      expect(response).to redirect_to(edit_mission_path(Mission.last))
      expect(MissionStep.count).to eq(0)
    end

    it "rejects invalid mission details" do
      post missions_path, params: { mission: { name: "", equipment_mass: "0" } }

      expect(response).to have_http_status(:unprocessable_content)
      expect(response.body).to include("must be greater than 0", "is-invalid")
      expect(Mission.count).to eq(0)
    end
  end

  describe "GET /missions/:id/edit" do
    it "shows an active step form and fuel estimate for a saved mission" do
      mission = add_apollo_steps(create_mission)

      get edit_mission_path(mission)

      expect(response).to have_http_status(:ok)
      expect(response.body).to include("Plan mission", "Add step", "51,898")
      expect(response.body).to include('name="mission_step[action]"', "step_#{mission.mission_steps.first.id}_action")
      expect(response.body).to include('data-action="change-&gt;mission-form#submit"')
      expect(response.parsed_body.at_css('input[name="mission[equipment_mass]"]')["data-action"])
        .to eq("input->mission-form#submit")

      add_step_form = response.parsed_body.at_css("form[action='#{mission_mission_steps_path(mission)}']")
      expect(add_step_form["method"]).to eq("post")
      expect(add_step_form.at_css("select#new_step_action[required] option[value='launch']")).to be_present
      expect(add_step_form.at_css("select#new_step_planet[required] option[value='#{earth.id}']")).to be_present
      expect(add_step_form.at_css("button[type='submit']").text).to include("Add step")
    end
  end

  describe "PATCH /missions/:id" do
    it "saves changed mass and refreshes the path and fuel through Turbo" do
      mission = add_apollo_steps(create_mission)

      patch mission_path(mission),
        params: { mission: { name: "Apollo updated", equipment_mass: "30000" } },
        as: :turbo_stream

      expect(response).to have_http_status(:ok)
      expect_plan_streams
      expect(mission.reload.name).to eq("Apollo updated")
      expect(mission.equipment_mass).to eq(BigDecimal("30000"))
      expected_fuel = FuelCalculator.new(mission: mission).call
      expect(response.body).to include(ActionController::Base.helpers.number_with_delimiter(expected_fuel))
    end

    it "shows validation errors without changing the saved mass" do
      mission = create_mission

      patch mission_path(mission), params: { mission: { name: mission.name, equipment_mass: "0" } }, as: :turbo_stream

      expect(response).to have_http_status(:unprocessable_content)
      expect(response.body).to include('target="mission_details"', 'target="fuel_estimate"', "must be greater than 0")
      expect(mission.reload.equipment_mass).to eq(BigDecimal("28801"))
    end
  end

  describe "POST /missions/:mission_id/steps" do
    it "adds a step and refreshes the path and estimate" do
      mission = create_mission

      expect do
        post mission_mission_steps_path(mission),
          params: { mission_step: { action: "launch", planet_id: earth.id } },
          as: :turbo_stream
      end.to change(MissionStep, :count).by(1)

      expect(response).to have_http_status(:ok)
      expect_plan_streams
      expect(mission.mission_steps.last.position).to eq(0)
      expect(response.body).to include("Step 1", "Total fuel required")
    end

    it "rejects invalid action and planet without changing the route" do
      mission = create_mission

      post mission_mission_steps_path(mission),
        params: { mission_step: { action: "orbit", planet_id: nil } },
        as: :turbo_stream

      expect(response).to have_http_status(:unprocessable_content)
      expect_plan_streams
      expect(response.body).to include("is not included in the list", "must exist", "0")
      expect(mission.mission_steps.count).to eq(0)
    end
  end

  describe "PATCH /missions/:mission_id/steps/:id" do
    it "updates a step and recalculates fuel" do
      mission = add_apollo_steps(create_mission)
      step = mission.mission_steps.first

      patch mission_mission_step_path(mission, step),
        params: { mission_step: { action: "land", planet_id: mars.id } },
        as: :turbo_stream

      expect(response).to have_http_status(:ok)
      expect_plan_streams
      expect(step.reload.attributes.slice("action", "planet_id")).to eq({ "action" => "land", "planet_id" => mars.id })
      expect(response.body).not_to include("51,898")
    end
  end

  describe "DELETE /missions/:mission_id/steps/:id" do
    it "removes a step and recalculates fuel" do
      mission = add_apollo_steps(create_mission)
      step = mission.mission_steps.first

      expect do
        delete mission_mission_step_path(mission, step), as: :turbo_stream
      end.to change(MissionStep, :count).by(-1)

      expect(response).to have_http_status(:ok)
      expect_plan_streams
      expect(response.body).to include("Step 1", "Total fuel required")
      expect(mission.reload.mission_steps.first.position).to eq(1)
    end
  end

  describe "GET /missions" do
    it "lists missions with fuel estimates and actions" do
      mission = add_apollo_steps(create_mission)

      get missions_path

      expect(response).to have_http_status(:ok)
      expect(response.body).to include(mission.name, "28,801", "51,898", "View", "Edit", "Delete")
      delete_form = response.parsed_body.at_css("form[action='#{mission_path(mission)}']")
      expect(delete_form.at_css("input[name='_method'][value='delete']")).to be_present
      expect(delete_form["data-turbo-confirm"]).to include("Delete #{mission.name}?")
    end
  end

  describe "GET /missions/:id" do
    it "shows the ordered flight path and total fuel" do
      mission = add_apollo_steps(create_mission)

      get mission_path(mission)

      expect(response).to have_http_status(:ok)
      expect(response.body).to include("Apollo 11 Mission", "51,898", "Launch", "Land", "Moon")
    end
  end

  describe "DELETE /missions/:id" do
    it "deletes the mission and its steps" do
      mission = add_apollo_steps(create_mission)

      expect do
        delete mission_path(mission)
      end.to change(Mission, :count).by(-1).and change(MissionStep, :count).by(-4)

      expect(response).to redirect_to(root_path)
      expect(Planet.count).to eq(3)
    end
  end
end
