module Huia
  module AST
    class Nil < Literal

      def initialize
        super nil
      end

      def bytecode g
        pos g

        push_huia_const g, :Nil
        g.push_literal 'create'
        g.send :__huia__send, 1
      end

    end
  end
end
