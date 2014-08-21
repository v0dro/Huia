module Huia
  module Core
    String = Literal.__huia__send('extend:', proc do

      __huia__send('def:as:', 'concat:', proc do |other|
        str = to_ruby
        str = if other.respond_to? :to_ruby
                str + other.to_ruby
              else
                str + other
              end
        String.__huia__send('createFromValue:', str)
      end)
    end)
  end
end
