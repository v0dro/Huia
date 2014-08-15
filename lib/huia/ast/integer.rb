module Huia
  module AST
    class Integer < Numeric

      def bytecode g
        pos g

        g.push_int value.to_i
      end

    end
  end
end
