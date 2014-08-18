module Huia
  module Core
    Literal = Object.__huia__send('extend:', proc do
      attr_accessor :value
    end)
  end
end
