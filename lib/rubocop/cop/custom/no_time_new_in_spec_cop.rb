# frozen_string_literal: true

module RuboCop
  module Cop
    module Custom
      class NoTimeNewInSpec < Base
        MSG = "Do not use Time.new in specs. Use Time.zone.parse(...) or Time.find_zone(...)."
        RESTRICT_ON_SEND = [:new].freeze

        def_node_matcher :time_new?, <<~PATTERN
          (send
            {
              (const nil? :Time)
              (const (cbase) :Time)
            }
            :new
            ...)
        PATTERN

        def on_send(node)
          return unless time_new?(node)

          add_offense(node)
        end
      end
    end
  end
end
