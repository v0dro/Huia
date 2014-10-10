# We extend Delta onto our core classes, and when that's done
# it tries to load the corresponding huia file from `core/` and
# extend the class with it.

module Huia
  module Boot
    module Delta

      def __huia__load_core
        base = self
        # Where's the |> operator when you need it?
        file = underscore(demodulize(base.to_s))
        block = Huia.load(file, File.expand_path('../../../../core/', __FILE__)).closure.block
        base.instance_eval(&block)

      rescue Huia::CodeLoader::LoadError
        # don't care if the file is missing.
      ensure
        __huia__freeze_methods!
      end

      def __huia__freeze_methods!
        @methods.freeze! if @methods
        @privateMethods.freeze! if @privateMethods
        @instanceMethods.freeze! if @instanceMethods
        @privateInstanceMethods.freeze! if @privateInstanceMethods
      end

      private

      def demodulize const_name
        const_name.split('::').last
      end

      def underscore const_name
        s = const_name[0].downcase
        const_name[1..-1].each_char do |char|
          case char
          when /[A-Z]/
            s << "_"
            s << char.downcase
          else
            s << char
          end
        end
        s
      end
    end
  end
end
