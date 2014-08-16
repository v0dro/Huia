module Huia
  module AST
    class Scope < Node

      attr_reader :children, :parent, :arguments

      def initialize parent
        @children  = []
        @arguments = []
        @locals    = []
        @parent    = parent
      end

      def add_argument variable
        @arguments << variable
      end

      def arity
        @arguments.size
      end

      def allocate_local variable
        name = variable.name
        @locals.push name unless @locals.member? name
        variable.index = @locals.find_index name
      end

      def argument_names
        @arguments
      end

      def append node
        raise RuntimeError, "Cannot append a non-Node" unless node.is_a? Huia::AST::Node
        @children << node
        self
      end

      def bytecode g
        pos g

        # g.push_rubinius
        # g.create_block block_from_children g
        # g.send_stack_with_block :lambda, 0

        children.each do |child|
          child.bytecode g
        end

        g.ret
      end

      private

      def block_from_children g
        blk = g.class.new
        blk.file = g.file
        blk.for_block = true

        blk.arity = arity
        blk.definition_line line
        pos blk

        arguments.each do |argument|
          argument.bytecode g
        end

        blk.push_modifiers
        blk.break = nil
        blk.next = nil
        blk.redo = blk.new_label
        blk.redo.set!

        children.each do |child|
          child.bytecode(blk)
        end

        blk.pop_modifiers
        blk.ret
        blk.close
        # blk.pop_state

        blk.local_count = local_count blk
        blk.local_names = local_names blk
      end

      def local_count g
        g.push_int @locals.size
      end

      def local_names g
        @locals.map do |name|
          g.push_literal name.to_sym
        end
        g.make_array @locals.size
      end
    end
  end
end
