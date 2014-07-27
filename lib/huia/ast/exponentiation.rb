module Huia
  module AST
    class Exponentiation < BinaryOp
      def reduce
        send_right_to_left 'toThePowerOf:'
      end
    end
  end
end
