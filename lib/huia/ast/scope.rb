module Huia
  module AST
    class Scope < Node

      attr_reader :variables

      def initialize
        @variables = {}
      end

      def allocate variable_name
        @variables[variable_name] = Huia::AST::Variable.new variable_name
      end
    end
  end
end
