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

      __huia__send('def:as:', 'isEqualTo:', proc do |other|
        other = other.to_ruby if other.respond_to? :to_ruby

        if value == other
          ::Huia::Core::True.__huia__send('create')
        else
          ::Huia::Core::False.__huia__send('create')
        end
      end)

      __huia__send('defineMethod:as:', 'createFromValue:', proc do |value|
        value = value.to_ruby if value.respond_to? :to_ruby
        __huia__send('create').tap do |o|
          o.value = value
        end
      end)
    end)
  end
end
