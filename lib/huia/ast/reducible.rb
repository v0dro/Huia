module Huia
  module AST
    class Reducible < Node
      def reducible?; true; end

      def reduce
        raise RuntimeError, "subclasses of Reducible must implement the reduce method"
      end
    end
  end
end
