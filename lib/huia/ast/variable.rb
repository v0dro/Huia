module Huia
  module AST
    class Variable < Node

      attr_reader :name
      attr_accessor :scope, :variable

      def initialize name
        @name = name
        @variable = nil
      end

      def bytecode g
        pos g

        g.state.scope.assign_local_reference self unless @variable
        @variable.get_bytecode g
      end
    end
  end
end
