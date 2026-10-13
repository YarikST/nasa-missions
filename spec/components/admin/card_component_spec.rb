# frozen_string_literal: true

require "rails_helper"

RSpec.describe Admin::CardComponent, type: :component do
  it "renders its title, description, and body" do
    render_inline(described_class.new(
      title: "Campaign summary",
      description: "Review the campaign before publishing."
    )) do
      "Card content"
    end

    expect(page).to have_css(".card > .card-header h2", text: "Campaign summary")
    expect(page).to have_css(".card > .card-header p", text: "Review the campaign before publishing.")
    expect(page).to have_css(".card > .card-body", text: "Card content")
  end

  it "omits the description when one is not given" do
    render_inline(described_class.new(title: "Flight path")) do
      "Card content"
    end

    expect(page).to have_css(".card > .card-header h2", text: "Flight path")
    expect(page).to have_no_css(".card > .card-header p")
  end
end
