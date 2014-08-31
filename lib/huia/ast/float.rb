module Huia
  module AST
    class Float < Numeric

      def bytecode g
        pos g

        g.push_huia_float value
      end

    end
  end
end
