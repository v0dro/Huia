# This module is really just helpers to reduce the complexity of the Ruby VM.
module Huia
  module Boot
    module Epsilon
      def define_method_as method_name, &block
        __huia__send('defineMethod:as:', method_name, block)
      end

      def define_instance_method_as method_name, &block
        __huia__send('defineInstanceMethod:as:', method_name, block)
      end
    end
  end
end
