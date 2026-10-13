# frozen_string_literal: true

module RuboCop
  module Cop
    module Custom
      class RSpecLetItBeOverrideCop < RuboCop::Cop::Base
        MSG = "Do not override `%<name>s` defined by an ancestor example group. Use a different name."

        # Ancestors we care about (only these count as the original, persistent value)
        ANCESTOR_METHODS = %i[let_it_be let_it_be_with_refind].freeze
        # Any of these in a descendant count as an override (including let / let!)
        OVERRIDING_METHODS = %i[let let! let_it_be let_it_be_with_refind].freeze

        def on_block(node)
          send_node = node.send_node
          return unless overriding_call?(send_node)

          name = let_name(send_node)
          return unless name

          add_offense(node, message: format(MSG, name: ":#{name}")) if overrides_ancestor_let_it_be?(node, name)
        end

        def on_send(node)
          return unless overriding_call?(node)
          return if node.block_node

          name = let_name(node)
          return unless name

          add_offense(node, message: format(MSG, name: ":#{name}")) if overrides_ancestor_let_it_be?(node, name)
        end

        private

        def overriding_call?(send_node)
          send_node&.type == :send && OVERRIDING_METHODS.include?(send_node.method_name)
        end

        def ancestor_let_it_be_call?(send_node)
          send_node&.type == :send && ANCESTOR_METHODS.include?(send_node.method_name)
        end

        def let_name(send_node)
          arg = send_node.arguments.first
          arg&.sym_type? ? arg.value : nil
        end

        # True if any ancestor example group directly defines a let_it_be with the same name.
        # We ignore the current node to avoid self-matching false positives.
        def overrides_ancestor_let_it_be?(node, name)
          node.each_ancestor(:block).any? do |blk|
            example_group_block?(blk) && directly_defines_ancestor_let_it_be?(blk, name, excluding: node)
          end
        end

        def directly_defines_ancestor_let_it_be?(block_node, name, excluding:)
          body_nodes(block_node).any? do |child|
            next false if same_node?(child, excluding)

            case child.type
            when :block
              send = child.send_node
              ancestor_let_it_be_call?(send) && let_name(send) == name
            when :send
              ancestor_let_it_be_call?(child) && let_name(child) == name
            else
              false
            end
          end
        end

        def body_nodes(block_node)
          body = block_node.body
          return [] unless body

          body.begin_type? ? body.children : [body]
        end

        def same_node?(candidate, current)
          candidate.equal?(current) || candidate.loc.expression == current.loc.expression
        end

        def example_group_block?(block_node)
          send = block_node.send_node
          return false unless send&.type == :send

          example_group_method?(send.method_name)
        end

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
