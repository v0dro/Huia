# The most basic definition of object.  See also `core/object`.

module Huia
  module Core
    class Object
      include ObjectMixin

      module BootstrapMethods
        def self.included base
          base.instance_eval do
            @methods = {}
            @privateMethods = {}
          end

          base.extend self
          base.singleton_class.extend self
        end

        def self.extended o
          o.__huia__define_method 'defineMethod:as:' do |signature,closure|
            @methods[signature] = closure
            o.__huia__define_method signature do |*args|
              instance_exec *args, &__huia__send('defaultResponderFor:', signature)
            end
          end

          o.__huia__define_method 'definePrivateMethod:as:' do |signature,closure|
            @privateMethods[signature] = closure
            o.__huia__define_method signature do |*args|
              instance_exec *args, &__huia__send('defaultResponderFor:', signature)
            end
            o.__huia__make_private signature
          end

          o.__huia__define_method 'defaultResponderFor:' do |signature|
            @methods.fetch(signature, @privateMethods[signature])
          end

          o.__huia__define_method 'get:' do |name|
            instance_variable_get "@#{name}"
          end

          o.__huia__define_method 'set:to:' do |name, value|
            instance_variable_set "@#{name}", value
          end

          o.__huia__define_method 'sendMessage:withArgs:' do |signature, args|
            __huia__send signature, *args
          end

          o.__huia__define_method 'if:then:' do |test, closure|
            if result = test
              instance_exec result, &closure.block
            end
          end
        end

        def initialize
          puts "Initializing instance vars"
          @methods = {}
          @privateMethods = {}
          super
        end
      end

      include BootstrapMethods

    end
  end
end
