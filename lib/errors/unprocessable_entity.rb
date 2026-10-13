# frozen_string_literal: true

class Errors::UnprocessableEntity < StandardError
  attr_reader :messages

  def initialize(messages = ["Oops ... Something went wrong, please try again later"])
    @messages = messages.is_a?(String) ? [messages] : messages
    super
  end
end
