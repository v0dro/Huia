module Huia
  module Core
    Huia = Object.__huia__send('extend:', proc do

      __huia__send('defineMethod:as:', 'requireFile:', proc do |path|
        ::Huia.load(path.to_ruby).invoke
      end)

      __huia__send('defineMethod:as:', 'requireCore:', proc do |file|
        file = file.to_ruby if file.respond_to? :to_ruby
        constantized = (file[0].upcase + file[1..-1].downcase).to_sym
        if ::Huia::Core.constants.member? constantized
          ::Huia::Core.const_get constantized
        else
          ::Huia.load(file.to_ruby.downcase, File.expand_path('../../../../core/', __FILE__)).invoke
        end
      end)

    end)
  end
end
