module Huia
  module AST
    class Array < Literal

      def initialize ary=[]
        @value = ary
      end

      def append value
        @value.push value
      end

      def bytecode g
        pos g

        g.push_huia_array @value.size do |g|
          @value.each do |item|
            item.bytecode g
          end
        end
      end
    end
  end
end
