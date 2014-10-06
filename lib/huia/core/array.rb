module Huia
  module Core
    Array = Literal.__huia__send('extend:', proc do
      include Enumerable

      define_method :each do |*args,&block|
        value.each *args, &block
      end
    end)
  end
end
