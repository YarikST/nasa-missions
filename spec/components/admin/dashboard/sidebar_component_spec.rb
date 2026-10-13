# frozen_string_literal: true

require "rails_helper"

RSpec.describe Admin::Dashboard::SidebarComponent, type: :component do
  it "renders the dashboard sidebar" do
    render_inline(described_class.new)

    expect(page).to have_css("aside.bg-dark", text: "NASA Missions Administration")
  end
end
