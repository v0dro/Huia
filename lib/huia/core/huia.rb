module Huia
  module Core
    Huia = Object.__huia__send('extend:', proc do

      __huia__send('defineMethod:as:', 'requireFile:', proc do |path|
        ::Huia.load(path.to_ruby).invoke
      end)

      __huia__send('defineMethod:as:', 'requireCore:', proc do |file|
        ::Huia.load(file.to_ruby.downcase, File.expand_path('../../../../core/', __FILE__))
      end)

    end)
  end
end
