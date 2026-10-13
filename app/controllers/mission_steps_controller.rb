# frozen_string_literal: true

class MissionStepsController < ApplicationController
  include MissionPlanRendering

  before_action :set_mission
  before_action :set_step, only: %i[update destroy]

  def create
    @mission.with_lock do
      position = (@mission.mission_steps.maximum(:position) || -1) + 1
      @step = @mission.mission_steps.build(step_params.merge(position: position))
      @saved = @step.save
    end

    if @saved
      respond_to do |format|
        format.turbo_stream { render_mission_plan(mission: @mission) }
        format.html { redirect_to edit_mission_path(@mission) }
      end
    else
      render_step_errors(new_step: @step, errors: [])
    end
  end

  def update
    if @step.update(step_params)
      respond_to do |format|
        format.turbo_stream { render_mission_plan(mission: @mission) }
        format.html { redirect_to edit_mission_path(@mission) }
      end
    else
      render_step_errors(errors: @step.errors.full_messages)
    end
  end

  def destroy
    @step.destroy!

    respond_to do |format|
      format.turbo_stream { render_mission_plan(mission: @mission) }
      format.html { redirect_to edit_mission_path(@mission) }
    end
  end

  private

  def set_mission
    @mission = Mission.find(params[:mission_id])
  end

  def set_step
    @step = @mission.mission_steps.find(params[:id])
  end

  def step_params
    params.require(:mission_step).permit(:action, :planet_id)
  end

  def render_step_errors(new_step: MissionStep.new, errors: @step.errors.full_messages)
    respond_to do |format|
      format.turbo_stream do
        render_mission_plan(mission: @mission, new_step: new_step, errors: errors, status: :unprocessable_content)
      end
      format.html { redirect_to edit_mission_path(@mission), alert: errors.to_sentence }
    end
  end
end
