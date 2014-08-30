module Huia
  module AST
    class Return < Node

      attr_reader :value

      def initialize value
        @value = value
      end

      def bytecode g
        pos g

        value.bytecode g
        g.ret
      end
    end
  end
end
