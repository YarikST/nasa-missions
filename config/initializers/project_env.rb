# frozen_string_literal: true

module Rails
  def self.project_env
    @project_env ||= ActiveSupport::StringInquirer.new(ENV.fetch("PROJECT_ENV", ""))
  end
end
