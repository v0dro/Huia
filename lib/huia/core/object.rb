# The most basic definition of object.  See also `core/object`.

module Huia
  module Core
    class Object < ::Object
      include Huia::Boot::Alpha
      extend  Huia::Boot::Alpha

      extend  Huia::Boot::Beta
      include Huia::Boot::Beta

      extend  Huia::Boot::Gamma
      include Huia::Boot::Gamma

      extend  Huia::Boot::Delta

      __huia__define_method('create', proc do
        methods = Huia::Boot::HashWithSuperAccess.new @instanceMethods
        privateMethods = Huia::Boot::HashWithSuperAccess.new @privateInstanceMethods
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
        methods                = Huia::Boot::HashWithSuperAccess.new @methods
        privateMethods         = Huia::Boot::HashWithSuperAccess.new @privateMethods
        instanceMethods        = Huia::Boot::HashWithSuperAccess.new @instanceMethods
        privateInstanceMethods = Huia::Boot::HashWithSuperAccess.new @privateInstanceMethods
        klass                  = self
        Class.new klass do
          @methods                = methods
          @privateMethods         = privateMethods
          @instanceMethods        = instanceMethods
          @privateInstanceMethods = privateInstanceMethods
          @superclass             = klass

          __huia__call closure, self
        end
      end)

      define_instance_method = proc do |signature, closure|
        @instanceMethods[signature] = closure
      end

      define_private_instance_method = proc do |signature, closure|
        @privateInstanceMethods[signature] = closure
      end

      __huia__define_private_method('def:as:', define_instance_method)
      __huia__define_private_method('defineInstanceMethod:as:', define_instance_method)
      __huia__define_private_method('pdef:as:', define_private_instance_method)
      __huia__define_private_method('definePrivateInstanceMethod:as:', define_private_instance_method)
    end
  end
end
