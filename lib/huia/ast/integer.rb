module Huia
  module AST
    class Integer < Numeric

      def bytecode g
        pos g

        push_huia_const g, :Integer
        g.send :new, 0

        g.dup
        g.push_int value.to_i
        g.send :value=, 1

        g.pop
      end

    end
  end
end
