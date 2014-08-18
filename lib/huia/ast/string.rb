module Huia
  module AST
    class String < Literal

      def bytecode g
        pos g

        push_huia_const g, :String
        g.send :new, 0

        g.dup
        g.push_literal value
        g.string_dup
        g.send :value=, 1

        g.pop
      end

    end
  end
end
