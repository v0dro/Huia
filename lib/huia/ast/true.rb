module Huia
  module AST
    class True < Literal

      def initialize
        super true
      end

      def bytecode g
        pos(g)

        g.push :true
      end

    end
  end
end
