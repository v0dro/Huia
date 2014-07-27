module Huia
  module AST
    class Modulo < BinaryOp
      def reduce
        send_right_to_left 'moduloBy:'
      end
    end
  end
end
