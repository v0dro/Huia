module Huia
  module Core
    Literal = Object.__huia__send('extend:', proc do
      attr_accessor :value

      define_method :to_ruby do
        value
      end

      __huia__send('defineMethod:as:', 'createFromValue:', proc do |value|
        value = value.to_ruby if value.respond_to? :to_ruby
        __huia__send('create').tap do |o|
          o.value = value
        end
      end)
    end)
  end
end
