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
        g.huia_send 'sendMessage:withArgs:', 2 do |g|
          g.push_huia_string right.signature
          g.push_huia_array argument_count do |g|
            arguments.each do |argument|
              argument.bytecode g
            end
          end
        end
      end

      def has_arguments?
        argument_count > 0
      end

      def arguments
        right.arguments || []
      end

      def argument_count
        arguments.size
      end
    end
  end
end
