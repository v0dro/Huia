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

        done = g.new_label

        g.state.scope.allocate_local self unless @variable
        @variable.get_bytecode g

        g.dup
        g.is_nil
        g.gif done

        g.pop
        g.push_huia_nil
        @variable.set_bytecode(g)

        done.set!
      end
    end
  end
end
