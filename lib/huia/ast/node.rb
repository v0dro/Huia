module Huia
  module AST
    class Node
      def reducible?; false; end

      def reduce
        self
      end

      def call_method method, *args
        puts "#{self.inspect} asked to call #{method} with args: #{args.inspect}"
      end
    end
  end
end
