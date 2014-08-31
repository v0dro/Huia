module Huia
  module AST
    class Integer < Numeric

      def bytecode g
        pos g

        g.push_huia_integer value
      end

    end
  end
end
