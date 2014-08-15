module Huia
  module AST
    class Numeric < Literal

      def bytecode g
        pos g

        g.push_unique_literal value
      end

    end
  end
end
