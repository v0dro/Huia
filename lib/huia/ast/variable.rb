module Huia
  module AST
    class Variable < Node
      attr_reader :name
      attr_accessor :index

      def initialize name
        @name = name
        @variable = nil
      end

      def bytecode g
        pos g

        g.push_local index
      end
    end
  end
end
