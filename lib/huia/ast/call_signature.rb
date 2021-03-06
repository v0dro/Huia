module Huia
  module AST
    class CallSignature < Node

      attr_reader :signature, :arguments

      def initialize signature, arguments=[]
        @signature = signature
        @arguments = arguments
      end

      def concat_signature other
        raise SyntaxError, "Signature #{signature} is already final." unless takes_argument?
        raise SyntaxError, "Signature #{other.signature} cannot be appended to #{signature}." unless other.takes_argument?
        @signature = signature + other.signature
        @arguments = arguments + other.arguments

        self
      end

      def takes_argument?
        signature[-1] == ':'
      end
    end
  end
end
