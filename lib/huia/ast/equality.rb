module Huia
  module AST
    class Equality < BinaryOp
      def reduce
        send_right_to_left 'isEqualTo:'
      end
    end
  end
end
