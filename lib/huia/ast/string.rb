module Huia
  module AST
    class String < Literal

      def append value
        @value << value
      end

      def bytecode g
        pos g

        g.push_huia_string value
      end

    end
  end
end
