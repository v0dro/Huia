module Huia
  module Boot
    module Delta

      # We extend Delta onto our core classes, and when that's done
      # it tries to load the correspinding huia file from `core/` and
      # extend the class with it.
      def self.extended base
        file  = base.to_s.split('::').last.downcase # would like `#underscore` but we don't have one.
        block = Huia.load("core/#{file}").closure.block

        puts "extending #{base.inspect} with #{file.inspect}: #{block.inspect}"

        base.instance_eval(&block)
      end

    end
  end
end
