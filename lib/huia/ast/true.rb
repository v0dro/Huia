module Huia
  module AST
    class True < Literal

      def initialize
        super true
      end

      def bytecode g
        pos(g)

        g.push_huia_true
      end

    end
  end
end
