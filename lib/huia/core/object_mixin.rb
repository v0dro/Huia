# Add's the ability to bootstrap methods onto Object.

module Huia
  module Core
    module ObjectMixin

      def self.included base
        polute base.singleton_class
        polute base
      end

      def self.polute o
        o.send :define_method, :__huia__make_signature do |signature|
          "__HUIA__#{signature}".to_sym
        end

        o.send :define_method, :__huia__define_method do |signature, &block|
          puts "Defining instance method #{signature.inspect} on #{self.inspect}"
          o.send :define_method, __huia__make_signature(signature), &block
        end

        o.send :define_method, :__huia__make_private do |signature|
          private __huia__make_signature(signature)
        end

        o.send :define_method, :__huia__send do |signature, *args|
          send __huia__make_signature(signature), *args
        end

        o.send :define_method, :__huia__alias_public do |from, to|
          @methods[to] = @methods[from]
        end

        o.send :define_method, :__huia__alias_private do |from, to|
          @privateMethods[to] = @privateMethods[from]
        end

        o.send :define_method, :__huia__bootstrap_ivars do
          @methods = {}
          @privateMethods = {}
        end
      end
    end
  end
end
