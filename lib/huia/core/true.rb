module Huia
  module Core
    True = Literal.__huia__send('extend:', proc do
      def __huia__init
        super
        @value = true
      end
    end)
  end
end
