# frozen_string_literal: true

class Admin::Dashboard::SidebarComponent < Admin::BaseComponent
  NAVIGATION_ITEMS = [
    {
      label: "Dashboard",
      path: "/admin",
      icon: "bi-speedometer2"
    },
    {
      label: "Creators",
      path: "#",
      icon: "bi-people"
    },
    {
      label: "Brands",
      path: "#",
      icon: "bi-building"
    },
    {
      label: "Campaigns",
      path: "#",
      icon: "bi-megaphone"
    },
    {
      label: "Reviews",
      path: "#",
      icon: "bi-chat-square-text"
    }
  ].freeze

  private

  def navigation_items
    NAVIGATION_ITEMS
  end

  def active?(path)
    request.path == path
  end
end
