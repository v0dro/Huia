module Huia
  module Bootstrap
    class MethodClass < ClassObject

      attr_accessor :binding, :signature, :block

      def initialize binding, signature, block
        super()
        self.binding   = binding
        self.signature = signature
        self.block     = block
      end

      def send_message name, *args
        return call *args if name == 'callWithArgs:'
        super
      end

      def call *args
        # not really sure about how this works yet.
        binding.instance_exec(*args, &block)
      end
    end
  end
end
