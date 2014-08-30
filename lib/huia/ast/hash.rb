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

        # Hash.createFromValue:
        push_huia_const g, :Hash
        g.push_literal 'create'
        g.string_dup

        # Dispatch Hash.createFromValue: <hash>
        g.send :__huia__send, 1

        # Assign each key and value.
        @value.each do |item|
          g.dup

          g.push_literal 'at:set:'
          g.string_dup

          # bytecode for key and value:
          item.bytecode g

          g.send :__huia__send, 3
          g.pop
        end
      end

    end
  end
end
