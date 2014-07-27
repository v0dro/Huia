module Huia
  module AST
    class Subtraction < BinaryOp
      def reduce
        send_right_to_left 'subtract:'
      end
    end
  end
end
