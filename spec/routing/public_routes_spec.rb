# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Public routes" do
  it "does not expose the old admin and authentication pages" do
    expect(get: "/admin").not_to be_routable
    expect(get: "/admin/dashboard").not_to be_routable
    expect(get: "/admin/login").not_to be_routable
    expect(post: "/admin/login").not_to be_routable
    expect(delete: "/admin/logout").not_to be_routable
    expect(get: "/admin/password/new").not_to be_routable
    expect(get: "/admin/confirmation/new").not_to be_routable
  end
end
