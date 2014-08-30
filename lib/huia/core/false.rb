module Huia
  module Core
    False = Literal.__huia__send('extend:', proc do
      define_method :__huia__init do
        super
        @value = false
      end
    end)
  end
end
