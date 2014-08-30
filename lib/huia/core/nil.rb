module Huia
  module Core
    Nil = Literal.__huia__send('extend:', proc do
      define_method :__huia__init do
        super
        @value = nil
      end
    end)
  end
end
