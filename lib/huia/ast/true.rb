module Huia
  module AST
    class True < Literal

      def initialize
        super true
      end

      def bytecode g
        pos(g)

        push_huia_const g, :True
        g.push_literal 'create'
        g.string_dup
        g.send :__huia__send, 1
      end

    end
  end
end
