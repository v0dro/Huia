module Huia
  module AST
    class Hash < Literal

      def initialize hash_item=nil
        @value = []
        append hash_item if hash_item
      end

      def append hash_item
        @value.push hash_item
      end

      def bytecode g
        pos g

        g.push_huia_hash

        # Assign each key and value.
        @value.each do |item|
          g.dup

          g.huia_send 'at:set:', 2 do |g|
            item.bytecode g
          end

          g.pop
        end
      end

    end
  end
end
