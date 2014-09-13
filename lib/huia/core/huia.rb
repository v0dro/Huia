# # `Huia`
#
# Provides a place to interact with the Huia environment.
#
# Inherits from [[Object]].
#
# ## Methods defined by the Huia VM:
module Huia
  module Core
    Huia = Object.__huia__send('extend:', proc do

      # ### `Huia.requireFile:` **Public**
      #
      # Evaluates a Huia file and returns its result.
      #
      # Arguments:
      #   - `path`: a [[String]] containing the path to the file to be evaluated.
      define_method_as 'requireFile:' do |path|
        ::Huia.load(path.to_ruby).invoke
      end

      # ### `Huia.requireCore:` **Public**
      #
      # Evaluates a Huia core library file and returns it's result.
      #
      # Arguments:
      #   - `path`: a [[String]] containing the path to the core file to be evaluated (relative to the Huia core library path).
      define_method_as 'requireCore:' do |path|
        path = path.to_ruby if path.respond_to? :to_ruby
        constantized = (path[0].upcase + path[1..-1].downcase).to_sym
        if ::Huia::Core.constants.member? constantized
          ::Huia::Core.const_get constantized
        else
          ::Huia.load(path.downcase, File.expand_path('../../../../core/', __FILE__)).invoke
        end
      end

    end)
  end
end
