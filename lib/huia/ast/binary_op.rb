module Huia
  module AST
    class BinaryOp < Reducible
      attr_accessor :left
      attr_accessor :right

      def initialize left, right
        @left = left; @right = right
      end

      def send_right_to_left method
        reduced_left.call_method(method, reduced_right)
      end

      private

      def reduced_left
        @reduced_left ||= reduce_left
      end

      def reduced_right
        @reduced_right ||= reduce_right
      end

      def reduce_left
        return left.reduce if left.reducible?
        left
      end

      def reduce_right
        return right.reduce if right.reducible?
        right
      end
    end
  end
end
