module Huia
  module AST
    class MethodCall < Node
      attr_reader :left, :right

      def initialize left, right
        raise SyntaxError, "RHS must be a call signature." unless right.is_a? Huia::AST::CallSignature
        @left  = left
        @right = right
      end

      def bytecode g
        pos g

        # receiver
        left.bytecode g

        # huia method name argument
        g.push_literal right.signature
        g.string_dup

        # arguments
        right.arguments.each do |argument|
          argument.bytecode g
        end

        g.send :__huia__send, right.arguments.size + 1, true
      end
    end
  end
end
