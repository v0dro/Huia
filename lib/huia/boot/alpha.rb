module Huia
  module Boot
    module Alpha
      def __huia__init; end

      def __huia__bootstrap_ivars
        @methods        = {}
        @privateMethods = {}
        if Class === self
          @instanceMethods = {}
          @privateInstanceMethods = {}
        end
      end

      # Baseline implementation for defining private from within Ruby.
      def __huia__define_private_method signature, closure
        @privateMethods[signature] = closure
      end

      # Likewise
      def __huia__define_method signature, closure
        @methods[signature] = closure
      end

      # We will redefine this method to use `defaultResponderFor:` once that
      # Huia method is defined.
      # For now, we can use it to call methods defined as Procs by the Ruby
      # runtime, or dispatch to Closure objects.
      #
      # Also note that at this stage we don't care about public vs private
      # methods.
      def __huia__send signature, *args
        closure = @methods.fetch(signature, @privateMethods[signature])

        raise NoMethodError, "Unable to find method #{signature.inspect} on #{self.inspect}" unless closure

        __huia__call closure, self, *args
      end

      def __huia__call closure, _self, *args
        raise ArgumentError, "__huia__call takes a closure" unless closure.respond_to? :block
        # Handle bootstrapped methods which are defined as procs.
        return _self.instance_exec(*args, &closure) unless closure.respond_to? :__huia__send

        # Otherwise dispatch via Huia's own method calling.
        closure.__huia__send('callWithSelf:andArgs:', _self, *args)
      end
    end
  end
end
