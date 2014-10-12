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

      define_method :arity do
        argument_names.size
      end

      define_method :argument_names do
        @argumentNames.to_ruby.map { |a| a.to_str }
      end

      define_method :defined_at do |file,line,column|
        @definedAt = { file: file, line: line, column: column }
      end

      define_method :ensures do
        @ensures ||= ::Huia::Core.array
      end

      define_method :rescues do
        @rescues ||= ::Huia::Core.hash
      end

      define_method :rescues_exception? do |exception|
        !!rescues[exception.class]
      end

      define_method :rescue_for do |exception|
        rescues[exception.class]
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
        begin
          __huia__call block, _self, self, *args

        rescue ::Huia::Core::RuntimeException => e
          exception = e.huia_exception

          if rescues_exception? exception
            __huia__call(rescue_for(exception), _self, exception)
          else
            raise e
          end

        ensure
          ensures.each do |ensure_block|
            __huia__call(ensure_block, _self)
          end
        end
      end

      # ### `Closure.create:` **Public**
      #
      # Creates a new [[Closure]] object taking a block argument.
      define_method_as 'create:' do |block|
        if block.respond_to? :__huia__send
          block
        else
          __huia__send('create').tap do |o|
            o.block = block
          end
        end
      end

      define_method :to_ruby do
        block
      end

      define_method :to_proc do
        block
      end
    end)
  end
end
