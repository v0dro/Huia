module Huia
  module Core
    True = Literal.__huia__send('extend:', proc do
      define_method :__huia__init do
        super
        @value = true
      end
    end)
  end
end
