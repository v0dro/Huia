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
        ::Huia.require_file(path.to_ruby)
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
          ::Huia.require_file(path.downcase, File.expand_path('../../../../core/', __FILE__))
        end
      end

      # ### `Huia.requirePackage:` **Public**
      #
      # Evaluates and returns the named package.
      #
      # Arguments:
      #  - `packageName`: a [[String]] containing the name of the package to retrieve.
      define_method_as 'requirePackage:' do |name|
        __huia__send('requireFile:fromPackage:', 'package', name)
      end

      # ### `Huiq.requireFile:fromPackage:` **Public**
      #
      # Evaluates the specificed file from within the named package.
      #
      # Arguments:
      #  - `file`: the file name relative to the package's path.
      #  - `package`: the package to look inside.
      define_method_as 'requireFile:fromPackage:' do |file,package|
        package_path = ::Huia.packages[package.to_s]

        ::Huia.require_file(File.join(package_path, file.to_s))
      end
    end)
  end
end
