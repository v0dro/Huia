# # `Closure`
#
# Used to represent a closure as an object which can be passed around and into
# methods as arguments. Inherits from [[Object]]
#
# ## Methods defined by the Huia Runtime:
module Huia
  module Core
    Closure = Object.__huia__send('extend:', proc do
      attr_accessor :block, :definedAt

      def arity
        argument_names.size
      end

      def argument_names
        @argumentNames.to_ruby.map { |a| a.to_str }
      end

      define_method :defined_at do |file,line,column|
        @definedAt = { file: file, line: line, column: column }
      end

      # ### `Closure#callWithSelf:andArgs` **Public**
      #
      # Allows you to call the closure.
      #
      # Arguments:
      #   - `self`: the object to use as self within the block.
      #   - `args`: an [[Array]] of arguments to pass to the block.
      define_instance_method_as 'callWithSelf:andArgs:' do |_self, args|
        args = Array(args)
        __huia__call block, _self, *args
      end

      # ### `Closure.create:` **Public**
      #
      # Creates a new [[Closure]] object taking a block argument.
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
