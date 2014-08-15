module Huia
  module AST
    class String < Literal

      def bytecode g
        pos g

        g.push_literal value
        g.string_dup
      end

    end
  end
end
