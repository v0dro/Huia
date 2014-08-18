module Huia
  module Core
    Nil = Literal.__huia__send('extend:', proc do
      def __huia__init
        super
        @value = nil
      end
    end)
  end
end
