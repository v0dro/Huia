module Huia
  module AST
    class CallSignature < Reducible

      attr_reader :signature, :arguments

      def initialize signature, arguments=[]
        @signature = signature
        @arguments = arguments
      end

      def concat_signature other
        raise RuntimeError, "Signature #{signature} is already final." unless takes_argument?
        raise RuntimeError, "Signature #{other.signature} cannot be appended to #{signature}." unless other.takes_argument?
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
