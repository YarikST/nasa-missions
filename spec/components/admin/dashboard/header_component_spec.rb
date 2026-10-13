# frozen_string_literal: true

require "rails_helper"

RSpec.describe Admin::Dashboard::HeaderComponent, type: :component do
  it "renders the current staff name and logout action" do
    current_staff = Struct.new(:name).new("Jane Doe")

    render_inline(described_class.new(
      title: "Dashboard",
      current_staff: current_staff,
      logout_path: "/admin/logout"
    ))

    expect(page).to have_css("header h1", text: "Dashboard")
    expect(page).to have_text("Jane Doe")
    expect(page).to have_button("Log out")
    expect(page).to have_css(
      'form[action="/admin/logout"] input[name="_method"][value="delete"]',
      visible: :all
    )
  end
end
