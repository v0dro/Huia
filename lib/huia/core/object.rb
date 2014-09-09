# The most basic definition of object.  See also `core/object`.

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

      # Define the default behavior for creating subclasses:
      #
      # First, create HashWithSuperAccess objects for all four method types
      # on classes and assign them.
      # Second, assign the superclass to self.
      # Third, call the closure which was passed in as an argument; this
      # can be used to customise the new class:
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

      __huia__define_private_method('def:as:', define_instance_method)
      __huia__define_private_method('defineInstanceMethod:as:', define_instance_method)
      __huia__define_private_method('pdef:as:', define_private_instance_method)
      __huia__define_private_method('definePrivateInstanceMethod:as:', define_private_instance_method)

      __huia__define_method('inspect', proc do
        klass_name = if self.name
                       "(#{self.name.split('::').last})"
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

      __huia__send('def:as:', 'inspect', proc do
        klass_name = if self.class.name
                       self.class.name.split("::").last
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

      __huia__send 'def:as:', 'isEqualTo:', is_equal_to_other
      __huia__send 'defineMethod:as:', 'isEqualTo:', is_equal_to_other
    end
  end
end
