# frozen_string_literal: true

module RuboCop
  module Cop
    module Custom
      class RSpecLetItBeNestingCop < RuboCop::Cop::Base
        MSG = "Do not use `let_it_be` in deeply nested example groups. " \
              "Allowed only at file top-level or within the first 2 levels describe/context."

        RELEVANT_METHODS = %i[let_it_be let_it_be_with_refind].freeze

        def on_block(node)
          # Handles: let_it_be(:x) { ... }
          send_node = node.send_node
          return unless relevant_let_it_be?(send_node)

          register_offense_if_nested(node)
        end

        def on_send(node)
          # Handles: let_it_be(:x)
          return unless relevant_let_it_be?(node)
          return if node.block_node # block-form handled in on_block

          register_offense_if_nested(node)
        end

        private

        def relevant_let_it_be?(send_node)
          send_node&.type == :send && RELEVANT_METHODS.include?(send_node.method_name)
        end

        def register_offense_if_nested(node)
          depth = example_group_depth(node)

          add_offense(node, message: MSG) if depth > 3
        end

        # Count ancestor example-group blocks the node is inside.
        # Depth 0: file top-level (no example group ancestors)
        # Depth 1: inside a single describe/context (allowed)
        # Depth 2: inside a 1 level nested describe/context (allowed)
        # Depth 3+: nested groups (offense)
        def example_group_depth(node)
          node.each_ancestor(:block).count { |blk| example_group_block?(blk) }
        end

        def example_group_block?(block_node)
          send = block_node.send_node
          return false unless send&.type == :send

          example_group_method?(send.method_name)
        end

        # Extend this list if you use additional RSpec group DSL.
        def example_group_method?(name)
          %i[
            describe context feature example_group
            fdescribe fcontext xdescribe xcontext
          ].include?(name)
        end
      end
    end
  end
end
