module Huia
  module AST
    class Nil < Literal

      def initialize
        super nil
      end

      def bytecode g
        pos g

        g.push :nil
      end

    end
  end
end
