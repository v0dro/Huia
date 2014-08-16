module Huia
  module AST
    class Node
      attr_accessor :file, :line

      def bytecode g
        pos g
      end

      def pos g
        g.set_line line
      end
    end
  end
end
