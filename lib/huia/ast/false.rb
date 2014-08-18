module Huia
  module AST
    class False < Literal

      def initialize
        super false
      end

      def bytecode g
        pos g

        push_huia_const g, :False
        g.send :new, 0
      end

    end
  end
end
