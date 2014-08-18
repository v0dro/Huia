module Huia
  module AST
    class Float < Numeric

      def bytecode g
        pos g

        push_huia_const g, :Float
        g.send :new, 0

        g.dup
        g.push_literal value.to_f
        g.send :value=, 1

        g.pop
      end

    end
  end
end
