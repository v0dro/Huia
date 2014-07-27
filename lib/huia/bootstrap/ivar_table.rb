module Huia
  module Bootstrap
    class IVarTable

      IVarNotFound = Class.new(RuntimeError)

      def initialize
        @ivar_table = Hash.new
      end

      def set name, value
        @ivar_table[name] = value
      end

      def get name
        @ivar_table.fetch(name)
      rescue KeyError => e
        raise IVarNotFound, e.message
      end
    end
  end
end
