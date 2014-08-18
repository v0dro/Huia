module Huia
  module AST
    class Constant < Literal

      def bytecode g
        pos g

        push_huia_const g, value
      end

    end
  end
end
