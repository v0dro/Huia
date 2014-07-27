module Huia
  module AST
    class Multiplication < BinaryOp
      def reduce
        send_right_to_left 'multiplyBy:'
      end
    end
  end
end
