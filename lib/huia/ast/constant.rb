module Huia
  module AST
    class Constant < Literal

      def bytecode g
        pos g

        g.push_huia_const value
      end

    end
  end
end
