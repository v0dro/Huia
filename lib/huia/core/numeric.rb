module Huia
  module Core
    Numeric = Literal.__huia__send('extend:', proc do
      define_method :to_int do
        value.to_int
      end
    end)
  end
end
