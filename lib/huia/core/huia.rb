module Huia
  module Core
    Huia = Object.__huia__send('extend:', proc do

      __huia__send('defineMethod:as:', 'requireFile:', proc do |path|
        ::Huia.load(path.to_ruby).invoke
      end)

    end)
  end
end
