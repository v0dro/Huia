module Huia
  module AST
    class Scope < Node

      attr_reader :variables, :children, :parent

      def initialize parent
        @variables = {}
        @children  = []
        @parent    = parent
      end

      def allocate variable_name
        @variables[variable_name] = Huia::AST::Variable.new variable_name
      end

      def append node
        raise RuntimeError, "Cannot append a non-Node" unless node.is_a? Huia::AST::Node
        @children.push node
        self
      end

      def reduce
        @children.map(&:reduce)
      end
    end
  end
end