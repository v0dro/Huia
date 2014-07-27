module Huia
  module AST
    class VarAssign < BinaryOp
      def initialize left, right
        raise SyntaxError, "LHS must be a Variable" unless left.is_a? Variable
        super
      end

      def reduce
        puts "assigning #{reduced_right.inspect} to #{left.inspect}"
        left.value = reduced_right

        left
      end
    end
  end
end
