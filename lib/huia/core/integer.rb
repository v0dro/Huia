module Huia
  module Core
    Integer = Numeric.__huia__send('extend:', proc {})
  end
end
