module Huia
  module AST
    class Symbol < Literal

      def bytecode g
        pos g

        push_huia_const g, :Symbol
        g.send :new, 0

        g.dup
        g.push_literal value[1..-1].to_sym
        g.send :value=, 1

        g.pop
      end

    end
  end
end
