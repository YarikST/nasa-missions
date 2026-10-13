# frozen_string_literal: true

module RequestHelper
  def json
    @json ||= JSON.parse(response.body)
  end

  def json_ids
    json.pluck("id").sort
  end

  def json_keys(key)
    json.pluck(key).sort
  end
end
