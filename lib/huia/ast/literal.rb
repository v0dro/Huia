module Huia
  module AST
    class Literal < Node

      attr_accessor :value

      def initialize value
        puts "#{self.class.to_s}#initialize #{value.inspect}"
        self.value = value
      end

    end
  end
end
