module Huia
  module Core
    module BootstrapMethods
      def self.included base
        base.instance_eval do
          @methods = {}
          @privateMethods = {}
          @instanceMethods = {}
          @privateInstanceMethods = {}
        end

        polute base

        polute BootstrapInstanceMethods.singleton_class
        base.include BootstrapInstanceMethods
      end

      def self.polute o
        o.__huia__define_method 'defineMethod:as:' do |signature,closure|
          @methods[signature] = closure
          o.__huia__define_method signature do |*args|
            instance_exec *args, &__huia__send('defaultResponderFor:', signature).block
          end
        end

        o.__huia__define_method 'definePrivateMethod:as:' do |signature,closure|
          @privateMethods[signature] = closure
          o.__huia__define_method signature do |*args|
            instance_exec *args, &__huia__send('defaultResponderFor:', signature).block
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

        puts "#{o.inspect} now has instance methods #{o.instance_methods.grep(/huia/i).inspect}"
      end

      def initialize
        puts "Initializing instance vars"
        @methods = {}
        @privateMethods = {}
        super
      end

      def method_missing method, *args
        return __huia__send 'sendMessage:withArgs:', method[8..-1], *args if method[0..7] == '__HUIA__'
        super
      end
    end
  end
end
