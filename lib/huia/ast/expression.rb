module Huia
  module AST
    class Expression < Literal

      def bytecode g
        pos g
        value.bytecode g
      end
    end
  end
end
