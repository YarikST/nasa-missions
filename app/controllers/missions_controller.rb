# frozen_string_literal: true

class MissionsController < ApplicationController
  include MissionPlanRendering

  before_action :set_mission, only: %i[show edit update destroy]
  before_action :load_planets, only: %i[edit update]

  def index
    @missions = Mission.includes(mission_steps: :planet).order(created_at: :desc, id: :desc)
    @fuel_by_mission_id = @missions.to_h { |mission| [mission.id, FuelCalculator.new(mission: mission).call] }
  end

  def show
    @fuel = FuelCalculator.new(mission: @mission).call
  end

  def new
    @mission = Mission.new
  end

  def edit
    @fuel = FuelCalculator.new(mission: @mission).call
  end

  def create
    @mission = Mission.new(mission_params)

    if @mission.save
      redirect_to edit_mission_path(@mission), notice: t(".created")
    else
      render :new, status: :unprocessable_content
    end
  end

  def update
    if @mission.update(mission_params)
      respond_to do |format|
        format.turbo_stream { render_mission_plan(mission: @mission) }
        format.html { redirect_to edit_mission_path(@mission), notice: t(".updated") }
      end
    else
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.replace("mission_details", partial: "missions/details_form", locals: { mission: @mission }),
            turbo_stream.replace("fuel_estimate", partial: "missions/fuel_estimate", locals: { fuel: nil })
          ], status: :unprocessable_content
        end
        format.html { render :edit, status: :unprocessable_content }
      end
    end
  end

  def destroy
    @mission.destroy!
    redirect_to root_path, notice: t(".deleted")
  end

  private

  def set_mission
    @mission = Mission.includes(mission_steps: :planet).find(params[:id])
  end

  def load_planets
    @planets = Planet.order(:name)
  end

  def mission_params
    params.require(:mission).permit(:name, :equipment_mass)
  end
end
