# We extend Delta onto our core classes, and when that's done
# it tries to load the corresponding huia file from `core/` and
# extend the class with it.

module Huia
  module Boot
    module Delta

      def __huia__load_core
        base = self
        file  = base.to_s.split('::').last.downcase # would like `#underscore` but we don't have one.
        block = Huia.load("core/#{file}", File.expand_path('../../../../', __FILE__)).closure.block
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

    end
  end
end
