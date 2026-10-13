# frozen_string_literal: true

require "rails_helper"

RSpec.describe Admin::CardComponent, type: :component do
  it "renders the default header and body" do
    render_inline(described_class.new(
      title: "Campaign summary",
      description: "Review the campaign before publishing."
    )) do
      "Card content"
    end

    expect(page).to have_css(".card > .card-header h2", text: "Campaign summary")
    expect(page).to have_css(".card > .card-header p", text: "Review the campaign before publishing.")
    expect(page).to have_css(".card > .card-body", text: "Card content")
    expect(page).to have_no_css(".card > .card-footer")
  end

  it "renders custom slots and HTML attributes" do
    render_inline(described_class.new(
      html_attributes: { id: "campaign-card", class: "shadow-sm" },
      body_html_attributes: { class: "p-4" },
      footer_html_attributes: { class: "text-end" }
    )) do |card|
      card.with_header { "Custom header" }
      card.with_footer { "Card footer" }

      "Card content"
    end

    expect(page).to have_css("#campaign-card.card.shadow-sm > .card-header", text: "Custom header")
    expect(page).to have_css("#campaign-card > .card-body.p-4", text: "Card content")
    expect(page).to have_css("#campaign-card > .card-footer.text-end", text: "Card footer")
  end
end
