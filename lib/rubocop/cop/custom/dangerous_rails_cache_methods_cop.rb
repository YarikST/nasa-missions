# frozen_string_literal: true

module RuboCop
  module Cop
    module Custom
      class DangerousRailsCacheMethodsCop < RuboCop::Cop::Base
        # copilot: add squish to the message
        MSG = <<~MESSAGE.tr("\n", " ")
          Avoid using `Rails.cache.delete_matched` and `Rails.cache.expire_fragment` as they can lead to
          performance issues and unintended cache invalidation. Use more targeted cache deletion methods instead like
          `Rails.cache.delete` with specific keys. If you absolutely must use `delete_matched`, discuss it with the team
          first.
        MESSAGE

        def on_send(node)
          add_offense(node, message: MSG) if dangerous_cache_call?(node)
        end

        private

        def dangerous_cache_call?(node)
          delete_matched_call?(node) || expire_fragment_call?(node)
        end

        def delete_matched_call?(node)
          return false unless node.method_name == :delete_matched

          receiver = node.receiver
          return false unless receiver

          receiver.method_name == :cache &&
            receiver.receiver&.const_name == "Rails"
        end

        def expire_fragment_call?(node)
          return true if node.method_name == :expire_fragment

          receiver = node.receiver
          return false unless receiver

          node.method_name == :expire_fragment &&
            receiver.method_name == :cache &&
            receiver.receiver&.const_name == "Rails"
        end
      end
    end
  end
end
