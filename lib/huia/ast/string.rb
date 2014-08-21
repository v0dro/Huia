module Huia
  module AST
    class String < Literal

      def bytecode g
        pos g

        push_huia_const g, :String
        g.push_literal 'createFromValue:'
        g.string_dup
        g.push_literal value
        g.string_dup
        g.send :__huia__send, 2
      end

    end
  end
end
