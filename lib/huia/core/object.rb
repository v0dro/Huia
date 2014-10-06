# # `Object` is the base class used by all objects in the Huia runtime.
#
# ## Methods defined by the Huia Runtime:
#
module Huia
  module Core
    class Object < ::Object
      include ::Huia::Boot::Alpha
      extend  ::Huia::Boot::Alpha

      extend  ::Huia::Boot::Beta
      include ::Huia::Boot::Beta

      extend  ::Huia::Boot::Gamma
      include ::Huia::Boot::Gamma

      extend  ::Huia::Boot::Delta
      extend  ::Huia::Boot::Epsilon

      # ### `Object.create` **Public**
      #
      # Creates a new instance of the Object.
      __huia__define_method('create', proc do
        methods = ::Huia::Boot::HashWithSuperAccess.new @instanceMethods
        privateMethods = ::Huia::Boot::HashWithSuperAccess.new @privateInstanceMethods
        klass = self
        new.tap do |o|
          o.instance_variable_set '@methods', methods
          o.instance_variable_set '@privateMethods', privateMethods
          o.instance_variable_set '@class', klass
          o.send :__huia__init
        end
      end)

      # ### `Object.extend:` **Public**
      #
      # Creates a new subclass of [[Object]]. You must pass a block argument which
      # is used to specialise the behaviour of the subclass, eg:
      #
      # ```huia
      #   Animal = Object.extend:
      #
      #     def: 'name:' as: |name|
      #       set: 'name' to: name
      # ```
      __huia__define_method('extend:', proc do |closure|
        methods                = ::Huia::Boot::HashWithSuperAccess.new @methods
        privateMethods         = ::Huia::Boot::HashWithSuperAccess.new @privateMethods
        instanceMethods        = ::Huia::Boot::HashWithSuperAccess.new @instanceMethods
        privateInstanceMethods = ::Huia::Boot::HashWithSuperAccess.new @privateInstanceMethods
        definedAt              = closure.definedAt if closure.respond_to? :definedAt

        Class.new(self).tap do |klass|
          klass.instance_variable_set(:@methods, methods)
          klass.instance_variable_set(:@privateMethods, privateMethods)
          klass.instance_variable_set(:@instanceMethods, instanceMethods)
          klass.instance_variable_set(:@privateInstanceMethods, privateInstanceMethods)
          klass.instance_variable_set(:@superclass, self)
          klass.instance_variable_set(:@definedAt, definedAt) if definedAt
          klass.instance_eval(&closure.block)
        end
      end)

      define_instance_method = proc do |signature, closure|
        signature = signature.to_ruby if signature.respond_to? :to_ruby
        @instanceMethods[signature] = closure
      end

      define_private_instance_method = proc do |signature, closure|
        signature = signature.to_ruby if signature.respond_to? :to_ruby
        @privateInstanceMethods[signature] = closure
      end

      # ### `Object.defineInstanceMethod:as:` **Private**
      #
      # Defines an instance method on a class.
      # Aliased to `Object.def:as:`.
      #
      # Arguments:
      #   - `signature` the method signature, as a [[String]].
      #   - `closure` the method implementation, as a [[Closure]] or block argument.
      __huia__define_private_method('def:as:', define_instance_method)
      __huia__define_private_method('defineInstanceMethod:as:', define_instance_method)

      # ### `Object.definePrivateInstanceMethod:as:` **Private**
      #
      # Defines a private instsance method on a class.
      # Aliased to `Object.pdef:as:`.
      #
      # Arguments:
      #   - `signature` the method signature, as a [[String]].
      #   - `closure` the method implementation, as a [[Closure]] or block argument.
      __huia__define_private_method('pdef:as:', define_private_instance_method)
      __huia__define_private_method('definePrivateInstanceMethod:as:', define_private_instance_method)

      # ### `Object.inspect` **Public**
      #
      # Default inspection string for all classes.
      __huia__define_method('inspect', proc do
        klass_name = if self.name
                       "(#{self.name.to_s.split('::').last})"
                     else
                       ''
                     end
        ivars      = instance_variables.map { |i| i.to_s[1..-1] }
        ivars      = if ivars.any?
                       " [#{ivars.join(' ')}]"
                     else
                       ''
                     end
        location   = if @definedAt
                       "@#{@definedAt[:file]}:#{@definedAt[:line]}"
                     else
                       ''
                     end
        ::Huia::Core.string "<Class#{klass_name}##{object_id}#{location}#{ivars}>"
      end)

      # ### `Object#inspect` **Public**
      #
      # Default inspection string for all object instances.
      __huia__send('def:as:', 'inspect', proc do
        klass_name = if self.class.name
                       self.class.name.to_s.split("::").last
                     else
                       defined_at = self.class.instance_variable_get('@definedAt')
                       location = if defined_at
                                    "@#{defined_at[:file]}:#{defined_at[:line]}"
                                  else
                                    ''
                                  end
                       "Class##{self.class.object_id}#{location}"
                     end
        ivars      = instance_variables.map { |i| i.to_s[1..-1] }
        ivars      = if ivars.any?
                       " [#{ivars.join(' ')}]"
                     else
                       ''
                     end
        ::Huia::Core.string "<Object(#{klass_name})##{object_id}#{ivars}>"
      end)

      is_equal_to_other = proc do |other|
        if self == other
          ::Huia::Core.true
        else
          ::Huia::Core.false
        end
      end

      # ### `Object.isEqualTo:` & `Object#isEqualTo:` **Public**
      #
      # Default test for object equality.
      #
      # Argument: object to test against.
      __huia__send 'def:as:', 'isEqualTo:', is_equal_to_other
      __huia__send 'defineMethod:as:', 'isEqualTo:', is_equal_to_other

      raise_exception_with_message = proc do |exception_class, message|
        fail_exception = ::Huia::Core::Exception.huia_send('createWithMessage:', "Object #{exception_class.huia_send('inspect')} is not a subclass of `Exception` (raising: #{message.huia_send('inspect')})")
        raise fail_exception unless exception_class.huia_class?
        raise fail_exception unless exception_class.ancestors.member? ::Huia::Core::Exception

        raise exception_class.huia_send('createWithMessage:', message)
      end

      # ### `Object.raiseException:withMessage:` & `Object#raiseException:withMessage:` **Private**
      #
      # Raise a run-time exception.
      #
      # Arguments:
      #   - `exceptionClass` - the class of exception to raise. Usually a subclass of [[Exception]].
      #   - `message` - the message to set on the exception instance.
      __huia__send 'def:as:', 'raiseException:withMessage:', raise_exception_with_message
      __huia__send 'defineMethod:as:', 'raiseException:withMessage:', raise_exception_with_message

      def self.huia_class?
        true
      end

      define_method :huia_class? do
        false
      end

      def self.huia_instance?
        false
      end

      define_method :huia_instance? do
        true
      end

      def self.name
        @name || super
      end
    end
  end
end
