module Huia
  module AST
    class Node
      attr_accessor :file, :line, :column

      def bytecode g
        pos g
      end

      def pos g
        g.set_line line
        g.file = file.to_sym
      end
    end
  end
end
