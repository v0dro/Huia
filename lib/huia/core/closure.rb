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
      __huia__send('def:as:', 'callWithSelf:andArgs:', proc do |_self, args|
        args = Array(args)
        __huia__call block, _self, *args
      end)

      # Create the `create:` constructor which takes a block.
      __huia__send('defineMethod:as:', 'create:', proc do |block|
        __huia__send('create').tap do |o|
          o.block = block
        end
      end)

      define_method :to_ruby do
        block
      end
    end)
  end
end
