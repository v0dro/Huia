module Huia
  module AST
    class Expression < Node

      attr_reader :children

      def initialize children
        @children = Array(children)
      end

      def append child
        children.push child
      end

      def bytecode g
        pos g

        children.each do |child|
          child.bytecode g
        end
      end
    end
  end
end
