# frozen_string_literal: true

module RuboCop
  module Cop
    module Custom
      class DuplicateIncludesAssociationCop < RuboCop::Cop::Base
        MSG = <<~MESSAGE.tr("\n", " ")
          Do not specify the same association more than once in a single `includes`, `preload`, or `eager_load` call.
        MESSAGE

        RELEVANT_METHODS = %i[includes preload eager_load].freeze

        def on_send(node)
          return unless RELEVANT_METHODS.include?(node.method_name)

          duplicated_nodes(node).each do |duplicated_node|
            add_offense(duplicated_node, message: MSG)
          end
        end

        private

        def duplicated_nodes(node)
          seen_paths = {}
          duplicates = []

          node.arguments.each do |argument|
            extract_paths(argument).each do |path, path_node|
              next if path.empty?

              normalized_path = path.join(".")

              if seen_paths.key?(normalized_path)
                duplicates << path_node
              else
                seen_paths[normalized_path] = path_node
              end
            end
          end

          duplicates
        end

        def extract_paths(node, current_path = [])
          return [] unless node

          return [[current_path + [node.value.to_s], node]] if association_node?(node)

          return node.values.flat_map { |child| extract_paths(child, current_path) } if node.array_type?

          return extract_paths_from_hash(node, current_path) if node.hash_type?

          []
        end

        def extract_paths_from_hash(node, current_path)
          node.pairs.flat_map do |pair|
            key_name = association_name(pair.key)
            next [] unless key_name

            nested_path = current_path + [key_name]

            [
              [nested_path, pair.key],
              *extract_paths(pair.value, nested_path)
            ]
          end
        end

        def association_node?(node)
          node.sym_type? || node.str_type?
        end

        def association_name(node)
          return node.value.to_s if association_node?(node)

          nil
        end
      end
    end
  end
end
