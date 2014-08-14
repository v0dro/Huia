# Add's the ability to bootstrap methods onto Object.

module Huia
  module Core
    module ObjectMixin
      extend Module.new do
      end.tap do |m|
        m.send :define_method, :__huia__make_signature do |signature|
          "__HUIA__#{signature}".to_sym
        end

        m.send :define_method, :__huia__define_method do |signature, &block|
          puts "Defining method #{signature.inspect} on #{self.inspect}"
          send :define_method, __huia__make_signature(signature), &block
        end

        m.send :define_method, :__huia__make_private do |signature|
          private __huia__make_signature(signature)
        end

        m.send :define_method, :__huia__send do |signature, *args|
          send __huia__make_signature(signature), *args
        end

        m.send :define_method, :__huia__bootstrap_ivars do
          @methods = {}
          @privateMethods = {}
        end
      end

      def self.included base
        base.extend self
        base.singleton_class.extend self
      end
    end
  end
end
