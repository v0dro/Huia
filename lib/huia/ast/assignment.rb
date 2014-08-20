module Huia
  module AST
    class Assignment < Node

      attr_accessor :value, :scope, :variable
      attr_reader :name

      def initialize name, value
        @name  = name
        @value = value
      end


      def bytecode g
        pos g

        g.state.scope.allocate_local self unless @variable

        @value.bytecode g if @value

        pos g

        @variable.set_bytecode(g)
      end
    end
  end
end
