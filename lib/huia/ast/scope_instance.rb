module Huia
  module AST
    class ScopeInstance < Node

      attr_reader :scope

      def initialize scope
        @scope = scope
      end

      def bytecode g
        pos g
      end

    end
  end
end
