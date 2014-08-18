module Huia
  module Core
    False = Literal.__huia__send('extend:', proc do
      def __huia__init
        super
        @value = false
      end
    end)
  end
end
