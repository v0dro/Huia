module Huia
  module AST
    class MethodCall < Node
      attr_reader :left, :right

      def initialize left, right
        raise SyntaxError, "RHS must be a call signature." unless right.is_a? Huia::AST::CallSignature
        @left  = left
        @right = right
      end

      def reduce
        puts "Asked to call #{right.signature} on #{left}."
      end
    end
  end
end
