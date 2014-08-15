module Huia
  module AST
    class Symbol < Literal

      def bytecode g
        pos g

        g.push_literal value[1..-1].to_sym
      end

    end
  end
end
