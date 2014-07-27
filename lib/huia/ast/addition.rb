module Huia
  module AST
    class Addition < BinaryOp
      def reduce
        send_right_to_left 'plus:'
      end
    end
  end
end
