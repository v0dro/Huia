module Huia
  module Core
    Literal = Object.__huia__send('extend:', proc do
      attr_accessor :value

      define_method :to_ruby do
        value
      end

      define_method :eql? do |other|
        if ::Huia::Core::Literal === other
          value.eql? other.value
        else
          value.eql? other
        end
      end
      alias_method :==, :eql?

      define_method :hash do
        value.hash
      end

      define_instance_method_as 'isEqualTo:' do |other|
        other = other.to_ruby if other.respond_to? :to_ruby

        if value == other
          ::Huia::Core.true
        else
          ::Huia::Core.false
        end
      end

      define_method_as 'createFromValue:' do |value|
        value = value.to_ruby if value.respond_to? :to_ruby
        huia_send('create').tap do |o|
          o.value = value
        end
      end
    end)
  end
end
