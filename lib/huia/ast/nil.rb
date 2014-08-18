module Huia
  module AST
    class Nil < Literal

      def initialize
        super nil
      end

      def bytecode g
        pos g

        push_huia_const g, :Nil
        g.send :new, 0
      end

    end
  end
end
