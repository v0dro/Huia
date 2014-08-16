module Huia
  module Boot
    module Beta
      def self.included base
        base.instance_eval do
          extend Huia::Boot::Beta

          @methods.each do |signature, closure|
            @instanceMethods[signature] = closure
          end

          @privateMethods.each do |signature, closure|
            @privateInstanceMethods[signature] = closure
          end
        end
      end

      def self.extended base
        base.__huia__bootstrap_ivars

        base.__huia__define_private_method('get:', proc do |name|
          instance_variable_get "@#{name}"
        end)

        base.__huia__define_private_method('set:to:', proc do |name, value|
          instance_variable_set "@#{name}", value
        end)

        base.__huia__define_private_method('definePrivateMethod:as:', proc do |signature,closure|
          @privateMethods[signature] = closure
        end)

        base.__huia__define_private_method('defineMethod:as:', proc do |signature,closure|
          @methods[signature] = closure
        end)

        base.__huia__define_private_method('undefinePrivateMethod:', proc do |signature|
          # Explicitly set it to nil, instead of deleting it, as that means
          # that if there is one defined in the superclass it'll be blocked.
          # If the user wants to simply remove the local version and use the super
          # version then they can remove it from the methods hash.
          @privateMethods[signature] = nil
        end)

        base.__huia__define_private_method('defaultResponderFor:', proc do |signature|
          @methods.fetch(signature, @privateMethods[signature])
        end)

        base.__huia__define_method('sendMessage:withArgs:', proc do |signature, *args|
          __huia__send signature, *args
        end)

        base.__huia__define_private_method('if:then:', proc do |test,closure|
          if result = test
            __huia__call closure, self, result
          end
        end)
      end
    end
  end
end
