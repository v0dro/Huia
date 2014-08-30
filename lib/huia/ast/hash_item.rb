module Huia
  module AST
    class HashItem < Node
      attr_reader :key, :value

      def initialize key, value
        @key   = key
        @value = value
      end

      def bytecode g
        pos g

        key.bytecode g
        value.bytecode g
      end
    end
  end
end
