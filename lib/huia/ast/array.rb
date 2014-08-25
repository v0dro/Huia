module Huia
  module AST
    class Array < Literal

      def initialize array=[]
        @value = array
      end

      def append value
        @value.push value
      end

      def bytecode g
        pos g

        push_huia_const g, :Array
        g.push_literal 'createFromValue:'

        @value.each do |item|
          item.bytecode g
        end
        g.make_array @value.size

        g.send :__huia__send, 2
      end
    end
  end
end
