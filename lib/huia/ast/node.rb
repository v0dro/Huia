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

      private

      def push_huia_const g, const
        g.push_cpath_top
        g.find_const :Huia
        g.find_const :Core
        g.find_const const.to_sym
      end
    end
  end
end
