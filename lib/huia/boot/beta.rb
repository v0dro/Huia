module Huia
  module Boot
    module Beta
      def self.included base
        base.instance_eval do
          @instanceMethods = HashWithSuperAccess.new @methods
          @privateInstanceMethods  = HashWithSuperAccess.new @privateMethods
        end
      end

      def self.extended base
        base.__huia__bootstrap_ivars

        base.__huia__define_private_method('get:', proc do |name|
          name = name.to_ruby if name.respond_to? :to_ruby
          instance_variable_get "@#{name}"
        end)

        base.__huia__define_private_method('set:to:', proc do |name, to_ruby|
          name = name.to_ruby if name.respond_to? :to_ruby
          instance_variable_set "@#{name}", to_ruby
        end)

        base.__huia__define_private_method('definePrivateMethod:as:', proc do |signature,closure|
          signature = signature.to_ruby if signature.respond_to? :to_ruby
          @privateMethods[signature] = closure
        end)

        base.__huia__define_private_method('defineMethod:as:', proc do |signature,closure|
          signature = signature.to_ruby if signature.respond_to? :to_ruby
          @methods[signature] = closure
        end)

        base.__huia__define_private_method('undefinePrivateMethod:', proc do |signature|
          # Explicitly set it to nil, instead of deleting it, as that means
          # that if there is one defined in the superclass it'll be blocked.
          # If the user wants to simply remove the local version and use the super
          # version then they can remove it from the methods hash.
          signature = signature.to_ruby if signature.respond_to? :to_ruby
          @privateMethods[signature] = nil
        end)

        base.__huia__define_private_method('defaultResponderFor:', proc do |signature|
          signature = signature.to_ruby if signature.respond_to? :to_ruby
          @methods.fetch(signature, @privateMethods[signature])
        end)

        base.__huia__define_method('sendMessage:withArgs:', proc do |signature, args|
          args = args.to_ruby if ::Huia::Core::Array === args
          __huia__send signature, *args
        end)

        base.__huia__define_private_method('if:then:', proc do |test,closure|
          if test.__huia__send('truthy?').value
            __huia__call closure, self, test
          end
        end)

      end

      def __huia__send signature, *args
        closure = __huia__send_to_drf signature

        __huia__call closure, self, *args
      end

      def __huia__send_to_drf signature
        drf = @privateMethods['defaultResponderFor:']
        closure = self.instance_exec(signature, &drf.block)

        signature = signature.to_ruby if signature.respond_to? :to_ruby
        raise NoMethodError, "Unable to find method #{signature.inspect} on #{self.__huia__send('inspect')}" unless closure
        closure
      end
    end
  end
end
