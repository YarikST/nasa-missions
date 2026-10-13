# frozen_string_literal: true

class Admin::SelectMenuComponentPreview < ViewComponent::Preview
  def default
    render Admin::SelectMenuComponent.new(
      name: "mission_step[action]",
      title: "Action",
      id: "mission_step_action",
      options: [["Launch", "launch"], ["Land", "land"]]
    )
  end
end
