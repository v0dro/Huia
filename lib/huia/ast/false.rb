module Huia
  module AST
    class False < Literal

      def initialize
        super false
      end

      def bytecode g
        pos g

        push_huia_const g, :False
        g.push_literal 'create'
        g.string_dup
        g.send :__huia__send, 1
      end

    end
  end
end
