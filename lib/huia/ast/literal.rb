module Huia
  module AST
    class Literal < Node

      attr_accessor :value

      def initialize value
        self.value = value
      end

      def bytecode g
        pos g

        g.push_literal value
      end

    end
  end
end
