module Huia
  module AST
    class Float < Numeric

      def bytecode g
        pos g

        push_huia_const g, :Float
        g.push_literal 'createFromValue:'
        g.push_literal value.to_f
        g.send :__huia__send, 2
      end

    end
  end
end
