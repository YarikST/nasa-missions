# frozen_string_literal: true

module RuboCop
  module Cop
    module Custom
      # Disallow committing specs with any VCR recording enabled.
      # Only `record: :none` is permitted.
      class VcrNoRecordingCop < RuboCop::Cop::Base
        MSG = "Only `record: :none` is allowed in committed specs."

        def on_send(node)
          return unless node.method?(:use_cassette)

          node.arguments.each do |arg|
            next unless arg.hash_type?

            arg.pairs.each do |pair|
              next unless pair.key.sym_type? && pair.key.value == :record

              val = pair.value.value if pair.value.sym_type? || pair.value.true_type?

              add_offense(pair) unless val == :none
            end
          end
        end
      end
    end
  end
end
