module Huia
  module AST
    class Nil < Literal

      def initialize
        super nil
      end

      def bytecode g
        pos g

        g.push_huia_nil
      end

    end
  end
end
