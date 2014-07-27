module Huia
  module AST
    class Division < BinaryOp
      def reduce
        send_right_to_left 'divideBy:'
      end
    end
  end
end
