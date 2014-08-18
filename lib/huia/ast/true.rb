module Huia
  module AST
    class True < Literal

      def initialize
        super true
      end

      def bytecode g
        pos(g)

        push_huia_const g, :True
        g.send :new, 0
      end

    end
  end
end
