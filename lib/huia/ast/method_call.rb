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

        # sendMessage:withArgs
        g.push_literal 'sendMessage:withArgs:'
        g.string_dup

        # huia method name argument
        g.push_literal right.signature
        g.string_dup

        arguments.each do |argument|
          argument.bytecode g
        end
        g.make_array argument_count

        g.send :__huia__send, 3
      end

      def has_arguments?
        argument_count > 0
      end

      def arguments
        right.arguments
      end

      def argument_count
        arguments.size
      end
    end
  end
end
