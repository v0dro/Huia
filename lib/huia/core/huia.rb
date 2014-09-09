module Huia
  module Core
    Huia = Object.__huia__send('extend:', proc do

      define_method_as 'requireFile:' do |path|
        ::Huia.load(path.to_ruby).invoke
      end

      define_method_as 'requireCore:' do |file|
        file = file.to_ruby if file.respond_to? :to_ruby
        constantized = (file[0].upcase + file[1..-1].downcase).to_sym
        if ::Huia::Core.constants.member? constantized
          ::Huia::Core.const_get constantized
        else
          ::Huia.load(file.downcase, File.expand_path('../../../../core/', __FILE__)).invoke
        end
      end

    end)
  end
end
