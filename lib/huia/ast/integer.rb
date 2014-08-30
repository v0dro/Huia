module Huia
  module AST
    class Integer < Numeric

      def bytecode g
        pos g

        push_huia_const g, :Integer
        g.push_literal 'createFromValue:'
        g.string_dup
        g.push_int value.to_i
        g.send :__huia__send, 2
      end

    end
  end
end
