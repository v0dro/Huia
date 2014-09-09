module Huia
  module Core
    Closure = Object.__huia__send('extend:', proc do
      attr_accessor :block

      def arity
        argument_names.size
      end

      def argument_names
        @argumentNames.to_ruby.map { |a| a.to_str }
      end

      # Create the base `callWithSelf:andArgs` method of Closure.
      define_instance_method_as 'callWithSelf:andArgs:' do |_self, args|
        args = Array(args)
        __huia__call block, _self, *args
      end

      # Create the `create:` constructor which takes a block.
      define_method_as 'create:' do |block|
        if Proc === block
          __huia__send('create').tap do |o|
            o.block = block
          end
        else
          block
        end
      end

      define_method :to_ruby do
        block
      end
    end)
  end
end
