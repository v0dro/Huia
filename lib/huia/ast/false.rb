module Huia
  module AST
    class False < Literal

      def initialize
        super false
      end

      def bytecode g
        pos g

        g.push_huia_false
      end

    end
  end
end
