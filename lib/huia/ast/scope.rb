module Huia
  module AST
    class Scope < Node

      attr_reader :variables, :children, :parent, :arguments
      attr_accessor :file

      def initialize parent
        @variables = {}
        @children  = []
        @arguments = []
        @parent    = parent
      end

      def allocate variable_name
        @variables[variable_name] = Huia::AST::Variable.new variable_name
      end

      def add_argument variable
        @arguments << variable
        append variable
      end

      def append node
        raise RuntimeError, "Cannot append a non-Node" unless node.is_a? Huia::AST::Node
        @children << node
        self
      end

      def reduce
        @children.map(&:reduce)
      end
    end
  end
end
